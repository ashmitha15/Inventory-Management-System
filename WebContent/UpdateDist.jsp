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
<title>View Distributor</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey" style="align:center">
<div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Home.jsp" class="w3-bar-item w3-button" style="font-size:25px">Home</a>
</div>



<%
String DIST_NAME = request.getParameter("DIST_NAME");
String pName=(String)session.getAttribute("pName");
String connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
Connection connection = null;
Statement stmt = null;
ResultSet rs = null;
PreparedStatement pstatement = null;
String id = null;
//ArrayList<String> updateDist = new ArrayList<String>();
Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
                     try {
           connection = DriverManager.getConnection(connectionURL, "axb1312", "Ashmisrav1502");
           String queryString = "SELECT DIST_ID FROM FALL22_S001_12_DISTRIBUTOR WHERE DIST_NAME = ?";
           pstatement = connection.prepareStatement(queryString);
           pstatement.setString(1, DIST_NAME);
           rs = pstatement.executeQuery();
           while (rs.next()) {
        	 
        	 id = rs.getString("DIST_ID");
        	 session.setAttribute("id", id);
           }
           
           request.setAttribute("updateid", id);
           request.getRequestDispatcher("UpdateDist.jsp").forward(request,
                   response);
           %>
           <%
         }
         catch (Exception ex) {
         //out.println("Unable to connect to batabase.");
            }
         finally {
        	 pstatement.close();
        	 connection.close();
             
             
         }



%>
<form action="UpdateDist.jsp" method="post">
<table id = "distid" border="1" >
<h2>Distributor Details</h2>
    <c:forEach items="${updateid}" var="updateid">
        <tr>
            <td style="font-size:25px; width:50%">${updateid}</td>
            <c:set var="ID" scope="page" value="${updateid}"/>         
        </tr>
    </c:forEach>
</table>
</form>



<%


  //connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
   
    stmt = null;
     rs = null;
     pstatement = null;
    ArrayList<String> productId = new ArrayList<String>();
     Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
	                 try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              String queryString = "SELECT DP.PROD_ID FROM  FALL22_S001_12_PRODUCTS_PROD_TYPE PT,  FALL22_S001_12_DISTRIBUTOR_PROD_DETAILS DP WHERE PT.PROD_ID = DP.PROD_ID  AND DIST_ID = ?";
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1, id);
              rs = pstatement.executeQuery();
              while (rs.next()) {
            	  productId.add(rs.getString("PROD_ID"));
              }
              request.setAttribute("ProductNameList", productId);

              request.getRequestDispatcher("UpdateDist.jsp").forward(request,
                      response);
              %>
              <%
            } 
            catch (Exception ex) {
            //out.println("Unable to connect to batabase.");
   
               }
            finally {
            	pstatement.close();
                connection.close();
            }
%>
<form action="UpdateDist.jsp" method="post">
        <select id="prodid1" name="prodid1" style="font-size:25px">

            <c:forEach var="ProductNameList" items="${ProductNameList}">

                <option value="${ProductNameList}" style="font-size:25px">${ProductNameList}</option>

            </c:forEach>

        </select>
        
        <TABLE style="border:black; border-width:5px; border-style:solid;">
         <TR>
	      <TH style="font-size:25px">Brand Name: </TH>
		  <TD><INPUT TYPE="text" NAME="BRAND_NAME" style="font-size:25px"></TD>
	  </tr>
      <TR>
	     <TH style="font-size:25px">Price of product:</TH>
		 <TD><INPUT type="number" NAME="PRICE_OF_PRODUCT" style="font-size:25px"></TD>
	  </tr>
	  <TR>
	     <TH style="font-size:25px">Qty:</TH>
		 <TD><INPUT type="number" NAME="QTY" style="font-size:25px"></TD>
	  </tr>
	 
	  <TR>
	     <TH style="font-size:25px">Discount:</TH>
		 <TD><INPUT type="number" NAME="DISCOUNT" style="font-size:25px"></TD>
	  </tr>
	  
	  
	
   </TABLE>

  <input type="submit" value="Submit" align="middle" style="font-size:15px">      

    </form>
<%
   String dist_id = (String)session.getAttribute("id");
   String PRODID1 = request.getParameter("prodid1");   
   String BRAND_NAME = request.getParameter("BRAND_NAME");
   String PRICE_OF_PRODUCT = request.getParameter("PRICE_OF_PRODUCT");
   String QTY = request.getParameter("QTY");
   String DISCOUNT = request.getParameter("DISCOUNT");
   //String DATE_OF_PURCHASE = request.getParameter("DATE_OF_PURCHASE");
    // connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
    
     pstatement = null;
     Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
          int updateQuery = 0;
	 if (BRAND_NAME!=null && PRICE_OF_PRODUCT!=null && QTY!=null && DISCOUNT!=null ){
	     if( BRAND_NAME!="" && PRICE_OF_PRODUCT!="" && QTY!="" && DISCOUNT!="" ) {
	                 try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              String queryString = "INSERT INTO FALL22_S001_12_DISTRIBUTOR_PROD_DETAILS VALUES(?,?,?,?,?,?,SYSDATE)";
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1, dist_id);
			  pstatement.setString(2, PRODID1);
			  pstatement.setString(3, BRAND_NAME);
			  pstatement.setString(4, PRICE_OF_PRODUCT);
			  pstatement.setString(5, QTY);
		      pstatement.setString(6, DISCOUNT);
			  
			 
			  
              updateQuery = pstatement.executeUpdate();
             
                            if (updateQuery != 0) {%>
	           <br>
	           <TABLE style="background-color: #E3E4FA;" 
                   WIDTH="30%" border="1">
		      <tr><th style="font-size:25px">Data is inserted successfully 
                    in database.</th></tr>
		   </table>
              <%
              }         
                            
            } 
            catch (Exception ex) {
            //out.println("Unable to connect to batabase.");
   
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
    updateQuery = 0;
   Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
        
                     try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              
              String queryString = "UPDATE Fall22_S001_12_Products SET STOCK_COUNT = STOCK_COUNT + ? WHERE PROD_ID = ?";
              
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1,QTY);
              pstatement.setString(2,PRODID1);
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