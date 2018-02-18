/*
  Class: CPDM Capstone
  Author: Chris McClain
  Abstract: Allows management to add, edit and delete
            imaging in the Cancer Registry.
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
 Name: Management_ManageImaging
 Abstract: Handles programming tasks for ManageImaging.aspx.
*/
public partial class Management_ManageImaging : System.Web.UI.Page
{
    /*
     Name: Page_Load
     Abstract: Hide the controls for adding, editing, and deleting imaging.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            upEditDeleteImaging.Visible = false;
            upAddImaging.Visible = false;
        }
    }

    /*
     Name: btnAdd_Click
     Abstract: Display the controls for adding imaging.
    */
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        upAddImaging.Visible = true;
    }

    /*
     Name: btnEditDelete_Click
     Abstract: Display the controls for editing and deleting imaging.
    */
    protected void btnEditDelete_Click(object sender, EventArgs e)
    {
        upEditDeleteImaging.Visible = true;
    }

    /*
     Name: btnSubmitImaging_Click
     Abstract: Insert new imaging into the TImaging table.
    */
    protected void btnSubmitImaging_Click(object sender, EventArgs e)
    {
        int intImagingID = 0;

        // Get the imaging ID for the new imaging
        intImagingID = GetNextHighestID();

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TImaging(intImagingID, strImaging, strCptCode, strDescription) ";
        strInsert += "VALUES(@intImagingID, @strImaging, @strCptCode, @strDescription)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intImagingID", intImagingID);
        cmdInsert.Parameters.AddWithValue("@strImaging", txtImagingName.Text);
        cmdInsert.Parameters.AddWithValue("@strCptCode", txtCPTCode.Text);
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
        txtImagingName.Text = "";
        txtCPTCode.Text = "";
        txtDescription.Text = "";
        Response.Redirect("ManageImaging.aspx");
    }

    /*
     Name: GetNextHighestID
     Abstract: Get the ID for the new imaging.
    */
    protected int GetNextHighestID()
    {
        String strHighestID = "";
        int intNextHighestID = 0;

        // Create the SELECT statement to find the highest imaging ID in the TImaging table.
        String strSelect = "SELECT MAX( intImagingID ) as intImagingID FROM TImaging;";

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drImaging;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command - read through the results.
        drImaging = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Find the current highest imaging ID.
        while (drImaging.Read())
        {
            strHighestID = drImaging["intImagingID"].ToString();
        }

        // Add 1 to the current highest imaging ID to get the imaging ID for the new imaging.
        intNextHighestID = Int32.Parse(strHighestID) + 1;

        // Discard the command object and database connection
        cmdSelect.Dispose();
        conSelect.Dispose();

        // Return the ID for the new imaging.
        return intNextHighestID;
    }
}