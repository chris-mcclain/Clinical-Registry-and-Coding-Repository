<%--
Author: Chris McClain
Abstract: Displays the HCPCS code for specified supplies and medications
--%>

<%@ Page Title="HCPCS Coder" Language="C#" MasterPageFile="~/MasterPages/Frontend.master" AutoEventWireup="true" CodeFile="HCPCSCoder.aspx.cs" Inherits="HCPCSCoder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server"><br />
    <p style="font-family:'Lucida Calligraphy'; text-align:center; color:blue">Choose a Supply or Medication to Code</p><br />
     <div style="float: left">
        <asp:Label ID="lblSupply" runat="server" Text="Supply: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
        <asp:DropDownList ID="ddlSupply" runat="server" DataSourceID="dsSupplies" DataTextField="strSupply" DataValueField="intSupplyID" OnSelectedIndexChanged="ddlSupply_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True">
            <asp:ListItem Text="--Choose a Supply--" Value="-1"></asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="dsSupplies" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intSupplyID], [strSupply], [strHCPCSCode] FROM [TSupplies]"></asp:SqlDataSource>
        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        <br /><br /><br /><br />
        <asp:Label ID="lblSupplyCode" runat="server" Text="Supply HCPCS: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
        <asp:Label ID="lblSupplyHCPCS" runat="server"></asp:Label>
    </div>

    <div style="float: left">
        <asp:Label ID="lblMedication" runat="server" Text="Medication: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
        <asp:DropDownList ID="ddlMedication" runat="server" DataSourceID="dsMedications" DataTextField="strMedication" DataValueField="intMedicationID" OnSelectedIndexChanged="ddlMedication_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True">
             <asp:ListItem Text="--Choose a Medication--" Value="-1"></asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="dsMedications" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intMedicationID], [strMedication], [strHCPCSCode] FROM [TMedications]"></asp:SqlDataSource>
        <br /><br /><br /><br />
        <asp:Label ID="lblMedicationCode" runat="server" Text="Medication HCPCS: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
        <asp:Label ID="lblMedicationHCPCS" runat="server"></asp:Label>
    </div>
</asp:Content>

