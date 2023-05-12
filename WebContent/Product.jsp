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
<title>Products</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey" style="align:center">
<div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Home.jsp" class="w3-bar-item w3-button" style="font-size:25px">Home</a>
     <a href="DeleteProd.jsp" class="w3-bar-item w3-button" style="font-size:25px">Delete Products</a>
     <a href="MostSoldBrand.jsp" class="w3-bar-item w3-button" style="font-size:25px">Most Sold Brand</a>
     <a href="DecreaseProdCount.jsp" class="w3-bar-item w3-button" style="font-size:25px">Decrease Product count</a>
     <a href="IncreaseProdCount.jsp" class="w3-bar-item w3-button" style="font-size:25px">Increase Product count</a>
</div>



<h1 class="w3-xxxsmall"><b></b></h1>  
    <form action="Product.jsp" style="font-size:25px">
  <select name="prodType">
    <option value="PAINT">PAINT</option>
    <option value="CEMENT">CEMENT</option>
    <option value="STEEL">STEEL</option>
  </select>
  <input type="submit" value="Select" style="font-size:15px">
</form>



<%
String productSelected = request.getParameter("prodType");
   String connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
    Connection connection = null;
    Statement stmt = null;
    ResultSet rs = null;
    PreparedStatement pstatement = null;
    ArrayList<String> productName = new ArrayList<String>();
     Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
                     try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              String queryString = "SELECT PROD_NAME FROM Fall22_S001_12_Products WHERE PROD_ID IN(SELECT PROD_ID FROM Fall22_S001_12_Products_Prod_Type WHERE PROD_TYPE = ?)";
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1, productSelected);
              rs = pstatement.executeQuery();
              while (rs.next()) {
                  productName.add(rs.getString("PROD_NAME"));
              }
              request.setAttribute("ProductNameList", productName);



             request.getRequestDispatcher("Product.jsp").forward(request,
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





<form action="Product.jsp" method="post">
        <select id="prodName" name="prodName" style="font-size:25px">



           <c:forEach var="ProductNameList" items="${ProductNameList}">



               <option value="${ProductNameList}" style="font-size:25px">${ProductNameList}</option>
                <c:set var="P_ID" scope="page" value="${ProductNameList}"/>



           </c:forEach>



       </select>



       <input type="submit" value="Select" value="${pt}" align="middle" style="font-size:15px">



   </form>




<%
String prod_name = request.getParameter("prodName");
session.setAttribute("pName",prod_name);
//String connurl = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
//Connection conn = null;
Statement st = null;
ResultSet rset = null;
PreparedStatement ps = null;
ArrayList<String> prodDets = new ArrayList<String>();
//Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
try {
    connection = DriverManager.getConnection(connectionURL, "axb1312", "Ashmisrav1502");      
    String queryString = "SELECT PROD_NAME, PRICE_OF_PROD, STOCK_COUNT FROM Fall22_S001_12_Products WHERE PROD_NAME LIKE ?";
          ps = connection.prepareStatement(queryString);
          ps.setString(1, prod_name);
          rset = ps.executeQuery();
          while (rset.next()) {
              prodDets.add("Products Name: " +rset.getString("PROD_NAME"));
              prodDets.add("Price: " +rset.getString("PRICE_OF_PROD"));
              prodDets.add("Stock: " +rset.getString("STOCK_COUNT"));
          }
          request.setAttribute("prodDetsList", prodDets);



         request.getRequestDispatcher("Product.jsp").forward(request,
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
<form action="Product.jsp" method="post">
<table border="1" >
<h2>Products Details</h2>
    <c:forEach items="${prodDetsList}" var="prodDetsList">
        <tr>
            <td style="font-size:25px; width:50%">${prodDetsList}</td>
            <c:set var="ID" scope="page" value="${prodDetsList}"/>
                   
        </tr>
    </c:forEach>
</table>
</form>
</body>
</html>