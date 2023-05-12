<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Customers</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Home.jsp" class="w3-bar-item w3-button" style="font-size:25px">Home</a>
     <a href="CampaignArea.jsp" class="w3-bar-item w3-button" style="font-size:25px">Campaign Customer Area </a>
</div>
<form action="NewCustomer.jsp" method="post">
<table style="border:black; border-width:5px; border-style:solid;" >
<h2>Enter the transcation details of new customer</h2>
    
    <TR>
          <TH style="font-size:25px">Customer Name</TH>
          <TD><INPUT TYPE="text" NAME="CUST_NAME" style="font-size:25px"></TD>
      </tr>
    
    <TR>
          <TH style="font-size:25px">Area</TH>
          <TD><INPUT TYPE="text" NAME="AREA" style="font-size:25px"></TD>
      </tr>
    
    
    <TR>
          <TH style="font-size:25px">Product id</TH>
          <TD><INPUT TYPE="text" NAME="PROD_ID" style="font-size:25px"></TD>
      </tr>

      <TR>
         <TH style="font-size:25px">Quantity</TH>
         <TD><INPUT type="number" NAME="QTY" style="font-size:25px"></TD>
      </tr>
      <TR>
         <TH style="font-size:25px">Total Amount</TH>
         <TD><INPUT type="number" NAME="TOTAL_AMOUNT" style="font-size:25px"></TD>
      </tr>
      <TR>
         <TH style="font-size:25px">Discount</TH>
         <TD><INPUT type="number" NAME="DISCOUNT_TO_CUST" style="font-size:25px"></TD>
      </tr>
      
      <TR>
          <TH></TH>
          <TD class="w3-button w3-block w3-padding-large w3-red w3-margin-bottom"><INPUT TYPE="submit" VALUE="submit"></TD>
          
      </tr>
    
</table>
</form>

<%
   String CUST_PHONE_NO = (String)session.getAttribute("CUST_PHONE_NO");

	String CUST_NAME = request.getParameter("CUST_NAME"); 
	String AREA = request.getParameter("AREA");
   String prod_id = request.getParameter("PROD_ID"); 
   String quantity = request.getParameter("QTY");
   //session.setAttribute("custPhone", CUST_PHONE_NO);
    String connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
    Connection connection = null;
     PreparedStatement pstatement = null;
     ResultSet rs = null;
    ArrayList<String> custList = new ArrayList<String>();
     Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
    String total = request.getParameter("TOTAL_AMOUNT"); 
    String discount = request.getParameter("DISCOUNT_TO_CUST");
    int updateQuery = 0;
   Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
   if(prod_id!=null && quantity!=null ){
       if(prod_id!="" && quantity!="") {
                     try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              
              String queryString = "INSERT INTO Fall22_S001_12_CUSTOMER VALUES(NULL,?,?,1)";
              
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1,CUST_NAME);
              pstatement.setString(2,AREA);
              updateQuery = pstatement.executeUpdate();
              if (updateQuery != 0) { %>
 <br>
 <TABLE style="background-color: #E3E4FA;" 
     WIDTH="30%" border="1">
<tr><th style="font-size:25px">Data is inserted successfully 
      in database table Customer.</th></tr>
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
       }}
 
%>

<% 
connection = null;
pstatement = null;
rs = null;
String id = null;
Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
if(prod_id!=null && quantity!=null ){
    if(prod_id!="" && quantity!="") {        
                try {
         connection = DriverManager.getConnection
         (connectionURL, "axb1312", "Ashmisrav1502");
         
         String queryString = "SELECT CUST_ID FROM Fall22_S001_12_CUSTOMER ORDER BY CUST_ID DESC fetch first 1 row only";
         
         pstatement = connection.prepareStatement(queryString);
         rs = pstatement.executeQuery();
            while(rs.next()){
                    id = rs.getString("CUST_ID");
                }
       }
       catch (Exception ex) {

          }
       finally {
           // close all the connections.
           pstatement.close();
           connection.close();
       }
 }
}
%>

<%
     connection = null;
     pstatement = null;
     rs = null;
    Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
    updateQuery = 0;
   Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
   if(prod_id!=null && quantity!=null ){
       if(prod_id!="" && quantity!="") {
                     try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              
              String queryString = "INSERT INTO Fall22_S001_12_CUSTOMER_CUST_PHONE_NO VALUES(?,?)";
              
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1,id);
              pstatement.setString(2,CUST_PHONE_NO);
              updateQuery = pstatement.executeUpdate();
              if (updateQuery != 0) { %>
 <br>
 <TABLE style="background-color: #E3E4FA;" 
     WIDTH="30%" border="1">
<tr><th style="font-size:25px">Data is inserted successfully 
      in database table Customer's Phone.</th></tr>
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
       }}
 
%>



<%
     connection = null;
     pstatement = null;
     rs = null;
    Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
    updateQuery = 0;
   Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
   if(prod_id!=null && quantity!=null ){
       if(prod_id!="" && quantity!="") {
                     try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              
              String queryString = "INSERT INTO Fall22_S001_12_BUYS VALUES(?,?,SYSDATE,?,?,?)";
              
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1,prod_id);
              pstatement.setString(2,id);
              pstatement.setString(3,quantity);
              pstatement.setString(4,total);
              pstatement.setString(5,discount);
              updateQuery = pstatement.executeUpdate();
              if (updateQuery != 0) { %>
 <br>
 <TABLE style="background-color: #E3E4FA;" 
     WIDTH="30%" border="1">
<tr><th style="font-size:25px">Data is inserted successfully 
      in database table Buys.</th></tr>
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
       }}
 
%>

<%
   connection = null;
    pstatement = null;
    rs = null;
    updateQuery = 0;
   Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
        
                     try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              
              String queryString = "UPDATE Fall22_S001_12_Products SET STOCK_COUNT = STOCK_COUNT - ? WHERE PROD_ID = ?";
              
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1,quantity);
              pstatement.setString(2,prod_id);
              updateQuery = pstatement.executeUpdate();
              if (updateQuery != 0) { %>
 <br>
 <TABLE style="background-color: #E3E4FA;" 
     WIDTH="30%" border="1">
<tr><th style="font-size:25px">Data is updated in Products table successfully.</th></tr>
</table>
<%
}
}
              catch (Exception ex) {
   
               }
            finally {
                pstatement.close();
                connection.close();
            }
 
%>




</body>
</html>