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
<title>게시물을 리스트 형태로 가져오기</title>
</head>
<body>
	<div>
		게시물 총 수 :
		<c:out value="${paginationInfo.totalRecordCount}" />
		건

		<table>
			<caption>초록마크를 따기 위해서는 꼭 필요한 요소</caption>

			<thead>
				<tr>
					<th>TEMP_ID</th>
					<th>TEMP_VAL</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="result" items="${resultList}">
					<tr>
						<td><c:out value="${result.tempId}" /></td>
						<td><c:url var="viewUrl" value="/temp/select.do">
								<c:param name="tempId" value="${result.tempId}" />
							</c:url> <a href="${viewUrl}"><c:out value="${result.tempVal}" /></a>
						</td>
						<td><c:url var="delUrl" value="/temp/delete.do">
								<c:param name="tempId" value="${result.tempId}" />
							</c:url> <a href="${delUrl}" class="btn-del">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="paging_div">
			<ul class="paging_align">
				<c:url var="pageUrl" value="/temp/selectList.do"/>
				<c:set var="pagingParam"><c:out value="${pageUrl}"/> </c:set>
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pagingParam}"/>
				<%-- 리소스 > 스프링 > com > context-common.xml > For Pagination Tag 설정  --> 공통적으로 페이지를 쓸 수 있게 해주는.
					사이트마다의 특성이 다르기 때문에, 변경하고자 할 때마다.  페이지내이션 태그에서 바꾸면 됨. 설정 부분만. 
					무슨 태그로 되어있는 지 정도는 확인해야 함. --%>
			</ul>
		</div>
	</div>

	<button type="button" id="btn-reg" data-href="/temp/tempRegist.do">등록하기</button>
</body>

<script>
	$(document).ready(function(){
		$("#btn-reg").click(function(){
			location.href = $(this).data("href");
		});
		$(".btn-del").click(function(){
			if(!confirm("삭제하시겠어요?")){
				return false;				
			}
		});
	});
</script>

</html>

