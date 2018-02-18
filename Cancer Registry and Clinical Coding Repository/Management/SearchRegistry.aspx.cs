/*
  Class: CPDM Capstone
  Author: Chris McClain
  Abstract: Displays the Cancer Registry patients with matching
            first name, last name, and date of birth.
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
 Name: Management_SearchRegistry
 Abstract: Handles programming tasks for SearchRegistry.aspx.
*/
public partial class Management_SearchRegistry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    /*
     Name: bntSearch_Click
     Abstract: Display the Cancer Registry patients with matching first name, last name, and date of birth.
    */
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        upRegistryPatients.Visible = true;
    }
}