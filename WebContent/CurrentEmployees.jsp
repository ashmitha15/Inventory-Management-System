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
   
     
    <div align="center">
        <table border="1" cellpadding="7">
            <caption><h2>List of Employees</h2></caption>
            <tr>
                <th>EMP_ID</th>
                <th>EMP_NAME</th>
                <th>EMP_PHONE_NO</th>
                <th>SALARY_PER_MONTH</th>
                <th>START_DATE</th>
                <th>END_DATE</th>
                <th>ADMIN_ID</th>
            </tr>
            <c:forEach var="user" items="${listEmployees.rows}">
                <tr>
                    <td><c:out value="${user.EMP_ID}"/></td>
                    <c:set var="ID" scope="page" value="${user.EMP_ID}"/>
                    <td><c:out value="${user.EMP_NAME}" /></td>
                    <td><c:out value="${user.EMP_PHONE_NO}" /></td>
                    <td><c:out value="${user.SALARY_PER_MONTH}" /></td>
                    <td><c:out value="${user.START_DATE}" /></td>
                    <td><c:out value="${user.END_DATE}" /></td>
                    <td><c:out value="${user.ADMIN_ID}" /></td>
                    <TD class="w3-button w3-block w3-red"><INPUT TYPE="button" value="Remove" onclick="myFunction(${pageScope.ID})">
                    </TD>
                </tr>
            </c:forEach>
        </table>
    </div>
    <p id="demo"></p>
    <script>
    function myFunction(del_ID){
    	//document.getElementById("demo").innerHTML = del_ID;
    	//out.println(del_ID);
    	window.location = 'RemoveEmployee.jsp?EMP_ID='+del_ID;
       // var id=document.form.id.value;
       // alert(id);
       // var f=document.form;
       // f.method="post";
       // f.action='preview.jsp?id='+id;
       // f.submit();
    }
    </script>
    
<input type="button" value="Return to Home"
        onclick="window.location.href='Home.jsp'" />
</body>
</html>