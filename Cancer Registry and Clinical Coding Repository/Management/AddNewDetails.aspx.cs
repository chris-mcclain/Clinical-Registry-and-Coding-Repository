/*
  Class: CPDM Capstone
  Author: Chris McClain
  Abstract: Allows management to add new details 
            to a patient's Cancer Registry chart
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
 Name: Management_AddNewDetails
 Abstract: Handles programming tasks for AddNewDetails.aspx.
 */
public partial class Management_AddNewDetails : System.Web.UI.Page
{
    /*
    Name: Page_Load
    Abstract: Retrieve the patient ID from the query string sent from the management default page.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        int intPatientID = Convert.ToInt32(Request.QueryString["intPatientID"]);
        LoadPatientInformation(intPatientID);
    }

    /*
    Name: LoadPatientInformation
    Abstract: Displays the name, date of birth, and Tiger Number in the chart header.
    */
    protected void LoadPatientInformation(int intPatientID)
    {
        // Create a SELECT statement.
        String strSelect = "SELECT strFirstName, strLastName, dteDateOfBirth, strTigerNumber FROM TPatients WHERE intPatientID = " + intPatientID;

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drPatientData;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command. 
        drPatientData = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        while (drPatientData.Read())
        {
            lblPatientName.Text = drPatientData["strFirstName"].ToString() + " " + drPatientData["strLastName"].ToString();
            lblDateOfBirth.Text = "Date of Birth: " + drPatientData["dteDateOfBirth"].ToString();
            lblTigerNumber.Text = "Tiger Number: " + drPatientData["strTigerNumber"].ToString();
        }

        // Discard the command object and database connection.
        cmdSelect.Dispose();
        conSelect.Dispose();
    }

    /*
    Name: btnSubmitDiagnosis_Click
    Abstract: Inserts new diagnosis into patient's Cancer Registry chart.
    */
    protected void btnSubmitDiagnosis_Click(object sender, EventArgs e)
    {
        //Retrieve the patient ID from the query string sent from the management default page.
        int intPatientID = Convert.ToInt32(Request.QueryString["intPatientID"]);

        Boolean blnNewDiagnosis;

        // Get diagnosis the user wishes to add.
        int intDiagnosisID = Convert.ToInt32(ddlDiagnoses.SelectedValue);

        // Call function to determine if the diagnosis is new for the chosen patient.
        blnNewDiagnosis = ValidateDiagnosis(intDiagnosisID, intPatientID);

        String strInsert = "";

        // If the diagnosis is new for the patient, add the diagnosis.
        if (blnNewDiagnosis == true)
        {
            // Create the INSERT statement.
            strInsert = "INSERT INTO TPatientConditions(intPatientID, intConditionID, dteDateDiagnosed) " +
                        "VALUES (@intPatientID, @intConditionID, @dteDateDiagnosed)";

            // Create a database connection.
            SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

            // Create a command object.
            SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

            // Get the values for the insert.
            cmdInsert.Parameters.AddWithValue("@intPatientID", intPatientID);
            cmdInsert.Parameters.AddWithValue("@intConditionID", ddlDiagnoses.SelectedValue);
            cmdInsert.Parameters.AddWithValue("@dteDateDiagnosed", txtDiagnosisDate.Text);

            // Open the database connection.
            conInsert.Open();

            // Execute the INSERT command.
            cmdInsert.ExecuteNonQuery();

            // Close the database connection.
            conInsert.Close();

            // Discard the command object and database connection.
            cmdInsert.Dispose();
            conInsert.Dispose();

            txtDiagnosisDate.Text = "";
        }
        else
        {
            // Otherwise, print message that diagnosis is already established for this patient.
            string strDiagnosis = ddlDiagnoses.SelectedItem.Text;
            string strPatientName = lblPatientName.Text;
            string myScript = "alert('" + strDiagnosis + " is already an established diagnosis for " + strPatientName + "');";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "Diagnosis",
                myScript, true);
        }
    }

    /*
    Name: ValidateDiagnosis
    Abstract: Searches patient diagnoses to determine if diagnosis is new for the patient.
    */
    protected Boolean ValidateDiagnosis(int intDiagnosisID, int intPatientID)
    {
        // Create a SELECT statement.
        String strSelect = "SELECT intConditionID FROM TPatientConditions WHERE intPatientID = " + intPatientID;

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drPatientData;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command. 
        drPatientData = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Create a List object for holding all condition IDs associated with the patient
        List<int> lstConditionIDs = new List<int>();

        // Add each diagnosis ID to the List
        if (drPatientData.HasRows)
        {
            while (drPatientData.Read())
            {
                lstConditionIDs.Add(Convert.ToInt32(drPatientData["intConditionID"]));
            }
        }

        // Discard the command object and database connection.
        cmdSelect.Dispose();
        conSelect.Dispose();

        // If the diagnosis ID is found in the list, return false to prevent the user
        // from adding a duplicate diagnosis.  Otherwise, return true to allow the
        // diagnosis to be added.
        if(lstConditionIDs.Contains(intDiagnosisID))
        {
            return false;
        }
        else
        {
            return true;
        }   
    }

    /*
    Name: btnSubmitImaging_Click
    Abstract: Insert new imaging into patient's Cancer Registry chart.
    */
    protected void btnSubmitImaging_Click(object sender, EventArgs e)
    {
        // Retrieve the patient ID from the query string sent from the management default page.
        int intPatientID = Convert.ToInt32(Request.QueryString["intPatientID"]);

        string strIndexType = "Imaging";

        // Set imaging index.
        int intImagingIndex = GetNextHighestIndex(intPatientID, strIndexType);

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TPatientImaging(intPatientID, intImagingID, intImagingIndex, dteImagingDate, blnMetsPresent) " +
                    "VALUES (@intPatientID, @intImagingID, @intImagingIndex, @dteImagingDate, @blnMetsPresent)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intPatientID", intPatientID);
        cmdInsert.Parameters.AddWithValue("@intImagingID", ddlImaging.SelectedValue);
        cmdInsert.Parameters.AddWithValue("@intImagingIndex", intImagingIndex);
        cmdInsert.Parameters.AddWithValue("@dteImagingDate", txtImagingDate.Text);
        cmdInsert.Parameters.AddWithValue("@blnMetsPresent", chkMets.Checked);

        // Open the database connection.
        conInsert.Open();

        // Execute the INSERT command.
        cmdInsert.ExecuteNonQuery();

        // Close the database connection.
        conInsert.Close();

        // Discard the command object and database connection.
        cmdInsert.Dispose();
        conInsert.Dispose();

        // Clear the controls
        txtImagingDate.Text = "";
        chkMets.Checked = false;
    }

    /*
    Name: GetNextHighestIndex
    Abstract: Get the next highest index for imaging, lab tests, treatments, medications, and procedures.
    */
    protected int GetNextHighestIndex(int intPatientID, string strIndexType)
    {
        String strHighestIndex = "";
        int intNextHighestIndex = 0;
        String strSelect = "";

        switch(strIndexType)
        {
            // Create the SELECT statement to find the highest imaging index.
            case "Imaging":
                 strSelect = "SELECT MAX( intImagingIndex ) as intImagingIndex FROM TPatientImaging WHERE intPatientID = "
                                    + intPatientID + " AND intImagingID = " + ddlImaging.SelectedValue;
                break;
            // Create the SELECT statement to find the highest lab test index.
            case "LabTest":
                strSelect = "SELECT MAX( intLabTestIndex ) as intLabTestIndex FROM TPatientLabTests WHERE intPatientID = "
                                    + intPatientID + " AND intLabTestID = " + ddlLabTests.SelectedValue;
                break;
            // Create the SELECT statement to find the highest treatment index.
            case "Treatment":
                strSelect = "SELECT MAX( intTreatmentIndex ) as intTreatmentIndex FROM TPatientTreatments WHERE intPatientID = "
                                    + intPatientID + " AND intTreatmentID = " + ddlTreatments.SelectedValue;
                break;
            // Create the SELECT statement to find the highest medication index.
            case "Medication":
                strSelect = "SELECT MAX( intMedicationIndex ) as intMedicationIndex FROM TPatientMedications WHERE intPatientID = "
                                    + intPatientID + " AND intMedicationID = " + ddlMedications.SelectedValue;
                break;
            // Create the SELECT statement to find the highest procedure index.
            case "Procedure":
                strSelect = "SELECT MAX( intProcedureIndex ) as intProcedureIndex FROM TPatientProcedures WHERE intPatientID = "
                                    + intPatientID + " AND intProcedureID = " + ddlProcedures.SelectedValue;
                break;
            default:
                strSelect = "";
                break;

        }

        // Create a database connection.
        SqlConnection conSelect = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdSelect = new SqlCommand(strSelect, conSelect);

        // Create a data reader.
        SqlDataReader drHighestIndex;

        // Open the database connection.
        conSelect.Open();

        // Execute the SELECT command - read through the results.
        drHighestIndex = cmdSelect.ExecuteReader(CommandBehavior.CloseConnection);

        // Find the current highest index.
        while (drHighestIndex.Read())
        {
            switch(strIndexType)
            {
                // Get the current highest imaging index - set to '0' if no imaging in patient's chart.
                case "Imaging":
                    if (drHighestIndex["intImagingIndex"] != DBNull.Value)
                    {
                        strHighestIndex = drHighestIndex["intImagingIndex"].ToString();
                    }        
                    else
                    {
                        strHighestIndex = "0";
                    }
                    break;
                // Get the current highest lab test index - set to '0' if no lab test in patient's chart.
                case "LabTest":
                    if (drHighestIndex["intLabTestIndex"] != DBNull.Value)
                    {
                        strHighestIndex = drHighestIndex["intLabTestIndex"].ToString();
                    }        
                    else
                    {
                        strHighestIndex = "0";
                    }
                    break;
                // Get the current highest treatment index - set to '0' if no treatment in patient's chart.
                case "Treatment":
                     if (drHighestIndex["intTreatmentIndex"] != DBNull.Value)
                    {
                        strHighestIndex = drHighestIndex["intTreatmentIndex"].ToString();
                    }        
                    else
                    {
                        strHighestIndex = "0";
                    }
                    break;
                // Get the current highest medication index - set to '0' if no medication in patient's chart.
                case "Medication":
                     if (drHighestIndex["intMedicationIndex"] != DBNull.Value)
                    {
                        strHighestIndex = drHighestIndex["intMedicationIndex"].ToString();
                    }        
                    else
                    {
                        strHighestIndex = "0";
                    }
                    break;
                // Get the current highest procedure index - set to '0' if no procedure in patient's chart.
                case "Procedure":
                     if (drHighestIndex["intProcedureIndex"] != DBNull.Value)
                    {
                        strHighestIndex = drHighestIndex["intProcedureIndex"].ToString();
                    }        
                    else
                    {
                        strHighestIndex = "0";
                    }
                    break;
            }
        }

        // Add 1 to the current highest index to get the index for new imaging, lab tests, treatments, medications, and procedures.
        intNextHighestIndex = Int32.Parse(strHighestIndex) + 1;

        // Discard the command object and database connection.
        cmdSelect.Dispose();
        conSelect.Dispose();

        // Return the new index.
        return intNextHighestIndex;
    }

    /*
    Name: btnSubmitLabTest_Click
    Abstract: Insert new lab test into patient's Cancer Registry chart
    */
    protected void btnSubmitLabTest_Click(object sender, EventArgs e)
    {
        // Retrieve the patient ID from the query string sent from the management default page.
        int intPatientID = Convert.ToInt32(Request.QueryString["intPatientID"]);

        string strIndexType = "LabTest";

        // Set lab test index.
        int intLabTestIndex = GetNextHighestIndex(intPatientID, strIndexType);

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TPatientLabTests(intPatientID, intLabTestID, intLabTestIndex, dteLabTestDate, strResult) " +
                    "VALUES (@intPatientID, @intLabTestID, @intLabTestIndex, @dteLabTestDate, @strResult)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intPatientID", intPatientID);
        cmdInsert.Parameters.AddWithValue("@intLabTestID", ddlLabTests.SelectedValue);
        cmdInsert.Parameters.AddWithValue("@intLabTestIndex", intLabTestIndex);
        cmdInsert.Parameters.AddWithValue("@dteLabTestDate", txtTestDate.Text);
        cmdInsert.Parameters.AddWithValue("@strResult", txtResult.Text);

        // Open the database connection.
        conInsert.Open();

        // Execute the INSERT command.
        cmdInsert.ExecuteNonQuery();

        // Close the database connection.
        conInsert.Close();

        // Discard the command object and database connection.
        cmdInsert.Dispose();
        conInsert.Dispose();

        // Clear the controls.
        txtTestDate.Text = "";
        txtResult.Text = "";
    }

    /*
    Name: btnSubmitTreatment_Click
    Abstract: Insert new treatment into patient's Cancer Registry chart
    */
    protected void btnSubmitTreatment_Click(object sender, EventArgs e)
    {
        // Retrieve the patient ID from the query string sent from the management default page.
        int intPatientID = Convert.ToInt32(Request.QueryString["intPatientID"]);

        string strIndexType = "Treatment";

        // Set treatment index.
        int intTreatmentIndex = GetNextHighestIndex(intPatientID, strIndexType);

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TPatientTreatments(intPatientID, intTreatmentID, intTreatmentIndex, dteTreatmentDate) " +
                    "VALUES (@intPatientID, @intTreatmentID, @intTreatmentIndex, @dteTreatmentDate)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intPatientID", intPatientID);
        cmdInsert.Parameters.AddWithValue("@intTreatmentID", ddlTreatments.SelectedValue);
        cmdInsert.Parameters.AddWithValue("@intTreatmentIndex", intTreatmentIndex);
        cmdInsert.Parameters.AddWithValue("@dteTreatmentDate", txtTreatmentDate.Text);
       
        // Open the database connection.
        conInsert.Open();

        // Execute the INSERT command.
        cmdInsert.ExecuteNonQuery();

        // Close the database connection.
        conInsert.Close();

        // Discard the command object and database connection.
        cmdInsert.Dispose();
        conInsert.Dispose();

        // Clear treatment date textbox.
        txtTreatmentDate.Text = "";
     
    }

    /*
    Name: btnMedication_Click
    Abstract: Insert new medication into patient's Cancer Registry chart
    */
    protected void btnSubmitMedication_Click(object sender, EventArgs e)
    {
        // Retrieve the patient ID from the query string sent from the management default page.
        int intPatientID = Convert.ToInt32(Request.QueryString["intPatientID"]);

        string strIndexType = "Medication";

        // Set medication index.
        int intMedicationIndex = GetNextHighestIndex(intPatientID, strIndexType);

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TPatientMedications(intPatientID, intMedicationID, intMedicationIndex, dteAdministrationDate, strInsuranceAuthorization, dteNextDueDate) " +
                    "VALUES (@intPatientID, @intMedicationID, @intMedicationIndex, @dteAdministrationDate, @strInsuranceAuthorization, @dteNextDueDate)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intPatientID", intPatientID);
        cmdInsert.Parameters.AddWithValue("@intMedicationID", ddlMedications.SelectedValue);
        cmdInsert.Parameters.AddWithValue("@intMedicationIndex", intMedicationIndex);
        cmdInsert.Parameters.AddWithValue("@dteAdministrationDate", txtAdministrationDate.Text);
        cmdInsert.Parameters.AddWithValue("@strInsuranceAuthorization", txtAuthorization.Text);
        cmdInsert.Parameters.AddWithValue("@dteNextDueDate", txtDueDate.Text);

        // Open the database connection.
        conInsert.Open();

        // Execute the INSERT command.
        cmdInsert.ExecuteNonQuery();

        // Close the database connection.
        conInsert.Close();

        // Discard the command object and database connection.
        cmdInsert.Dispose();
        conInsert.Dispose();

        // Clear the controls.
        txtAdministrationDate.Text = "";
        txtAuthorization.Text = "";
        txtDueDate.Text = "";
    }

    /*
    Name: btnSubmitProcedure_Click
    Abstract: Insert new procedure into patient's Cancer Registry chart
    */
    protected void btnSubmitProcedure_Click(object sender, EventArgs e)
    {
        // Retrieve the patient ID from the query string sent from the management default page.
        int intPatientID = Convert.ToInt32(Request.QueryString["intPatientID"]);

        string strIndexType = "Procedure";

        // Set procedure index.
        int intProcedureIndex = GetNextHighestIndex(intPatientID, strIndexType);

        String strInsert = "";

        // Create the INSERT statement.
        strInsert = "INSERT INTO TPatientProcedures(intPatientID, intProcedureID, intProcedureIndex, dteProcedureDate) " +
                    "VALUES (@intPatientID, @intProcedureID, @intProcedureIndex, @dteProcedureDate)";

        // Create a database connection.
        SqlConnection conInsert = new SqlConnection(ConfigurationManager.ConnectionStrings["dbSQL1ConnectionString"].ConnectionString);

        // Create a command object.
        SqlCommand cmdInsert = new SqlCommand(strInsert, conInsert);

        // Get the values for the insert.
        cmdInsert.Parameters.AddWithValue("@intPatientID", intPatientID);
        cmdInsert.Parameters.AddWithValue("@intProcedureID", ddlProcedures.SelectedValue);
        cmdInsert.Parameters.AddWithValue("@intProcedureIndex", intProcedureIndex);
        cmdInsert.Parameters.AddWithValue("@dteProcedureDate", txtProcedureDate.Text);

        // Open the database connection.
        conInsert.Open();

        // Execute the INSERT command.
        cmdInsert.ExecuteNonQuery();

        // Close the database connection.
        conInsert.Close();

        // Discard the command object and database connection.
        cmdInsert.Dispose();
        conInsert.Dispose();

        // Clear the procedure date textbox.
        txtProcedureDate.Text = "";
    
    }
}