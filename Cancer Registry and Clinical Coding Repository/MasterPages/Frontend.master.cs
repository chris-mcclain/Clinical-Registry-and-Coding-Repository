/*
  Class: CPDM Capstone
  Author: Chris McClain
  Abstract: Displays the navigation menu for the logged-in user.
  Date: July 25, 2017
*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

/*
 Name: MasterPages_Frontend
 Abstract: Displays the navigation menu for the logged-in user.
*/
public partial class MasterPages_Frontend : System.Web.UI.MasterPage
{
    /*
     Name: Page_Load
     Abstract: Displays the navigation menu for the logged-in user.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        mnuMainMenu.Visible = HttpContext.Current.User.Identity.IsAuthenticated;
    }

    /*
     Name: LoginStatus1_LoggingOut
     Abstract: End the session, log user out, and redirect user to the login page.
    */
    protected void LoginStatus1_LoggingOut(object sender, LoginCancelEventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        FormsAuthentication.SignOut();
        FormsAuthentication.RedirectToLoginPage();
        mnuMainMenu.Visible = false;
        Response.Redirect("Default.aspx");
    }
}
