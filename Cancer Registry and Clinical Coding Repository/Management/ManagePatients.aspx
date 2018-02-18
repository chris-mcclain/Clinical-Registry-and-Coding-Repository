<%--
Form: ManagePatients
Class: CPDM Capstone
Author: Chris McClain
Abstract: Navigation page that allows management to navigate to pages for adding patients, editing existing details, 
          adding new details, and deleting patients from the Cancer Registry.
Date: July 15, 2017
--%>

<%@ Page Title="Manage Patients" Language="C#" MasterPageFile="~/MasterPages/Management.master" AutoEventWireup="true" CodeFile="ManagePatients.aspx.cs" Inherits="Management_ManagePatients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"><br />
        <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" StaticMenuItemStyle-HorizontalPadding="10px" BorderStyle="Solid" BorderWidth="1px" BackColor="aliceblue" DynamicHorizontalOffset="2" Font-Names="Lucida Calligraphy" Font-Size="0.9em" ForeColor="#284E98" StaticDisplayLevels="2" StaticSubMenuIndent="10px" StaticMenuItemStyle-VerticalPadding="2px" Width="787">
            <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
            <DynamicMenuStyle BackColor="#B5C7DE" />
            <StaticSelectedStyle BackColor="#507CD1" />
            <DynamicSelectedStyle BackColor="#507CD1" />
            <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
            <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
             <Items>
                <asp:MenuItem Text="Add a Patient" Value="Add" NavigateUrl="~/Management/AddPatient.aspx"></asp:MenuItem>
                <asp:MenuItem Text="Delete a Patient" Value="DeletPatient" NavigateUrl="~/Management/SearchRegistry.aspx"></asp:MenuItem>
                <asp:MenuItem Text="Add New Details" Value="AddDetails" NavigateUrl="~/Management/SearchRegistry.aspx"></asp:MenuItem>                             
                <asp:MenuItem Text="Delete Details" Value="DeleteDetails" NavigateUrl="~/CancerRegistry/Default.aspx"></asp:MenuItem>
                <asp:MenuItem Text="Edit Patient Demographics" Value="EditDetails" NavigateUrl="~/Management/SearchRegistry.aspx"></asp:MenuItem> 
            </Items>
        </asp:Menu>
   
</asp:Content>

