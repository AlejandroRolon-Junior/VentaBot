using System.Windows.Forms;
using System.Drawing;
using System.IO;

namespace CapaPresentacion
{
    partial class FrmPrincipal
    {
        private System.ComponentModel.IContainer components = null;

        private Guna.UI2.WinForms.Guna2Panel PanelMenu;
        private Guna.UI2.WinForms.Guna2CirclePictureBox PicUsuario;
        private Guna.UI2.WinForms.Guna2CirclePictureBox PicBot;
        private Guna.UI2.WinForms.Guna2HtmlLabel LblSaludo;
        private ContextMenuStrip MenuUsuario;
        private ToolStripMenuItem CambiarImagenToolStripMenuItem;

        private Guna.UI2.WinForms.Guna2Button BtnAlmacen;
        private Guna.UI2.WinForms.Guna2Panel SubmenuAlmacen;
        private Guna.UI2.WinForms.Guna2Button BtnArticulos;

        private Guna.UI2.WinForms.Guna2Button BtnCompras;
        private Guna.UI2.WinForms.Guna2Panel SubmenuCompras;
        private Guna.UI2.WinForms.Guna2Button BtnProveedores;
        private Guna.UI2.WinForms.Guna2Button BtnIngresos;

        private Guna.UI2.WinForms.Guna2Button BtnVentas;
        private Guna.UI2.WinForms.Guna2Panel SubmenuVentas;
        private Guna.UI2.WinForms.Guna2Button BtnClientes;
        private Guna.UI2.WinForms.Guna2Button BtnVentasSub;

        private Guna.UI2.WinForms.Guna2Button BtnMantenimiento;
        private Guna.UI2.WinForms.Guna2Panel SubmenuMantenimiento;
        private Guna.UI2.WinForms.Guna2Button BtnTrabajadores;

        private Guna.UI2.WinForms.Guna2Button BtnConsultas;
        private Guna.UI2.WinForms.Guna2Panel SubmenuConsultas;
        private Guna.UI2.WinForms.Guna2Button BtnConsultaStock;
        private Guna.UI2.WinForms.Guna2Button BtnConsultaCompras;
        private Guna.UI2.WinForms.Guna2Button BtnConsultaVentas;

        protected override void Dispose(bool disposing)
        {
            if (disposing && components != null) components.Dispose();
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            components = new System.ComponentModel.Container();

            PanelMenu = new Guna.UI2.WinForms.Guna2Panel();
            PicUsuario = new Guna.UI2.WinForms.Guna2CirclePictureBox();
            PicBot = new Guna.UI2.WinForms.Guna2CirclePictureBox();
            LblSaludo = new Guna.UI2.WinForms.Guna2HtmlLabel();
            MenuUsuario = new ContextMenuStrip(components);
            CambiarImagenToolStripMenuItem = new ToolStripMenuItem();

            // Panel lateral
            PanelMenu.Dock = DockStyle.Left;
            PanelMenu.FillColor = Color.Black;
            PanelMenu.Size = new Size(220, 600);
           
            PanelMenu.Controls.Add(PicBot);
            PanelMenu.Controls.Add(LblSaludo);

    

            // Imagen animada bot


// Imagen animada Bot centrada en PanelMenu
PicBot.Size = new Size(100, 100);
PicBot.Location = new Point((PanelMenu.Width - 100) / 2, 30);
PicBot.SizeMode = PictureBoxSizeMode.Zoom;
PicBot.BackColor = Color.Transparent;

// Solo agregamos PicBot, quitamos PicUsuario por completo
PanelMenu.Controls.Add(PicBot);


            // Saludo
            LblSaludo.Text = "ROL: Bienvenido";
            LblSaludo.ForeColor = Color.White;
            LblSaludo.Location = new Point(10, 190);
            LblSaludo.Size = new Size(200, 25);

         

            // Botones principales
            BtnAlmacen = CrearBoton("Almacén", new Point(10, 230));
            BtnAlmacen.Click += (s, e) => SubmenuAlmacen.Visible = !SubmenuAlmacen.Visible;

            BtnCompras = CrearBoton("Compras", new Point(10, 300));
            BtnCompras.Click += (s, e) => SubmenuCompras.Visible = !SubmenuCompras.Visible;

            BtnVentas = CrearBoton("Ventas", new Point(10, 370));
            BtnVentas.Click += (s, e) => SubmenuVentas.Visible = !SubmenuVentas.Visible;

            BtnMantenimiento = CrearBoton("Mantenimiento", new Point(10, 440));
            BtnMantenimiento.Click += (s, e) => SubmenuMantenimiento.Visible = !SubmenuMantenimiento.Visible;

            BtnConsultas = CrearBoton("Consultas", new Point(10, 510));
            BtnConsultas.Click += (s, e) => SubmenuConsultas.Visible = !SubmenuConsultas.Visible;

            // Submenús
            SubmenuAlmacen = CrearSubPanel(new Point(30, 270));
            BtnArticulos = CrearSubBoton("Artículos", new Point(0, 0));
            BtnArticulos.Click += BtnArticulos_Click;
            SubmenuAlmacen.Controls.Add(BtnArticulos);

            SubmenuCompras = CrearSubPanel(new Point(30, 340));
            BtnProveedores = CrearSubBoton("Proveedores", new Point(0, 0));
            BtnIngresos = CrearSubBoton("Ingresos", new Point(0, 35));
            BtnProveedores.Click += BtnProveedores_Click;
            BtnIngresos.Click += BtnIngresos_Click;
            SubmenuCompras.Controls.Add(BtnProveedores);
            SubmenuCompras.Controls.Add(BtnIngresos);

            SubmenuVentas = CrearSubPanel(new Point(30, 410));
            BtnClientes = CrearSubBoton("Clientes", new Point(0, 0));
            BtnVentasSub = CrearSubBoton("Ventas", new Point(0, 35));
            BtnClientes.Click += BtnClientes_Click;
            BtnVentasSub.Click += BtnVentas_Click;
            SubmenuVentas.Controls.Add(BtnClientes);
            SubmenuVentas.Controls.Add(BtnVentasSub);

            SubmenuMantenimiento = CrearSubPanel(new Point(30, 480));
            BtnTrabajadores = CrearSubBoton("Trabajadores", new Point(0, 0));
            BtnTrabajadores.Click += BtnTrabajadores_Click;
            SubmenuMantenimiento.Controls.Add(BtnTrabajadores);

            SubmenuConsultas = CrearSubPanel(new Point(30, 550));
            BtnConsultaStock = CrearSubBoton("Stock", new Point(0, 0));
            BtnConsultaCompras = CrearSubBoton("Compras x Fecha", new Point(0, 35));
            BtnConsultaVentas = CrearSubBoton("Ventas x Fecha", new Point(0, 70));
            BtnConsultaStock.Click += BtnConsultaStock_Click;
            BtnConsultaCompras.Click += BtnConsultaCompras_Click;
            BtnConsultaVentas.Click += BtnConsultaVentas_Click;
            SubmenuConsultas.Controls.Add(BtnConsultaStock);
            SubmenuConsultas.Controls.Add(BtnConsultaCompras);
            SubmenuConsultas.Controls.Add(BtnConsultaVentas);

            PanelMenu.Controls.AddRange(new Control[] {
                BtnAlmacen, SubmenuAlmacen,
                BtnCompras, SubmenuCompras,
                BtnVentas, SubmenuVentas,
                BtnMantenimiento, SubmenuMantenimiento,
                BtnConsultas, SubmenuConsultas
            });

            // Configuración final del formulario
            this.Controls.Add(PanelMenu);
            this.Text = "VentaBot";
            this.BackColor = Color.FromArgb(15, 15, 15);
            this.ClientSize = new Size(1000, 600);
            this.Load += FrmPrincipal_Load;
        }

        private Guna.UI2.WinForms.Guna2Button CrearBoton(string texto, Point location)
        {
            var btn = new Guna.UI2.WinForms.Guna2Button();
            btn.Text = texto;
            btn.Size = new Size(180, 40);
            btn.FillColor = Color.FromArgb(255, 60, 60);
            btn.ForeColor = Color.White;
            btn.Font = new Font("Segoe UI", 10F);
            btn.Location = location;
            btn.BorderRadius = 10;
            return btn;
        }

        private Guna.UI2.WinForms.Guna2Button CrearSubBoton(string texto, Point location)
        {
            var btn = new Guna.UI2.WinForms.Guna2Button();
            btn.Text = texto;
            btn.Size = new Size(160, 30);
            btn.FillColor = Color.FromArgb(40, 40, 40);
            btn.ForeColor = Color.White;
            btn.Font = new Font("Segoe UI", 9F);
            btn.Location = location;
            btn.BorderRadius = 5;
            return btn;
        }

        private Guna.UI2.WinForms.Guna2Panel CrearSubPanel(Point location)
        {
            var pnl = new Guna.UI2.WinForms.Guna2Panel();
            pnl.FillColor = Color.FromArgb(25, 25, 25);
            pnl.Size = new Size(170, 100);
            pnl.Location = location;
            pnl.Visible = false;
            return pnl;
        }
    }
}
