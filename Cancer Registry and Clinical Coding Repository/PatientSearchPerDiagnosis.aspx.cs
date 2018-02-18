/*
  Class: CPDM Capstone
  Author: Chris McClain
  Abstract: Displays all patients who have the specified diagnosis.
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
 Name: PatientSearchPerDiagnosis
 Abstract: Handles programming tasks for PatientSearchPerDiagnosis.aspx.
*/
public partial class PatientSearchPerDiagnosis : System.Web.UI.Page
{
    /*
     Name: Page_Load
     Abstract: Hide the update panel that will display the patients with the specified diagnosis.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            upDiagnosis.Visible = false;
        }
    }

    /*
     Name: ddlDiagnosis_SelectedIndexChanged
     Abstract: Displays all patients with the specified diagnosis.
    */
    protected void ddlDiagnosis_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDiagnosis.SelectedIndex > 0)
        {
            // Create a SELECT statement.
            String strSelect = "SELECT TP.strFirstName, TP.strLastName, TP.dteDateOfBirth, TP.strTigerNumber, TC.strCondition " +
                               "FROM TPatients AS TP, TConditions AS TC, TPatientConditions AS TPC WHERE TP.intPatientID = " +
                               "TPC.intPatientID AND TC.intConditionID = TPC.intConditionID AND TC.intConditionID = " + ddlDiagnosis.SelectedValue;

            // Create a database connection.
            SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

            // Create a command object.
            SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

            // Create a data reader.
            SqlDataReader drPatientDiagnosis;

            // Open the database connection.
            conSelect.Open();

            // Execute the SELECT command. 
            drPatientDiagnosis = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

            // Bind the datareader data to the gridview.
            gvDiagnosis.DataSource = drPatientDiagnosis;
            gvDiagnosis.DataBind();

            // Make the display visible.
            upDiagnosis.Visible = true;

            // Discard the command object and database connection.
            cmdSelect.Dispose();
            conSelect.Dispose();
        }
    }
}