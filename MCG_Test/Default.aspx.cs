using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MCG_Test
{
	public partial class _Default : Page
	{
        string con = ConfigurationManager.ConnectionStrings["CON_DB"].ToString();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                GetVacant();
            }

        }

        protected void GetVacant()
        {
            using (SqlConnection myConnection = new SqlConnection(con))
            {
                string oString = "SP_Get_List_Sch";
                SqlCommand cmd = new SqlCommand(oString, myConnection);
                cmd.CommandType = CommandType.StoredProcedure;
                myConnection.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable DT = new DataTable();

                da.Fill(DT);
                myConnection.Close();
                da.Dispose();

                if (DT.Rows.Count == 0)
                {
                    DT.Rows.Add(DT.NewRow());
                    GridView1.DataSource = DT;
                    GridView1.DataBind();
                    int columncount = GridView1.Rows[0].Cells.Count;
                    GridView1.Rows[0].Cells.Clear();
                    GridView1.Rows[0].Cells.Add(new TableCell());
                    GridView1.Rows[0].Cells[0].ColumnSpan = columncount;
                    GridView1.Rows[0].Cells[0].Text = "No Data Found";
                }
                else
                {
                    GridView1.DataSource = DT;
                    GridView1.DataBind();
                }


            }
        }

        private DataTable GetRoom()
        {
            using (SqlConnection myConnection = new SqlConnection(con))
            {
                string oString = "SP_Get_Room";
                SqlCommand cmd = new SqlCommand(oString, myConnection);
                cmd.Parameters.AddWithValue("@StatusRoom", "VACANT");
                cmd.CommandType = CommandType.StoredProcedure;
                myConnection.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable DT = new DataTable();

                da.Fill(DT);
                myConnection.Close();
                da.Dispose();

                return DT;
            }
        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                string item = e.Row.Cells[0].Text;
                foreach (Button button in e.Row.Cells[2].Controls.OfType<Button>())
                {
                    if (button.CommandName == "Delete")
                    {
                        button.Attributes["onclick"] = "if(!confirm('Do you want to delete " + item + "?')){ return false; };";
                    }
                }

                DropDownList cmbRuang = (DropDownList)e.Row.FindControl("ddlRuangan");
                if (cmbRuang != null)
                {
                    cmbRuang.DataSource = GetRoom();
                    cmbRuang.DataTextField = "NamaRuangan";
                    cmbRuang.DataValueField = "Ruangan_PK";
                    cmbRuang.DataBind();
                    cmbRuang.SelectedValue = GridView1.DataKeys[e.Row.RowIndex].Values[1].ToString();
                }

            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                DropDownList cmbNewRuang = (DropDownList)e.Row.FindControl("ddlRuangan");
                cmbNewRuang.DataSource = GetRoom();
                cmbNewRuang.DataTextField = "NamaRuangan";
                cmbNewRuang.DataValueField = "Ruangan_PK";
                cmbNewRuang.DataBind();
            }
        }

        protected void btInsert_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow GrdRow = (GridViewRow)btn.Parent.Parent;

            DropDownList txtRoom = (DropDownList)GrdRow.Cells[0].FindControl("ddlRuangan");
            TextBox txtsubject = (TextBox)GrdRow.Cells[0].FindControl("txtNewSubject");
            TextBox txtdate = (TextBox)GrdRow.Cells[0].FindControl("InputNewTanggal");
            TextBox txtjmulai = (TextBox)GrdRow.Cells[0].FindControl("InputNewJamMulai");
            TextBox txtjamsls = (TextBox)GrdRow.Cells[0].FindControl("InputNewJamSelesai");

            DateTime vDate1, vDate2,vDateN;
            DateTime.TryParseExact(txtdate.Text + txtjmulai.Text, "MM/dd/yyyyHH:mm tt", CultureInfo.InvariantCulture, DateTimeStyles.None, out vDate1);
            DateTime.TryParseExact(txtdate.Text + txtjamsls.Text, "MM/dd/yyyyHH:mm tt", CultureInfo.InvariantCulture, DateTimeStyles.None, out vDate2);
            DateTime.TryParseExact(DateTime.Now.ToString("dd/MM/yyyyHH:mm"), "dd/MM/yyyyHH:mm", CultureInfo.InvariantCulture, DateTimeStyles.None, out vDateN);


            if(txtsubject.Text=="")
			{
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Subject tidak boleh kosong !')", true);
                return;
            }

            if (txtdate.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Tanggal tidak boleh kosong !')", true);
                return;
            }

            if (vDate1 < vDateN)
			{
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Tidak bisa book untuk Tanggal yang sudah lewat !')", true);
                return;
            }
            if (vDate2<vDate1)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Pilihan Waktu Selesai lebih kecil dari tanggal Mulai !')", true);
                return;
            }



            using (SqlConnection myConnection = new SqlConnection(con))
            {
                string oString = "sp_New_reserv";
                SqlCommand cmd = new SqlCommand(oString, myConnection);
                cmd.Parameters.AddWithValue("@Ruangan_FK", txtRoom.Text);
                cmd.Parameters.AddWithValue("@SubjectReservasi", txtsubject.Text);
                cmd.Parameters.AddWithValue("@TanggalReservasi", txtdate.Text);
                cmd.Parameters.AddWithValue("@JamMulai", txtjmulai.Text);
                cmd.Parameters.AddWithValue("@JamSelesai", txtjamsls.Text);

                cmd.CommandType = CommandType.StoredProcedure;
                myConnection.Open();
                cmd.ExecuteNonQuery();
                cmd.Dispose();

            }

            GetVacant();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetVacant();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetVacant();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

            int ReservedID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString());
            GridViewRow GrdRow = (GridViewRow)GridView1.Rows[e.RowIndex];

            TextBox txtsubject = (TextBox)GrdRow.Cells[0].FindControl("txtEditSubject");
            TextBox txtdate = (TextBox)GrdRow.Cells[0].FindControl("InputEditTanggal");
            TextBox txtjmulai = (TextBox)GrdRow.Cells[0].FindControl("InputEditJamMulai");
            TextBox txtjamsls = (TextBox)GrdRow.Cells[0].FindControl("InputEditJamSelesai");

            DateTime vDate1, vDate2, vDateN;
            DateTime.TryParseExact(txtdate.Text + txtjmulai.Text, "MM/dd/yyyyHH:mm tt", CultureInfo.InvariantCulture, DateTimeStyles.None, out vDate1);
            DateTime.TryParseExact(txtdate.Text + txtjamsls.Text, "MM/dd/yyyyHH:mm tt", CultureInfo.InvariantCulture, DateTimeStyles.None, out vDate2);
            DateTime.TryParseExact(DateTime.Now.ToString("dd/MM/yyyyHH:mm"), "dd/MM/yyyyHH:mm", CultureInfo.InvariantCulture, DateTimeStyles.None, out vDateN);


            if (txtsubject.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Subject tidak boleh kosong !')", true);
                return;
            }

            if (txtdate.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Tanggal tidak boleh kosong !')", true);
                return;
            }

            if (vDate1 < vDateN)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Tidak bisa book untuk Tanggal yang sudah lewat !')", true);
                return;
            }
            if (vDate2 < vDate1)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Pilihan Waktu Selesai lebih kecil dari tanggal Mulai !')", true);
                return;
            }


            using (SqlConnection myConnection = new SqlConnection(con))
            {
                string oString = "sp_Edit_reserv";
                SqlCommand cmd = new SqlCommand(oString, myConnection);
                cmd.Parameters.AddWithValue("@Reservasi_PK", ReservedID);
                cmd.Parameters.AddWithValue("@SubjectReservasi", txtsubject.Text);
                cmd.Parameters.AddWithValue("@TanggalReservasi", txtdate.Text);
                cmd.Parameters.AddWithValue("@JamMulai", txtjmulai.Text);
                cmd.Parameters.AddWithValue("@JamSelesai", txtjamsls.Text);
                GridView1.EditIndex = -1;
                cmd.CommandType = CommandType.StoredProcedure;
                myConnection.Open();
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            GetVacant();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetVacant();
        }

        protected void DT_ToExcel(object sender, EventArgs e)
		{
            using (SqlConnection myConnection = new SqlConnection(con))
            {
                string oString = "SP_Get_List_Sch";
                SqlCommand cmd = new SqlCommand(oString, myConnection);
                cmd.CommandType = CommandType.StoredProcedure;
                myConnection.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                da.Fill(dt);
                myConnection.Close();
                da.Dispose();

                if (dt.Rows.Count == 0)
                {
                    dt.Rows.Add(dt.NewRow());
                    dt.Rows[0][0] = "";
                }

                string attachment = "attachment; filename=RoomReserv.xls";
                Response.ClearContent();
                Response.AddHeader("content-disposition", attachment);
                Response.ContentType = "application/vnd.ms-excel";
                string tab = "";
                foreach (DataColumn dc in dt.Columns)
                {
                    Response.Write(tab + dc.ColumnName);
                    tab = "\t";
                }
                Response.Write("\n");
                int i;
                foreach (DataRow dr in dt.Rows)
                {
                    tab = "";
                    for (i = 0; i < dt.Columns.Count; i++)
                    {
                        Response.Write(tab + dr[i].ToString());
                        tab = "\t";
                    }
                    Response.Write("\n");
                }
                Response.End();

            }
           
        }

		protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
		{
            int ReservedID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString());
            GridViewRow GrdRow = (GridViewRow)GridView1.Rows[e.RowIndex];
            using (SqlConnection myConnection = new SqlConnection(con))
            {
                string oString = "sp_Rem_reserv";
                SqlCommand cmd = new SqlCommand(oString, myConnection);
                cmd.Parameters.AddWithValue("@Reservasi_PK", ReservedID);
                GridView1.EditIndex = -1;
                cmd.CommandType = CommandType.StoredProcedure;
                myConnection.Open();
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            GetVacant();
        }
	}
}