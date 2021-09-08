<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/temp/insert.do" method="post" name="frm">
	
		<label for="tempVal">값 정보 </label>
		<input type="text" id="tempVal" name="tempVal">
		<br/>
		
		<button type="submit">등록</button>
		
	</form>
</body>
</html>