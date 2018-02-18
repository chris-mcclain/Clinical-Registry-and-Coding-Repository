/*
  Class: CPDM Capstone
  Author: Chris McClain
  Abstract: Displays patient name, date of birth, medication, insurance authorization, due date for next injection
            and next scheduled appointment for all patients who are due for injections within the specified time frame.
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
 Name: InjectionAppointmentTracker
 Abstract: Handles programming tasks for InjectionAppointmentTracker.aspx.
*/
public partial class InjectionAppointmentTracker : System.Web.UI.Page
{
    /*
     Name: Page_Load
     Abstract: Hide the update panel that will display the injection appointments.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            upInjectionAppointments.Visible = false;
        }

    }

    /*
     Name: btnSubmitDates_Click
     Abstract: Display patient name, date of birth, medication, insurance authorization, due date for next injection
               and next scheduled appointment for all patients who are due for injections within the specified time frame.
    */
    protected void btnSubmitDates_Click(object sender, EventArgs e)
    {
        // Create a SELECT statement.
        String strSelect = "SELECT TP.strFirstName, TP.strLastName, TP.dteDateOfBirth, TM.strMedication, " +
                            "TPM.strInsuranceAuthorization, TPM.dteNextDueDate, TP.dteNextAppointmentDate " +
                            "FROM TPatients AS TP, TMedications AS TM, TPatientMedications AS TPM WHERE TP.intPatientID = TPM.intPatientID " +
                            "AND TM.intMedicationID = TPM.intMedicationID " +
                            "AND TPM.dteNextDueDate BETWEEN '" + txtStartDate.Text + "' AND '" + txtEndDate.Text + "'";

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drInjectionAppointments;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command. 
        drInjectionAppointments = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Bind the datareader data to the gridview.
        gvInjectionAppointments.DataSource = drInjectionAppointments;
        gvInjectionAppointments.DataBind();

        // Make the display visible.
        upInjectionAppointments.Visible = true;

        // Discard the command object and database connection.
        cmdSelect.Dispose();
        conSelect.Dispose();
    }
}