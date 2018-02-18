/*
  Author: Chris McClain
  Abstract: Allows management to add, edit and delete
            medications in the Cancer Registry.
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
 Name: Management_ManageMedications
 Abstract: Handles programming tasks for ManageMedications.aspx.
*/
public partial class Management_ManageMedications : System.Web.UI.Page
{
    /*
     Name: Page_Load
     Abstract: Hide the update panels for adding, editing, and deleting medications.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            upAddMedication.Visible = false;
            upEditDeleteMedication.Visible = false;
        }
    }

    /*
     Name: bntAdd_Click
     Abstract: Show the controls for adding a medication.
   */
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        upAddMedication.Visible = true;
    }

    /*
     Name: btnEditDelete_Click
     Abstract: Show the controls for editing and deleting a medication.
    */
    protected void btnEditDelete_Click(object sender, EventArgs e)
    {
        upEditDeleteMedication.Visible = true;
    }

    /*
     Name: btnSubmitMedication_Click
     Abstract: Insert medication into the TMedications table.
    */
    protected void btnSubmitMedication_Click(object sender, EventArgs e)
    {
        int intMedicationID = 0;

        // Get the medication ID for the new medication.
        intMedicationID = GetNextHighestID();

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TMedications(intMedicationID, strMedication, strHcpcsCode, strDescription) ";
        strInsert += "VALUES(@intMedicationID, @strMedication, @strHcpcsCode, @strDescription)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intMedicationID", intMedicationID);
        cmdInsert.Parameters.AddWithValue("@strMedication", txtMedicationName.Text);
        cmdInsert.Parameters.AddWithValue("@strHcpcsCode", txtHCPCSCode.Text);
        cmdInsert.Parameters.AddWithValue("@strDescription", txtDescription.Text);

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
        txtMedicationName.Text = "";
        txtHCPCSCode.Text = "";
        txtDescription.Text = "";
        Response.Redirect("ManageMedications.aspx");
    }

    /*
     Name: Get NextHighestID
     Abstract: Get the ID for the new medication.
    */
    protected int GetNextHighestID()
    {
        String strHighestID = "";
        int intNextHighestID = 0;

        // Create the SELECT statement to find the highest medication ID in the TMedications table.
        String strSelect = "SELECT MAX( intMedicationID ) as intMedicationID FROM TMedications;";

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drMedications;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command - read through the results.
        drMedications = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Find the current highest medication ID.
        while (drMedications.Read())
        {
            strHighestID = drMedications["intMedicationID"].ToString();
        }

        // Add 1 to the current highest medication ID to get the medication ID for the new medication.
        intNextHighestID = Int32.Parse(strHighestID) + 1;

        // Discard the command object and database connection
        cmdSelect.Dispose();
        conSelect.Dispose();

        // Return the ID for the new patient.
        return intNextHighestID;
    }
}
