<%--
Author: Chris McClain
Abstract: Displays the names, dates of birth, and Tiger Numbers of all patients who receive the specified injectable
          medication
--%>

<%@ Page Title="Patient Search Per Injectable" Language="C#" MasterPageFile="~/MasterPages/Frontend.master" AutoEventWireup="true" CodeFile="PatientSearchPerInjectable.aspx.cs" Inherits="PatientSearchPerInjectable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server"><br />
    <p style="font-family:'Lucida Calligraphy';  color:blue">Display A List of Patients Based on Medications Received</p><br />
    <asp:Label ID="lblInjectable" runat="server" Text="Medication: " ForeColor="Blue" Font-Names="Lucida Calligraphy"></asp:Label>
    <asp:DropDownList ID="ddlInjectables" runat="server" DataSourceID="dsInjectables" DataTextField="strMedication" DataValueField="intMedicationID" OnSelectedIndexChanged="ddlInjectables_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True">
        <asp:ListItem Text="--Choose a Medication--" Value="-1"></asp:ListItem>
    </asp:DropDownList>
    <asp:SqlDataSource ID="dsInjectables" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT DISTINCT[strMedication], [intMedicationID] FROM [TMedications]"></asp:SqlDataSource>
    <br /><br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upInjectables" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvInjectables" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
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
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

