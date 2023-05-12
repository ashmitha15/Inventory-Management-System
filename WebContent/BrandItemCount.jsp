<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Total Brand and item count</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey">

<sql:setDataSource
        var="myDS"
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu"
        user="axb1312" password="Ashmisrav1502"
    />
     
    <sql:query var="brandItem"   dataSource="${myDS}">
        SELECT P.PROD_ID, P.PROD_NAME, P.BRAND_NAME,PT.PROD_TYPE, SUM(STOCK_COUNT) OVER (PARTITION BY P.BRAND_NAME, PT.PROD_TYPE) AS TOTAL_UNITS_PRESENT FROM FALL22_S001_12_PRODUCTS P, FALL22_S001_12_PRODUCTS_PROD_TYPE PT WHERE P.PROD_ID = PT.PROD_ID
    </sql:query>
   
   <div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="BrandItemCount.jsp" class="w3-bar-item w3-button" style="font-size:25px">Brand and Item count</a>
  <a href="AreaPerProducts.jsp" class="w3-bar-item w3-button" style="font-size:25px">Products Per Area</a>
  <a href="TransPerDist.jsp" class="w3-bar-item w3-button" style="font-size:25px">Transport Per Distributor</a>
</div>

     
    <div align="center">
        <table border="1" cellpadding="7">
            <caption><h2>TOTAL NUMBER OF UNITS PRESEN UNDER EACH BRAND</h2></caption>
            <tr>
                <th>PROD_ID</th>
                <th>PROD_NAME</th>
                <th>BRAND_NAME</th>
                <th>PROD_TYPE</th>
                <th>TOTAL_UNITS_PRESENT</th>
                
            </tr>
            <c:forEach var="user" items="${brandItem.rows}">
                <tr>
                    <td><c:out value="${user.PROD_ID}" /></td>
                    <td><c:out value="${user.PROD_NAME}" /></td>
                    <td><c:out value="${user.BRAND_NAME}" /></td>
                    <td><c:out value="${user.PROD_TYPE}" /></td>
                    <td><c:out value="${user.TOTAL_UNITS_PRESENT}" /></td>
             
                </tr>
            </c:forEach>
        </table>
    </div>


<input type="button" value="Return to Home"
        onclick="window.location.href='Home.jsp'" />
</body>
</html>