<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<thead>
				<td>Temp_Id</td>
				<td>Temp_Val</td>
			
			
		</thead>
		
		<tbody>
			<c:forEach var="item" items="${list}">
			<td>${item.tempId}</td>
			<td>${item.tempVal}/</td>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>