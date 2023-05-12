<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd" >
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Locale"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>



<html>
<head>
<meta charset="UTF-8">
<title>Most sold brand</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey" style="align:center">
<div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Home.jsp" class="w3-bar-item w3-button" style="font-size:25px">Home</a>
</div>



<form name="datepickeer" action="MostSoldBrand.jsp" method="POST">
<table>
<tr><td>Start Date :</td> <td><input type = "text" name = "dateA" value="2013-01-08"></td><tr>
<tr><td>End Date :</td> <td><input type = "text" name = "dateB"></td><tr>



<tr><td><input type = "submit" name = "submit" value = "submit"></td></tr>
</table>
</form>



<%
String dateA =request.getParameter("dateA");
String dateB =request.getParameter("dateB");
String connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
Connection connection = null;
Statement stmt = null;
ResultSet rs = null;
PreparedStatement pstatement = null;
ArrayList<String> most = new ArrayList<String>();
Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
                     try {
           connection = DriverManager.getConnection(connectionURL, "axb1312", "Ashmisrav1502");
           String queryString = "SELECT P.BRAND_NAME FROM FALL22_S001_12_PRODUCTS P WHERE P.PROD_ID IN (SELECT B.PROD_ID FROM  FALL22_S001_12_BUYS B WHERE DATE_OF_PURCHASE BETWEEN ? AND ? GROUP BY B.PROD_ID ORDER BY COUNT(PROD_ID) DESC FETCH FIRST 1 ROW ONLY)";
           pstatement = connection.prepareStatement(queryString);
           pstatement.setString(1, dateA);
           pstatement.setString(2, dateB);           
           rs = pstatement.executeQuery();
           
           while (rs.next()) {
               most.add("Brand name: " +rs.getString("BRAND_NAME"));              
           }
           request.setAttribute("mostSoldList", most);
           request.getRequestDispatcher("MostSoldBrand.jsp").forward(request,
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
<form action="MostSoldBrand.jsp" method="post">
<table border="1" >
<h2>Most Sold Brand Details</h2>
    <c:forEach items="${mostSoldList}" var="mostSoldList">
        <tr>
            <td style="font-size:25px; width:50%">${mostSoldList}</td>
            <c:set var="ID" scope="page" value="${mostSoldList}"/>         
        </tr>
    </c:forEach>
</table>
</form>
</body>
</html>