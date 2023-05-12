<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd" > 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  
      <%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>

<html>
<head>
<meta charset="UTF-8">
<title>Employee</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey">

<sql:setDataSource
        var="myDS"
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu"
        user="axb1312" password="Ashmisrav1502"
    />
     
    <sql:query var="listEmployees"   dataSource="${myDS}">    
	SELECT * FROM Fall22_S001_12_Employee where END_DATE IS NULL
    </sql:query>
   <div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Employee.jsp" class="w3-bar-item w3-button" style="font-size:25px">Employees</a>
  <a href="NewEmployee.jsp" class="w3-bar-item w3-button" style="font-size:25px">New Employee</a>
  <a href="CurrentEmployees.jsp" class="w3-bar-item w3-button" style="font-size:25px">Current Employees</a>
</div>


<%
   int EMP_ID = Integer.parseInt(request.getParameter("EMP_ID"));
   String connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
    Connection connection = null;
     PreparedStatement pstatement = null;
     Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
          int updateQuery = 0;
	                 try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              String queryString = "UPDATE Fall22_S001_12_Employee SET END_DATE = SYSDATE WHERE EMP_ID=?";
              pstatement = connection.prepareStatement(queryString);
              pstatement.setInt(1, EMP_ID);
              updateQuery = pstatement.executeUpdate();
                            if (updateQuery != 0) { %>
	           <br>
	           <TABLE style="background-color: #E3E4FA;" 
                   WIDTH="30%" border="1">
		      <tr><th style="font-size:25px">Employee is no longer working.</th></tr>
		   </table>
              <%
              }
            } 
            catch (Exception ex) {
            out.println("Unable to connect to batabase.");
   
               }
            finally {
                // close all the connections.
                pstatement.close();
                connection.close();
            }
%>


<input type="button" value="CHECK"
        onclick="window.location.href='CurrentEmployees.jsp'" />
    
<input type="button" value="Return to Home"
        onclick="window.location.href='Home.jsp'" />
</body>
</html>