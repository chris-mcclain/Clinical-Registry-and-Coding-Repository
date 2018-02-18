/*
  Class: CPDM Capstone
  Author: Chris McClain
  Abstract: Displays CPT codes for selected imaging and procedures.
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
 Name: CPTCoder
 Abstract: Handles programming tasks for CPTCoder.aspx.
*/
public partial class CPTCoder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    /*
     Name: ddlImaging_SelectedIndexChanged
     Abstract: Displays the CPT Code for the chosen imaging.
    */
    protected void ddlImaging_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlImaging.SelectedIndex > 0)
        {
            // Create a SELECT statement.
            String strSelect = "SELECT TI.strCPTCode FROM TImaging AS TI WHERE TI.intImagingID =  " + ddlImaging.SelectedValue;

            // Create a database connection.
            SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

            // Create a command object.
            SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

            // Create a data reader.
            SqlDataReader drImagingCPT;

            // Open the database connection.
            conSelect.Open();

            // Execute the SELECT command. 
            drImagingCPT = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

            while (drImagingCPT.Read())
            {
                // Display CPT code for the chosen imaging.
                lblImagingCPT.Text = drImagingCPT["strCPTCode"].ToString();
            }

            // Discard the command object and database connection.
            cmdSelect.Dispose();
            conSelect.Dispose();
        }
    }

    /*
     Name: ddlProcedure_SelectedIndexChanged
     Abstract: Displays the CPT Code for the chosen procedure.
    */
    protected void ddlProcedure_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlProcedure.SelectedIndex > 0)
        {
            // Create a SELECT statement.
            String strSelect = "SELECT TP.strCPTCode FROM TProcedures AS TP WHERE TP.intProcedureID =  " + ddlProcedure.SelectedValue;

            // Create a database connection.
            SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

            // Create a command object.
            SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

            // Create a data reader.
            SqlDataReader drProcedureCPT;

            // Open the database connection.
            conSelect.Open();

            // Execute the SELECT command. 
            drProcedureCPT = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

            while (drProcedureCPT.Read())
            {
                // Display the CPT code for the chosen procedure.
                lblProcedureCPT.Text = drProcedureCPT["strCPTCode"].ToString();
            }

            // Discard the command object and database connection.
            cmdSelect.Dispose();
            conSelect.Dispose();
        }
    }
}