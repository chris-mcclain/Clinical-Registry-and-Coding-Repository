/*
  Author: Chris McClain
  Abstract: Allows management to add a new patient
            to the Cancer Registry.
*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/*
 Name: Management_AddPatient
 Abstract: Handles programming tasks for AddPatient.aspx.
 */
public partial class Management_AddPatient : System.Web.UI.Page
{
    /*
   Name: btnSubmit_Click
   Abstract: Inserts new patient into the Cancer Registry.
   */
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int intPatientID = 0;

        // Get patient ID for new patient.
        intPatientID = GetNextHighestID();

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TPatients(intPatientID, strFirstName, strLastName, dteDateOfBirth, strTigerNumber, dteNextAppointmentDate) ";
        strInsert += "VALUES(@intPatientID, @strFirstName, @strLastName, @dteDateOfBirth, @strTigerNumber, @dteNextAppointmentDate)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intPatientID", intPatientID);
        cmdInsert.Parameters.AddWithValue("@strFirstName", txtFirstName.Text);
        cmdInsert.Parameters.AddWithValue("@strLastName", txtLastName.Text);
        cmdInsert.Parameters.AddWithValue("@dteDateOfBirth", txtDateOfBirth.Text);
        cmdInsert.Parameters.AddWithValue("@strTigerNumber", txtTigerNumber.Text);
        cmdInsert.Parameters.AddWithValue("@dteNextAppointmentDate", txtNextAppointment.Text);

        // Open the database connection.
        conInsert.Open();

        // Execute the INSERT command.
        cmdInsert.ExecuteNonQuery();

        // Close the database connection.
        conInsert.Close();

        // Discard the command object and database connection
        cmdInsert.Dispose();
        conInsert.Dispose();

        // Refresh the page.
        Response.Redirect("ManagePatients.aspx");
    }

    /*
    Name: GetNextHighestID
    Abstract: Get the highest Pateint ID in the database - add 1 to get the Patient ID for the new patient.
  */
    protected int GetNextHighestID()
    {
        String strHighestID = "";
        int intNextHighestID = 0;

        // Create the SELECT statement to find the highest Patient ID in the TPatients table.
        String strSelect = "SELECT MAX( intPatientID ) as intPatientID FROM TPatients;";

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drPatients;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command - read through the results.
        drPatients = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Find the current highest Patient ID.
        while (drPatients.Read())
        {
            strHighestID = drPatients["intPatientID"].ToString();
        }

        // Add 1 to the current highest Patient ID to get the Patient ID for the new patient.
        intNextHighestID = Int32.Parse(strHighestID) + 1;

        // Discard the command object and database connection
        cmdSelect.Dispose();
        conSelect.Dispose();

        // Return the ID for the new patient.
        return intNextHighestID;
    }
}
