/*
  Class: CPDM Capstone
  Author: Chris McClain
  Abstract: Populates the heading labels for the Cancer Registry chart
  Date: July 25, 2017
*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/*
 Name: CancerRegistry_CancerRegistry
 Abstract: Handles programming tasks for CancerRegistry.aspx.
 */
public partial class CancerRegistry_CancerRegistry : System.Web.UI.Page
{

    /*
     Name: Page_Load
     Abstract: Hides the "Delete" link for each GridView record for users not in the manager role.
     */
    protected void Page_Load(object sender, EventArgs e)
    {
        int intPatientID = Convert.ToInt32(Request.QueryString["intPatientID"]);

        if (!Page.User.IsInRole("Managers"))
        {
            gvConditions.Columns[0].Visible = false;
            gvImaging.Columns[0].Visible = false;
            gvLabTests.Columns[0].Visible = false;
            gvMedications.Columns[0].Visible = false;
            gvProcedures.Columns[0].Visible = false;
            gvTreatments.Columns[0].Visible = false;
        }

        LoadPatientInformation(intPatientID);

        LoadAuthorizationLabel(intPatientID);

    }

    /*
     Name: LoadPatientInformation
     Abstract: Loads the patient's name, date of birth, Tiger Number and next appointment date chart heading labels.
     */
    protected void LoadPatientInformation( int intPatientID)
    {
        // Create a SELECT statement.
        String strSelect = "SELECT strFirstName, strLastName, dteDateOfBirth, strTigerNumber, dteNextAppointmentDate FROM TPatients WHERE intPatientID = " + intPatientID;

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drPatientData;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command. 
        drPatientData = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Load chart header information.
        while (drPatientData.Read())
        {
            lblPatientName.Text = drPatientData["strFirstName"].ToString() + " " + drPatientData["strLastName"].ToString();
            lblDateOfBirth.Text = "Date of Birth: " + drPatientData["dteDateOfBirth"].ToString();
            lblTigerNumber.Text = "Tiger Number: " + drPatientData["strTigerNumber"].ToString();
            lblNextAppointment.Text = "Next Appointment Date: " + drPatientData["dteNextAppointmentDate"].ToString();
        }

        // Discard the command object and database connection.
        cmdSelect.Dispose();
        conSelect.Dispose();
    }

    /*
     Name: LoadAuthorizationLabel
     Abstract: Loads the medication authorization header label.
    */
    protected void LoadAuthorizationLabel( int intPatientID )
    {
        // Create a SELECT statement.
        String strSelect = "SELECT TOP 1 TM.strMedication, TPM.strInsuranceAuthorization, TPM.dteAdministrationDate FROM TMedications AS TM, TPatientMedications AS TPM WHERE TM.intMedicationID = TPM.intMedicationID AND intPatientID = " + intPatientID + " ORDER BY YEAR(TPM.dteAdministrationDate) DESC, MONTH(TPM.dteAdministrationDate) DESC, DAY(TPM.dteAdministrationDate) DESC";

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drAuthorization;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command. 
        drAuthorization = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Create a List object for holding each medication name and authorization.
        List<string> lstMedicationAuthorization = new List<string>();

        // Add medication name and authorization to lstMedicationAuthorization.
        if (drAuthorization.HasRows)
        {
            while (drAuthorization.Read())
            {
                lstMedicationAuthorization.Add(Convert.ToString(drAuthorization["strMedication"]) + ": " + (Convert.ToString(drAuthorization["strInsuranceAuthorization"])));
            }           
        }
        else
        {
            // If pt does not receive injectables, hide the authorization label.
            lblAuthorization1.Visible = false;
        }

        // Display medication name and authorization.
        lblAuthorization1.Text = String.Join(Environment.NewLine, lstMedicationAuthorization);

        lstMedicationAuthorization.Clear();
        
        // Discard the command object and database connection.
        cmdSelect.Dispose();
        conSelect.Dispose();
    }
}