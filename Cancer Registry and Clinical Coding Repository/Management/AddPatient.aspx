<%--
Author: Chris McClain
Abstract: Allows management to add a new patient to the Cancer Registry
--%>

<%@ Page Title="Add Patient to Registry" Language="C#" MasterPageFile="~/MasterPages/Management.master" AutoEventWireup="true" CodeFile="AddPatient.aspx.cs" Inherits="Management_AddPatient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .table {
            width: 100%;
        }
        .demoLabels {
            width: 148px;
            text-align: right;
        }
        .ErrorMessage {
            color: red;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblAddPatient" runat="server" Text="Add a Patient to the Cancer Registry" Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
    <br />
    <br />
    <table class="table">
                <tr>
                    <td class="demoLabels">
                        
                        <asp:Label ID="lblFirstName" runat="server" Text="First Name: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>                  
                    <td>
                        <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ErrorMessage="You must enter a first name" ControlToValidate="txtFirstName" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td class="demoLabels">
                        <asp:Label ID="lblLastName" runat="server" Text="Last Name: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ErrorMessage="You must enter a last name" ControlToValidate="txtLastName" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td class="demoLabels">
                        <asp:Label ID="lblDateOfBirth" runat="server" Text="Date of Birth: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtDateOfBirth" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDateOfBirth" runat="server" ErrorMessage="You must enter a date of birth" ControlToValidate="txtDateOfBirth" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvDateOfBirth" runat="server" ErrorMessage="You must enter a valid date of birth" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtDateOfBirth" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:CompareValidator>
                    </td>

                </tr>
                <tr>
                    <td class="demoLabels">
                        <asp:Label ID="lblTigerNumber" runat="server" Text="Tiger Number: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtTigerNumber" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTigerNumber" runat="server" ErrorMessage="You must enter a Tiger Number" ControlToValidate="txtTigerNumber" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revTigerNumber" runat="server" ErrorMessage="You must enter a valid Tiger Number" ControlToValidate="txtTigerNumber" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationExpression="^[0-9a-zA-Z]+$"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="demoLabels">
                        <asp:Label ID="lblNextAppointment" runat="server" Text="Next Appointment Date: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtNextAppointment" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNextAppointment" runat="server" ErrorMessage="You must enter the next appointment date" ControlToValidate="txtNextAppointment" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvNextAppointment" runat="server" ErrorMessage="You must enter a valid appointment date" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtNextAppointment" CssClass="ErrorMessage" Display="Dynamic" Text="*"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                       <br /> 
                    </td>
                    <td>
                        <div style="text-align:left">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                        </div>
                    </td>
                </tr>
            </table>
    <asp:ValidationSummary ID="vsAddPatient" runat="server" CssClass="ErrorMessage" />
</asp:Content>

