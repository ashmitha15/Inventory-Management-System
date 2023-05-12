<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Total Products per Area</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey">

<sql:setDataSource
        var="myDS"
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu"
        user="axb1312" password="Ashmisrav1502"
    />
     
 <sql:query var="AreaProduct" dataSource="${myDS}">
   SELECT C.CUST_AREA,P.PROD_NAME, SUM(TOTAL_AMOUNT)AS TOTAL_AMOUNT FROM  FALL22_S001_12_CUSTOMER C, FALL22_S001_12_PRODUCTS P, FALL22_S001_12_BUYS B WHERE B.PROD_ID = P.PROD_ID AND C.CUST_ID = B.CUST_ID GROUP BY CUBE(C.CUST_AREA,P.PROD_NAME) ORDER BY C.CUST_AREA,P.PROD_NAME   
</sql:query>
   
   <div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="BrandItemCount.jsp" class="w3-bar-item w3-button" style="font-size:25px">Brand and Item count</a>
  <a href="AreaPerProducts.jsp" class="w3-bar-item w3-button" style="font-size:25px">Products Per Area</a>
  <a href="TransPerDist.jsp" class="w3-bar-item w3-button" style="font-size:25px">Transport Per Distributor</a>
</div>

    <div align="center">
        <table border="1" cellpadding="7">
            <caption><h2>TOTAL AMOUNT OF PRODUCTS BOUGHT BY THE CUSTOMERS IN THAT AREA</h2></caption>
            <tr>
                <th>CUST_AREA</th>
                <th>PROD_NAME</th>
                <th>TOTAL_AMOUNT</th>
                
            </tr>
            <c:forEach var="user" items="${AreaProduct.rows}">
                <tr>
                    <td><c:out value="${user.CUST_AREA}" /></td>
                    <td><c:out value="${user.PROD_NAME}" /></td>
                    <td><c:out value="${user.TOTAL_AMOUNT}" /></td>
             
                </tr>
            </c:forEach>
        </table>
    </div>


<input type="button" value="Return to Home"
        onclick="window.location.href='Home.jsp'" />
</body>
</html>