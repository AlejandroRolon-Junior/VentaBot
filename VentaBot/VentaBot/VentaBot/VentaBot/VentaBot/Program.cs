using System;
using System.Collections.Concurrent;
using System.Data.SqlClient;
using System.Text;
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
        // REEMPLAZA ESTOS DATOS:
        private static readonly string telegramToken = "7504474587:AAGnAewBAK6TaixnRdnhka6Ootw_SMXCBvo";
        private static readonly string connectionString = "Data Source=DESKTOP-1F4MGDH;Initial Catalog=dbventaBot;Integrated Security=True";

        private static TelegramBotClient botClient;

        // Para mantener sesiones: chatId -> documento
        private static ConcurrentDictionary<long, string> sesiones = new ConcurrentDictionary<long, string>();

        [STAThread]
        static void Main()
        {
            Task.Run(() => IniciarBotTelegram());

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new frmLogin());
        }

        static async Task IniciarBotTelegram()
        {
            botClient = new TelegramBotClient(telegramToken);

            var cts = new System.Threading.CancellationTokenSource();
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

        static async Task HandleUpdateAsync(ITelegramBotClient bot, Update update, System.Threading.CancellationToken token)
        {
            if (update.Type == UpdateType.Message && update.Message.Type == MessageType.Text)
            {
                long chatId = update.Message.Chat.Id;
                string texto = update.Message.Text.Trim();

                // <-- Aquí agregas el manejo del comando /start
                if (texto == "/start")
                {
                    string bienvenida = "Hola, soy Ventabot, tu asistente de ventas.\n" +
                                        "Por favor, envíame tu número de documento para comenzar.";
                    await bot.SendTextMessageAsync(chatId, bienvenida);
                    return;
                }
                // <--

                if (!sesiones.ContainsKey(chatId))
                {
                    var rolNombre = await ObtenerRolYNombrePorDocumentoAsync(texto);
                    if (rolNombre != null)
                    {
                        sesiones[chatId] = texto;

                        string saludo = $"Hola {rolNombre.NombreCompleto}, tu rol es: {rolNombre.Rol}";
                        await bot.SendTextMessageAsync(chatId, saludo);

                        var menu = ObtenerMenuPorRol(rolNombre.Rol);
                        await bot.SendTextMessageAsync(chatId, "Selecciona una opción:", replyMarkup: menu);
                    }
                    else
                    {
                        await bot.SendTextMessageAsync(chatId, "Documento no registrado. Por favor intenta de nuevo.");
                    }
                }
                else
                {
                    await bot.SendTextMessageAsync(chatId, "Por favor, usa el menú para seleccionar opciones.");
                }
            }
            else if (update.Type == UpdateType.CallbackQuery)
            {
                var callback = update.CallbackQuery;
                long chatId = callback.Message.Chat.Id;
                string opcion = callback.Data;

                if (!sesiones.TryGetValue(chatId, out string documento))
                {
                    await bot.SendTextMessageAsync(chatId, "Primero envía tu número de documento para autenticarte.");
                    await bot.AnswerCallbackQueryAsync(callback.Id);
                    return;
                }

                var rolNombre = await ObtenerRolYNombrePorDocumentoAsync(documento);
                if (rolNombre == null)
                {
                    await bot.SendTextMessageAsync(chatId, "Error: usuario no encontrado. Reenvía tu documento.");
                    sesiones.TryRemove(chatId, out _);
                    await bot.AnswerCallbackQueryAsync(callback.Id);
                    return;
                }

                string respuesta = await EjecutarConsultaPorOpcionAsync(rolNombre.Rol, opcion, documento);
                await bot.SendTextMessageAsync(chatId, respuesta);

                await bot.AnswerCallbackQueryAsync(callback.Id);
            }
        }


        static Task HandleErrorAsync(ITelegramBotClient bot, Exception ex, System.Threading.CancellationToken token)
        {
            Console.WriteLine(ex.ToString());
            return Task.CompletedTask;
        }

        // Clase simple para guardar rol y nombre
        class RolNombre
        {
            public string Rol { get; set; }
            public string NombreCompleto { get; set; }
        }

        static async Task<RolNombre> ObtenerRolYNombrePorDocumentoAsync(string documento)
        {
            using var conn = new SqlConnection(connectionString);
            await conn.OpenAsync();

            // Buscar trabajador
            string sqlTrab = @"SELECT acceso, nombre + ' ' + apellidos AS NombreCompleto FROM trabajador WHERE num_documento = @doc";
            using var cmdTrab = new SqlCommand(sqlTrab, conn);
            cmdTrab.Parameters.AddWithValue("@doc", documento);
            using var readerTrab = await cmdTrab.ExecuteReaderAsync();
            if (await readerTrab.ReadAsync())
            {
                return new RolNombre
                {
                    Rol = readerTrab.GetString(0),
                    NombreCompleto = readerTrab.GetString(1)
                };
            }
            readerTrab.Close();

            // Buscar cliente
            string sqlCli = @"SELECT nombre + ' ' + apellidos AS NombreCompleto FROM cliente WHERE num_documento = @doc";
            using var cmdCli = new SqlCommand(sqlCli, conn);
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

        static InlineKeyboardMarkup ObtenerMenuPorRol(string rol)
        {
            (string Texto, string Comando)[] opciones;

            switch (rol.ToLower())
            {
                case "admin":
                    opciones = new[]
                    {
                        ("Ver últimas ventas", "ventas"),
                        ("Gestionar usuarios", "usuarios"),
                        ("Consultar productos", "productos")
                    };
                    break;

                case "vendedor":
                    opciones = new[]
                    {
                        ("Ver mis ventas", "ventas_vendedor"),
                        ("Consultar productos", "productos")
                    };
                    break;

                case "cliente":
                    opciones = new[]
                    {
                        ("Mis compras", "mis_compras"),
                        ("Consultar productos", "productos")
                    };
                    break;

                default:
                    opciones = new[]
                    {
                        ("Consultar productos", "productos")
                    };
                    break;
            }

            var botones = new System.Collections.Generic.List<InlineKeyboardButton[]>();
            foreach (var opt in opciones)
            {
                botones.Add(new[] { InlineKeyboardButton.WithCallbackData(opt.Texto, opt.Comando) });
            }

            return new InlineKeyboardMarkup(botones);
        }

        static async Task<string> EjecutarConsultaPorOpcionAsync(string rol, string opcion, string documento)
        {
            using var conn = new SqlConnection(connectionString);
            await conn.OpenAsync();

            StringBuilder sb = new();

            try
            {
                switch (opcion)
                {
                    case "ventas":
                        if (!rol.Equals("admin", StringComparison.OrdinalIgnoreCase))
                            return "No tienes permiso para esta opción.";

                        {
                            string sql = @"SELECT TOP 5 v.idventa, c.nombre + ' ' + c.apellidos AS cliente, v.fecha 
                                           FROM venta v
                                           INNER JOIN cliente c ON v.idcliente = c.idcliente
                                           ORDER BY v.fecha DESC";

                            using var cmd = new SqlCommand(sql, conn);
                            using var reader = await cmd.ExecuteReaderAsync();
                            sb.AppendLine("Últimas ventas:");
                            while (await reader.ReadAsync())
                            {
                                sb.AppendLine($"Venta #{reader["idventa"]} - Cliente: {reader["cliente"]} - Fecha: {((DateTime)reader["fecha"]).ToShortDateString()}");
                            }
                        }
                        break;

                    case "usuarios":
                        if (!rol.Equals("admin", StringComparison.OrdinalIgnoreCase))
                            return "No tienes permiso para esta opción.";

                        {
                            string sql = @"SELECT nombre, apellidos, acceso FROM trabajador ORDER BY nombre";
                            using var cmd = new SqlCommand(sql, conn);
                            using var reader = await cmd.ExecuteReaderAsync();
                            sb.AppendLine("Usuarios registrados:");
                            while (await reader.ReadAsync())
                            {
                                sb.AppendLine($"{reader["nombre"]} {reader["apellidos"]} - Rol: {reader["acceso"]}");
                            }
                        }
                        break;

                    case "productos":
                        {
                            string sql = @"SELECT TOP 10 nombre, descripcion FROM articulo ORDER BY idarticulo DESC";
                            using var cmd = new SqlCommand(sql, conn);
                            using var reader = await cmd.ExecuteReaderAsync();
                            sb.AppendLine("Productos disponibles:");
                            while (await reader.ReadAsync())
                            {
                                sb.AppendLine($"{reader["nombre"]}: {reader["descripcion"]}");
                            }
                        }
                        break;

                    case "mis_compras":
                        if (!rol.Equals("cliente", StringComparison.OrdinalIgnoreCase))
                            return "No tienes permiso para esta opción.";

                        {
                            int idcliente = await ObtenerIdClientePorDocumentoAsync(documento, conn);
                            if (idcliente == 0)
                                return "No se encontró tu información de cliente.";

                            string sql = @"SELECT v.idventa, v.fecha, v.tipo_comprobante, v.serie, v.correlativo, SUM(dv.cantidad * dv.precio_venta) AS total
                                           FROM venta v
                                           INNER JOIN detalle_venta dv ON v.idventa = dv.idventa
                                           WHERE v.idcliente = @idcliente
                                           GROUP BY v.idventa, v.fecha, v.tipo_comprobante, v.serie, v.correlativo
                                           ORDER BY v.fecha DESC";

                            using var cmd = new SqlCommand(sql, conn);
                            cmd.Parameters.AddWithValue("@idcliente", idcliente);
                            using var reader = await cmd.ExecuteReaderAsync();
                            sb.AppendLine("Tus compras recientes:");
                            bool tiene = false;
                            while (await reader.ReadAsync())
                            {
                                tiene = true;
                                sb.AppendLine($"Venta #{reader["idventa"]} - Fecha: {((DateTime)reader["fecha"]).ToShortDateString()} - Total: {Convert.ToDecimal(reader["total"]):C}");
                            }
                            if (!tiene) return "No tienes compras registradas.";
                        }
                        break;

                    case "ventas_vendedor":
                        if (!rol.Equals("vendedor", StringComparison.OrdinalIgnoreCase))
                            return "No tienes permiso para esta opción.";

                        {
                            int idtrabajador = await ObtenerIdTrabajadorPorDocumentoAsync(documento, conn);
                            if (idtrabajador == 0)
                                return "No se encontró tu información de trabajador.";

                            string sql = @"SELECT v.idventa, c.nombre + ' ' + c.apellidos AS cliente, v.fecha
                                           FROM venta v
                                           INNER JOIN cliente c ON v.idcliente = c.idcliente
                                           WHERE v.idtrabajador = @idtrabajador
                                           ORDER BY v.fecha DESC";

                            using var cmd = new SqlCommand(sql, conn);
                            cmd.Parameters.AddWithValue("@idtrabajador", idtrabajador);
                            using var reader = await cmd.ExecuteReaderAsync();
                            sb.AppendLine("Tus ventas asignadas:");
                            bool tiene = false;
                            while (await reader.ReadAsync())
                            {
                                tiene = true;
                                sb.AppendLine($"Venta #{reader["idventa"]} - Cliente: {reader["cliente"]} - Fecha: {((DateTime)reader["fecha"]).ToShortDateString()}");
                            }
                            if (!tiene) return "No tienes ventas asignadas.";
                        }
                        break;

                    default:
                        return "Opción no reconocida.";
                }
            }
            catch (Exception ex)
            {
                return $"Error en consulta: {ex.Message}";
            }

            return sb.ToString();
        }

        static async Task<int> ObtenerIdClientePorDocumentoAsync(string documento, SqlConnection conn)
        {
            string sql = "SELECT idcliente FROM cliente WHERE num_documento = @doc";
            using var cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@doc", documento);
            var result = await cmd.ExecuteScalarAsync();
            return result != null ? Convert.ToInt32(result) : 0;
        }

        static async Task<int> ObtenerIdTrabajadorPorDocumentoAsync(string documento, SqlConnection conn)
        {
            string sql = "SELECT idtrabajador FROM trabajador WHERE num_documento = @doc";
            using var cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@doc", documento);
            var result = await cmd.ExecuteScalarAsync();
            return result != null ? Convert.ToInt32(result) : 0;
        }
    }
}
