<%--
Author: Chris McClain
Abstract: Displays the number of global days associated with specified procedures
--%>

<%@ Page Title="Global Days" Language="C#" MasterPageFile="~/MasterPages/Frontend.master" AutoEventWireup="true" CodeFile="GlobalDays.aspx.cs" Inherits="GlobalDays" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server"><br />
    <p style="font-family:'Lucida Calligraphy'; text-align:center; color:blue">Choose a Procedure to Find Global Days</p><br />
        <asp:Label ID="lblProcedure" runat="server" Text="Procedure: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
        <asp:DropDownList ID="ddlProcedure" runat="server" DataSourceID="dsProcedure" DataTextField="strProcedure" DataValueField="intProcedureID" AutoPostBack="True" OnSelectedIndexChanged="ddlProcedure_SelectedIndexChanged" AppendDataBoundItems="True">
            <asp:ListItem Text="--Choose a Procedure--" Value="-1"></asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="dsProcedure" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intProcedureID], [strProcedure], [intGlobalDays] FROM [TProcedures]"></asp:SqlDataSource>
        <br /><br /><br /><br />
        <asp:Label ID="lblGlobalDays" runat="server" Text="Global Days: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
        <asp:Label ID="lblProcedureGlobalDays" runat="server"></asp:Label>
</asp:Content>

