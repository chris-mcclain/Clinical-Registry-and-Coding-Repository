<%--
Form: AddNewDetails
Class: CPDM Capstone
Author: Chris McClain
Abstract: Allows management to add new details to a patient's Cancer Registry chart
Date: July 15, 2017
--%>

<%@ Page Title="Add New Details" Language="C#" MasterPageFile="~/MasterPages/Management.master" AutoEventWireup="true" CodeFile="AddNewDetails.aspx.cs" Inherits="Management_AddNewDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:Label ID="lblPatientName" runat="server" Font-Names="Lucida Calligraphy" Font-Bold="True"></asp:Label>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    <asp:Label ID="lblDateOfBirth" runat="server" Font-Names="Lucida Calligraphy" Font-Bold="True"></asp:Label>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    <asp:Label ID="lblTigerNumber" runat="server" Font-Names="Lucida Calligraphy" Font-Bold="True"></asp:Label><br /><br />
    <asp:Panel ID="Panel1" runat="server" BackColor="#FFFFCC" Width="1025">
    <asp:Panel ID="pnlDiagnoses" runat="server" style="display:inline-block; float:left" BackColor="#FFFFCC" GroupingText="Add a Diagnosis" Width="450px"><br /><br />
        <div style="text-align:center">
        <asp:DropDownList ID="ddlDiagnoses" runat="server" DataSourceID="dsDiagnoses" DataTextField="strCondition" DataValueField="intConditionID"></asp:DropDownList><br /><br />
        </div>
        <asp:SqlDataSource ID="dsDiagnoses" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intConditionID], [strCondition] FROM [TConditions]"></asp:SqlDataSource>
        <asp:Label ID="lblDiagnosisDate" runat="server" Text="Date Diagnosed: "></asp:Label>
        <asp:TextBox ID="txtDiagnosisDate" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvDiagnosisDate" runat="server" ErrorMessage="You must enter a diagnosis date" ControlToValidate="txtDiagnosisDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Diagnosis"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="cvDiagnosisDate" runat="server" ErrorMessage="You must enter a valid diagnosis date" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtDiagnosisDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Diagnosis"></asp:CompareValidator><br /><br /><br /><br />
        <div style="text-align: center">
        <asp:Button ID="btnSubmitDiagnosis" runat="server" Text="Submit" OnClick="btnSubmitDiagnosis_Click" ValidationGroup="Diagnosis" />
        </div>
        <asp:ValidationSummary ID="vsDiagnosis" runat="server" CssClass="ErrorMessage" ShowMessageBox="True" ShowSummary="False" ValidationGroup="Diagnosis" />
    </asp:Panel>

    <asp:Panel ID="panImaging" runat="server" style="display:inline-block; float:left" BackColor="#FFFFCC" GroupingText="Add Imaging" Width="450px"><br /><br />
        <div style="text-align:center">
            <asp:DropDownList ID="ddlImaging" runat="server" DataSourceID="dsImaging" DataTextField="strImaging" DataValueField="intImagingID"></asp:DropDownList><br /><br />
        </div>
        <asp:SqlDataSource ID="dsImaging" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intImagingID], [strImaging] FROM [TImaging]"></asp:SqlDataSource>
        <asp:Label ID="lblImagingDate" runat="server" Text="Imaging Date: "></asp:Label>
        <asp:TextBox ID="txtImagingDate" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvImagingDate" runat="server" ErrorMessage="You must enter an imaging date" ControlToValidate="txtImagingDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Imaging"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="cvImagingDate" runat="server" ErrorMessage="You must enter a valid imaging date" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtImagingDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Imaging"></asp:CompareValidator><br /><br />
        <asp:Label ID="lblMets" runat="server" Text="Mets Present: "></asp:Label>
        <asp:CheckBox ID="chkMets" runat="server" /><br /><br />
        <div style="text-align:center">
            <asp:Button ID="btnSubmitImaging" runat="server" Text="Submit" OnClick="btnSubmitImaging_Click" ValidationGroup="Imaging" />
        </div>
        <asp:ValidationSummary ID="vsImaging" runat="server" CssClass="ErrorMessage" ValidationGroup="Imaging" Visible="True" ShowSummary="False" ShowMessageBox="True" />
    </asp:Panel>
    <asp:Panel ID="panLabTests" runat="server" style="display:inline-block; float:left" BackColor="#FFFFCC" GroupingText="Add a Lab Test" Width="450px"><br /><br />
        <div style="text-align:center">
            <asp:DropDownList ID="ddlLabTests" runat="server" DataSourceID="dsLabTests" DataTextField="strLabTest" DataValueField="intLabTestID"></asp:DropDownList><br /><br />
        </div>
        <asp:SqlDataSource ID="dsLabTests" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intLabTestID], [strLabTest] FROM [TLabTests]"></asp:SqlDataSource>
        <asp:Label ID="lblTestDate" runat="server" Text="Lab Test Date: "></asp:Label>
        <asp:TextBox ID="txtTestDate" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvTestDate" runat="server" ErrorMessage="You must enter a lab test date" ControlToValidate="txtTestDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="LabTest"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="cvTestDate" runat="server" ErrorMessage="You must enter a valid lab test date" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtTestDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="LabTest"></asp:CompareValidator><br /><br />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        <asp:Label ID="lblResult" runat="server" Text="Result: "></asp:Label>
        <asp:TextBox ID="txtResult" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvResult" runat="server" ErrorMessage="You must enter a result" ControlToValidate="txtResult" CssClass="ErrorMessage" Display="Dynamic" ValidationGroup="LabTest" Text="*"></asp:RequiredFieldValidator><br /><br />
        <div style="text-align:center">
            <asp:Button ID="btnSubmitLabTest" runat="server" Text="Submit" OnClick="btnSubmitLabTest_Click" ValidationGroup="LabTest" />
        </div>
        <asp:ValidationSummary ID="vsLabTest" runat="server" CssClass="ErrorMessage" ShowSummary="False" ShowMessageBox="True" ValidationGroup="LabTest" />
    </asp:Panel>
    <asp:Panel ID="panTreatments" runat="server" style="display:inline-block; float:left" BackColor="#FFFFCC" GroupingText="Add a Treatment" Width="450px"><br /><br />
        <div style="text-align:center">
            <asp:DropDownList ID="ddlTreatments" runat="server" DataSourceID="dsTreatments" DataTextField="strTreatment" DataValueField="intTreatmentID"></asp:DropDownList><br /><br />
        </div>
        <asp:SqlDataSource ID="dsTreatments" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intTreatmentID], [strTreatment] FROM [TTreatments]"></asp:SqlDataSource>
        <asp:Label ID="lblTreatmentDate" runat="server" Text="Treatment Date: "></asp:Label>
        <asp:TextBox ID="txtTreatmentDate" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvTreatmentDate" runat="server" ErrorMessage="You must enter a treatment date" ControlToValidate="txtTreatmentDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Treatment"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="cvTreatmentDate" runat="server" ErrorMessage="You must enter a valid treatment date" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtTreatmentDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Treatment"></asp:CompareValidator><br /><br /><br /><br />
        <div style="text-align:center">
            <asp:Button ID="btnSubmitTreatment" runat="server" Text="Submit" OnClick="btnSubmitTreatment_Click" ValidationGroup="Treatment" />
        </div>
        <asp:ValidationSummary ID="vsTreatment" runat="server" CssClass="ErrorMessage"  ValidationGroup="Treatment" ShowSummary="False" ShowMessageBox="True" />
    </asp:Panel>
    <asp:Panel ID="panProcedures" runat="server" style="display:inline-block; float:left" BackColor="#FFFFCC" GroupingText="Add a Procedure" Width="450px"><br /><br />
        <div style="text-align:center">
            <asp:DropDownList ID="ddlProcedures" runat="server" DataSourceID="dsProcedures" DataTextField="strProcedure" DataValueField="intProcedureID"></asp:DropDownList><br /><br />
        </div>
        <asp:SqlDataSource ID="dsProcedures" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intProcedureID], [strProcedure] FROM [TProcedures]"></asp:SqlDataSource>
        <asp:Label ID="lblProcedureDate" runat="server" Text="Procedure Date: "></asp:Label>
        <asp:TextBox ID="txtProcedureDate" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvProcedureDate" runat="server" ErrorMessage="You must enter a procedure date" ControlToValidate="txtProcedureDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Procedure"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="cvProcedureDate" runat="server" ErrorMessage="You must enter a valid procedure date" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtProcedureDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Procedure"></asp:CompareValidator><br /><br /><br /><br /><br /><br />
        <div style="text-align:center">
            <asp:Button ID="btnSubmitProcedure" runat="server" Text="Submit" OnClick="btnSubmitProcedure_Click" ValidationGroup="Procedure" />
        </div>
        <asp:ValidationSummary ID="vsProcedure" runat="server" CssClass="ErrorMessage" ValidationGroup="Procedure" Visible="True" ShowSummary="False" ShowMessageBox="True" />
    </asp:Panel>
    <asp:Panel ID="panMedications" runat="server" style="display:inline-block; float:left" BackColor="#FFFFCC" GroupingText="Add a Medication" Width="450px"><br /><br />
        <div style="text-align:center">
            <asp:DropDownList ID="ddlMedications" runat="server" DataSourceID="dsMedications" DataTextField="strMedication" DataValueField="intMedicationID"></asp:DropDownList><br /><br />
        </div>
        <asp:SqlDataSource ID="dsMedications" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" SelectCommand="SELECT [intMedicationID], [strMedication] FROM [TMedications]"></asp:SqlDataSource>&nbsp&nbsp&nbsp&nbsp&nbsp
        <asp:Label ID="lblAdministrationDate" runat="server" Text="Administration Date: "></asp:Label>
        <asp:TextBox ID="txtAdministrationDate" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvAdministrationDate" runat="server" ErrorMessage="You must enter an administration date" ControlToValidate="txtAdministrationDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Medication"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="cvAdministrationDate" runat="server" ErrorMessage="You must enter a valid administration date" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtTreatmentDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Medication"></asp:CompareValidator><br /><br />
        <asp:Label ID="lblAuthorization" runat="server" Text="Insurance Authorization: "></asp:Label>
        <asp:TextBox ID="txtAuthorization" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvAuthorization" runat="server" ErrorMessage="You must enter an authorization" ControlToValidate="txtAuthorization" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Medication"></asp:RequiredFieldValidator><br /><br />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        <asp:Label ID="lblDueDate" runat="server" Text="Next Due Date: "></asp:Label>
        <asp:TextBox ID="txtDueDate" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvDueDate" runat="server" ErrorMessage="You must enter a due date" ControlToValidate="txtDueDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Medication"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="cvDueDate" runat="server" ErrorMessage="You must enter a valid due date" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtDueDate" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="Medication"></asp:CompareValidator><br /><br />
        <div style="text-align:center">
            <asp:Button ID="btnSubmitMedication" runat="server" Text="Submit" OnClick="btnSubmitMedication_Click" ValidationGroup="Medication" />
        </div>
        <asp:ValidationSummary ID="vsMedication" runat="server" CssClass="ErrorMessage" ValidationGroup="Medication" ShowSummary="False" ShowMessageBox="True" />
    </asp:Panel>
    </asp:Panel>
</asp:Content>

