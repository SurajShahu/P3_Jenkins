<%@page import="in.co.rays.project_3.dto.JobDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="in.co.rays.project_3.model.ModelFactory"%>
<%@page import="in.co.rays.project_3.util.DataUtility"%>
<%@page import="in.co.rays.project_3.controller.JobListCtl"%>
<%@page import="in.co.rays.project_3.util.HTMLUtility"%>
<%@page import="in.co.rays.project_3.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Job List</title>
<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=ORSView.APP_CONTEXT%>/js/CheckBox11.js"></script>
<style>
.hm {
	background-image: url('<%=ORSView.APP_CONTEXT%>/img/universe_01.jpg');
	background-size: 100%;
	background-attachment: fixed;
}

.p1 {
	padding: 4px;
	width: 200px;
	font-size: bold;
}

.text {
	text-align: center;
}

input.form-control, select.form-control {
	margin-bottom: 0 !important;
	display: inline-block;
}

.btn-md {
	margin-bottom: 0 !important;
}
</style>
<nav class="fixed-top"> <%@include file="Header.jsp"%></nav>
<br>
<br>
<br>
</head>
<body class="hm">

	<%@include file="calendar.jsp"%>


	<div>
		<form class="pb-5" action="<%=ORSView.JOB_LIST_CTL%>" method="post">
			<jsp:useBean id="dto" class="in.co.rays.project_3.dto.JobDTO"
				scope="request"></jsp:useBean>
			<%
				List list1 = (List) request.getAttribute("roleList");
			%>


			<%
				int pageNo = ServletUtility.getPageNo(request);
				int pageSize = ServletUtility.getPageSize(request);
				int index = ((pageNo - 1) * pageSize) + 1;
				int nextPageSize = DataUtility.getInt(request.getAttribute("nextListSize").toString());
				/* RoleDTO rbean1 = new RoleDTO();
				RoleModelInt rmodel = ModelFactory.getInstance().getRoleModel(); */

				List list = ServletUtility.getList(request);

				Iterator<JobDTO> it = list.iterator();
				if (list.size() != 0) {
			%>
			<center>
				<h1 class="text-light font-weight-bold pt-3">Job List</h1>
			</center>
			<div class="row">
				<div class="col-md-4"></div>
				<%
					if (!ServletUtility.getSuccessMessage(request).equals("")) {
				%>

				<div class="col-md-4 alert alert-success alert-dismissible"
					style="background-color: #80ff80">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>
						<font color="#008000"><%=ServletUtility.getSuccessMessage(request)%></font>
					</h4>
				</div>
				<%
					}
				%>
				<div class="col-md-4"></div>
			</div>
			<div class="row">
				<div class="col-md-4"></div>

				<%
					if (!ServletUtility.getErrorMessage(request).equals("")) {
				%>
				<div class=" col-md-4 alert alert-danger alert-dismissible">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>
						<font color="red"> <%=ServletUtility.getErrorMessage(request)%></font>
					</h4>
				</div>
				<%
					}
				%>
				<div class="col-md-4"></div>
			</div>

			<div class="row align-items-center">
				<div class="col-sm-1"></div>

				<div class="col-sm-2">
					<input type="text" name="title" placeholder="Enter title"
						class="form-control"
						value="<%=ServletUtility.getParameter("title", request)%>"
						maxlength="18" pattern="[A-Za-z ]*"
						onkeypress="return isLetter(event)"
						title="Only letters are allowed.">
				</div>
				&emsp;
				<script>
					function isLetter(event) {
						// Get the character code of the pressed key
						var charCode = event.charCode;

						// Check if the character is a letter or a space
						if (charCode == 32
								|| (charCode >= 65 && charCode <= 90)
								|| (charCode >= 97 && charCode <= 122)) {
							return true;
						}
						// Prevent the input if the character is not a letter or a space
						return false;
					}
				</script>


				<!-- Opening Date -->
				<div class="col-sm-2">
					<input type="text" name="opening" id="udate" readonly="readonly"
						placeholder="Enter Date" class="form-control"
						value="<%=ServletUtility.getParameter("opening", request)%>">
				</div>
				&emsp;

				<!-- Minimum Experience -->
				<div class="col-sm-2">
					<input type="text" name="experience" placeholder="Enter Experience"
						class="form-control"
						value="<%=ServletUtility.getParameter("experience", request)%>">
				</div>
				&emsp;

				<!-- Status -->
				<div class="col-sm-2">
					<select name="status" class="form-control">
						<option value=""
							<%if (ServletUtility.getParameter("status", request) == null
						|| "".equals(ServletUtility.getParameter("status", request))) {%>
							selected <%}%>>Select Status</option>
						<option value="Open"
							<%if ("Open".equals(ServletUtility.getParameter("status", request))) {%>
							selected <%}%>>Open</option>
						<option value="Closed"
							<%if ("Closed".equals(ServletUtility.getParameter("status", request))) {%>
							selected <%}%>>Closed</option>
					</select>
				</div>
				&emsp;

				<div class="col-sm-2">
					<input type="submit" class="btn btn-primary btn-md"
						style="font-size: 15px" name="operation"
						value="<%=JobListCtl.OP_SEARCH%>"> &emsp; <input
						type="submit" class="btn btn-dark btn-md" style="font-size: 15px"
						name="operation" value="<%=JobListCtl.OP_RESET%>">
				</div>
				<div class="col-sm-1"></div>
			</div>


			</br>
			<div style="margin-bottom: 20px;" class="table-responsive">
				<table class="table table-bordered table-dark table-hover">
					<thead>
						<tr style="background-color: #8C8C8C;">

							<th width="10%"><input type="checkbox" id="select_all"
								name="Select" class="text"> Select All</th>
							<th width="5%" class="text">S.NO</th>
							<th width="25%" class="text">Title</th>
							<th width="20%" class="text">Opening</th>
							<th width="20%" class="text">Experience(years)</th>
							<th width="20%" class="text">Status</th>
							<th width="5%" class="text">Edit</th>

						</tr>
					</thead>
					<%
						while (it.hasNext()) {
								dto = it.next();

								/* RoleDTO rbean = rmodel.findByPK(dto.getRoleId()); */
					%>
					<tbody>
						<tr>
							<td align="center"><input type="checkbox" class="checkbox"
								name="ids" value="<%=dto.getId()%>"></td>
							<td class="text"><%=index++%></td>
							<td class="text"><%=dto.getTitle()%></td>
							<td class="text"><%=DataUtility.getDateString(dto.getOpening())%></td>
							<td class="text"><%=dto.getExperience()%></td>
							<td class="text"><%=dto.getStatus()%></td>
							<td class="text"><a href="JobCtl?id=<%=dto.getId()%>">Edit</a></td>
						</tr>

					</tbody>
					<%
						}
					%>
				</table>
			</div>
			<table width="100%">
				<tr>
					<td><input type="submit" name="operation"
						class="btn btn-warning btn-md" style="font-size: 17px"
						value="<%=JobListCtl.OP_PREVIOUS%>"
						<%=pageNo > 1 ? "" : "disabled"%>></td>
					<td><input type="submit" name="operation"
						class="btn btn-primary btn-md" style="font-size: 17px"
						value="<%=JobListCtl.OP_NEW%>"></td>
					<td><input type="submit" name="operation"
						class="btn btn-danger btn-md" style="font-size: 17px"
						value="<%=JobListCtl.OP_DELETE%>"></td>

					<td align="right"><input type="submit" name="operation"
						class="btn btn-warning btn-md" style="font-size: 17px"
						style="padding: 5px;" value="<%=JobListCtl.OP_NEXT%>"
						<%=(nextPageSize != 0) ? "" : "disabled"%>></td>
				</tr>
				<tr></tr>
			</table>

			<%
				}
				if (list.size() == 0) {
			%>
			<center>
				<h1 style="font-size: 40px; color: white;">
					<b>Job List</b>
				</h1>
			</center>
			</br>
			<div class="row">
				<div class="col-md-4"></div>

				<%
					if (!ServletUtility.getErrorMessage(request).equals("")) {
				%>
				<div class=" col-md-4 alert alert-danger alert-dismissible">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>
						<font color="red"> <%=ServletUtility.getErrorMessage(request)%></font>
					</h4>
				</div>
				<%
					}
				%>




				<%
					if (!ServletUtility.getSuccessMessage(request).equals("")) {
				%>

				<div class="col-md-4 alert alert-success alert-dismissible"
					style="background-color: #80ff80">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>
						<font color="#008000"><%=ServletUtility.getSuccessMessage(request)%></font>
					</h4>
				</div>
				<%
					}
				%>
				<div style="padding-left: 48%;">
					<input type="submit" name="operation"
						class="btn btn-primary btn-md" style="font-size: 17px"
						value="<%=JobListCtl.OP_BACK%>">
				</div>

				<div class="col-md-4"></div>
			</div>

			<%
				}
			%>

			<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
		</form>


	</div>


</body>
<%@include file="FooterView.jsp"%>
</html>
