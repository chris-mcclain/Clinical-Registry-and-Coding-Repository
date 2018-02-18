<%--
Author: Chris McClain
Abstract: Allows management to add to, edit, and delete conditions from the TConditions table
--%>

<%@ Page Title="Manage Diagnoses" Language="C#" MasterPageFile="~/MasterPages/Management.master" AutoEventWireup="true" CodeFile="ManageConditions.aspx.cs" Inherits="Management_ManageConditions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Button ID="btnAdd" runat="server" Text="Add Diagnosis" OnClick="btnAdd_Click" />&nbsp&nbsp&nbsp&nbsp
    <asp:Button ID="btnEditDelete" runat="server" Text="Edit/Delete Diagnosis" OnClick="btnEditDelete_Click" CausesValidation="False" />
    <br /><br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upAddDiagnosis" runat="server">
        <ContentTemplate>
            <table class="table">
                 <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblDiagnosisName" runat="server" Text="Diagnosis Name: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtDiagnosisName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDiagnosisName" runat="server" ErrorMessage="You must enter a diagnosis" ControlToValidate="txtDiagnosisName" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddCondition"></asp:RequiredFieldValidator><br />
                    </td>
                        </tr>
                <tr>
                    <td class="labels" style="text-align: right"><asp:Label ID="lblICD10Code" runat="server" Text="ICD-10 Code: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td><asp:TextBox ID="txtICD10Code" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvICD10Code" runat="server" ErrorMessage="You must enter an ICD-10 Code" ControlToValidate="txtICD10Code" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="AddCondition"></asp:RequiredFieldValidator><br /></td>
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
                    <td style="text-align:left"><asp:Button ID="btnSubmitDiagnosis" runat="server" Text="Submit" OnClick="btnSubmitDiagnosis_Click" ValidationGroup="AddCondition" /></td>
                </tr>
            </table>  
            <asp:ValidationSummary ID="vsManageConditions" runat="server" CssClass="ErrorMessage" ValidationGroup="AddCondition" />          
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <asp:UpdatePanel ID="upEditDeleteDiagnsosis" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvDiagnosis" runat="server" AutoGenerateColumns="False" DataKeyNames="intConditionID" DataSourceID="dsDiagnosis" CellPadding="4" ForeColor="#333333" GridLines="None">
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
                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" ValidationGroup="EditConditions" />  
                    <asp:TemplateField HeaderText="Diagnosis">
                        <ItemTemplate>
                            <asp:Label ID="lblCondition" runat="server" Text='<%# Bind("strCondition") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCondition" runat="server" Text='<%# Bind("strCondition") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCondition" runat="server" ErrorMessage="You must enter a condition" ControlToValidate="txtCondition" CssClass="ErrorMessage" ValidationGroup="EditConditions" Display="None"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>              
                    <asp:TemplateField HeaderText="ICD-10 Code">
                        <ItemTemplate>
                            <asp:Label ID="lblICD10Code" runat="server" Text='<%# Bind("strICD10Code") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtICD10Code" runat="server" Text='<%# Bind("strICD10Code") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvICD10Code" runat="server" ErrorMessage="You must enter an ICD-10 Code" ControlToValidate="txtICD10Code" CssClass="ErrorMessage" ValidationGroup="EditConditions" Display="None"></asp:RequiredFieldValidator>
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
            <asp:SqlDataSource ID="dsDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" 
                SelectCommand="SELECT * FROM [TConditions]"
                DeleteCommand="DELETE FROM TConditions WHERE intConditionID=@intConditionID"
                UpdateCommand="UPDATE TConditions SET strCondition=@strCondition, strICD10Code=@strICD10Code, strDescription=@strDescription WHERE intConditionID=@intConditionID">             
                <UpdateParameters>
                    <asp:Parameter Name="intConditionID" Type="Int32" />
                    <asp:Parameter Name="strCondition" Type="String" />
                    <asp:Parameter Name="strICD10Code" Type="String" />
                    <asp:Parameter Name="strDescription" Type="String" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="intConditionID" Type="Int32" />
                </DeleteParameters></asp:SqlDataSource>        
            <asp:ValidationSummary ID="vsEditConditions" runat="server" CssClass="ErrorMessage" ValidationGroup="EditConditions" />
        </ContentTemplate>    
    </asp:UpdatePanel>
</asp:Content>

