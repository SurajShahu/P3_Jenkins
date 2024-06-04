package in.co.rays.project_3.controller;

/**
 * Jasper functionality Controller. Performs operation for Print pdf of
 * MarksheetMeriteList
 *
 * @author Suraj Sahu
 */

//public class JasperCtl {
//
//}

/*
 * Resource Bundle: It loads a resource bundle named "system" from a package
 * named "in.co.rays.project_3.bundle". This bundle probably contains
 * configuration parameters for the report generation. Loading JasperReport:
 * 
 * The compiled JasperReport object is retrieved from the resource bundle using
 * the key "jasper". This report is the template for the PDF report generation.
 * Connection to Database:
 * 
 * It establishes a connection to a database based on the configuration
 * specified in the resource bundle. If the configuration is "Hibernate", it
 * uses Hibernate's session to get the connection. If it's "JDBC", it uses a
 * JDBC connection. Filling Data into the Report:
 * 
 * It creates a map to hold parameters that might be used in the report
 * (currently empty), then fills the report template with data from the database
 * using JasperFillManager.fillReport(). Exporting JasperReport:
 * 
 * Once the report is filled with data, it's exported to a PDF byte array using
 * JasperExportManager.exportReportToPdf(). Setting Response Content Type and
 * Writing PDF to Output Stream:
 * 
 * Finally, it sets the content type of the response to "application/pdf",
 * writes the PDF bytes to the response output stream, and flushes it. This
 * sends the PDF file back to the client as the response to the GET request.
 * Exception Handling:
 * 
 * 
 * Overall, this servlet handles requests to generate PDF reports based on
 * JasperReports templates and database data, using configuration parameters
 * from a resource bundle.
 */
