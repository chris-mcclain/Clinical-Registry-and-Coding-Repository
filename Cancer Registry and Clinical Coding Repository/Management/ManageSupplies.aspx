<%--
Form: ManageSupplies
Class: CPDM Capstone
Author: Chris McClain
Abstract: Allows management to add to, edit, and delete from the TSupplies table
Date: July 15, 2017
--%>

<%@ Page Title="Manage Supplies" Language="C#" MasterPageFile="~/MasterPages/Management.master" AutoEventWireup="true" CodeFile="ManageSupplies.aspx.cs" Inherits="Management_ManageSupplies" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Button ID="btnAdd" runat="server" Text="Add Supply" OnClick="btnAdd_Click" />&nbsp&nbsp&nbsp&nbsp
    <asp:Button ID="btnEditDelete" runat="server" Text="Edit/Delete Supply" OnClick="btnEditDelete_Click" CausesValidation="False" />
    <br /><br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upAddSupply" runat="server">
        <ContentTemplate>
            <table class="table">
                 <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblSupplyName" runat="server" Text="Supply Name: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtSupplyName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvSupplyName" runat="server" ErrorMessage="You must enter a supply" ControlToValidate="txtSupplyName" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddSupply"></asp:RequiredFieldValidator><br /></td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblHCPCSCode" runat="server" Text="HCPCS Code: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtHCPCSCode" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvHCPCSCode" runat="server" ErrorMessage="You must enter a HCPCS Code" ControlToValidate="txtHCPCSCode" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddSupply"></asp:RequiredFieldValidator><br /></td>
                </tr>
                <tr>
                    <td></td>
                    <td style="text-align:left"><asp:Button ID="btnSubmitSupply" runat="server" Text="Submit" OnClick="btnSubmitSupply_Click" ValidationGroup="AddSupply" /></td>
                </tr>
            </table>     
            <asp:ValidationSummary ID="vsSupplies" runat="server" CssClass="ErrorMessage" ValidationGroup="AddSupply" />       
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <asp:UpdatePanel ID="upEditDeleteSupply" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvSupply" runat="server" AutoGenerateColumns="False" DataKeyNames="intSupplyID" DataSourceID="dsSupply" CellPadding="10" ForeColor="#333333" GridLines="None">
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
                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" ValidationGroup="EditSupply" />  
                    <asp:TemplateField HeaderText="Supply">
                        <ItemTemplate>
                            <asp:Label ID="lblSupply" runat="server" Text='<%# Bind("strSupply") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtSupply" runat="server" Text='<%# Bind("strSupply") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSupply" runat="server" ErrorMessage="You must enter a supply" ControlToValidate="txtSupply" CssClass="ErrorMessage" ValidationGroup="EditSupply" Display="None"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>              
                    <asp:TemplateField HeaderText="HCPCS Code">
                        <ItemTemplate>
                            <asp:Label ID="lblHCPCSCode" runat="server" Text='<%# Bind("strHCPCSCode") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtHCPCSCode" runat="server" Text='<%# Bind("strHCPCSCode") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvHCPCSCode" runat="server" ErrorMessage="You must enter a HCPCS Code" ControlToValidate="txtHCPCSCode" CssClass="ErrorMessage" ValidationGroup="EditSupply" Display="None"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>                                   
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="dsSupply" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>"
                 SelectCommand="SELECT * FROM [TSupplies]"
                 DeleteCommand="DELETE FROM TSupplies WHERE intSupplyID=@intSupplyID"
                 UpdateCommand="UPDATE TSupplies SET strSupply=@strSupply, strHCPCSCode=@strHCPCSCode WHERE intSupplyID=@intSupplyID">
                <DeleteParameters>
                    <asp:Parameter Name="intSupplyID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="intSupplyID" Type="Int32" />
                    <asp:Parameter Name="strSupply" Type="String" />
                    <asp:Parameter Name="strHCPCSCode" Type="String" />
                </UpdateParameters> 
            </asp:SqlDataSource>
            <asp:ValidationSummary ID="vsEditSupply" runat="server" CssClass="ErrorMessage" ValidationGroup="EditSupply" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

