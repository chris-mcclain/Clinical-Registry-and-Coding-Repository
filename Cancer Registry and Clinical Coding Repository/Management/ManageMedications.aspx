<%--
Author: Chris McClain
Abstract: Allows management to add to, edit, and delete from the TMedications table
--%>

<%@ Page Title="Manage Medications" Language="C#" MasterPageFile="~/MasterPages/Management.master" AutoEventWireup="true" CodeFile="ManageMedications.aspx.cs" Inherits="Management_ManageMedications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Button ID="btnAdd" runat="server" Text="Add Medication" OnClick="btnAdd_Click" />&nbsp&nbsp&nbsp&nbsp
    <asp:Button ID="btnEditDelete" runat="server" Text="Edit/Delete Medication" OnClick="btnEditDelete_Click" CausesValidation="False" />
    <br /><br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upAddMedication" runat="server">
        <ContentTemplate>
            <table class="table">
                 <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblMedicationName" runat="server" Text="Medication Name: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtMedicationName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMedicationName" runat="server" ErrorMessage="You must enter a medication name and dosage" ControlToValidate="txtMedicationName" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddMedications"></asp:RequiredFieldValidator><br /></td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblHCPCSCode" runat="server" Text="HCPCS Code: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtHCPCSCode" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvHCPCSCode" runat="server" ErrorMessage="You must enter a HCPCS Code" ControlToValidate="txtHCPCSCode" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddMedications"></asp:RequiredFieldValidator><br /></td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblDescription" runat="server" Text="Description: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtDescription" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td></td>
                    <td style="text-align:left"><asp:Button ID="btnSubmitMedication" runat="server" Text="Submit" OnClick="btnSubmitMedication_Click" ValidationGroup="AddMedications" /></td>
                </tr>
            </table>     
            <asp:ValidationSummary ID="vsManageMedications" runat="server" CssClass="ErrorMessage" ValidationGroup="AddMedications" />       
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <asp:UpdatePanel ID="upEditDeleteMedication" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvMedication" runat="server" AutoGenerateColumns="False" DataKeyNames="intMedicationID" DataSourceID="dsMedications" CellPadding="10" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="#2461BF" ForeColor="White" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                <Columns>
                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" ValidationGroup="EditMedications" />  
                    <asp:TemplateField HeaderText="Lab Test">
                        <ItemTemplate>
                            <asp:Label ID="lblMedication" runat="server" Text='<%# Bind("strMedication") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMedication" runat="server" Text='<%# Bind("strMedication") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvMedicationName" runat="server" ErrorMessage="You must enter a medication name and dosage" ControlToValidate="txtMedication" CssClass="ErrorMessage" ValidationGroup="EditMedications" Display="None"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>              
                    <asp:TemplateField HeaderText="CPT Code">
                        <ItemTemplate>
                            <asp:Label ID="lblHCPCSCode" runat="server" Text='<%# Bind("strHcpcsCode") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtHCPCSCode" runat="server" Text='<%# Bind("strHcpcsCode") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvHCPCSCode" runat="server" ErrorMessage="You must enter a HCPCS Code" ControlToValidate="txtHCPCSCode" CssClass="ErrorMessage" ValidationGroup="EditMedications" Display="None"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>                   
                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                             <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("strDescription") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("strDescription") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>                       
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="dsMedications" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>"
                 SelectCommand="SELECT * FROM [TMedications]"
                 DeleteCommand="DELETE FROM TMedications WHERE intMedicationID=@intMedicationID"
                 UpdateCommand="UPDATE TMedications SET strMedication=@strMedication, strHcpcsCode=@strHcpcsCode, strDescription=@strDescription WHERE intMedicationID=@intMedicationID">
                <DeleteParameters>
                    <asp:Parameter Name="intMedicationID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="intMedicationID" Type="Int32" />
                    <asp:Parameter Name="strMedication" Type="String" />
                    <asp:Parameter Name="strHcpcsCode" Type="String" />
                    <asp:Parameter Name="strDescription" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource> 
            <asp:ValidationSummary ID="vsEditMedications" runat="server" CssClass="ErrorMessage" ValidationGroup="EditMedications" />    
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

