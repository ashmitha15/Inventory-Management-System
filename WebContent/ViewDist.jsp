<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd" > 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey" style="align:center">
<div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Home.jsp" class="w3-bar-item w3-button" style="font-size:25px">Home</a>
</div>

<%String DIST_NAME = request.getParameter("DIST_NAME");
String pName=(String)session.getAttribute("pName");
String connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
Connection connection = null;
 Statement stmt = null;
 ResultSet rs = null;
 PreparedStatement pstatement = null;
 ArrayList<String> dets = new ArrayList<String>();
 Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
	                 try {
           connection = DriverManager.getConnection(connectionURL, "axb1312", "Ashmisrav1502");
           String queryString = "SELECT d.DIST_NAME, d.CONTACT_NO, dp.PRICE_OF_PRODUCT, dp.DISCOUNT FROM FALL22_S001_12_DISTRIBUTOR d, FALL22_S001_12_DISTRIBUTOR_PROD_DETAILS dp where d.dist_name like ? and d.DIST_ID = dp.DIST_ID and BRAND_NAME = (select brand_name from Fall22_S001_12_Products where PROD_NAME = ?)";
           pstatement = connection.prepareStatement(queryString);
           pstatement.setString(1, DIST_NAME);
           pstatement.setString(2, pName);
           rs = pstatement.executeQuery();
           while (rs.next()) {
        	   dets.add("Distributor Name: " +rs.getString("DIST_NAME"));
        	   dets.add("Contact No: " +rs.getString("CONTACT_NO"));
        	   dets.add("Price: " +rs.getString("PRICE_OF_PRODUCT"));
        	   dets.add("Discount: " +rs.getString("DISCOUNT"));
           }
           request.setAttribute("detsList", dets);
           request.getRequestDispatcher("ViewDist.jsp").forward(request,
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
<form action="ViewDist.jsp" method="post">
<table border="1" >
<h2>Distributor Purchase Details</h2>
    <c:forEach items="${detsList}" var="detsList">
        <tr>
            <td style="font-size:25px; width:50%">${detsList}</td>
            <c:set var="ID" scope="page" value="${detsList}"/>         
        </tr>
    </c:forEach>
</table>
</form>
</body>
</html>