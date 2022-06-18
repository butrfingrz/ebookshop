<!-- Andrea Fletcher  
     Module 6 EBookshop Project 
     
 	 This JSP connects to a MySql Database, runs a query
 	 to get a list of all the available books, and outputs them
 	 on the webpage as a table
 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>JDBC test</title>
</head>
<body>
	<%
	//Database specific stuff
	Class.forName("com.mysql.cj.jdbc.Driver");
	//Set parms to connect to databse - get the values from web.xml file
	String dbName = application.getInitParameter("dbName"); 
	String dbUser = application.getInitParameter("dbUser");
	String dbPass = application.getInitParameter("dbPass");

	//establist connection to the databse
	Connection conn = DriverManager.getConnection(dbName, dbUser, dbPass);
	
	//create the statement
	Statement stmt = conn.createStatement();
	
	//execute the query and store the results
	ResultSet rs = stmt.executeQuery("select * from books");
	%>
	<table border="1">
		<%
		//get column count so we can add to the result table
		ResultSetMetaData resMetaData = rs.getMetaData();
		int nCols = resMetaData.getColumnCount();
		%>
		<tr>
			<%
				//the first row...
				//loop through all the columns from the database table 
				//and create a column to output
				for (int kCol = 1; kCol <= nCols; kCol++) {
				out.print("<td><b>" + resMetaData.getColumnName(kCol) + "</b></td>");
			}
			%>
		</tr>
		<%
			//While there are more results from the query...
			while (rs.next()) {
		%><tr>
			<%
				//loop through the columns for that row so we can output
				// it to the user
				for (int kCol = 1; kCol <= nCols; kCol++) {
				out.print("<td>" + rs.getString(kCol) + "</td>");
			}
			%>
		</tr>
		<%
			}
		%>
	</table>
	<%
  conn.close();
  %>
</body>
</html>