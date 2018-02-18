<%--
Author: Chris McClain
Abstract: Displays the CPT code associated with specified procedures and imaging.
--%>

<%@ Page Title="CPT Coder" Language="C#" MasterPageFile="~/MasterPages/Frontend.master" AutoEventWireup="true" CodeFile="CPTCoder.aspx.cs" Inherits="CPTCoder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server"><br />
    <p style="font-family:'Lucida Calligraphy'; text-align:center; color:blue">Choose a Procedure or Imaging to Code</p><br />
    <div style="float: left">
    <asp:Label ID="lblProcedure" runat="server" Text="Procedure: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
    <asp:DropDownList ID="ddlProcedure" runat="server" DataSourceID="dsProcedure" DataTextField="strProcedure" DataValueField="intProcedureID" OnSelectedIndexChanged="ddlProcedure_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True">
        <asp:ListItem Text="--Choose a Procedure--" Value="-1"></asp:ListItem>
    </asp:DropDownList>
    <asp:SqlDataSource ID="dsProcedure" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intProcedureID], [strProcedure], [strCptCode] FROM [TProcedures]"></asp:SqlDataSource>
    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    <br /><br /><br /><br />
    <asp:Label ID="lblProcedureCode" runat="server" Text="CPT Code:  " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
    <asp:Label ID="lblProcedureCPT" runat="server" style="text-align:center"></asp:Label>
    </div>
    <div style="float: left">
        <asp:Label ID="lblImaging" runat="server" Text="Imaging: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
        <asp:DropDownList ID="ddlImaging" runat="server" DataSourceID="dsImaging" DataTextField="strImaging" DataValueField="intImagingID" OnSelectedIndexChanged="ddlImaging_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True">
            <asp:ListItem Text="--Choose Imaging--" Value="-1"></asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="dsImaging" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intImagingID], [strImaging], [strCptCode] FROM [TImaging]"></asp:SqlDataSource>
        <br /><br /><br /><br />
        <asp:Label ID="lblImagingCode" runat="server" Text="CPT Code:  " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
        <asp:Label ID="lblImagingCPT" runat="server" Text="" ViewStateMode="Inherit" BorderStyle="None" style="text-align:center"></asp:Label>
    </div>
</asp:Content>

