<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MCG_Test._Default" EnableEventValidation="false" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>ROOM RESERVATION</h1>       
    </div>
	<form runat="server">
    <div class="row">
		<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="col-md-4">

                <div class="form-group">
                <label for="ddl_Room"><b>ROOM</b></label>
                <asp:DropDownList runat="server" class="form-select" aria-label="Default select example" ID="ddl_Room" >
				<asp:ListItem Selected="True">ALL</asp:ListItem>
				</asp:DropDownList>
                </div>


			    <asp:GridView ID="GridView1" CellSpacing="2" runat="server" CellPadding="4" ForeColor="#333333" ShowFooter="True" GridLines="None" 
				AutoGenerateColumns="False" Width="100%" OnRowDataBound="GridView1_RowDataBound" AllowPaging="True" 
				OnPageIndexChanging="GridView1_PageIndexChanging" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" DataKeyNames="Reservasi_PK"
				OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting">
				<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
				<EditRowStyle BackColor="#999999" />
				<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
				<HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
				<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
				<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
				<SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
				<SortedAscendingCellStyle BackColor="#E9E7E2" />
				<SortedAscendingHeaderStyle BackColor="#506C8C" />
				<SortedDescendingCellStyle BackColor="#FFFDF8" />
				<SortedDescendingHeaderStyle BackColor="#6F8DAE" />
				<Columns>

                <asp:TemplateField HeaderText="Ruangan" HeaderStyle-HorizontalAlign="Left"> 
                <EditItemTemplate> 
				<asp:Label ID="lblRuangan" runat="server" Text='<%# Eval("NamaRuangan") %>'></asp:Label> 
                </EditItemTemplate> 
                <ItemTemplate> 
                <asp:Label ID="lblRuangan" runat="server" Text='<%# Eval("NamaRuangan") %>'></asp:Label> 
                </ItemTemplate> 
                <FooterTemplate> 
                <asp:DropDownList class="form-select" aria-label="Default select example" ID="ddlRuangan" runat="server" ></asp:DropDownList> 
                </FooterTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:TemplateField> 


	            <asp:TemplateField HeaderText="Subject" HeaderStyle-HorizontalAlign="Left"> 
	            <EditItemTemplate> 
                <asp:TextBox  ID="txtEditSubject" ForeColor="#808080" runat="server" Text='<%# Bind("SubjectReservasi") %>'></asp:TextBox> 
	            </EditItemTemplate> 
	            <FooterTemplate> 
                <asp:TextBox ID="txtNewSubject" ForeColor="#808080" runat="server" ></asp:TextBox> 
	            </FooterTemplate> 
	            <ItemTemplate> 
                <asp:Label ID="lblSubject"  ForeColor="#808080" runat="server" Text='<%# Bind("SubjectReservasi") %>'></asp:Label> 
	            </ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
	            </asp:TemplateField>


                <asp:TemplateField HeaderText="Tanggal" HeaderStyle-HorizontalAlign="Left"> 
	            <EditItemTemplate> 
				<asp:TextBox ID="InputEditTanggal" runat="server" DataFormatString="{0:dd/MM/yyyy}" Text='<%# Eval("TanggalReservasi", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
	            </EditItemTemplate> 
	            <FooterTemplate> 
				<asp:TextBox ID="InputNewTanggal"  ForeColor="#808080" DataFormatString="{0:dd/MM/yyyy}" runat="server"></asp:TextBox>  
	            </FooterTemplate> 
	            <ItemTemplate>
                <asp:Label ID="lblSTanggal" runat="server" DataFormatString="{0:dd/MM/yyyy}" Text='<%# Eval("TanggalReservasi", "{0:dd/MM/yyyy}") %>'></asp:Label> 
	            </ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
	            </asp:TemplateField>


                <asp:TemplateField HeaderText="jam Mulai" HeaderStyle-HorizontalAlign="Left"> 
	            <EditItemTemplate> 
				<asp:TextBox id="InputEditJamMulai"  ForeColor="#808080" runat="server" Text='<%# Eval("JamMulai", "{0:HH/mm}")%>'></asp:TextBox>  
	            </EditItemTemplate> 
	            <FooterTemplate> 
				<asp:TextBox id="InputNewJamMulai"  ForeColor="#808080" runat="server"></asp:TextBox>  
	            </FooterTemplate> 
	            <ItemTemplate>
                <asp:Label ID="lblJamMulai" runat="server" Text='<%# Eval("JamMulai", "{0:HH/mm}")%>'></asp:Label> 
	            </ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
	            </asp:TemplateField>


				<asp:TemplateField HeaderText="jam Selesai" HeaderStyle-HorizontalAlign="Left"> 
	            <EditItemTemplate> 
				<asp:TextBox id="InputEditJamSelesai"  ForeColor="#808080" runat="server" Text='<%# Eval("JamSelesai", "{0:HH/mm}")%>'></asp:TextBox> 
	            </EditItemTemplate> 
	            <FooterTemplate> 
				<asp:TextBox id="InputNewJamSelesai"  ForeColor="#808080"  runat="server"></asp:TextBox>  
	            </FooterTemplate> 
	            <ItemTemplate> 
                <asp:Label ID="lblJamSelesai" runat="server" Text='<%# Bind("JamSelesai") %>'></asp:Label> 
	            </ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
	            </asp:TemplateField>


				<asp:TemplateField>
				<ItemTemplate></ItemTemplate>
				<FooterTemplate>
                <asp:Button ID="btInsert" runat="server" Text="Add" OnClick="btInsert_Click" CommandName="Footer" />
				</FooterTemplate>
				</asp:TemplateField>

				<asp:CommandField ButtonType="Button" ShowEditButton="True" />
				<asp:CommandField ButtonType="Button" ShowDeleteButton="True" />

				</Columns>
                   
			</asp:GridView>

        </div>     
    </div>
	<p><asp:Button runat="server" ID="btnExport" Text="Export To Excel" OnClick = "DT_ToExcel" /></p>
</form>
</asp:Content>

