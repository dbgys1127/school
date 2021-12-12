<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:choose>
	<c:when test="${not empty searchVO.reqstId}">
		<c:set var="actionUrl" value="/rsv/rsvApplyUpdate.do"></c:set>
	</c:when>
	<c:otherwise>
		<c:set var="actionUrl" value="/rsv/rsvApplyInsert.do"></c:set>
	</c:otherwise>
</c:choose>


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
<title>사용자가 등록하는 페이지</title>

<link href="/css/common.css" rel="stylesheet" type="text/css">

<!-- BBS Style -->
<link href="/asset/BBSTMP_0000000000001/style.css" rel="stylesheet">
<!-- 공통 Style -->
<link href="/asset/LYTTMP_0000000000000/style.css" rel="stylesheet">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>


<!-- jquery UI -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" >

<script src="https://cdnjs.cloudflare.com/ajax/libs/datepicker/1.0.10/datepicker.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/datepicker/1.0.10/datepicker.min.css" rel="stylesheet">

<script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css" rel="stylesheet">



</head>
<body>
<!-- 전체 레이어 시작 -->
	<div id="wrap">
		<!-- 헤더 -->
		<div id="header_mainsize"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
		<div id="topnavi"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTopnav" /> </div>
			
		<!-- container 시작 -->
		<div id="container">
			<!-- 현재위치 네비게이션 시작 -->
			<div id="content">
			<!-- 목록영역 -->
				<div id="bbs_wrap">
					<div class="board_view">
						<dl class="tit_view">
							<dt>프로그램명</dt>
							<dd><c:out value="${reservation.resveSj}" /></dd>
						</dl>
						
						<dl class="tit_view">
							<dt>신청유형</dt>
							<dd>
								<c:choose>
									<c:when test="${request.confmSeCode eq 'TYPE01'}">선착순</c:when>
									<c:when test="${request.confmSeCode eq 'TYPE02'}">승인관리</c:when>
								</c:choose>
							</dd>
						</dl>
						
						<dl class="tit_view">
							<dt>강사명</dt>
							<dd><c:out value="${reservation.recNm}" /></dd>
						</dl>
						
						<dl class="info_view">
							<dt>운영일자</dt>
							<dd><c:out value="${reservation.useBeginDt}" />~<c:out value="${reservation.useEndDt}" /></dd>
							<dt>운영시간</dt>
							<dd><c:out value="${reservation.useBeginTime} ~ ${reservation.useEndTime}" /></dd>
							<dt>신청기간</dt>
							<dd><c:out value="${reservation.reqstBgnde}" />~<c:out value="${reservation.reqstEndde}" /></dd>
							<dt>신청 가능한 인원</dt>
							<dd><c:out value="${reservation.maxAplyCnt}" /></dd>
						</dl>
						
						<dl class="info_view2">
							<dt>작성자ID</dt>
							<dd><c:out value="${reservation.frstRegisterId}" /></dd>
							<dt>작성일</dt>
							<dd><fmt:formatDate value="${reservation.frstRegistPnttm}" pattern="yyyy-MM-dd" /></dd>
						</dl>
						<div class="view_cont">
							<c:out value="${reservation.resveCn}" escapeXml="false"/>
						</div>
					</div>
					
					<h3 class="icon1">신청정보</h3>
					<form action="${actionUrl}" method="post" id="frm" name="frm" onsubmit="return regist()">
						<input type="hidden" name="resveId" value="${searchVO.resveId}" />
						<input type="hidden" name="resveSeCode" value="${searchVO.resveSeCode}" />
						<input type="hidden" name="reqstId" value="${searchVO.reqstId}" />
						<input type="hidden" name="resveDe" value="TYPE01" />
					
						<table class="chart2">
							<caption>예약자 정보 작성</caption>
							<colgroup>
								<col style="width:120px" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"> * 예약자명</th>
									<td>
										<input type="text" id="chargerNm" name="chargerNm" title="예약자명" value="<c:out value="${result.chargerNm}" />">
									</td>
								</tr>
								<tr>
									<th scope="row"> * 연락처</th>
									<td>
										<input type="text" id="telno" name="telno" title="연락처" value="<c:out value="${result.telno}" />">
									</td>
								</tr>
								<tr>
									<th scope="row">이메일</th>
									<td>
										<input type="text" id="email" name="email" title="이메일" value="<c:out value="${result.email}" />">
									</td>
								</tr>
							</tbody>
						</table>
						
						<div class="btn-cont ar">
							<c:choose>
								<c:when test="${not empty searchVO.reqstId}">
									<c:url var="uptUrl" value="/rsv/rsvApplyUpdate.do${_BASE_PARAM}">
										<c:param name="reqstId" value="${result.reqstId}"></c:param>
									</c:url>
									<a href="${uptUrl}" id="btn-reg" class="btn">수정</a>
									
									<c:url var="delUrl" value="/rsv/rsvApplyDelete.do${_BASE_PARAM}">
										<c:param name="reqstId" value="${result.reqstId}"></c:param>
									</c:url>
									<a href="${delUrl}" id="btn-del" class="btn"><i class="ico-del"></i> 삭제</a>
								</c:when>
								
								<c:otherwise>
									<a href="#none" id="btn-reg" class="btn spot">신청</a>
								</c:otherwise>
							</c:choose>
							
							<c:url var="listUrl" value="/rsv/selectList.do${_BASE_PARAM}" />
								<a href="${listUrl}" class="btn">취소</a>
						</div>
					
					</form>
					
					
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


$(document).ready(function(){

	//예약 글 등록
	$("#btn-reg").click(function(){
		$("#frm").submit();
			return false;
	});
	
	//예약 글 삭제
	$("#btn-del").click(function(){
		if(!confirm("삭제하시겠습니까?")){
			return false;
		}
	});

});


function regist(){
	if(!$("#chargerNm").val()){
		alert("예약자명을 입력하세요");
		$("#chargerNm").focus();
		return false;
	}else if(!$("#telno").val()){
		alert("연락처를 입력하세요");
		$("#telno").focus();
		return false;
	}
}



</script>
</body>
</html>