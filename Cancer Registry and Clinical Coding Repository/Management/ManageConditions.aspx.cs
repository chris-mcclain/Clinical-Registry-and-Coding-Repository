/*
  Author: Chris McClain
  Abstract: Allows management to add, edit and delete
            diagnoses in the Cancer Registry.
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
 Name: Management_ManageConditions
 Abstract: Handles programming tasks for ManageConditions.aspx.
*/
public partial class Management_ManageConditions : System.Web.UI.Page
{
    /*
     Name: Page_Load
     Abstract: Hide the update panels for adding, editing, and deleting diagnoses.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            upAddDiagnosis.Visible = false;
            upEditDeleteDiagnsosis.Visible = false;
        }
    }

    /*
     Name: bntAdd_Click
     Abstract: Show the controls for adding a diagnosis.
    */
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        upAddDiagnosis.Visible = true;
    }

    /*
     Name: btnEditDelete_Click
     Abstract: Show the controls for editing and deleting a diagnosis.
    */
    protected void btnEditDelete_Click(object sender, EventArgs e)
    {
        upEditDeleteDiagnsosis.Visible = true;
    }

    /*
     Name: btnSubmitDiagnosis_Click
     Abstract: Insert diagnosis into the TConditions table.
    */
    protected void btnSubmitDiagnosis_Click(object sender, EventArgs e)
    {
        int intConditionID = 0;

        // Get the condition ID for the new diagnosis.
        intConditionID = GetNextHighestID();

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TConditions(intConditionID, strCondition, strICD10Code, strDescription) ";
        strInsert += "VALUES(@intConditionID, @strCondition, @strICD10Code, @strDescription)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intConditionID", intConditionID);
        cmdInsert.Parameters.AddWithValue("@strCondition", txtDiagnosisName.Text);
        cmdInsert.Parameters.AddWithValue("@strICD10Code", txtICD10Code.Text);
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
        txtDiagnosisName.Text = "";
        txtICD10Code.Text = "";
        txtDescription.Text = "";
        Response.Redirect("ManageConditions.aspx");
    }

    /*
     Name: Get NextHighestID
     Abstract: Get the ID for the new diagnosis.
    */
    protected int GetNextHighestID()
    {
        String strHighestID = "";
        int intNextHighestID = 0;

        // Create the SELECT statement to find the highest condition ID in the TConditions table.
        String strSelect = "SELECT MAX( intConditionID ) as intConditionID FROM TConditions;";

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drConditions;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command - read through the results.
        drConditions = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Find the current highest condition ID.
        while (drConditions.Read())
        {
            strHighestID = drConditions["intConditionID"].ToString();
        }

        // Add 1 to the current highest condition ID to get the condition ID for the new diagnosis.
        intNextHighestID = Int32.Parse(strHighestID) + 1;

        // Discard the command object and database connection
        cmdSelect.Dispose();
        conSelect.Dispose();

        // Return the ID for the new diagnosis.
        return intNextHighestID;
    }
}
