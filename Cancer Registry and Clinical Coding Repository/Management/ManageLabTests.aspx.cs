/*
  Author: Chris McClain
  Abstract: Allows management to add, edit and delete
            lab tests in the Cancer Registry.
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
 Name: Management_ManageLabTests
 Abstract: Handles programming tasks for ManageLabTests.aspx.
*/
public partial class Management_ManageLabTests : System.Web.UI.Page
{
    /*
     Name: Page_Load
     Abstract: Hide the update panels for adding, editing, and deleting lab tests.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            upAddLabTest.Visible = false;
            upEditDeleteLabTest.Visible = false;
        }
    }

    /*
     Name: bntAdd_Click
     Abstract: Show the controls for adding a lab test.
   */
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        upAddLabTest.Visible = true;
    }

    /*
     Name: btnEditDelete_Click
     Abstract: Show the controls for editing and deleting a lab test.
    */
    protected void btnEditDelete_Click(object sender, EventArgs e)
    {
        upEditDeleteLabTest.Visible = true;
    }

    /*
     Name: btnSubmitLabTest_Click
     Abstract: Insert lab test into the TLabTests table.
    */
    protected void btnSubmitLabTest_Click(object sender, EventArgs e)
    {
        int intLabTestID = 0;

        // Get the lab test ID for the new lab test.
        intLabTestID = GetNextHighestID();

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TLabTests(intLabTestID, strLabTest, strCptCode, strDescription, strProcessingLab) ";
        strInsert += "VALUES(@intLabTestID, @strLabTest, @strCptCode, @strDescription, @strProcessingLab)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intLabTestID", intLabTestID);
        cmdInsert.Parameters.AddWithValue("@strLabTest", txtLabTestName.Text);
        cmdInsert.Parameters.AddWithValue("@strCptCode", txtCPTCode.Text);
        cmdInsert.Parameters.AddWithValue("@strDescription", txtDescription.Text);
        cmdInsert.Parameters.AddWithValue("@strProcessingLab", txtProcessingLab.Text);

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
        txtLabTestName.Text = "";
        txtCPTCode.Text = "";
        txtDescription.Text = "";
        txtProcessingLab.Text = "";
        Response.Redirect("ManageLabTests.aspx");
    }

    /*
     Name: Get NextHighestID
     Abstract: Get the ID for the new lab test.
    */
    protected int GetNextHighestID()
    {
        String strHighestID = "";
        int intNextHighestID = 0;

        // Create the SELECT statement to find the highest lab test ID in the TLabTests table.
        String strSelect = "SELECT MAX( intLabTestID ) as intLabTestID FROM TLabTests;";

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drLabTests;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command - read through the results.
        drLabTests = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Find the current highest lab test ID.
        while (drLabTests.Read())
        {
            strHighestID = drLabTests["intLabTestID"].ToString();
        }

        // Add 1 to the current highest lab test ID to get the lab test ID for the new lab test.
        intNextHighestID = Int32.Parse(strHighestID) + 1;

        // Discard the command object and database connection
        cmdSelect.Dispose();
        conSelect.Dispose();

        // Return the ID for the new lab test.
        return intNextHighestID;
    }
}
