<%--
Form: ManageImaging
Class: CPDM Capstone
Author: Chris McClain
Abstract: Allows management to add to, edit, and delete imaging from the TImaging table
Date: July 15, 2017
--%>

<%@ Page Title="Manage Imaging" Language="C#" MasterPageFile="~/MasterPages/Management.master" AutoEventWireup="true" CodeFile="ManageImaging.aspx.cs" Inherits="Management_ManageImaging" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Button ID="btnAdd" runat="server" Text="Add Imaging" OnClick="btnAdd_Click" />&nbsp&nbsp&nbsp&nbsp
    <asp:Button ID="btnEditDelete" runat="server" Text="Edit/Delete Imaging" OnClick="btnEditDelete_Click" CausesValidation="False" />
    <br /><br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upAddImaging" runat="server">
        <ContentTemplate>
            <table class="table">
                 <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblImagingName" runat="server" Text="Imaging Name: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtImagingName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvImagingName" runat="server" ErrorMessage="You must enter an imaging name" ControlToValidate="txtImagingName" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddImaging"></asp:RequiredFieldValidator><br /></td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblCPTCode" runat="server" Text="CPT Code: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtCPTCode" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCPTCode" runat="server" ErrorMessage="You must enter a CPT Code" ControlToValidate="txtCPTCode" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddImaging"></asp:RequiredFieldValidator><br /></td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblDescription" runat="server" Text="Description: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtDescription" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td style="text-align:left"><asp:Button ID="btnSubmitImaging" runat="server" Text="Submit" OnClick="btnSubmitImaging_Click" ValidationGroup="AddImaging" /></td>
                </tr>
            </table>        
            <asp:ValidationSummary ID="vsManageImaging" runat="server" CssClass="ErrorMessage" ValidationGroup="AddImaging" />    
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <asp:UpdatePanel ID="upEditDeleteImaging" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvImaging" runat="server" AutoGenerateColumns="False" DataKeyNames="intImagingID" DataSourceID="dsImaging" CellPadding="10" ForeColor="#333333" GridLines="None">
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
                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" ValidationGroup="EditImaging" />  
                    <asp:TemplateField HeaderText="Imaging">
                        <ItemTemplate>
                            <asp:Label ID="lblImaging" runat="server" Text='<%# Bind("strImaging") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtImaging" runat="server" Text='<%# Bind("strImaging") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvImaging" runat="server" ErrorMessage="You must enter imaging" ControlToValidate="txtImaging" CssClass="ErrorMessage" ValidationGroup="EditImaging" Display="None"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>              
                    <asp:TemplateField HeaderText="CPT Code">
                        <ItemTemplate>
                            <asp:Label ID="lblCPTCode" runat="server" Text='<%# Bind("strCptCode") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCPTCode" runat="server" Text='<%# Bind("strCptCode") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCPTCode" runat="server" ErrorMessage="You must enter a CPT Code" ControlToValidate="txtCPTCode" CssClass="ErrorMessage" ValidationGroup="EditImaging" Display="None"></asp:RequiredFieldValidator>
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
            <asp:SqlDataSource ID="dsImaging" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>"
                 SelectCommand="SELECT * FROM [TImaging]"
                 DeleteCommand="DELETE FROM TImaging WHERE intImagingID=@intImagingID"
                 UpdateCommand="UPDATE TImaging SET strImaging=@strImaging, strCptCode=@strCptCode, strDescription=@strDescription WHERE intImagingID=@intImagingID">
                <DeleteParameters>
                    <asp:Parameter Name="intImagingID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="intImagingID" Type="Int32" />
                    <asp:Parameter Name="strImaging" Type="String" />
                    <asp:Parameter Name="strCptCode" Type="String" />
                    <asp:Parameter Name="strDescription" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>  
            <asp:ValidationSummary ID="vsEditImaging" runat="server" CssClass="ErrorMessage" ValidationGroup="EditImaging" />               
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

