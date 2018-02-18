<%--
Form: ManageTreatments
Class: CPDM Capstone
Author: Chris McClain
Abstract: Allows management to add to, edit, and delete from the TTreatments table
Date: July 15, 2017
--%>

<%@ Page Title="Manage Treatments" Language="C#" MasterPageFile="~/MasterPages/Management.master" AutoEventWireup="true" CodeFile="ManageTreatments.aspx.cs" Inherits="Management_ManageTreatments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Button ID="btnAdd" runat="server" Text="Add Treatment" OnClick="btnAdd_Click" />&nbsp&nbsp&nbsp&nbsp
    <asp:Button ID="btnEditDelete" runat="server" Text="Edit/Delete Treatment" OnClick="btnEditDelete_Click" CausesValidation="False" />
    <br /><br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upAddTreatment" runat="server">
        <ContentTemplate>
            <table class="table">
                 <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblTreatmentName" runat="server" Text="Treatment Name: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtTreatmentName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTreatmentName" runat="server" ErrorMessage="You must enter a treatment" ControlToValidate="txtTreatmentName" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddTreatment"></asp:RequiredFieldValidator>
                        <br /></td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblCPTCode" runat="server" Text="CPT Code: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtCPTCode" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCPTCode" runat="server" ErrorMessage="You must enter a CPT Code" ControlToValidate="txtCPTCode" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddTreatment"></asp:RequiredFieldValidator><br /></td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblDescription" runat="server" Text="Description: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtDescription" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td></td>
                    <td style="text-align:left"><asp:Button ID="btnSubmitTreatment" runat="server" Text="Submit" OnClick="btnSubmitTreatment_Click" ValidationGroup="AddTreatment" /></td>
                </tr>
            </table>            
            <asp:ValidationSummary ID="vsTreatments" runat="server" CssClass="ErrorMessage" ValidationGroup="AddTreatment" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <asp:UpdatePanel ID="upEditDeleteTreatment" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvTreatment" runat="server" AutoGenerateColumns="False" DataKeyNames="intTreatmentID" DataSourceID="dsTreatment" CellPadding="10" ForeColor="#333333" GridLines="None">
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
                     <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" ValidationGroup="EditTreatment" />  
                    <asp:TemplateField HeaderText="Treatment">
                        <ItemTemplate>
                            <asp:Label ID="lblTreatment" runat="server" Text='<%# Bind("strTreatment") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTreatment" runat="server" Text='<%# Bind("strTreatment") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTreatment" runat="server" ErrorMessage="You must enter a treatment" ControlToValidate="txtTreatment" CssClass="ErrorMessage" ValidationGroup="EditTreatment" Display="None"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>              
                    <asp:TemplateField HeaderText="CPT Code">
                        <ItemTemplate>
                            <asp:Label ID="lblCPTCode" runat="server" Text='<%# Bind("strCptCode") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCPTCode" runat="server" Text='<%# Bind("strCptCode") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCPTCode" runat="server" ErrorMessage="You must enter a CPT Code" ControlToValidate="txtCPTCode" CssClass="ErrorMessage" ValidationGroup="EditTreatment" Display="None"></asp:RequiredFieldValidator><br /></td>
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
            <asp:SqlDataSource ID="dsTreatment" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>"
                 SelectCommand="SELECT * FROM [TTreatments]"
                 DeleteCommand="DELETE FROM TTreatments WHERE intTreatmentID=@intTreatmentID"
                 UpdateCommand="UPDATE TTreatments SET strTreatment=@strTreatment, strCptCode=@strCptCode, strDescription=@strDescription WHERE intTreatmentID=@intTreatmentID">
                <DeleteParameters>
                    <asp:Parameter Name="intTreatmentID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="intTreatmentID" Type="Int32" />
                    <asp:Parameter Name="strTreatment" Type="String" />
                    <asp:Parameter Name="strCptCode" Type="String" />
                    <asp:Parameter Name="strDescription" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:ValidationSummary ID="vsEditTreatment" runat="server" CssClass="ErrorMessage" ValidationGroup="EditTreatment" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

