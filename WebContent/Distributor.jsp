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
<title>Distributor</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey" style="align:center">
<div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Home.jsp" class="w3-bar-item w3-button" style="font-size:25px">Home</a>
    <a href="MaxDist.jsp" class="w3-bar-item w3-button" style="font-size:25px">Max Discount</a>
      
</div>



<h1 class="w3-xxxsmall"><b></b></h1>  
    <form action="Distributor.jsp" style="font-size:25px">
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



             request.getRequestDispatcher("Distributor.jsp").forward(request,
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





<form action="Distributor.jsp" method="post">
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
ArrayList<String> distName = new ArrayList<String>();
//Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
try {
    connection = DriverManager.getConnection(connectionURL, "axb1312", "Ashmisrav1502");      
    String queryString = "SELECT DIST_NAME FROM FALL22_S001_12_DISTRIBUTOR WHERE DIST_ID IN( SELECT DIST_ID FROM FALL22_S001_12_DISTRIBUTOR_PROD_DETAILS WHERE BRAND_NAME=(SELECT BRAND_NAME FROM Fall22_S001_12_Products WHERE PROD_NAME LIKE ?))";
          ps = connection.prepareStatement(queryString);
          ps.setString(1, prod_name);
          rset = ps.executeQuery();
          while (rset.next()) {
              distName.add(rset.getString("DIST_NAME"));
          }
          request.setAttribute("DistNameList", distName);



         request.getRequestDispatcher("Distributor.jsp").forward(request,
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
<form action="Distributor.jsp" method="post">
<table border="1" >
<h2>Distributor Names</h2>
    <c:forEach items="${DistNameList}" var="DistNameList">
        <tr>
            <td style="font-size:25px; width:50%">${DistNameList}</td>
            <c:set var="ID" scope="page" value="${DistNameList}"/>
            <td> <a class="w3-button w3-block w3-red" href="ViewDist.jsp?DIST_NAME=${pageScope.ID}" id="a">VIEW</a></td>
            <td> <a class="w3-button w3-block w3-red" href="UpdateDist.jsp?DIST_NAME=${pageScope.ID}" id="a">ADD</a></td>
                   
        </tr>
    </c:forEach>
</table>
</form>
</body>
</html>