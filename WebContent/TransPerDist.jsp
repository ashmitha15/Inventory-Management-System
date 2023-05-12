<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Total Transporter charges per distributor</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey">

<sql:setDataSource
        var="myDS"
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu"
        user="axb1312" password="Ashmisrav1502"
    />
     
 <sql:query var="TransCharges" dataSource="${myDS}">
    SELECT D.DIST_ID,T.VEHICLE_NO, SUM(T.CHARGES) AS TOTAL_CHARGES FROM FALL22_S001_12_DISTRIBUTOR D, FALL22_S001_12_TRANSPORTER T WHERE D.DIST_ID = T.DIST_ID GROUP BY ROLLUP(D.DIST_ID,T.VEHICLE_NO )
 </sql:query>
   
   <div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="BrandItemCount.jsp" class="w3-bar-item w3-button" style="font-size:25px">Brand and Item count</a>
  <a href="AreaPerProducts.jsp" class="w3-bar-item w3-button" style="font-size:25px">Products Per Area</a>
  <a href="TransPerDist.jsp" class="w3-bar-item w3-button" style="font-size:25px">Transport Per Distributor</a>
</div>
 
     
    <div align="center">
        <table border="1" cellpadding="7">
            <caption><h2>THE TOTAL TRANSPORT CHARGES FOR EACH DISTRIBUTOR</h2></caption>
            <tr>
                <th>DIST_ID</th>
                <th>VEHICLE_NO</th>
                <th>TOTAL_CHARGES</th>
                
            </tr>
            <c:forEach var="user" items="${TransCharges.rows}">
                <tr>
                    <td><c:out value="${user.DIST_ID}" /></td>
                    <td><c:out value="${user.VEHICLE_NO}" /></td>
                    <td><c:out value="${user.TOTAL_CHARGES}" /></td>
             
                </tr>
            </c:forEach>
        </table>
    </div>


<input type="button" value="Return to Home"
        onclick="window.location.href='Home.jsp'" />
</body>
</html>