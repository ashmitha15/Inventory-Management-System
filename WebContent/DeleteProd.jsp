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
<title>Delete Product</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey" style="align:center">



<h1 class="w3-xxxsmall"><b></b></h1>  
    <form action="DeleteProd.jsp" style="font-size:25px">
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



             request.getRequestDispatcher("DeleteProd.jsp").forward(request,
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





<form action="DeleteProd.jsp" method="post">
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



//String connurl = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
connection = null;
stmt = null;
rs = null;
pstatement = null;
int updateQuery = 0;
ArrayList<String> distName = new ArrayList<String>();
//Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
System.out.println(prod_name);
try{
connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              
              String queryString = "DELETE FROM Fall22_S001_12_PRODUCTS_PROD_TYPE PPT WHERE PROD_ID = ( SELECT PROD_ID FROM Fall22_S001_12_PRODUCTS P WHERE PPT.PROD_ID = P.PROD_ID AND PROD_NAME LIKE ?)";
              
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1,prod_name);
              System.out.println("set0");
              updateQuery = pstatement.executeUpdate();
              System.out.println("execute");
              if (updateQuery != 0) { %>
<br>
<TABLE style="background-color: #E3E4FA;"
     WIDTH="30%" border="1">
<tr><th style="font-size:25px">Data is Deleted successfully
      in database table Products.</th></tr>
</table>
<%
}
}
              catch (Exception ex) {
   
               }
            finally {
                // close all the connections.
                pstatement.close();
                connection.close();
            }
%>
</body>
</html>