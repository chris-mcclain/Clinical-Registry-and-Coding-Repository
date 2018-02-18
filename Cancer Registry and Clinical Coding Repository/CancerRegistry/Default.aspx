<%--
Form: Default
Class: CPDM Capstone
Author: Chris McClain
Abstract: Home page for the Cancer Registry - allows the user to search for a patient in the Cancer Registry
Date: July 15, 2017
--%>

<%@ Page Title="Cancer Registry Search" Language="C#" MasterPageFile="~/MasterPages/Frontend.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Cancer_Registry_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .table {
            width: 100%;
        }
        .demoLabels {
            width: 148px;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="cpMainContent" Runat="Server">
    <br />
    <asp:Label ID="lblSearch" runat="server" Text="Search for Cancer Registry Patient:" ForeColor="Blue" Font-Names="Lucida Calligraphy"></asp:Label>
    <br />
    <br />
    <table class="table">
        <tr>
            <td class="demoLabels">
                <asp:Label ID="lblFirstName" runat="server" Text="First Name: " ForeColor="Blue" Font-Names="Lucida Calligraphy"></asp:Label></td>
            <td>
                <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvfFirstName" runat="server" ErrorMessage="You must enter a first name" ControlToValidate="txtFirstName" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="demoLabels">
                <asp:Label ID="lblLastName" runat="server" Text="Last Name: " ForeColor="Blue" Font-Names="Lucida Calligraphy"></asp:Label></td>
            <td>
                <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ErrorMessage="You must enter a last name" ControlToValidate="txtLastName" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="demoLabels">
                <asp:Label ID="lblDateOfBirth" runat="server" Text="Date of Birth: " ForeColor="Blue" Font-Names="Lucida Calligraphy"></asp:Label></td>
            <td>
                <asp:TextBox ID="txtDateOfBirth" runat="server"></asp:TextBox>
                <asp:CompareValidator ID="cvDateOfBirth" runat="server" ErrorMessage="You must enter a valid date" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtDateOfBirth" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:CompareValidator>
                <asp:RequiredFieldValidator ID="rfvDateOfBirth" runat="server" ErrorMessage="You must enter a date of birth" ControlToValidate="txtDateOfBirth" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
               <br /> 
            </td>
            <td>
                <div style="text-align:left">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </div>
            </td>
        </tr>
    </table>
    <br />
    <asp:ValidationSummary ID="vsRegistrySearch" runat="server" CssClass="ErrorMessage" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upRegistryPatients" runat="server" Visible="False">
        <ContentTemplate>
             <asp:GridView ID="gvRegistryPatients" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                 <AlternatingRowStyle BackColor="White" />
                 <EditRowStyle BackColor="#2461BF" />
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
                     <asp:HyperLinkField Text="Open" DataNavigateUrlFields="intPatientID" DataNavigateUrlFormatString="CancerRegistry.aspx?intPatientID={0}" />
                 </Columns>
             </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

