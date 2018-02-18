/*
  Author: Chris McClain
  Abstract: Displays all patients who receive the specified injectable medication.
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
 Name: PatientSearchPerInjectable
 Abstract: Handles programming tasks for PatientSearchPerInjectable.aspx.
*/
public partial class PatientSearchPerInjectable : System.Web.UI.Page
{
    /*
     Name: Page_Load
     Abstract: Hide the update panel that will display the patients who receive the specified injectable medication.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           upInjectables.Visible = false;
        }
    }

    /*
     Name: ddlInjectables_SelectedIndexChanged
     Abstract: Displays all patients who receive the specified injectable medication.
    */
    protected void ddlInjectables_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlInjectables.SelectedIndex > 0)
        {
            // Create a SELECT statement.
            String strSelect = "SELECT DISTINCT TP.strFirstName, TP.strLastName, TP.dteDateOfBirth, TP.strTigerNumber, TM.strMedication " +
                               "FROM TPatients AS TP, TMedications AS TM, TPatientMedications AS TPM WHERE TP.intPatientID = " +
                               "TPM.intPatientID AND TM.intMedicationID = TPM.intMedicationID AND TM.intMedicationID = " + ddlInjectables.SelectedValue;

            // Create a database connection.
            SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

            // Create a command object.
            SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

            // Create a data reader.
            SqlDataReader drPatientInjectables;

            // Open the database connection.
            conSelect.Open();

            // Execute the SELECT command. 
            drPatientInjectables = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

            // Bind the datareader data to the gridview.
            gvInjectables.DataSource = drPatientInjectables;
            gvInjectables.DataBind();

            // Make the display visible.
            upInjectables.Visible = true;

            // Discard the command object and database connection.
            cmdSelect.Dispose();
            conSelect.Dispose();
        }
    }
}
