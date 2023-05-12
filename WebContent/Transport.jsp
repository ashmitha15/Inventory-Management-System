<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transporter</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Home.jsp" class="w3-bar-item w3-button" style="font-size:25px">Home</a>
     <a href="OptimalTransAgency.jsp" class="w3-bar-item w3-button" style="font-size:25px">Find Optimal Transport Agency</a>
</div>


<sql:setDataSource
        var="myDS"
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu"
        user="axb1312" password="Ashmisrav1502"
    />
     
    <sql:query var="listTransporters"   dataSource="${myDS}">
        select * from Fall22_S001_12_Transporter
    </sql:query>
     
    <div align="center">
        <table border="1" cellpadding="6">
            <caption><h2>List of all Transporters</h2></caption>
            <tr>
                <th>VEHICLE_NO</th>
                <th>TRANS_AGENCY_NAME</th>
                <th>DIST_ID</th>
                <th>DATE_OF_DELIVERY</th>
                <th>CHARGES</th>
                <th>ADMIN_ID</th>
            </tr>
            <c:forEach var="user" items="${listTransporters.rows}">
                <tr>
                    <td><c:out value="${user.VEHICLE_NO}" /></td>
                    <td><c:out value="${user.TRANS_AGENCY_NAME}" /></td>
                    <td><c:out value="${user.DIST_ID}" /></td>
                    <td><c:out value="${user.DATE_OF_DELIVERY}" /></td>
                    <td><c:out value="${user.CHARGES}" /></td>
                    <td><c:out value="${user.ADMIN_ID}" /></td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <input type="button" value="InsertTransporter"
        onclick="window.location.href='InsertTransporter.jsp'" />


</body>
</html>