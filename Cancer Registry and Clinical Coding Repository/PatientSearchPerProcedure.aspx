<%--
Form: PatientSearchPerProcedure
Class: CPDM Capstone
Author: Chris McClain
Abstract: Displays the names, dates of birth, and Tiger Numbers of all patients who have had the specified procedure
Date: July 15, 2017
--%>

<%@ Page Title="Patient Search Per Procedure" Language="C#" MasterPageFile="~/MasterPages/Frontend.master" AutoEventWireup="true" CodeFile="PatientSearchPerProcedure.aspx.cs" Inherits="PatientSearchPerProcedure" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server"><br />
    <p style="font-family:'Lucida Calligraphy'; color:blue">Display A List of Patients Based on Procedures</p><br />
    <asp:Label ID="lblProcedures" runat="server" Text="Procedure: " ForeColor="Blue" Font-Names="Lucida Calligraphy"></asp:Label>
    <asp:DropDownList ID="ddlProcedures" runat="server" DataSourceID="dsProcedures" DataTextField="strProcedure" DataValueField="intProcedureID" OnSelectedIndexChanged="ddlProcedures_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True">
        <asp:ListItem Text="--Choose a Procedure--" Value="-1"></asp:ListItem>
    </asp:DropDownList>
    <asp:SqlDataSource ID="dsProcedures" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intProcedureID], [strProcedure] FROM [TProcedures]"></asp:SqlDataSource>
    <br /><br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upProcedures" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvProcedures" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
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

