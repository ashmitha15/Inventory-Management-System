<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body class="w3-light-grey">
<sql:setDataSource
        var="myDS"
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu"
        user="axb1312" password="Ashmisrav1502"
    />
      
      <sql:query var="listProducts"   dataSource="${myDS}">
        SELECT PROD_NAME, BRAND_NAME, STOCK_COUNT FROM Fall22_S001_12_PRODUCTS WHERE STOCK_COUNT < 30
    </sql:query>
    
    <sql:query var="listProductsMax"   dataSource="${myDS}">
        SELECT PROD_NAME, BRAND_NAME, STOCK_COUNT FROM Fall22_S001_12_PRODUCTS WHERE STOCK_COUNT > 100
    </sql:query>

<!-- Navigation bar with social media icons -->
<div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
  <a href="Distributor.jsp" class="w3-bar-item w3-button" style="font-size:25px">Distributor</a>
  <a href="Customer.jsp" class="w3-bar-item w3-button" style="font-size:25px">Customer</a>
  <a href="Employee.jsp" class="w3-bar-item w3-button" style="font-size:25px">Employee</a>
  <a href="Transport.jsp" class="w3-bar-item w3-button" style="font-size:25px">Transport</a>
  <a href="Product.jsp" class="w3-bar-item w3-button" style="font-size:25px">Product</a>
  <a href="Functionality.jsp" class="w3-bar-item w3-button" style="font-size:25px">Other Functionality</a>
  
  
</div>

<div class="w3-content" style="max-width:5000px">

  <!-- Header -->
  <header class="w3-container w3-center w3-padding-48 w3-white" >
    <h1 class="w3-xxxlarge"><b>WELCOME</b></h1>
    <h6><span class="w3-tag" style="font-size:30px">INVENTORY MANAGEMENT OF A CONSTRUCTION BASED HARDWARE STORE</span></h6>
  </header>

  <!-- Image header -->
  <header class="w3-display-container w3-wide" id="home">
    <img class="w3-image" src="home.jfif" alt="HOME PAGE" width="2000" height="1500">
    <div class="w3-display-left w3-padding-large">
      <h6><button class="w3-button w3-white w3-padding-large w3-large w3-opacity w3-hover-opacity-off" onclick="document.getElementById('alert').style.display='block'">ALERT MIN</button></h6>
      <h6><button class="w3-button w3-white w3-padding-large w3-large w3-opacity w3-hover-opacity-off" onclick="document.getElementById('alert1').style.display='block'">ALERT MAX</button></h6>
      
    </div>
    
    <div id="alert" class="w3-modal w3-animate-opacity" align="center">
  <div class="w3-modal-content" style="padding:60px">
    <div class="w3-container w3-white">
      <i onclick="document.getElementById('alert').style.display='none'" class="fa fa-remove w3-transparent w3-button w3-xlarge w3-right"></i>
      <h2 class="w3-wide">ALERT</h2>
      <table border="1" cellpadding="3">
            <caption><h2>List of Products with less stock count</h2></caption>
            <tr>
                <th>PROD_NAME</th>
                <th>BRAND_NAME</th>
                <th>STOCK_COUNT</th>
            </tr>
            <c:forEach var="user" items="${listProducts.rows}">
                <tr>
                    <td><c:out value="${user.PROD_NAME}" /></td>
                    <td><c:out value="${user.BRAND_NAME}" /></td>
                    <td><c:out value="${user.STOCK_COUNT}" /></td>
                </tr>
            </c:forEach>
        </table>
      
      
      <button type="button" class="w3-button w3-block w3-padding-large w3-red w3-margin-bottom" onclick="document.getElementById('alert').style.display='none'">CLOSE</button>
    </div>
  </div>
</div>

 <div id="alert1" class="w3-modal w3-animate-opacity" align="center">
  <div class="w3-modal-content" style="padding:60px">
    <div class="w3-container w3-white">
      <i onclick="document.getElementById('alert').style.display='none'" class="fa fa-remove w3-transparent w3-button w3-xlarge w3-right"></i>
      <h2 class="w3-wide">ALERT</h2>
      <table border="1" cellpadding="3">
            <caption><h2>List of Products with Max stock count</h2></caption>
            <tr>
                <th>PROD_NAME</th>
                <th>BRAND_NAME</th>
                <th>STOCK_COUNT</th>
            </tr>
            <c:forEach var="user" items="${listProductsMax.rows}">
                <tr>
                    <td><c:out value="${user.PROD_NAME}" /></td>
                    <td><c:out value="${user.BRAND_NAME}" /></td>
                    <td><c:out value="${user.STOCK_COUNT}" /></td>
                </tr>
            </c:forEach>
        </table>
      
      
      <button type="button" class="w3-button w3-block w3-padding-large w3-red w3-margin-bottom" onclick="document.getElementById('alert1').style.display='none'">CLOSE</button>
    </div>
  </div>
</div>
    
  </header>
  <footer class="w3-container w3-dark-grey" style="padding:32px">
</footer>
</body>
</html>