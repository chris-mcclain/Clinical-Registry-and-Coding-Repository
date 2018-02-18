<%--
Author: Chris McClain
Abstract: Displays the ICD-10 Code for the specified diagnosis
--%>

<%@ Page Title="ICD-10 Coder" Language="C#" MasterPageFile="~/MasterPages/Frontend.master" AutoEventWireup="true" CodeFile="ICD10Coder.aspx.cs" Inherits="ICD10Coder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server"><br />
    <p style="font-family:'Lucida Calligraphy'; color:blue; text-align: center";>Choose a Diagnosis to Code</p><br />
        <asp:Label ID="lblDiagnosis" runat="server" Text="Diagnosis: " ForeColor="Blue" Font-Names="Lucida Calligraphy"></asp:Label>
        <asp:DropDownList ID="ddlICD10Code" runat="server" DataSourceID="dsICD10Code" DataTextField="strCondition" DataValueField="intConditionID" OnSelectedIndexChanged="ddlICD10Code_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True">
            <asp:ListItem Text="--Choose a Diagnosis--" Value="-1"></asp:ListItem>
        </asp:DropDownList>
    
        <asp:SqlDataSource ID="dsICD10Code" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intConditionID], [strICD10Code], [strCondition] FROM [TConditions]"></asp:SqlDataSource>
        <br /><br /><br /><br />
        <asp:Label ID="lblCode" runat="server" Text="ICD-10 Code: " ForeColor="Blue" Font-Names="Lucida Calligraphy"></asp:Label>
        <asp:Label ID="lblICD10Code" runat="server"></asp:Label>
</asp:Content>

