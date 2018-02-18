﻿/*
  Author: Chris McClain
  Abstract: Allows management to add, edit and delete
            treatments in the Cancer Registry.
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
 Name: Management_ManageTreatments
 Abstract: Handles programming tasks for ManageTreatments.aspx.
*/
public partial class Management_ManageTreatments: System.Web.UI.Page
{
    /*
     Name: Page_Load
     Abstract: Hide the update panels for adding, editing, and deleting treatments.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            upAddTreatment.Visible = false;
            upEditDeleteTreatment.Visible = false;
        }
    }

    /*
     Name: bntAdd_Click
     Abstract: Show the controls for adding a treatment.
    */
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        upAddTreatment.Visible = true;
    }

    /*
    Name: btnEditDelete_Click
    Abstract: Show the controls for editing and deleting a treatment.
   */
    protected void btnEditDelete_Click(object sender, EventArgs e)
    {
        upEditDeleteTreatment.Visible = true;
    }

    /*
     Name: btnSubmitTreatment_Click
     Abstract: Insert treatment into the TTreatments table.
    */
    protected void btnSubmitTreatment_Click(object sender, EventArgs e)
    {
        int intTreatmentID = 0;

        // Get the treatment ID for the new treatment.
        intTreatmentID = GetNextHighestID();

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TTreatments(intTreatmentID, strTreatment, strCptCode, strDescription) ";
        strInsert += "VALUES(@intTreatmentID, @strTreatment, @strCptCode, @strDescription)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intTreatmentID", intTreatmentID);
        cmdInsert.Parameters.AddWithValue("@strTreatment", txtTreatmentName.Text);
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
        txtTreatmentName.Text = "";
        txtCPTCode.Text = "";
        txtDescription.Text = "";
        Response.Redirect("ManageTreatments.aspx");
    }

    /*
    Name: Get NextHighestID
    Abstract: Get the ID for the new treatment.
   */
    protected int GetNextHighestID()
    {
        String strHighestID = "";
        int intNextHighestID = 0;

        // Create the SELECT statement to find the highest treatment ID in the TTreatments table.
        String strSelect = "SELECT MAX( intTreatmentID ) as intTreatmentID FROM TTreatments;";

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drTreatments;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command - read through the results.
        drTreatments = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Find the current highest treatment ID.
        while (drTreatments.Read())
        {
            strHighestID = drTreatments["intTreatmentID"].ToString();
        }

        // Add 1 to the current highest treatment ID to get the treatment ID for the new treatment.
        intNextHighestID = Int32.Parse(strHighestID) + 1;

        // Discard the command object and database connection
        cmdSelect.Dispose();
        conSelect.Dispose();

        // Return the ID for the new treatment.
        return intNextHighestID;
    }
}
