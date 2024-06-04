package in.co.rays.project_3.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.impl.SessionImpl;

import in.co.rays.project_3.dto.UserDTO;
import in.co.rays.project_3.util.HibDataSource;
import in.co.rays.project_3.util.JDBCDataSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

/**
 * Jasper functionality Controller. Performs operation for Print pdf of
 * MarksheetMeriteList
 *
 * @author Suraj Sahu
 */
@WebServlet(name = "JasperCtl", urlPatterns = { "/ctl/JasperCtl" })
public class JasperCtl extends BaseCtl {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			/* Compilation of jrxml file-RC PF PE*/
			ResourceBundle rb = ResourceBundle.getBundle("in.co.rays.project_3.bundle.system");
			//R C
			JasperReport jasperReport = JasperCompileManager.compileReport(rb.getString("jasper"));

			Map<String, Object> map = new HashMap<String, Object>();
			java.sql.Connection conn = null;
			String Database = rb.getString("DATABASE");
			if ("Hibernate".equalsIgnoreCase(Database)) {
				conn = ((SessionImpl) HibDataSource.getSession()).connection();
			}
			if ("JDBC".equalsIgnoreCase(Database)) {
				conn = JDBCDataSource.getConnection();
			}
			/* Filling data into the report */
			//P F
			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, map, conn);
			
			/* Export Jasper report */
			//P E
			byte[] pdf = JasperExportManager.exportReportToPdf(jasperPrint);
			response.setContentType("application/pdf");
			response.getOutputStream().write(pdf);
			response.getOutputStream().flush();
			
		} catch (Exception e) {
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

	@Override
	protected String getView() {
		return null;
	}

}

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
