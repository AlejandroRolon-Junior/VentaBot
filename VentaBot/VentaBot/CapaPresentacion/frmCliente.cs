﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using CapaNegocio;

namespace CapaPresentacion
{
    public partial class frmCliente : Form
    {

        private bool IsNuevo = false;
        private bool IsEditar = false;

        public frmCliente()
        {
            InitializeComponent();
            this.ttMensaje.SetToolTip(this.txtNombre, "Ingrese el nombre del cliente");
            this.ttMensaje.SetToolTip(this.txtApellidos, "Ingrese los apellidos del cliente");
            this.ttMensaje.SetToolTip(this.txtDireccion, "Ingrese la dirección del cliente");
            this.ttMensaje.SetToolTip(this.txtNum_Documento, "Ingrese el número de documento del cliente");
        }

        // Mostrar mensaje de Confirmación
        private void MensajeOk(string mensaje)
        {
            MessageBox.Show(mensaje, "Sistema de ventas", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
        // Mostrar mensaje de error
        private void MensajeError(string mensaje)
        {
            MessageBox.Show(mensaje, "Sistema de ventas", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        // Limpiar todos los controles del formulario
        private void Limpiar()
        {
            this.txtNombre.Text = string.Empty;
            this.txtApellidos.Text = string.Empty;
            this.txtNum_Documento.Text = string.Empty;
            this.txtDireccion.Text = string.Empty;
            this.txtTelefono.Text = string.Empty;
            this.txtEmail.Text = string.Empty;
            this.txtIdcliente.Text = string.Empty;
        }

        // Habilitar los controles del formulario
        private void Habilitar(bool valor)
        {
            this.txtNombre.ReadOnly = !valor;
            this.txtApellidos.ReadOnly = !valor;
            this.txtDireccion.ReadOnly = !valor;
            this.cbTipo_Documento.Enabled = valor;
            this.txtNum_Documento.ReadOnly = !valor;
            this.txtTelefono.ReadOnly = !valor;
            this.txtEmail.ReadOnly = !valor;
            this.txtIdcliente.ReadOnly = !valor;
        }

        // Habilitar los botones del formulario
        private void Botones()
        {
            if (this.IsNuevo || this.IsEditar)
            {
                this.Habilitar(true);
                this.btnNuevo.Enabled = false;
                this.btnGuardar.Enabled = true;
                this.btnEditar.Enabled = false;
                this.btnCancelar.Enabled = true;
            }
            else
            {
                this.Habilitar(false);
                this.btnNuevo.Enabled = true;
                this.btnGuardar.Enabled = false;
                this.btnEditar.Enabled = true;
                this.btnCancelar.Enabled = false;
            }
        }

        // Ocultar columnas
        private void OcultarColumnas()
        {
            this.dataListado.Columns[0].Visible = false;
            this.dataListado.Columns[1].Visible = false;
        }

        // Método Mostrar
        private void Mostrar()
        {
            this.dataListado.DataSource = NCliente.Mostrar();
            this.OcultarColumnas();
            lblTotal.Text = "Total de Registros: " + Convert.ToString(dataListado.Rows.Count);
        }

        // Método BuscarApellidos
        private void BuscarApellidos()
        {
            this.dataListado.DataSource = NCliente.BuscarApellidos(this.txtBuscar.Text);
            this.OcultarColumnas();
            lblTotal.Text = "Total de Registros: " + Convert.ToString(dataListado.Rows.Count);
        }

        // Método BuscarNum_Documento
        private void BuscarNum_Documento()
        {
            this.dataListado.DataSource = NCliente.BuscarNum_Documento(this.txtBuscar.Text);
            this.OcultarColumnas();
            lblTotal.Text = "Total de Registros: " + Convert.ToString(dataListado.Rows.Count);
        }

        private void Label2_Click(object sender, EventArgs e)
        {

        }

        private void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void CbTipo_Documento_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void FrmCliente_Load(object sender, EventArgs e)
        {
            this.Top = 0;
            this.Left = 0;
            this.Mostrar();
            this.Habilitar(false);
            this.Botones();
        }

        private void BtnBuscar_Click(object sender, EventArgs e)
        {
            if (cbBuscar.Text.Equals("Apellidos"))
            {
                this.BuscarApellidos();
            }
            else if (cbBuscar.Text.Equals("Documento"))
            {
                this.BuscarNum_Documento();
            }
        }

        private void BtnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult Opcion;
                Opcion = MessageBox.Show("Realmente desea eliminar los registros", "Sistema de ventas", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);

                if (Opcion == DialogResult.OK)
                {
                    string Codigo;
                    string Rpta = "";

                    foreach (DataGridViewRow row in dataListado.Rows)
                    {
                        if (Convert.ToBoolean(row.Cells[0].Value))
                        {
                            Codigo = Convert.ToString(row.Cells[1].Value);
                            Rpta = NCliente.Eliminar(Convert.ToInt32(Codigo));

                            if (Rpta.Equals("OK"))
                            {
                                this.MensajeOk("Se eliminó el registro correctamente");
                            }
                            else
                            {
                                this.MensajeError(Rpta);
                            }
                        }
                    }
                    this.Mostrar();
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + ex.StackTrace);
            }
        }

        private void ChkEliminar_CheckedChanged(object sender, EventArgs e)
        {
            if (chkEliminar.Checked)
            {
                this.dataListado.Columns[0].Visible = true;
            }
            else
            {
                this.dataListado.Columns[0].Visible = false;
            }
        }

        private void DataListado_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.ColumnIndex == dataListado.Columns["Eliminar"].Index)
            {
                DataGridViewCheckBoxCell ChkEliminar = (DataGridViewCheckBoxCell)dataListado.Rows[e.RowIndex].Cells["Eliminar"];
                ChkEliminar.Value = !Convert.ToBoolean(ChkEliminar.Value);
            }
        }

        private void DataListado_DoubleClick(object sender, EventArgs e)
        {
            this.txtIdcliente.Text = Convert.ToString(this.dataListado.CurrentRow.Cells["idcliente"].Value);
            this.txtNombre.Text = Convert.ToString(this.dataListado.CurrentRow.Cells["nombre"].Value);
            this.txtApellidos.Text = Convert.ToString(this.dataListado.CurrentRow.Cells["apellidos"].Value);
            this.cbSexo.Text = Convert.ToString(this.dataListado.CurrentRow.Cells["sexo"].Value);
            this.dtFechaNac.Value = Convert.ToDateTime(this.dataListado.CurrentRow.Cells["fecha_nacimiento"].Value);
            this.cbTipo_Documento.Text = Convert.ToString(this.dataListado.CurrentRow.Cells["tipo_documento"].Value);
            this.txtNum_Documento.Text = Convert.ToString(this.dataListado.CurrentRow.Cells["num_documento"].Value);
            this.txtDireccion.Text = Convert.ToString(this.dataListado.CurrentRow.Cells["direccion"].Value);
            this.txtTelefono.Text = Convert.ToString(this.dataListado.CurrentRow.Cells["telefono"].Value);
            this.txtEmail.Text = Convert.ToString(this.dataListado.CurrentRow.Cells["email"].Value);

            this.tabControl1.SelectedIndex = 1;
        }

        private void BtnNuevo_Click(object sender, EventArgs e)
        {
            this.IsNuevo = true;
            this.IsEditar = false;
            this.Botones();
            this.Limpiar();
            this.Habilitar(true);
            this.txtNombre.Focus();
        }

        private void BtnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                string rpta = "";
                if (this.txtNombre.Text == string.Empty || this.txtApellidos.Text == string.Empty || 
                    this.txtNum_Documento.Text == string.Empty
                    || this.txtDireccion.Text == string.Empty)
                {
                    MensajeError("Falta ingresar los datos que serán marcados");
                    errorIcono.SetError(txtNombre, "Ingrese un Valor");
                    errorIcono.SetError(txtApellidos, "Ingrese un Valor");
                    errorIcono.SetError(txtNum_Documento, "Ingrese un Valor");
                    errorIcono.SetError(txtDireccion, "Ingrese un Valor");
                }
                else
                {
                    if (this.IsNuevo)
                    {
                        rpta = NCliente.Insertar(this.txtNombre.Text.Trim().ToUpper(),this.txtApellidos.Text.Trim().ToUpper(),
                            this.cbSexo.Text,dtFechaNac.Value, cbTipo_Documento.Text, txtNum_Documento.Text,
                            txtDireccion.Text, txtTelefono.Text, txtEmail.Text);

                    }
                    else
                    {
                        rpta = NCliente.Editar(Convert.ToInt32(this.txtIdcliente.Text),
                            this.txtNombre.Text.Trim().ToUpper(), this.txtApellidos.Text.Trim().ToUpper(),
                            this.cbSexo.Text, dtFechaNac.Value, cbTipo_Documento.Text, txtNum_Documento.Text,
                            txtDireccion.Text, txtTelefono.Text, txtEmail.Text);
                    }
                    if (rpta.Equals("OK"))
                    {
                        if (this.IsNuevo)
                        {
                            this.MensajeOk("Se insertó de forma correcta el registro");
                        }
                        else
                        {
                            this.MensajeOk("Se actualizó de forma correcta el registro");
                        }
                    }
                    else
                    {
                        this.MensajeError(rpta);
                    }
                    this.IsNuevo = false;
                    this.IsEditar = false;
                    this.Botones();
                    this.Limpiar();
                    this.Mostrar();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + ex.StackTrace);
            }
        }

        private void BtnEditar_Click(object sender, EventArgs e)
        {
            if (!this.txtIdcliente.Text.Equals(""))
            {
                this.IsEditar = true;
                this.Botones();
                this.Habilitar(true);
            }
            else
            {
                this.MensajeError("Primero seleccione el registo a modificar");
            }
        }

        private void BtnCancelar_Click(object sender, EventArgs e)
        {
            this.IsNuevo = false;
            this.IsEditar = false;
            this.Botones();
            this.Habilitar(false);
            this.Limpiar();
            this.txtIdcliente.Text = string.Empty;
        }
    }
}
