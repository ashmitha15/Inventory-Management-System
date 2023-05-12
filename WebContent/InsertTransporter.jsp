<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd" > 
      <%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<HTML>
<HEAD>
  <TITLE>Insert New Employee</TITLE>
</HEAD>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<BODY class="w3-light-grey">
      
<h1 class="w3-xxxsmall"><b>Add New Transporter</b></h1>
  <FORM action="InsertTransporter.jsp" method="get">
    <TABLE style="border:black; border-width:5px; border-style:solid;">
         <TR>
	      <TH style="font-size:25px">Vehicle No</TH>
		  <TD><INPUT TYPE="text" NAME="VEHICLE_NO" style="font-size:25px"></TD>
	  </tr>
      <TR>
	     <TH style="font-size:25px">Transport Agency name</TH>
		 <TD><INPUT type="text" NAME="TRANS_AGENCY_NAME" style="font-size:25px"></TD>
	  </tr>
	  <TR>
	     <TH style="font-size:25px">Distributor id</TH>
		 <TD><INPUT type="number" NAME="DIST_ID" style="font-size:25px"></TD>
	  </tr>
	   
      <TR>
	     <TH style="font-size:25px">Charges</TH>
		 <TD><INPUT type="number" NAME="CHARGES" style="font-size:25px"></TD>
	  </tr>

	  
	  
	  <TR>
	      <TH></TH>
		  <TD class="w3-button w3-block w3-padding-large w3-red w3-margin-bottom"><INPUT TYPE="submit" VALUE="submit"></TD>
		  
	  </tr>
   </TABLE>
 
<%
   String VEHICLE_NO = request.getParameter("VEHICLE_NO");
   String TRANS_AGENCY_NAME = request.getParameter("TRANS_AGENCY_NAME");
   String DIST_ID = request.getParameter("DIST_ID");
  // String DATE_OF_DELIVERY = request.getParameter("DATE_OF_DELIVERY");
   String CHARGES = request.getParameter("CHARGES");
    String connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
    Connection connection = null;
     PreparedStatement pstatement = null;
     Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
          int updateQuery = 0;
	 if(VEHICLE_NO!=null && TRANS_AGENCY_NAME!=null && DIST_ID!=null  && CHARGES!=null){
	     if(VEHICLE_NO!="" && TRANS_AGENCY_NAME!="" && DIST_ID!="" && CHARGES!="") {
	                 try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              String queryString = "INSERT INTO FALL22_S001_12_TRANSPORTER VALUES(?,?,?,SYSDATE,?,1)";
              pstatement = connection.prepareStatement(queryString);
              //out.println(EMP_PHONE_NO.intValue());
              //int phone = Integer.valueOf(EMP_PHONE_NO);
              //int salary = Integer.parseInt(SALARY_PER_MONTH);
              //out.println(EMP_PHONE_NO);
              pstatement.setString(1, VEHICLE_NO);
			  pstatement.setString(2, TRANS_AGENCY_NAME);
			  pstatement.setString(3, DIST_ID);
			  pstatement.setString(4, CHARGES);
              updateQuery = pstatement.executeUpdate();
                            if (updateQuery != 0) { %>
	           <br>
	           <TABLE style="background-color: #E3E4FA;" 
                   WIDTH="30%" border="1">
		      <tr><th style="font-size:25px">Data is inserted successfully 
                    in transporter table.</th></tr>
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
    //VEHICLE_NO = request.getParameter("VEHICLE_NO");

    //DIST_ID = request.getParameter("DIST_ID");
  
    //connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
    connection = null;
     pstatement = null;
     Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
          updateQuery = 0;
	 if(VEHICLE_NO!=null && TRANS_AGENCY_NAME!=null && DIST_ID!=null  && CHARGES!=null){
	     if(VEHICLE_NO!="" && TRANS_AGENCY_NAME!="" && DIST_ID!="" && CHARGES!="") {
	                 try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              String queryString = "INSERT INTO FALL22_S001_12_SENDS_THROUGH VALUES(?,SYSDATE,?)";
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1, DIST_ID);
              pstatement.setString(2, VEHICLE_NO);
              
              updateQuery = pstatement.executeUpdate();
              
                            if (updateQuery != 0) { %>
	           <br>
	           <TABLE style="background-color: #E3E4FA;" 
                   WIDTH="30%" border="1">
		      <tr><th style="font-size:25px">Data is inserted successfully 
                    in sends_through table.</th></tr>
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
<input type="button" value="Return to Home"
        onclick="window.location.href='Home.jsp'" />
  </FORM>
 </body> 
</html>