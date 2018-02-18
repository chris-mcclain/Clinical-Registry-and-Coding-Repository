/*
  Author: Chris McClain
  Abstract: Displays the number of global days associated with a procedure.
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
 Name: GlobalDays
 Abstract: Handles programming tasks for GlobalDays.aspx.
*/
public partial class GlobalDays : System.Web.UI.Page
{
    /*
     Name: ddlProcedure_SelectedIndexChanged
     Abstract: Displays the number of global days associated with the chosen procedure.
    */
    protected void ddlProcedure_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlProcedure.SelectedIndex > 0)
        {
            // Create a SELECT statement.
            String strSelect = "SELECT TP.intGlobalDays FROM TProcedures AS TP WHERE TP.intProcedureID =  " + ddlProcedure.SelectedValue;

            // Create a database connection.
            SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

            // Create a command object.
            SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

            // Create a data reader.
            SqlDataReader drGlobalDays;

            // Open the database connection.
            conSelect.Open();

            // Execute the SELECT command. 
            drGlobalDays = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

            while (drGlobalDays.Read())
            {
                // Display the global days associated with the chosen procedure.
                lblProcedureGlobalDays.Text = drGlobalDays["intGlobalDays"].ToString();
            }

            // Discard the command object and database connection.
            cmdSelect.Dispose();
            conSelect.Dispose();
        }
    }
}
