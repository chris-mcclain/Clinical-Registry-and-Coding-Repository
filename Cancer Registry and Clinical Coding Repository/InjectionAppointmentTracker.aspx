<%--
Form: InjectionAppointmentTracker
Class: CPDM Capstone
Author: Chris McClain
Abstract: Displays patient name, date of birth, medication, insurance authorization, due date for next injection
          and next scheduled appointment for all patients who are due for injections within the specified time frame.
Date: July 15, 2017
--%>

<%@ Page Title="Injection Appointment Tracker" Language="C#" MasterPageFile="~/MasterPages/Frontend.master" AutoEventWireup="true" CodeFile="InjectionAppointmentTracker.aspx.cs" Inherits="InjectionAppointmentTracker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server"><br />
    <br />
    <asp:Label ID="lblStartDate" runat="server" Text="Start Date: " ForeColor="Blue" Font-Names="Lucida Calligraphy"></asp:Label>
    <asp:TextBox ID="txtStartDate" runat="server"></asp:TextBox>
    <asp:CompareValidator ID="cvStartDate" runat="server" ErrorMessage="You must enter a valid start date" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtStartDate" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:CompareValidator>
    <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ErrorMessage="You must enter a start date" ControlToValidate="txtStartDate" CssClass="ErrorMessage" Display="Dynamic" Font-Bold="False" Text="*"></asp:RequiredFieldValidator>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    <asp:Label ID="lblEndDate" runat="server" Text="End Date: " ForeColor="Blue" Font-Names="Lucida Calligraphy"></asp:Label>
    <asp:TextBox ID="txtEndDate" runat="server"></asp:TextBox>
    <asp:CompareValidator ID="cvEndDate" runat="server" ErrorMessage="You must enter a valid end date" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtEndDate" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:CompareValidator>
    <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ErrorMessage="You must enter an end date" ControlToValidate="txtEndDate" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
    <br /><br />
    <div style="text-align:center">
    <asp:Button ID="btnSubmitDates" runat="server" Text="Submit" OnClick="btnSubmitDates_Click" />
    </div>
    <asp:ValidationSummary ID="vsAppointmentTracker" runat="server" CssClass="ErrorMessage" />
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upInjectionAppointments" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvInjectionAppointments" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
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

