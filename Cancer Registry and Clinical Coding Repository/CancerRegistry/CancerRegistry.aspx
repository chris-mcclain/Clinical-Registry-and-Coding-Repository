<%--
Form: CancerRegistry
Class: CPDM Capstone
Author: Chris McClain
Abstract: Displays information about diagnoses, lab tests, imaging, treatments, medications, and procedures for each
          patient with a chart in the Cancer Registry
Date: July 15, 2017
--%>

<%@ Page Title="Cancer Registry" Language="C#" MasterPageFile="~/MasterPages/Frontend.master" AutoEventWireup="true" CodeFile="CancerRegistry.aspx.cs" Inherits="CancerRegistry_CancerRegistry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        fieldset {
            height: 300px;
            width: 450px;
            display: inline-block;
        }
        legend {
            font-family: 'Lucida Calligraphy';
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMainContent" Runat="Server"><br /><br />
    <asp:Panel ID="panRegistryOverview" runat="server" BackColor="#FFFFCC" Width="1025">
        <div>
            <p style="float:left; width:30%; text-align:left">
                <asp:Label ID="lblPatientName" runat="server" Text="" Font-Names="Lucida Calligraphy" Font-Bold="True"></asp:Label>
            </p>
            <p style="float:left; width:25%; text-align:right">
                 <asp:Label ID="lblDateOfBirth" runat="server" Text="" Font-Names="Lucida Calligraphy" Font-Bold="True"></asp:Label>
            </p>
            <p style="float:left; width:40%; text-align:right">
                <asp:Label ID="lblTigerNumber" runat="server" Text="" Font-Names="Lucida Calligraphy" Font-Bold="True" ></asp:Label>
            </p>
        </div>
        <div style="clear:both"></div>
        <p style="text-align:left; float:left; width:60%">
            <asp:Label ID="lblAuthorization1" runat="server" Text="" Font-Names="Lucida Calligraphy" Font-Bold="True" ></asp:Label>
        </p> 
        <p style="text-align:right; float:left; width:40%">
           <asp:Label ID="lblNextAppointment" runat="server" Text="" Font-Names="Lucida Calligraphy" Font-Bold="True"></asp:Label>
        </p> 
            <div>
                <asp:Panel ID="panDiagnoses" runat="server" style="display:inline-block; overflow:scroll" GroupingText="Diagnoses" Width="500px" ScrollBars="Auto">
                    <asp:GridView ID="gvConditions" runat="server" CellPadding="7" CellSpacing="5" HorizontalAlign="Center" DataSourceID="dsDiagnosisDetails" AutoGenerateColumns="False" DataKeyNames="intConditionID" Width="450px" GridLines="Both">
                        <RowStyle HorizontalAlign="Center" />
                        <Columns>
                            <asp:CommandField ShowDeleteButton="true" />
                            <asp:TemplateField HeaderText="Diagnosis">
                                <ItemTemplate>
                                    <asp:Label ID="lblCondition" runat="server" Text='<%# Bind("strCondition") %>'></asp:Label>
                                </ItemTemplate>                            
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date Diagnosed">
                                <ItemTemplate>
                                    <asp:Label ID="lblDiagnosisDate" runat="server" Text='<%# Bind("dteDateDiagnosed") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ICD-10 Code">
                                <ItemTemplate>
                                    <asp:Label ID="lblICD10" runat="server" Text='<%# Bind("strICD10Code") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="dsDiagnosisDetails" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>"
                         SelectCommand="SELECT TC.intConditionID, TC.strCondition, TC.strICD10Code, TPC.dteDateDiagnosed FROM TConditions AS TC, TPatientConditions AS TPC WHERE TC.intConditionID = TPC.intConditionID AND intPatientID = @intPatientID"
                         DeleteCommand="DELETE FROM TPatientConditions WHERE (intConditionID = @intConditionID) AND (intPatientID = @intPatientID)" >                      
                        <SelectParameters>
                            <asp:QueryStringParameter Name="intPatientID" DefaultValue="1" QueryStringField="intPatientID" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="intConditionID" Type="Int32" />
                            <asp:QueryStringParameter Name="intPatientID" DefaultValue="1" QueryStringField="intPatientID" />
                        </DeleteParameters>
                    </asp:SqlDataSource>                  
                </asp:Panel>
                <asp:Panel ID="panImaging" runat="server" style="display:inline-block; overflow:scroll" GroupingText="Imaging" ScrollBars="Auto" Width="500px">
                    <asp:GridView ID="gvImaging" runat="server" CellPadding="7" CellSpacing="5" DataKeyNames="intImagingID, intImagingIndex" AutoGenerateColumns="false" DataSourceID="dsImagingDetails" Width="450px">
                         <Columns>
                             <asp:CommandField ShowDeleteButton="true" />                             
                             <asp:TemplateField HeaderText="Imaging">
                                 <ItemTemplate>
                                     <asp:Label ID="lblImaging" runat="server" Text='<%# Bind("strImaging") %>'></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>
                             <asp:TemplateField HeaderText="Imaging Date">
                                 <ItemTemplate>
                                     <asp:Label ID="lblImagingDate" runat="server" Text='<%# Bind("dteImagingDate") %>'></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>
                             <asp:TemplateField HeaderText="Mets">
                                 <ItemTemplate>
                                     <asp:CheckBox ID="chkMetsPresent" runat="server" Checked='<%# Bind("blnMetsPresent") %>'/>
                                 </ItemTemplate>
                             </asp:TemplateField>
                        </Columns>
                        <RowStyle HorizontalAlign="Center" />
                    </asp:GridView>
                      <asp:SqlDataSource ID="dsImagingDetails" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" 
                         SelectCommand="SELECT TI.intImagingID, TI.strImaging, TPI.intPatientID, TPI.intImagingIndex, TPI.dteImagingDate, TPI.blnMetsPresent FROM TImaging AS TI, TPatientImaging AS TPI WHERE TI.intImagingID = TPI.intImagingID AND intPatientID = @intPatientID ORDER BY YEAR(TPI.dteImagingDate) DESC, MONTH(TPI.dteImagingDate) DESC, DAY(TPI.dteImagingDate) DESC" 
                         DeleteCommand="DELETE FROM TPatientImaging WHERE (intImagingID = @intImagingID) AND (intImagingIndex = @intImagingIndex) AND (intPatientID = @intPatientID)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="intPatientID" DefaultValue="1" QueryStringField="intPatientID" />
                        </SelectParameters>
                        <DeleteParameters>
                             <asp:Parameter Name="intImagingID" Type="Int32" />
                             <asp:QueryStringParameter Name="intPatientID" DefaultValue="1" QueryStringField="intPatientID" />
                        </DeleteParameters>
                    </asp:SqlDataSource>
                </asp:Panel>
                <asp:Panel ID="panLabTests" runat="server" style="display:inline-block; overflow:scroll" GroupingText="Lab Tests" Width="500px" ScrollBars="Auto">
                    <asp:GridView ID="gvLabTests" runat="server" CellPadding="7" CellSpacing="5" HorizontalAlign="Center" Width="450px" DataSourceID="dsLabTestDetails" DataKeyNames="intLabTestID, intLabTestIndex" AutoGenerateColumns="False">
                         <Columns>
                            <asp:CommandField ShowDeleteButton="true" />
                             <asp:TemplateField HeaderText="Lab Test">
                                 <ItemTemplate>
                                     <asp:Label ID="lblLabTest" runat="server" Text='<%# Bind("strLabTest") %>'></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>
                             <asp:TemplateField HeaderText="Lab Test Date">
                                 <ItemTemplate>
                                     <asp:Label ID="lblTestDate" runat="server" Text='<%# Bind("dteLabTestDate") %>'></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>
                             <asp:TemplateField HeaderText="Result">
                                 <ItemTemplate>
                                     <asp:Label ID="lblResult" runat="server" Text='<%# Bind("strResult") %>'></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>
                        </Columns>
                        <RowStyle HorizontalAlign="Center" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="dsLabTestDetails" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>"
                        SelectCommand="SELECT TLT.intLabTestID, TLT.strLabTest, TPLT.intLabTestIndex, TPLT.dteLabTestDate, TPLT.strResult FROM TLabTests AS TLT, TPatientLabTests AS TPLT WHERE TLT.intLabTestID = TPLT.intLabTestID AND intPatientID = @intPatientID ORDER BY YEAR(TPLT.dteLabTestDate) DESC, MONTH(TPLT.dteLabTestDate) DESC, DAY(TPLT.dteLabTestDate) DESC"
                        DeleteCommand="DELETE FROM TPatientLabTests WHERE (intPatientID = @intPatientID) AND (intLabTestID=@intLabTestID) AND (intLabTestIndex=@intLabTestIndex)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="intPatientID" DefaultValue="1" QueryStringField="intPatientID" />
                        </SelectParameters>
                        <DeleteParameters>
                             <asp:Parameter Name="intLabTestID" Type="Int32" />
                             <asp:Parameter Name="intLabTestIndex" Type="Int32" />
                             <asp:QueryStringParameter Name="intPatientID" DefaultValue="1" QueryStringField="intPatientID" />
                        </DeleteParameters>
                    </asp:SqlDataSource>
                </asp:Panel>
                <asp:Panel ID="panTreatments" runat="server" style="display:inline-block; overflow:scroll" GroupingText="Treatments" Width="500px" ScrollBars="Auto">
                    <asp:GridView ID="gvTreatments" runat="server" CellPadding="7" CellSpacing="5" HorizontalAlign="Center" Width="450px" DataSourceID="dsTreatmentDetails" DataKeyNames="intTreatmentID, intTreatmentIndex" AutoGenerateColumns="False">
                         <Columns>
                            <asp:CommandField ShowDeleteButton="true" />
                             <asp:TemplateField HeaderText="Treatment">
                                 <ItemTemplate>
                                     <asp:Label ID="lblTreatment" runat="server" Text='<%# Bind("strTreatment") %>'></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>
                             <asp:TemplateField HeaderText="Treatment Date">
                                 <ItemTemplate>
                                     <asp:Label ID="lblTreatmentDate" runat="server" Text='<%# Bind("dteTreatmentDate") %>'></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>
                        </Columns>
                        <RowStyle HorizontalAlign="Center" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="dsTreatmentDetails" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" 
                        SelectCommand="SELECT TT.intTreatmentID, TT.strTreatment, TPT.intTreatmentIndex, TPT.dteTreatmentDate FROM TTreatments AS TT, TPatientTreatments AS TPT WHERE TT.intTreatmentID = TPT.intTreatmentID AND intPatientID = @intPatientID ORDER BY YEAR(TPT.dteTreatmentDate) DESC, MONTH(TPT.dteTreatmentDate) DESC, DAY(TPT.dteTreatmentDate) DESC"
                        DeleteCommand="DELETE FROM TPatientTreatments WHERE intPatientID=@intPatientID AND intTreatmentID=@intTreatmentID AND intTreatmentIndex=@intTreatmentIndex">                       
                        <SelectParameters>
                            <asp:QueryStringParameter Name="intPatientID" QueryStringField="intPatientID" Type="Int32" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:QueryStringParameter Name="intPatientID" QueryStringField="intPatientID" Type="Int32" />
                            <asp:Parameter Name="intTreatmentID" Type="Int32" />
                            <asp:Parameter Name="intTreatmentIndex" Type="Int32" />
                        </DeleteParameters>
                    </asp:SqlDataSource>
                </asp:Panel>
                <asp:Panel ID="panProcedures" runat="server" style="display: inline-block; overflow:scroll" GroupingText="Procedures" Width="500px" ScrollBars="Auto">
                    <asp:GridView ID="gvProcedures" runat="server" CellPadding="7" CellSpacing="5" HorizontalAlign="Center" DataSourceID="dsProcedureDetails" Width="450px" DataKeyNames="intProcedureID, intProcedureIndex" AutoGenerateColumns="False">
                         <Columns>
                           <asp:CommandField ShowDeleteButton="true" />
                             <asp:TemplateField HeaderText="Procedure">
                                 <ItemTemplate>
                                     <asp:Label ID="lblProcedure" runat="server" Text='<%# Bind("strProcedure") %>'></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>
                             <asp:TemplateField HeaderText="Procedure Date">
                                 <ItemTemplate>
                                     <asp:Label ID="lblProcedureDate" runat="server" Text='<%# Bind("dteProcedureDate") %>'></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>
                        </Columns>
                        <RowStyle HorizontalAlign="Center" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="dsProcedureDetails" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" 
                        SelectCommand="SELECT TP.intProcedureID, TP.strProcedure, TPP.intProcedureIndex, TPP.dteProcedureDate FROM TProcedures AS TP, TPatientProcedures AS TPP WHERE TP.intProcedureID = TPP.intProcedureID AND intPatientID = @intPatientID ORDER BY YEAR(TPP.dteProcedureDate) DESC, MONTH(TPP.dteProcedureDate) DESC, DAY(TPP.dteProcedureDate) DESC"
                        DeleteCommand="DELETE FROM TPatientProcedures WHERE (intPatientID=@intPatientID) AND (intProcedureID=@intProcedureID) AND (intProcedureIndex=@intProcedureIndex)"> 
                        <SelectParameters>
                            <asp:QueryStringParameter Name="intPatientID" QueryStringField="intPatientID" Type="Int32" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:QueryStringParameter Name="intPatientID" QueryStringField="intPatientID" Type="Int32" />
                            <asp:Parameter Name="intProcedureID" Type="Int32" />
                            <asp:Parameter Name="intProcedureIndex" Type="Int32" />
                        </DeleteParameters>
                    </asp:SqlDataSource>
                </asp:Panel>
            <asp:Panel ID="panMedications" runat="server" style="display: inline-block; overflow:scroll" GroupingText="Medications" Width="500px" ScrollBars="Auto">
                    <asp:GridView ID="gvMedications" runat="server" CellPadding="7" CellSpacing="5" HorizontalAlign="Center" DataSourceID="dsMedicationDetails" Width="450px" DataKeyNames="intMedicationID, intMedicationIndex" AutoGenerateColumns="false">
                         <Columns>
                            <asp:CommandField ShowDeleteButton="true" />
                             <asp:TemplateField HeaderText="Medication">
                                 <ItemTemplate>
                                     <asp:Label ID="lblMedication" runat="server" Text='<%# Bind("strMedication") %>'></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>
                             <asp:TemplateField HeaderText="Administration Date">
                                 <ItemTemplate>
                                     <asp:Label ID="lblAdministrationDate" runat="server" Text='<%# Bind("dteAdministrationDate") %>'></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>
                        </Columns>
                        <RowStyle HorizontalAlign="Center" />
                    </asp:GridView>
                <asp:SqlDataSource ID="dsMedicationDetails" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" 
                    SelectCommand="SELECT TM.intMedicationID, TM.strMedication, TPM.intMedicationIndex, TPM.dteAdministrationDate FROM TMedications AS TM, TPatientMedications AS TPM WHERE TM.intMedicationID = TPM.intMedicationID AND intPatientID = @intPatientID ORDER BY YEAR(TPM.dteAdministrationDate) DESC, MONTH(TPM.dteAdministrationDate) DESC, DAY(TPM.dteAdministrationDate) DESC"
                    DeleteCommand="DELETE FROM TPatientMedications WHERE (intPatientID=@intPatientID) AND (intMedicationID=@intMedicationID) AND (intMedicationIndex=@intMedicationIndex)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="intPatientID" QueryStringField="intPatientID" Type="Int32" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:QueryStringParameter Name="intPatientID" QueryStringField="intPatientID" Type="Int32" />
                        <asp:Parameter Name="intMedicationID" Type="Int32" />
                        <asp:Parameter Name="intMedicationIndex" Type="Int32" />
                    </DeleteParameters>
                </asp:SqlDataSource>
            </asp:Panel>
            </div>
        </asp:Panel>
</asp:Content>

