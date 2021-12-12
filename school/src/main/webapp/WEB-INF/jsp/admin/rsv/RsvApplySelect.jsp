<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!-- 기본 URL -->
<c:url var="_BASE_PARAM" value="">
	<c:param name="menuNo" value="${param.menuNo}" />
	<c:param name="resveId" value="${searchVO.resveId}" />
	<c:param name="pageIndex" value="${searchVO.pageIndex}" />
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
<title>예약 신청 사용자 정보</title>

<link href="/css/common.css" rel="stylesheet" type="text/css">

<!-- BBS Style -->
<link href="/asset/BBSTMP_0000000000001/style.css" rel="stylesheet">
<!-- 공통 Style -->
<link href="/asset/LYTTMP_0000000000000/style.css" rel="stylesheet">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
<!-- 전체 레이어 시작 -->
	<div id="wrap">
		<!-- 헤더 -->
		<div id="header_mainsize"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
		<div id="topnavi"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTopnav" /> </div>
		
		<!-- container 시작 -->
		<div id="container">
			<!-- 좌측메뉴 시작 -->
			<div id="leftmenu"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncLeftmenu" /></div>
			
			<!-- 현재위치 네비게이션 시작 -->
			<div id="content">
				<div class="container">
					<div id="contents">
						<form action="/admin/rsv/rsvApplyConfirm.do" method="post" id="frm" name="frm" onsubmit="return regist()">
							<input type="hidden" name="resveId" value="${result.resveId}" />
							<input type="hidden" name="reqstId" value="${result.reqstId}" />
							
							<table class="chart2">
								<caption>예약정보 작성</caption>
								<colgroup>
									<col style="width:120px" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">신청자명</th>
										<td>
											<c:out value="${result.chargerNm}" />
											(<c:out value="${result.frstRegisterId}" />)
										</td>
									</tr>
									<tr>
										<th scope="row">연락처</th>
										<td>
											<c:out value="${result.telno}" />
										</td>
									</tr>
									<tr>
										<th scope="row">이메일</th>
										<td>
											<c:choose>
												<c:when test="${empty result.email}">없음</c:when>
												<c:otherwise>
													<c:out value="${result.email}" />
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
									<tr>
										<th scope="row">승인여부</th>
										<td>
											<select id="confmSeCode" name="confmSeCode">
												<option value="R">접수</option>
												<option value="O" <c:if test="${result.confmSeCode eq 'O'}">selected='selected'</c:if> >승인 완료</option>
												<option value="X" <c:if test="${result.confmSeCode eq 'X'}">selected='selected'</c:if> >승인 반려</option>
											</select>
										</td>
									</tr>
									<tr id="resn" <c:if test="${result.confmSeCode ne 'X'}">style="display:none;"</c:if>>
										<th>반려사유</th>
										<td>
											<textarea rows="5" id="returnResn" name="returnResn"><c:out value="${result.returnResn}" /></textarea>
										</td>
									</tr>
								</tbody>
							</table>
							
							<div class="btn-cont ar">
								<c:choose>
									<c:when test="${not empty searchVO.resveId}">
										<a href="#" id="btn-upt" class="btn">수정</a>
										
										<c:url var="delUrl" value="/admin/rsv/rsvApplyDelete.do${_BASE_PARAM}">
											<c:param name="reqstId" value="${result.reqstId}" />
										</c:url>
										<a href="${delUrl}" id="btn-del" class="btn"><i class="ico-del"></i>삭제</a>
									</c:when>
									<c:otherwise>
										<a href="#none" id="btn-reg" class="btn spot">등록</a>
									</c:otherwise>
								</c:choose>
								<c:url var="listUrl" value="/admin/rsv/rsvSelectList.do${_BASE_PARAM}" />
								<a href="${listUrl}" class="btn">취소</a>
							</div>
							
							</form>
						</div>
					</div>
				</div>
				<!-- //현재위치 네비게이션  끝 -->
		
		</div>
		<!-- //container 끝 -->
	
	<!-- footer 시작 -->
	<div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
	<!-- //footer 끝 -->

</div>

<script>
<c:if test="${not empty message}">
	alert("${message}");
</c:if>



$(document).ready(function(){
	//반려여부
	$("#confmSeCode").change(function(){
		var val = $(this).val();
		
		if(val == "X"){
			$("#resn").show();
		}else{
			$("#resn").hide();
		}
	});
	
	//예약자 삭제
	$("#btn-del").click(function(){
		if(!confirm("삭제하시겠습니까?")){
			return false;
		}
		
	});
	
	//승인
	$("#btn-upt").click(function(){
		$("#frm").submit();
		return false;
	});
	
});

function regist(){
	if($("#confmSeCode").val() == "X" && !$("#returnResn").val()){
		alert("반려 사유를 작성하세요.");
		$("#returnResn").focus();
		return false;
	}
}

</script>
</body>
</html>