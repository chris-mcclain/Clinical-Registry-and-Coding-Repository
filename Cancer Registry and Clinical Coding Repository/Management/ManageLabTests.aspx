<%--
Author: Chris McClain
Abstract: Allows management to add to, edit, and delete from the TLabTests table
--%>

<%@ Page Title="Manage Lab Tests" Language="C#" MasterPageFile="~/MasterPages/Management.master" AutoEventWireup="true" CodeFile="ManageLabTests.aspx.cs" Inherits="Management_ManageLabTests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Button ID="btnAdd" runat="server" Text="Add Lab Test" OnClick="btnAdd_Click" />&nbsp&nbsp&nbsp&nbsp
    <asp:Button ID="btnEditDelete" runat="server" Text="Edit/Delete Lab Test" OnClick="btnEditDelete_Click" CausesValidation="False" />
    <br /><br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upAddLabTest" runat="server">
        <ContentTemplate>
            <table class="table">
                 <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblLabTestName" runat="server" Text="Lab Test Name: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtLabTestName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLabTestName" runat="server" ErrorMessage="You must enter a lab test name" CssClass="ErrorMessage" ControlToValidate="txtLabTestName" Display="Dynamic" Text="*" ValidationGroup="AddLabTests"></asp:RequiredFieldValidator><br /></td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblCPTCode" runat="server" Text="CPT Code: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtCPTCode" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCPTCode" runat="server" ErrorMessage="You must enter a CPT Code" ControlToValidate="txtCPTCode" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddLabTests"></asp:RequiredFieldValidator><br /></td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblDescription" runat="server" Text="Description: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtDescription" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="labels" style="text-align: right">
                        <asp:Label ID="lblProcessingLab" runat="server" Text="Processing Lab: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtProcessingLab" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvProcessingLab" runat="server" ErrorMessage="You must enter a processing lab" ControlToValidate="txtProcessingLab" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddLabTests"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td style="text-align:left"><asp:Button ID="btnSubmitLabTest" runat="server" Text="Submit" OnClick="btnSubmitLabTest_Click" ValidationGroup="AddLabTests" /></td>
                </tr>
            </table>     
            <asp:ValidationSummary ID="vsManageLabTests" runat="server" CssClass="ErrorMessage" ValidationGroup="AddLabTests" />       
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <asp:UpdatePanel ID="upEditDeleteLabTest" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvLabTest" runat="server" AutoGenerateColumns="False" DataKeyNames="intLabTestID" DataSourceID="dsLabTests" CellPadding="10" ForeColor="#333333" GridLines="None">
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
                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" ValidationGroup="EditLabTests" />  
                    <asp:TemplateField HeaderText="Lab Test">
                        <ItemTemplate>
                            <asp:Label ID="lblLabTest" runat="server" Text='<%# Bind("strLabTest") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtLabTest" runat="server" Text='<%# Bind("strLabTest") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLabTest" runat="server" ErrorMessage="You must enter a lab test name" CssClass="ErrorMessage" ControlToValidate="txtLabTest" ValidationGroup="EditLabTests" Display="None"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>              
                    <asp:TemplateField HeaderText="CPT Code">
                        <ItemTemplate>
                            <asp:Label ID="lblCPTCode" runat="server" Text='<%# Bind("strCptCode") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCPTCode" runat="server" Text='<%# Bind("strCptCode") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCPTCode" runat="server" ErrorMessage="You must enter a CPT Code" ControlToValidate="txtCPTCode" CssClass="ErrorMessage" ValidationGroup="EditLabTests" Display="None"></asp:RequiredFieldValidator>
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
                    <asp:TemplateField HeaderText="Processing Lab">
                        <ItemTemplate>
                            <asp:Label ID="lblProcessingLab" runat="server" Text='<%# Bind("strProcessingLab") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtProcessingLab" runat="server" Text='<%# Bind("strProcessingLab") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvProcessingLab" runat="server" ErrorMessage="You must enter a processing lab" ControlToValidate="txtProcessingLab" CssClass="ErrorMessage" ValidationGroup="EditLabTests" Display="None"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>                  
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="dsLabTests" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>"
                 SelectCommand="SELECT * FROM [TLabTests]"
                 DeleteCommand="DELETE FROM TLabTests WHERE intLabTestID=@intLabTestID"
                 UpdateCommand="UPDATE TLabTests SET strLabTest=@strLabTest, strCptCode=@strCptCode, strDescription=@strDescription, strProcessingLab=@strProcessingLab WHERE intLabTestID=@intLabTestID">
                <DeleteParameters>
                    <asp:Parameter Name="intLabTestID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="intLabTestID" Type="Int32" />
                    <asp:Parameter Name="strLabTest" Type="String" />
                    <asp:Parameter Name="strCptCode" Type="String" />
                    <asp:Parameter Name="strDescription" Type="String" />
                    <asp:Parameter Name="strProcessingLab" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>   
            <asp:ValidationSummary ID="vsEditLabTests" runat="server" CssClass="ErrorMessage" ValidationGroup="EditLabTests" />      
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

