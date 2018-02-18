/*
  Author: Chris McClain
  Abstract: Allows management to add, edit and delete
            procedures in the Cancer Registry.
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
 Name: Management_ManageProcedures
 Abstract: Handles programming tasks for ManageProcedures.aspx.
*/
public partial class Management_ManageProcedures : System.Web.UI.Page
{
    /*
     Name: Page_Load
     Abstract: Hide the update panels for adding, editing, and deleting procedures.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            upAddProcedure.Visible = false;
            upEditDeleteProcedure.Visible = false;
        }
    }

    /*
    Name: bntAdd_Click
    Abstract: Show the controls for adding a procedure.
   */
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        upAddProcedure.Visible = true;
    }

    /*
     Name: btnEditDelete_Click
     Abstract: Show the controls for editing and deleting a procedure.
    */
    protected void btnEditDelete_Click(object sender, EventArgs e)
    {
        upEditDeleteProcedure.Visible = true;
    }

    /*
     Name: btnSubmitProcedure_Click
     Abstract: Insert procedure into the TProcedures table.
    */
    protected void btnSubmitProcedure_Click(object sender, EventArgs e)
    {
        int intProcedureID = 0;

        // Get the procedure ID for the new procedure.
        intProcedureID = GetNextHighestID();

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TProcedures(intProcedureID, strProcedure, strCptCode, intGlobalDays, strDescription) ";
        strInsert += "VALUES(@intProcedureID, @strProcedure, @strCptCode, @intGlobalDays, @strDescription)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intProcedureID", intProcedureID);
        cmdInsert.Parameters.AddWithValue("@strProcedure", txtProcedureName.Text);
        cmdInsert.Parameters.AddWithValue("@strCptCode", txtCPTCode.Text);
        cmdInsert.Parameters.AddWithValue("@intGlobalDays", txtGlobalDays.Text);
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
        txtProcedureName.Text = "";
        txtCPTCode.Text = "";
        txtGlobalDays.Text = "";
        txtDescription.Text = "";
        Response.Redirect("ManageProcedures.aspx");
    }

    /*
    Name: Get NextHighestID
    Abstract: Get the ID for the new procedure.
   */
    protected int GetNextHighestID()
    {
        String strHighestID = "";
        int intNextHighestID = 0;

        // Create the SELECT statement to find the highest procedure ID in the TProcedures table.
        String strSelect = "SELECT MAX( intProcedureID ) as intProcedureID FROM TProcedures;";

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drProcedures;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command - read through the results.
        drProcedures = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Find the current highest procedure ID.
        while (drProcedures.Read())
        {
            strHighestID = drProcedures["intProcedureID"].ToString();
        }

        // Add 1 to the current highest procedure ID to get the procedure ID for the new procedure.
        intNextHighestID = Int32.Parse(strHighestID) + 1;

        // Discard the command object and database connection
        cmdSelect.Dispose();
        conSelect.Dispose();

        // Return the ID for the new procedure.
        return intNextHighestID;
    }
}
