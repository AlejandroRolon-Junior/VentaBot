
using System;
using System.Data;
using System.Windows.Forms;
using CapaNegocio;

namespace CapaPresentacion
{
    public partial class FrmLogin : Form
    {
        public FrmLogin()
        {
            InitializeComponent();
            timer1.Start();
        }

        private void btnIngresar_Click(object sender, EventArgs e)
        {
            DataTable Datos = NTrabajador.Login(this.txtUsuario.Text, this.txtPassword.Text);

            if (Datos.Rows.Count == 0)
            {
                MessageBox.Show("No tiene acceso al sistema", "Acceso denegado", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
            {
                FrmPrincipal frm = new FrmPrincipal();
                frm.Idtrabajador = Datos.Rows[0][0].ToString();
                frm.Apellidos = Datos.Rows[0][1].ToString();
                frm.Nombre = Datos.Rows[0][2].ToString();
                frm.Acceso = Datos.Rows[0][3].ToString();

                this.Tag = frm; // ✅ PASAR LA REFERENCIA PARA Program.cs
                this.DialogResult = DialogResult.OK; // ✅ EJECUTAR Application.Run(frm)
            }
        }

        private void btnSalir_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            LblHora.Text = DateTime.Now.ToString("hh:mm:ss tt");
        }

        private void txtPassword_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtUsuario_TextChanged(object sender, EventArgs e)
        {

        }

        private void picBot_Click(object sender, EventArgs e)
        {

        }
    }
}
