<%--
Author: Chris McClain
Abstract: Displays the names, dates of birth, and Tiger Numbers of all patients who have the specified diagnosis
--%>

<%@ Page Title="Patient Search per Diagnosis" Language="C#" MasterPageFile="~/MasterPages/Frontend.master" AutoEventWireup="true" CodeFile="PatientSearchPerDiagnosis.aspx.cs" Inherits="PatientSearchPerDiagnosis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server"><br />
    <p style="font-family:'Lucida Calligraphy'; color:blue">Display A List of Patients Based on Cancer Diagnosis</p><br />
    <asp:Label ID="lblDiagnosis" runat="server" Text="Diagnosis: " ForeColor="Blue" Font-Names="Lucida Calligraphy"></asp:Label>
    <asp:DropDownList ID="ddlDiagnosis" runat="server" DataSourceID="dsDiagnosis" DataTextField="strCondition" DataValueField="intConditionID" OnSelectedIndexChanged="ddlDiagnosis_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True">
        <asp:ListItem Text="--Choose a Diagnosis--" Value="-1"></asp:ListItem>
    </asp:DropDownList>
    <asp:SqlDataSource ID="dsDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intConditionID], [strCondition] FROM [TConditions]"></asp:SqlDataSource>
    <br /><br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upDiagnosis" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvDiagnosis" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
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

