/*
  Class: CPDM Capstone
  Author: Chris McClain
  Abstract: Displays the welcome message for authenticated users.
  Date: July 25, 2017
*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/*
 Name: _Default
 Abstract: Displays the welcome message for authenticated users.
*/
public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblWelcome.Visible = HttpContext.Current.User.Identity.IsAuthenticated;
    }
}