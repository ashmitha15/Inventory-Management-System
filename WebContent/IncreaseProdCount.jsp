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
<title>Increase Product count</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey" style="align:center">
<div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Home.jsp" class="w3-bar-item w3-button" style="font-size:25px">Home</a>
</div>



<form name="datepickeer" action="IncreaseProdCount.jsp" method="POST">
<select name="prodType"> 
    <option value="PAINT">PAINT</option> 
    <option value="CEMENT">CEMENT</option> 
    <option value="STEEL">STEEL</option> 
  </select>
<table>
<tr><td>Start Date :</td> <td><input type = "date" name = "dateA" value="2013-01-08"></td><tr>
<tr><td>End Date :</td> <td><input type = "date" name = "dateB"></td><tr>



<tr><td><input type = "submit" name = "submit" value = "submit"></td></tr>
</table>
</form>



<%
String productSelected = request.getParameter("prodType"); 
String dateA =request.getParameter("dateA");
String dateB =request.getParameter("dateB");


String connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
Connection connection = null;
Statement stmt = null;
ResultSet rs = null;
PreparedStatement pstatement = null;
ArrayList<String> prodList = new ArrayList<String>();
Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
                     try {
           connection = DriverManager.getConnection(connectionURL, "axb1312", "Ashmisrav1502");
           String queryString = "SELECT P1.PROD_ID,P1.PROD_NAME,P1.BRAND_NAME FROM FALL22_S001_12_PRODUCTS P1 WHERE P1.PROD_ID IN ( SELECT B1.PROD_ID FROM FALL22_S001_12_BUYS B1, FALL22_S001_12_PRODUCTS_PROD_TYPE PT WHERE  B1.PROD_ID = PT.PROD_ID AND B1.DATE_OF_PURCHASE BETWEEN ? AND ? AND PT.PROD_TYPE LIKE ? GROUP BY B1.PROD_ID HAVING COUNT(B1.PROD_ID) IN (SELECT MAX(PROD_COUNT) AS MAX_COUNT FROM(SELECT B1.PROD_ID,COUNT(B1.PROD_ID) AS PROD_COUNT FROM  FALL22_S001_12_BUYS B1, FALL22_S001_12_PRODUCTS_PROD_TYPE PT WHERE B1.PROD_ID = PT.PROD_ID AND B1.DATE_OF_PURCHASE BETWEEN ? AND ? AND PT.PROD_TYPE LIKE ? GROUP BY B1.PROD_ID)))";
           pstatement = connection.prepareStatement(queryString);
           pstatement.setString(1, dateA);
           pstatement.setString(2, dateB);
           pstatement.setString(3, productSelected); 
           pstatement.setString(4, dateA);
           pstatement.setString(5, dateB);
           pstatement.setString(6, productSelected);
           rs = pstatement.executeQuery();
           
           while (rs.next()) {
        	   prodList.add("Product ID: " +rs.getString("PROD_ID"));
        	   prodList.add("Product Name: " +rs.getString("PROD_NAME"));
        	   prodList.add("Brand Name: " +rs.getString("BRAND_NAME"));
           }
           request.setAttribute("ProductsList", prodList);
           request.getRequestDispatcher("IncreaseProdCount.jsp").forward(request,
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
<form action="IncreaseProdCount.jsp" method="post">
<table border="1" >
<h2>Maximum sold Product Details</h2>
    <c:forEach items="${ProductsList}" var="ProductsList">
        <tr>
            <td style="font-size:25px; width:50%">${ProductsList}</td>
            <c:set var="ID" scope="page" value="${ProductsList}"/>         
        </tr>
    </c:forEach>
</table>
</form>
</body>
</html>