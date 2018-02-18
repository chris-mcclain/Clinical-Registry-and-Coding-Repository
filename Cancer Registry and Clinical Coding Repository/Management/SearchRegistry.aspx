<%--
Form: SearchRegistry
Class: CPDM Capstone
Author: Chris McClain
Abstract: Allows management to search the registry for patients
Date: July 15, 2017
--%>

<%@ Page Title="Search Registry" Language="C#" MasterPageFile="~/MasterPages/Management.master" AutoEventWireup="true" CodeFile="SearchRegistry.aspx.cs" Inherits="Management_SearchRegistry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblSearch" runat="server" Text="Search for a Cancer Registry Patient" Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label>
    <br />
    <br />
    <table>
        <tr>
            <td>
                <asp:Label ID="lblFirstName" runat="server" Text="First Name: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
            <td>
                <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ErrorMessage="You must enter a first name" ControlToValidate="txtFirstName" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="SearchRegistry"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblLastName" runat="server" Text="Last Name: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
            <td>
                <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ErrorMessage="You must enter a last name" ControlToValidate="txtLastName" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="SearchRegistry"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblDateOfBirth" runat="server" Text="Date of Birth: " Font-Names="Lucida Calligraphy" ForeColor="Blue"></asp:Label></td>
            <td>
                <asp:TextBox ID="txtDateOfBirth" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDateOfBirth" runat="server" ErrorMessage="You must enter a date of birth" ControlToValidate="txtDateOfBirth" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="SearchRegistry"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvDateOfBirth" runat="server" ErrorMessage="You must enter a valid date of birth" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtDateOfBirth" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="SearchRegistry"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td>
               <br /> 
            </td>
            <td>
                <div style="text-align:left">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" ValidationGroup="SearchRegistry" />
                </div>
            </td>
        </tr>
    </table>
    <asp:ValidationSummary ID="vsSearchRegistry" runat="server" CssClass="ErrorMessage" ValidationGroup="SearchRegistry" />
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upRegistryPatients" runat="server">
        <ContentTemplate>
             <asp:GridView ID="gvRegistryPatients" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="intPatientID" DataSourceID="dsPatientData" AutoGenerateColumns="False">
                 <AlternatingRowStyle BackColor="White" />
                 <EditRowStyle BackColor="#2461BF" ForeColor="White" />
                 <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                 <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                 <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                 <RowStyle BackColor="#EFF3FB" />
                 <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                 <SortedAscendingCellStyle BackColor="#F5F7FB" />
                 <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                 <SortedDescendingCellStyle BackColor="#E9EBEF" />
                 <SortedDescendingHeaderStyle BackColor="#4870BE" />
                 <Columns>
                     <asp:HyperLinkField Text="Select" DataNavigateUrlFields="intPatientID" DataNavigateUrlFormatString="AddNewDetails.aspx?intPatientID={0}" />
                     <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" ValidationGroup="EditDemo" />
                      <asp:TemplateField HeaderText="First Name">
                         <ItemTemplate>
                             <asp:Label ID="lblFirstName" runat="server" Text='<%# Bind("strFirstName") %>'></asp:Label>
                         </ItemTemplate>
                         <EditItemTemplate>
                             <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("strFirstName") %>'></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ErrorMessage="You must enter a first name" ControlToValidate="txtFirstName" CssClass="ErrorMessage" ValidationGroup="EditDemo" Display="None"></asp:RequiredFieldValidator>
                         </EditItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Last Name">
                         <ItemTemplate>
                             <asp:Label ID="lblLastName" runat="server" Text='<%# Bind("strLastName") %>'></asp:Label>
                         </ItemTemplate>
                         <EditItemTemplate>
                             <asp:TextBox ID="txtLastName" runat="server" Text='<%# Bind("strLastName") %>'></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ErrorMessage="You must enter a last name" ControlToValidate="txtLastName" CssClass="ErrorMessage" ValidationGroup="EditDemo" Display="None"></asp:RequiredFieldValidator>
                         </EditItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Date Of Birth">
                         <ItemTemplate>
                             <asp:Label ID="lblDateOfBirth" runat="server" Text='<%# Bind("dteDateOfBirth") %>'></asp:Label>
                         </ItemTemplate>
                         <EditItemTemplate>
                             <asp:TextBox ID="txtDateOfBirth" runat="server" Text='<%# Bind("dteDateOfBirth") %>'></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvDateOfBirth" runat="server" ErrorMessage="You must enter a date of birth" ControlToValidate="txtDateOfBirth" CssClass="ErrorMessage" ValidationGroup="EditDemo" Display="None"></asp:RequiredFieldValidator>
                             <asp:CompareValidator ID="cvDateOfBirth" runat="server" ErrorMessage="You must enter a valid date of birth" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtDateOfBirth" CssClass="ErrorMessage" ValidationGroup="EditDemo" Display="None"></asp:CompareValidator>
                         </EditItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Tiger Number">
                         <ItemTemplate>
                             <asp:Label ID="lblTigerNumber" runat="server" Text='<%# Bind("strTigerNumber") %>'></asp:Label>
                         </ItemTemplate>
                         <EditItemTemplate>
                             <asp:TextBox ID="txtTigerNumber" runat="server" Text='<%# Bind("strTigerNumber") %>'></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvTigerNumber" runat="server" ErrorMessage="You must enter a Tiger Number" ControlToValidate="txtTigerNumber" CssClass="ErrorMessage" ValidationGroup="EditDemo" Display="None"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revTigerNumber" runat="server" ErrorMessage="You must enter a valid Tiger Number" ControlToValidate="txtTigerNumber" CssClass="ErrorMessage" ValidationExpression="^[0-9a-zA-Z]+$" ValidationGroup="EditDemo" Display="None"></asp:RegularExpressionValidator>
                         </EditItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Next Appointment Date">
                         <ItemTemplate>
                             <asp:Label ID="lblNextAppointment" runat="server" Text='<%# Bind("dteNextAppointmentDate") %>'></asp:Label>
                         </ItemTemplate>
                         <EditItemTemplate>
                             <asp:TextBox ID="txtNextAppointment" runat="server" Text='<%# Bind("dteNextAppointmentDate") %>'></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvNextAppointment" runat="server" ErrorMessage="You must enter the next appointment date" ControlToValidate="txtNextAppointment" CssClass="ErrorMessage" ValidationGroup="EditDemo" Display="None"></asp:RequiredFieldValidator>
                             <asp:CompareValidator ID="cvNextAppointment" runat="server" ErrorMessage="You must enter a valid appointment date" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtNextAppointment" CssClass="ErrorMessage" ValidationGroup="EditDemo" Display="None"></asp:CompareValidator>
                         </EditItemTemplate>
                     </asp:TemplateField>
                 </Columns>
             </asp:GridView>
            
            <asp:SqlDataSource ID="dsPatientData" runat="server" ConnectionString="<%$ ConnectionStrings:dbSQL1ConnectionString %>" 
                 SelectCommand="SELECT intPatientID, strFirstName, strLastName, dteDateOfBirth, strTigerNumber, dteNextAppointmentDate FROM TPatients WHERE (strFirstName=@strFirstName) AND (strLastName=@strLastName) AND (dteDateOfBirth=@dteDateOfBirth)" 
                 UpdateCommand="UPDATE TPatients SET strFirstName=@strFirstName, strLastName=@strLastName, dteDateOfBirth=@dteDateOfBirth, strTigerNumber=@strTigerNumber, dteNextAppointmentDate=@dteNextAppointmentDate WHERE intPatientID=@intPatientID"
                 DeleteCommand="DELETE FROM TPatientConditions WHERE intPatientID=@intPatientID;
                                DELETE FROM TPatientImaging WHERE intPatientID=@intPatientID; 
                                DELETE FROM TPatientLabTests WHERE intPatientID=@intPatientID;  
                                DELETE FROM TPatientProcedures WHERE intPatientID=@intPatientID; 
                                DELETE FROM TPatientTreatments WHERE intPatientID=@intPatientID; 
                                DELETE FROM TPatientMedications WHERE intPatientID=@intPatientID; 
                                DELETE FROM TPatients WHERE intPatientID=@intPatientID">
                 <SelectParameters>
                     <asp:ControlParameter Name="strFirstName" ControlID="txtFirstName" PropertyName="Text" />
                     <asp:ControlParameter Name="strLastName" ControlID="txtLastName" PropertyName="Text" />
                     <asp:ControlParameter Name="dteDateOfBirth" ControlID="txtDateOfBirth" PropertyName="Text" />
                 </SelectParameters>
                 <UpdateParameters>
                     <asp:Parameter Name="intPatientID" Type="Int32" />
                     <asp:Parameter Name="strFirstName" Type="String" />
                     <asp:Parameter Name="strLastName" Type="String" />
                     <asp:Parameter Name="dteDateOfBirth" Type="String" />
                     <asp:Parameter Name="strTigerNumber" Type="String" />
                     <asp:Parameter Name="dteNextAppointmentDate" Type="String" />
                 </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="intPatientID" Type="Int32" />
                </DeleteParameters>
             </asp:SqlDataSource>
            <asp:ValidationSummary ID="vsEditDemo" runat="server" CssClass="ErrorMessage" ValidationGroup="EditDemo" /> 
        </ContentTemplate>      
        <Triggers>
            <asp:PostBackTrigger ControlID="gvRegistryPatients" />
        </Triggers>  
   </asp:UpdatePanel>  
</asp:Content>

