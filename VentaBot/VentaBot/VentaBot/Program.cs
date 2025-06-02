using System;
using System.Collections.Concurrent;
using System.Data.SqlClient;
using System.IO;
using System.Threading.Tasks;
using System.Windows.Forms;
using CapaPresentacion;
using Telegram.Bot;
using Telegram.Bot.Polling;
using Telegram.Bot.Types;
using Telegram.Bot.Types.Enums;
using Telegram.Bot.Types.ReplyMarkups;

namespace SistemadeVentas
{
    static class Program
    {
        private static readonly string telegramToken = "7504474587:AAGnAewBAK6TaixnRdnhka6Ootw_SMXCBvo";
        private static readonly string connectionString = "Data Source=DESKTOP-1F4MGDH;Initial Catalog=dbventaBot;Integrated Security=True";

        private static TelegramBotClient botClient;
        private static ConcurrentDictionary<long, string> sesiones = new ConcurrentDictionary<long, string>();
        private static System.Threading.CancellationTokenSource cts;

        [STAThread]
        static void Main()
        {
            Task.Run(() => IniciarBotTelegram());

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            FrmLogin login = new FrmLogin();
            DialogResult result = login.ShowDialog();

            if (result == DialogResult.OK && login.Tag is FrmPrincipal frm)
            {
                Application.Run(frm);
            }
        }

        private static async Task IniciarBotTelegram()
        {
            botClient = new TelegramBotClient(telegramToken);
            cts = new System.Threading.CancellationTokenSource();
            var receiverOptions = new ReceiverOptions { AllowedUpdates = { } };

            botClient.StartReceiving(
                HandleUpdateAsync,
                HandleErrorAsync,
                receiverOptions,
                cancellationToken: cts.Token);

            var me = await botClient.GetMeAsync();
            Console.WriteLine($"Bot iniciado: @{me.Username}");

            await Task.Delay(-1, cts.Token);
        }

        private static async Task HandleUpdateAsync(ITelegramBotClient bot, Update update, System.Threading.CancellationToken token)
        {
            if (update.Type == UpdateType.Message && update.Message.Type == MessageType.Text)
            {
                long chatId = update.Message.Chat.Id;
                string texto = update.Message.Text.Trim();

                if (texto == "/start")
                {
                    await bot.SendTextMessageAsync(chatId, "Hola, soy Ventabot. Por favor envíame tu número de documento.");
                    return;
                }

                if (!sesiones.ContainsKey(chatId))
                {
                    var info = await ObtenerRolYNombrePorDocumentoAsync(texto);
                    if (info != null)
                    {
                        sesiones[chatId] = texto;
                        await bot.SendTextMessageAsync(chatId, $"Hola {info.NombreCompleto}, tu rol es: {info.Rol}");
                        var menu = ObtenerMenuPorRol(info.Rol);
                        await bot.SendTextMessageAsync(chatId, "Selecciona una opción:", replyMarkup: menu);
                    }
                    else
                    {
                        await bot.SendTextMessageAsync(chatId, "Documento no registrado.");
                    }
                }
                else
                {
                    await bot.SendTextMessageAsync(chatId, "Ya estás autenticado. Usa el menú.");
                }
            }
            else if (update.Type == UpdateType.CallbackQuery)
            {
                var callback = update.CallbackQuery;
                long chatId = callback.Message.Chat.Id;
                string opcion = callback.Data;

                if (!sesiones.TryGetValue(chatId, out string documento))
                {
                    await bot.SendTextMessageAsync(chatId, "Primero envía tu número de documento.");
                    return;
                }

                string respuesta = await EjecutarConsultaAsync(opcion, documento);
                await bot.SendTextMessageAsync(chatId, respuesta);
                await bot.AnswerCallbackQueryAsync(callback.Id);
            }
        }

        private static Task HandleErrorAsync(ITelegramBotClient bot, Exception ex, System.Threading.CancellationToken token)
        {
            Console.WriteLine($"Error en bot: {ex.Message}");
            return Task.CompletedTask;
        }

        private static async Task<string> EjecutarConsultaAsync(string opcion, string documento)
        {
            try
            {
                using var conn = new SqlConnection(connectionString);
                await conn.OpenAsync();

                if (opcion == "productos")
                {
                    string sql = "SELECT TOP 5 nombre, descripcion FROM articulo ORDER BY idarticulo DESC";
                    using var cmd = new SqlCommand(sql, conn);
                    using var reader = await cmd.ExecuteReaderAsync();

                    string resultado = "Productos disponibles:\n";
                    while (await reader.ReadAsync())
                    {
                        resultado += $"- {reader["nombre"]}: {reader["descripcion"]}\n";
                    }
                    return resultado;
                }
                else if (opcion == "mis_compras")
                {
                    string sqlCliente = "SELECT idcliente FROM cliente WHERE num_documento = @doc";
                    using var cmdCliente = new SqlCommand(sqlCliente, conn);
                    cmdCliente.Parameters.AddWithValue("@doc", documento);
                    var id = await cmdCliente.ExecuteScalarAsync();

                    if (id == null) return "No se encontró tu información de cliente.";

                    int idcliente = Convert.ToInt32(id);

                    string sql = @"SELECT v.idventa, v.fecha, SUM(dv.cantidad * dv.precio_venta) AS total
                                   FROM venta v
                                   INNER JOIN detalle_venta dv ON v.idventa = dv.idventa
                                   WHERE v.idcliente = @idcliente
                                   GROUP BY v.idventa, v.fecha
                                   ORDER BY v.fecha DESC";

                    using var cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@idcliente", idcliente);
                    using var reader = await cmd.ExecuteReaderAsync();

                    string resultado = "Tus compras:\n";
                    bool tieneCompras = false;
                    while (await reader.ReadAsync())
                    {
                        tieneCompras = true;
                        resultado += $"- Venta #{reader["idventa"]} | Fecha: {Convert.ToDateTime(reader["fecha"]).ToShortDateString()} | Total: {reader["total"]:C}\n";
                    }

                    return tieneCompras ? resultado : "No tienes compras registradas.";
                }

                return "Opción no válida.";
            }
            catch (Exception ex)
            {
                return $"Error en consulta: {ex.Message}";
            }
        }

        private class RolNombre
        {
            public string Rol { get; set; }
            public string NombreCompleto { get; set; }
        }

        private static async Task<RolNombre> ObtenerRolYNombrePorDocumentoAsync(string documento)
        {
            using var conn = new SqlConnection(connectionString);
            await conn.OpenAsync();

            string sql = "SELECT acceso, nombre + ' ' + apellidos AS NombreCompleto FROM trabajador WHERE num_documento = @doc";
            using var cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@doc", documento);

            using var reader = await cmd.ExecuteReaderAsync();
            if (await reader.ReadAsync())
            {
                return new RolNombre
                {
                    Rol = reader.GetString(0),
                    NombreCompleto = reader.GetString(1)
                };
            }

            reader.Close();

            sql = "SELECT nombre + ' ' + apellidos AS NombreCompleto FROM cliente WHERE num_documento = @doc";
            using var cmdCli = new SqlCommand(sql, conn);
            cmdCli.Parameters.AddWithValue("@doc", documento);
            using var readerCli = await cmdCli.ExecuteReaderAsync();

            if (await readerCli.ReadAsync())
            {
                return new RolNombre
                {
                    Rol = "Cliente",
                    NombreCompleto = readerCli.GetString(0)
                };
            }

            return null;
        }

        private static InlineKeyboardMarkup ObtenerMenuPorRol(string rol)
        {
            (string Texto, string Comando)[] opciones;

            if (rol.ToLower() == "cliente")
            {
                opciones = new[]
                {
                    ("Mis compras", "mis_compras"),
                    ("Consultar productos", "productos")
                };
            }
            else
            {
                opciones = new[]
                {
                    ("Consultar productos", "productos")
                };
            }

            var botones = new System.Collections.Generic.List<InlineKeyboardButton[]>();
            foreach (var opt in opciones)
            {
                botones.Add(new[] { InlineKeyboardButton.WithCallbackData(opt.Texto, opt.Comando) });
            }

            return new InlineKeyboardMarkup(botones);
        }
    }
}
