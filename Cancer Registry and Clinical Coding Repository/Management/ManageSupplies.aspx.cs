/*
  Author: Chris McClain
  Abstract: Allows management to add, edit and delete
            supplies for the Clinical Coding Repository.
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
 Name: Management_ManageSupplies
 Abstract: Handles programming tasks for ManageSupplies.aspx.
*/
public partial class Management_ManageSupplies : System.Web.UI.Page
{
    /*
    Name: Page_Load
    Abstract: Hide the update panels for adding, editing, and deleting supplies.
   */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            upAddSupply.Visible = false;
            upEditDeleteSupply.Visible = false;
        }
    }

    /*
     Name: bntAdd_Click
     Abstract: Show the controls for adding a supply.
    */
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        upAddSupply.Visible = true;
    }

    /*
     Name: btnEditDelete_Click
     Abstract: Show the controls for editing and deleting a supply.
    */
    protected void btnEditDelete_Click(object sender, EventArgs e)
    {
        upEditDeleteSupply.Visible = true;
    }

    /*
     Name: btnSubmitSupply_Click
     Abstract: Insert supply into the TSupplies table.
    */
    protected void btnSubmitSupply_Click(object sender, EventArgs e)
    {
        int intSupplyID = 0;

        // Get the supply ID for the new supply.
        intSupplyID = GetNextHighestID();

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TSupplies(intSupplyID, strSupply, strHcpcsCode) ";
        strInsert += "VALUES(@intSupplyID, @strSupply, @strHcpcsCode)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intSupplyID", intSupplyID);
        cmdInsert.Parameters.AddWithValue("@strSupply", txtSupplyName.Text);
        cmdInsert.Parameters.AddWithValue("@strHcpcsCode", txtHCPCSCode.Text);

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
        txtSupplyName.Text = "";
        txtHCPCSCode.Text = "";
        Response.Redirect("ManageSupplies.aspx");
    }

    /*
     Name: Get NextHighestID
     Abstract: Get the ID for the new supply.
    */
    protected int GetNextHighestID()
    {
        String strHighestID = "";
        int intNextHighestID = 0;

        // Create the SELECT statement to find the highest supply ID in the TSupplies table.
        String strSelect = "SELECT MAX( intSupplyID ) as intSupplyID FROM TSupplies;";

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drSupplies;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command - read through the results.
        drSupplies = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Find the current highest supply ID.
        while (drSupplies.Read())
        {
            strHighestID = drSupplies["intSupplyID"].ToString();
        }

        // Add 1 to the current highest supply ID to get the supply ID for the new supply.
        intNextHighestID = Int32.Parse(strHighestID) + 1;

        // Discard the command object and database connection
        cmdSelect.Dispose();
        conSelect.Dispose();

        // Return the ID for the new supply.
        return intNextHighestID;
    }
}
