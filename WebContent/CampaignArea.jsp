<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd" >
<%@page import="java.sql.Date"%>
<%@page import="java.util.Formatter"%>
<%@page import="java.text.DateFormat"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Locale"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>



<html>
<head>
<meta charset="UTF-8">
<title>Campaign Area</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey" style="align:center">
<div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Home.jsp" class="w3-bar-item w3-button" style="font-size:25px">Home</a>
</div>



<form name="datepickeer" action="CampaignArea.jsp" method="POST">
<table>
<tr><td>Start Date :</td> <td><input type = "text" name = "dateA" value="2013-01-08"></td><tr>
<tr><td>End Date :</td> <td><input type = "text" name = "dateB"></td><tr>



<tr><td><input type = "submit" name = "submit" value = "submit"></td></tr>
</table>
</form>



<%
String dateA =request.getParameter("dateA");
String dateB =request.getParameter("dateB");
System.out.println("before select query"+dateA);
System.out.println("before select query"+dateB);




String connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
Connection connection = null;
Statement stmt = null;
ResultSet rs = null;
PreparedStatement pstatement = null;
ArrayList<String> area = new ArrayList<String>();
Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
                     try {
           connection = DriverManager.getConnection(connectionURL, "axb1312", "Ashmisrav1502");
           String queryString = "SELECT C1.CUST_AREA AS AREA FROM FALL22_S001_12_CUSTOMER C1, FALL22_S001_12_BUYS B1 WHERE C1.CUST_ID = B1.CUST_ID AND B1.DATE_OF_PURCHASE BETWEEN ? AND ? GROUP BY C1.CUST_AREA HAVING COUNT(C1.CUST_AREA) IN ( SELECT MIN(MYCOUNT) AS O FROM(SELECT C.CUST_AREA AREA,COUNT(C.CUST_AREA) AS MYCOUNT FROM FALL22_S001_12_CUSTOMER C, FALL22_S001_12_BUYS B WHERE C.CUST_ID = B.CUST_ID AND B.DATE_OF_PURCHASE BETWEEN ? AND ? GROUP BY C.CUST_AREA )TEMP )";
           System.out.println(dateA);
           System.out.println(dateB);
           pstatement = connection.prepareStatement(queryString);
           pstatement.setString(1, dateA);
           pstatement.setString(2, dateB);
           pstatement.setString(3, dateA);
           pstatement.setString(4, dateB);
         	
           
           rs = pstatement.executeQuery();
           
           while (rs.next()) {
               area.add("Customer Area: " +rs.getString("AREA"));
          
           }
           request.setAttribute("areaList", area);
           request.getRequestDispatcher("CampaignArea.jsp").forward(request,
                   response);
           %>
           <%
         }
         catch (Exception ex) {
         //out.println("Unable to connect to batabase.");
            }
         finally {
             connection.close();
         }
%>
<form action="CampaignArea.jsp" method="post">
<table border="1" >
<h2>Campaign Area Details</h2>
    <c:forEach items="${areaList}" var="areaList">
        <tr>
            <td style="font-size:25px; width:50%">${areaList}</td>
            <c:set var="ID" scope="page" value="${areaList}"/>         
        </tr>
    </c:forEach>
</table>
</form>
</body>
</html>