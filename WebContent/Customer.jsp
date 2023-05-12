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
<title>Customer</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Home.jsp" class="w3-bar-item w3-button" style="font-size:25px">Home</a>
     <a href="CampaignArea.jsp" class="w3-bar-item w3-button" style="font-size:25px">Campaign Customer Area </a>
</div>
<FORM action="Customer.jsp" method="get">
    <TABLE style="border:black; border-width:5px; border-style:solid;">
         <TR>
          <TH style="font-size:25px">Customer Name</TH>
          <TD><INPUT TYPE="text" NAME="CUST_NAME" style="font-size:25px"></TD>
      </tr>
      <TR>
         <TH style="font-size:25px">Customer Phone Number</TH>
         <TD><INPUT type="number" NAME="CUST_PHONE_NO" style="font-size:25px"></TD>
      </tr>
      
      <TR>
          <TH></TH>
          <TD class="w3-button w3-block w3-padding-large w3-red w3-margin-bottom"><INPUT TYPE="submit" VALUE="submit"></TD>
          
      </tr>
   </TABLE>
   </FORM>
   
   <%
   String CUST_NAME = request.getParameter("CUST_NAME");
   //session.setAttribute("custName", CUST_NAME);
   String CUST_PHONE_NO = request.getParameter("CUST_PHONE_NO");
   session.setAttribute("CUST_PHONE_NO", CUST_PHONE_NO);
   
    String connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
    Connection connection = null;
     PreparedStatement pstatement = null;
     ResultSet rs = null;
    ArrayList<String> custList = new ArrayList<String>();
  String name = null;
  String phone = null;
     Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
          //int updateQuery = 0;
     if(CUST_NAME!=null && CUST_PHONE_NO!=null ){
         if(CUST_NAME!="" && CUST_PHONE_NO!="") {
             
                     try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              
              String queryString = "SELECT C.CUST_NAME, CP.CUST_PHONE_NO FROM Fall22_S001_12_CUSTOMER C, Fall22_S001_12_CUSTOMER_CUST_PHONE_NO CP  WHERE EXISTS(SELECT C.CUST_NAME, CP.CUST_PHONE_NO  FROM Fall22_S001_12_CUSTOMER C, Fall22_S001_12_CUSTOMER_CUST_PHONE_NO CP WHERE C.CUST_ID = CP.CUST_ID AND C.CUST_NAME = ? AND CP.CUST_PHONE_NO =?) and C.CUST_ID = CP.CUST_ID AND C.CUST_NAME = ? AND CP.CUST_PHONE_NO =?";
              out.println("STRING");
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1,CUST_NAME);
              pstatement.setString(2,CUST_PHONE_NO);
              pstatement.setString(3,CUST_NAME);
              pstatement.setString(4,CUST_PHONE_NO);
              out.println("SET");
              rs = pstatement.executeQuery();
              out.println("QUERY");
                 while(rs.next()){
                	 out.println("NEXT");
              
                	 request.setAttribute("CUST_PHONE_NO", CUST_PHONE_NO);

                     request.getRequestDispatcher("ExistingCustomer.jsp").forward(request,
                             response);
                     }         
            	 request.setAttribute("CUST_NAME", CUST_NAME);
                 request.getRequestDispatcher("NewCustomer.jsp").forward(request,response);
            }
            catch (Exception ex) {
            //out.println("Unable to connect to database1.");
   
               }
            finally {
                // close all the connections.
                pstatement.close();
                connection.close();
            }
      }
    }
%>
  




</body>
</html>