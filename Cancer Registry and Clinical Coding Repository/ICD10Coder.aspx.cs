/*
  Class: CPDM Capstone
  Author: Chris McClain
  Abstract: Displays the ICD-10 code associated with a chosen diagnosis.
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
 Name: ICD10Coder
 Abstract: Handles programming tasks for ICD10Coder.aspx.
*/
public partial class ICD10Coder : System.Web.UI.Page
{
    /*
     Name: Page_Load
     Abstract: Hide the ICD-10 label.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
        }
    }

    /*
     Name: ddlICD10Code_SelectedIndexChanged
     Abstract: Displays the ICD-10 Code for the chosen diagnosis.
    */
    protected void ddlICD10Code_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlICD10Code.SelectedIndex > 0)
        {
            // Create a SELECT statement.
            String strSelect = "SELECT TC.strICD10Code FROM TConditions AS TC WHERE TC.intConditionID =  " + ddlICD10Code.SelectedValue;

            // Create a database connection.
            SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

            // Create a command object.
            SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

            // Create a data reader.
            SqlDataReader drICD10Code;

            // Open the database connection.
            conSelect.Open();

            // Execute the SELECT command. 
            drICD10Code = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

            while (drICD10Code.Read())
            {
                // Display the ICD-10 code associated with the chosen diagnosis.
                lblICD10Code.Text = drICD10Code["strICD10Code"].ToString();
            }

            // Discard the command object and database connection.
            cmdSelect.Dispose();
            conSelect.Dispose();
        }
    }
}