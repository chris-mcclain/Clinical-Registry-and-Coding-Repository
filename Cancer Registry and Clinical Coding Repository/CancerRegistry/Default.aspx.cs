/*
  Author: Chris McClain
  Abstract: Conducts search for user-specified cancer registry patient
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
 Abstract: Handles programming tasks for the Default page for the Cancer Registry
 */
public partial class Cancer_Registry_Default : System.Web.UI.Page
{
    /*
     Name: btnSearch_Click
     Abstract: Search the TPatients table for the chosen patient.
     */
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        upRegistryPatients.Visible = true;

        // Create a SELECT statement.
        String strSelect = "SELECT strFirstName, strLastName, dteDateOfBirth, strTigerNumber, intPatientID FROM TPatients WHERE strFirstName = '" + txtFirstName.Text + "' AND strLastName = '" + txtLastName.Text + "' AND dteDateOfBirth = '" + txtDateOfBirth.Text + "'";

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drPatients;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command. 
        drPatients = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        gvRegistryPatients.DataSource = drPatients;
        gvRegistryPatients.DataBind();

        // Discard the command object and database connection
        cmdSelect.Dispose();
        conSelect.Dispose();
    }
    
}
