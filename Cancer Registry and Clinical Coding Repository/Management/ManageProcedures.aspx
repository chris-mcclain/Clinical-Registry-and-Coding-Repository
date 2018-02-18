<%--
Form: ManageProcedures
Class: CPDM Capstone
Author: Chris McClain
Abstract: Allows management to add to, edit, and delete from the TProcedures table
Date: July 15, 2017
--%>

<%@ Page Title="Manage Procedures" Language="C#" MasterPageFile="~/MasterPages/Management.master" AutoEventWireup="true" CodeFile="ManageProcedures.aspx.cs" Inherits="Management_ManageProcedures" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Button ID="btnAdd" runat="server" Text="Add Procedure" OnClick="btnAdd_Click" />&nbsp&nbsp&nbsp&nbsp
    <asp:Button ID="btnEditDelete" runat="server" Text="Edit/Delete Procedure" OnClick="btnEditDelete_Click" CausesValidation="False" />
    <br /><br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upAddProcedure" runat="server">
        <ContentTemplate>
            <table class="table">
                 <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblProcedureName" runat="server" Text="Procedure Name: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtProcedureName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvProcedureName" runat="server" ErrorMessage="You must enter a procedure name" ControlToValidate="txtProcedureName" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddProcedure"></asp:RequiredFieldValidator><br /></td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblCPTCode" runat="server" Text="CPT Code: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtCPTCode" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCPTCode" runat="server" ErrorMessage="You must enter a CPT Code" ControlToValidate="txtCPTCode" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddProcedure"></asp:RequiredFieldValidator><br /></td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblGlobalDays" runat="server" Text="Global Days: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtGlobalDays" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvGlobalDays" runat="server" ErrorMessage="You must enter global days" ControlToValidate="txtGlobalDays" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddProcedure"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revGlobalDays" runat="server" ErrorMessage="Global days must be an integer value" ControlToValidate="txtGlobalDays" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationExpression="^[0-9]+$" ValidationGroup="AddProcedure"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblDescription" runat="server" Text="Description: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtDescription" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td></td>
                    <td style="text-align:left"><asp:Button ID="btnSubmitProcedure" runat="server" Text="Submit" OnClick="btnSubmitProcedure_Click" ValidationGroup="AddProcedure" /></td>
                </tr>
            </table>    
            <asp:ValidationSummary ID="vsManageProcedures" runat="server" CssClass="ErrorMessage" ValidationGroup="AddProcedure" />        
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <asp:UpdatePanel ID="upEditDeleteProcedure" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvProcedure" runat="server" AutoGenerateColumns="False" DataKeyNames="intProcedureID" DataSourceID="dsProcedure" CellPadding="4" ForeColor="#333333" GridLines="None">
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
                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" ValidationGroup="EditProcedure" />  
                    <asp:TemplateField HeaderText="Procedure">
                        <ItemTemplate>
                            <asp:Label ID="lblProcedure" runat="server" Text='<%# Bind("strProcedure") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtProcedure" runat="server" Text='<%# Bind("strProcedure") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvProcedure" runat="server" ErrorMessage="You must enter a procedure" ControlToValidate="txtProcedure" CssClass="ErrorMessage" ValidationGroup="EditProcedure" Display="None"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>              
                    <asp:TemplateField HeaderText="CPT Code">
                        <ItemTemplate>
                            <asp:Label ID="lblCPTCode" runat="server" Text='<%# Bind("strCptCode") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCPTCode" runat="server" Text='<%# Bind("strCptCode") %>'></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvCPTCode" runat="server" ErrorMessage="You must enter a CPT Code" ControlToValidate="txtCPTCode" CssClass="ErrorMessage" ValidationGroup="EditProcedure" Display="None"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Global Days">
                        <ItemTemplate>
                            <asp:Label ID="lblGlobalDays" runat="server" Text='<%# Bind("intGlobalDays") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtGlobalDays" runat="server" Text='<%# Bind("intGlobalDays") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvGlobalDays" runat="server" ErrorMessage="You must enter global days" ControlToValidate="txtGlobalDays" CssClass="ErrorMessage" ValidationGroup="EditProcedure" Display="None"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revGlobalDays" runat="server" ErrorMessage="Global days must be an integer value" ControlToValidate="txtGlobalDays" CssClass="ErrorMessage" ValidationExpression="^[0-9]+$" ValidationGroup="EditProcedure" Display="None"></asp:RegularExpressionValidator>
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
            <asp:SqlDataSource ID="dsProcedure" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>"
                 SelectCommand="SELECT * FROM [TProcedures]"
                 DeleteCommand="DELETE FROM TProcedures WHERE intProcedureID=@intProcedureID"
                 UpdateCommand="UPDATE TProcedures SET strProcedure=@strProcedure, strCptCode=@strCptCode, intGlobalDays=@intGlobalDays, strDescription=@strDescription WHERE intProcedureID=@intProcedureID">             
                <UpdateParameters>
                    <asp:Parameter Name="intProcedureID" Type="Int32" />
                    <asp:Parameter Name="strProcedure" Type="String" />
                    <asp:Parameter Name="strCptCode" Type="String" />
                    <asp:Parameter Name="intGlobalDays" Type="Int32" />
                    <asp:Parameter Name="strDescription" Type="String" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="intProcedureID" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <asp:ValidationSummary ID="vsEditProcedure" runat="server" CssClass="ErrorMessage" ValidationGroup="EditProcedure" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

