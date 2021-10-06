<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<title>게시물을 수정하기</title>
</head>
<body>
	${result.tempVal}
			<div class="box-btn">
				
						<c:url var="uptUrl" value="/temp/tempRegist.do">
								<c:param name="tempId" value="${result.tempId}" />
						</c:url> 
						<a href="${uptUrl}">수정</a>
						<c:url var="delUrl" value="/temp/delete.do">
								<c:param name="tempId" value="${result.tempId}" />
						</c:url> 
						<a href="${delUrl}" class="btn-del">삭제</a>
						<a href="/temp/selectList.do">목록</a>
			</div>
			
</body>

<script>
	$(document).ready(function(){
		$(".btn-del").click(function(){
			if(!confirm("삭제하시겠어요?")){
				return false;				
			}
		});
	});
</script>

</html>

