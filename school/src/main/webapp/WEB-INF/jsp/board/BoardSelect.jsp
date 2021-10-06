<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!-- 기본 URL -->
<c:url var="_BASE_PARAM" value="">
	<c:param name="menuNo" value="50" />
	<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}"></c:param></c:if>
	<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}"></c:param></c:if>
</c:url>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ko" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta charset="UTF-8">
<title>상세페이지</title>

<link href="http://172.16.144.100:2021/asset/BBSTMP_0000000000001/style.css" rel="stylesheet">
<link href="http://172.16.144.100:2021/asset/LYTTMP_0000000000000/style.css" rel="stylesheet">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
	<div class="container">
		<div id="contents">
			<div id="bbs_wrap">
				<div class="board_view">
					<dl class="tit_view">
						<dt>제목</dt>
						<dd>
							<c:out value="${result.boardSj}"></c:out>
						</dd>
					</dl>

					<dl class="info_view2">
						<dt>작성자ID</dt>
						<dd>
							<c:out value="${result.frstRegisterId}"></c:out>
						</dd>
						<dt>작성일</dt>
						<dd>
							<fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd" />
						</dd>
						<dt>조회수</dt>
						<dd>
							<c:out value="${result.inquireCo}"></c:out>
						</dd>
					</dl>

					<div class="view_cont">
						<c:out value="${result.boardCn}" escapeXml="false"></c:out>
						<!-- escapeXml="false" 태그가 안보이고. true 는 태그가 보이게 됨 -->
					</div>


					<div class="btn-cont ar">
						<c:choose>
							<c:when test="${not empty searchVO.boardId}">
								<c:url var="uptUrl" value="/board/boardRegist.do${_BASE_PARAM}">
									<c:param name="boardId" value="${result.boardId}"></c:param>
								</c:url>
								<a href="${uptUrl}" class="btn">수정</a>

								<c:url var="delUrl" value="/board/delete.do${_BASE_PARAM}">
									<c:param name="boardId" value="${result.boardId}"></c:param>
								</c:url>
								<a href="${delUrl}" id="btn-del" class="btn"><i class="ico-del"></i>삭제</a>
							</c:when>
							<c:otherwise>
								<a href="#none" id="btn-reg" class="btn spot">등록</a>
							</c:otherwise>
						</c:choose>

						<c:url var="listUrl" value="/board/selectList.do${_BASE_PARAM}" />
						<a href="${listUrl}" class="btn">목록</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function(){
			$("#btn-del").click(function(){
				if(!confirm("삭제하시겠습니까?")){
					return false;
				}
			});
		});
	
	</script>
	
	
</body>
</html>