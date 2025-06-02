using System;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using CapaPresentacion.Consultas;

namespace CapaPresentacion
{
    public partial class FrmPrincipal : Form
    {
        public string Idtrabajador { get; set; }
        public string Apellidos { get; set; }
        public string Nombre { get; set; }
        public string Acceso { get; set; }

        public FrmPrincipal()
        {
            InitializeComponent();
            IsMdiContainer = true;
        }

        private void FrmPrincipal_Load(object sender, EventArgs e)
        {
            byte[] botBytes = Properties.Resources.BotAnimation;
            MemoryStream msBot = new MemoryStream(botBytes);
            PicBot.Image = Image.FromStream(msBot);

            byte[] userBytes = Properties.Resources.UsuarioDefault;
            MemoryStream msUser = new MemoryStream(userBytes);
            PicUsuario.Image = Image.FromStream(msUser);
        }

        private void CambiarImagenToolStripMenuItem_Click(object sender, EventArgs e)
        {
            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Filter = "Imágenes (*.jpg;*.png)|*.jpg;*.png";

            if (ofd.ShowDialog() == DialogResult.OK && File.Exists(ofd.FileName))
            {
                try
                {
                    byte[] bytes = File.ReadAllBytes(ofd.FileName);
                    MemoryStream ms = new MemoryStream(bytes);
                    Image img = Image.FromStream(ms);
                    PicUsuario.Image = img;
                }
                catch
                {
                    MessageBox.Show("No se pudo cargar la imagen.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }


        // Eventos de submenús conectados a tu lógica original

        private void BtnArticulos_Click(object sender, EventArgs e)
        {
            frmArticulo frm = new frmArticulo();
            frm.MdiParent = this;
            frm.Show();
        }

        private void BtnProveedores_Click(object sender, EventArgs e)
        {
            FrmProveedor frm = new FrmProveedor();
            frm.MdiParent = this;
            frm.Show();
        }

        private void BtnIngresos_Click(object sender, EventArgs e)
        {
            frmIngreso frm = new frmIngreso();
            frm.MdiParent = this;
            frm.Show();
        }

        private void BtnClientes_Click(object sender, EventArgs e)
        {
            frmCliente frm = new frmCliente();
            frm.MdiParent = this;
            frm.Show();
        }

        private void BtnVentas_Click(object sender, EventArgs e)
        {
            FrmVenta frm = new FrmVenta();
            frm.MdiParent = this;
            frm.Show();
        }

        private void BtnTrabajadores_Click(object sender, EventArgs e)
        {
            frmTrabajador frm = new frmTrabajador();
            frm.MdiParent = this;
            frm.Show();
        }

        private void BtnConsultaStock_Click(object sender, EventArgs e)
        {
            FrmConsulta_Stock_Articulos frm = new FrmConsulta_Stock_Articulos();
            frm.MdiParent = this;
            frm.Show();
        }

        private void BtnConsultaCompras_Click(object sender, EventArgs e)
        {
            FrmVistaArticulo_Ingreso frm = new FrmVistaArticulo_Ingreso();
            frm.MdiParent = this;
            frm.Show();
        }

        private void BtnConsultaVentas_Click(object sender, EventArgs e)
        {
            FrmVistaArticulo_Venta frm = new FrmVistaArticulo_Venta();
            frm.MdiParent = this;
            frm.Show();
        }
    }
}
