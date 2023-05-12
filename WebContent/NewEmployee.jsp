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
   <div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Employee.jsp" class="w3-bar-item w3-button" style="font-size:25px">Employees</a>
  <a href="NewEmployee.jsp" class="w3-bar-item w3-button" style="font-size:25px">New Employee</a>
  <a href="CurrentEmployees.jsp" class="w3-bar-item w3-button" style="font-size:25px">Current Employees</a>
</div>    
<h1 class="w3-xxxsmall"><b>Add New Employee</b></h1>
  <FORM action="NewEmployee.jsp" method="get">
    <TABLE style="border:black; border-width:5px; border-style:solid;">
         <TR>
	      <TH style="font-size:25px">Employee Name</TH>
		  <TD><INPUT TYPE="text" NAME="EMP_NAME" style="font-size:25px"></TD>
	  </tr>
      <TR>
	     <TH style="font-size:25px">Employee Phone Number</TH>
		 <TD><INPUT type="number" NAME="EMP_PHONE_NO" style="font-size:25px"></TD>
	  </tr>
	  <TR>
	     <TH style="font-size:25px">Salary</TH>
		 <TD><INPUT type="number" NAME="SALARY_PER_MONTH" style="font-size:25px"></TD>
	  </tr>
	  
	  <TR>
	      <TH></TH>
		  <TD class="w3-button w3-block w3-padding-large w3-red w3-margin-bottom"><INPUT TYPE="submit" VALUE="submit"></TD>
		  
	  </tr>
   </TABLE>
 
<%
   String EMP_NAME = request.getParameter("EMP_NAME");
   String EMP_PHONE_NO = request.getParameter("EMP_PHONE_NO");
   String SALARY_PER_MONTH = request.getParameter("SALARY_PER_MONTH");
    String connectionURL = "jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu";
    Connection connection = null;
     PreparedStatement pstatement = null;
     Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
          int updateQuery = 0;
	 if(EMP_NAME!=null && EMP_PHONE_NO!=null && SALARY_PER_MONTH!=null){
	     if(EMP_NAME!="" && EMP_PHONE_NO!="" && SALARY_PER_MONTH!="") {
	                 try {
              connection = DriverManager.getConnection
              (connectionURL, "axb1312", "Ashmisrav1502");
              String queryString = "INSERT INTO Fall22_S001_12_Employee VALUES(NULL,?,?,?,SYSDATE,NULL,1)";
              pstatement = connection.prepareStatement(queryString);
              //out.println(EMP_PHONE_NO.intValue());
              //int phone = Integer.valueOf(EMP_PHONE_NO);
              //int salary = Integer.parseInt(SALARY_PER_MONTH);
              //out.println(EMP_PHONE_NO);
              pstatement.setString(1, EMP_NAME);
			  pstatement.setString(2, EMP_PHONE_NO);
			  pstatement.setString(3, SALARY_PER_MONTH);
              updateQuery = pstatement.executeUpdate();
                            if (updateQuery != 0) { %>
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
            out.println("Unable to connect to batabase.");
   
               }
            finally {
                // close all the connections.
                pstatement.close();
                connection.close();
            }
	  }
	}
%>
  </FORM>
 </body> 
</html>