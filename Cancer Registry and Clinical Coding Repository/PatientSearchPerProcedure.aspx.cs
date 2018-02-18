/*
  Author: Chris McClain
  Abstract: Displays all patients who have had the specified procedure.
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
 Name: PatientSearchPerProcedure
 Abstract: Handles programming tasks for PatientSearchPerProcedure.aspx.
*/
public partial class PatientSearchPerProcedure : System.Web.UI.Page
{
    /*
     Name: Page_Load
     Abstract: Hide the update panel that will display the patients who have had the specified procedure.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            upProcedures.Visible = false;
        }
    }

    /*
     Name: ddlInjectables_SelectedIndexChanged
     Abstract: Displays all patients who have had the specified procedure.
    */
    protected void ddlProcedures_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlProcedures.SelectedIndex > 0)
        {
            //Create a SELECT statement.
            String strSelect = "SELECT TP.strFirstName, TP.strLastName, TP.dteDateOfBirth, TP.strTigerNumber, TProc.strProcedure " +
                               "FROM TPatients AS TP, TProcedures AS TProc, TPatientProcedures AS TPP WHERE TP.intPatientID = " +
                               "TPP.intPatientID AND TProc.intProcedureID = TPP.intProcedureID AND TProc.intProcedureID = " + ddlProcedures.SelectedValue;

            // Create a database connection.
            SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

            // Create a command object.
            SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

            // Create a data reader.
            SqlDataReader drPatientProcedures;

            // Open the database connection.
            conSelect.Open();

            // Execute the SELECT command. 
            drPatientProcedures = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

            // Bind the datareader data to the gridview.
            gvProcedures.DataSource = drPatientProcedures;
            gvProcedures.DataBind();

            // Make the display visible.
            upProcedures.Visible = true;

            // Discard the command object and database connection.
            cmdSelect.Dispose();
            conSelect.Dispose();
        }
    }
}
