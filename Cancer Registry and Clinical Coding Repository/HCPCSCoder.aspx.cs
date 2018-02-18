/*
  Class: CPDM Capstone
  Author: Chris McClain
  Abstract: Displays the HCPCS code associated with a chosen supply or medication.
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
 Name: HCPCSCoder
 Abstract: Handles programming tasks for HCPCSCoder.aspx.
*/
public partial class HCPCSCoder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /*
     Name: ddlSupply_SelectedIndexChanged
     Abstract: Displays the HCPCS Code for the chosen supply.
    */
    protected void ddlSupply_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSupply.SelectedIndex > 0)
        {
            // Create a SELECT statement.
            String strSelect = "SELECT TS.strHCPCSCode FROM TSupplies AS TS WHERE TS.intSupplyID =  " + ddlSupply.SelectedValue;

            // Create a database connection.
            SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

            // Create a command object.
            SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

            // Create a data reader.
            SqlDataReader drSupplyHCPCS;

            // Open the database connection.
            conSelect.Open();

            // Execute the SELECT command. 
            drSupplyHCPCS = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

            while (drSupplyHCPCS.Read())
            {
                // Display the HCPCS code associated with the chosen supply.
                lblSupplyHCPCS.Text = drSupplyHCPCS["strHCPCSCode"].ToString();
            }

            // Discard the command object and database connection.
            cmdSelect.Dispose();
            conSelect.Dispose();
        }
    }

    /*
     Name: ddlMedication_SelectedIndexChanged
     Abstract: Displays the HCPCS Code for the chosen medication.
    */
    protected void ddlMedication_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlMedication.SelectedIndex > 0)
        {
            // Create a SELECT statement.
            String strSelect = "SELECT TM.strHCPCSCode FROM TMedications AS TM WHERE TM.intMedicationID =  " + ddlMedication.SelectedValue;

            // Create a database connection.
            SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

            // Create a command object.
            SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

            // Create a data reader.
            SqlDataReader drMedicationHCPCS;

            // Open the database connection.
            conSelect.Open();

            // Execute the SELECT command. 
            drMedicationHCPCS = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

            while (drMedicationHCPCS.Read())
            {
                // Display the HCPCS code for the chosen medication.
                lblMedicationHCPCS.Text = drMedicationHCPCS["strHCPCSCode"].ToString();
            }

            // Discard the command object and database connection.
            cmdSelect.Dispose();
            conSelect.Dispose();
        }
    }
}