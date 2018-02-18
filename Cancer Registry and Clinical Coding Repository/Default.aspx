<%--
Author: Chris McClain
Abstract: Log-in Page for Cancer Registry and Clinical Coding Repository
--%>

<%@ Page Title="Home" Language="C#" MasterPageFile="~/MasterPages/Frontend.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server">
    <div style="text-align:center">
        <div style="width:400px; margin-left:auto; margin-right:auto;">
            <asp:LoginView ID="LoginView1" runat="server">
                <AnonymousTemplate>
                    <asp:Login ID="MainPageLogin" runat="server" DestinationPageUrl="~/Default.aspx">
                    </asp:Login>
                </AnonymousTemplate>
                <LoggedInTemplate>                    
                </LoggedInTemplate>
            </asp:LoginView>
            
        </div>
    </div>
    <br /><br />
    <div style="text-align: center">
        <asp:Label ID="lblWelcome" runat="server" Text="Welcome to the Cancer Registry and Clinical Coding Repository" Font-Names="Lucida Calligraphy" Font-Size="26px" ForeColor="Blue" Font-Bold="True"></asp:Label> 
    </div>
</asp:Content>

