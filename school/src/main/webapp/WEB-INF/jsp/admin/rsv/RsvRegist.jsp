<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:choose>
	<c:when test="${not empty searchVO.resveId}">
		<c:set var="actionUrl" value="/admin/rsv/rsvUpdate.do"></c:set>
	</c:when>
	<c:otherwise>
		<c:set var="actionUrl" value="/admin/rsv/rsvInsert.do"></c:set>
	</c:otherwise>
</c:choose>


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
<title>관리자가 보는 리스트</title>

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
			<!-- 좌측메뉴 시작 -->
			<div id="leftmenu"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncLeftmenu" /></div>
			
			<!-- 현재위치 네비게이션 시작 -->
			<div id="content">
				<div class="container">
					<div id="contents">
						<!-- 검색 영역 -->
						<div id="bbs_search">
							<form name="frm" id="frm" method="post" action="${actionUrl}" onsubmit="return regist()">
								<input type="hidden" name="resveId" value="${result.resveId}" />
								<input type="hidden" name="resveSeCode" value="TYPE01" />
								
								<table class="chart2">
									<caption>예약정보 작성</caption>
									<colgroup>
										<col style="width:120px" />
										<col />
									</colgroup>
									
									<tbody>
										<tr>
											<th scope="row">프로그램명</th>
											<td> 
												<input type="text" id="resveSj" name="resveSj" title="제목입력" class="q3" value="<c:out value="${result.resveSj}"/> "> 
											</td>
										</tr>
										<tr>
											<th scope="row">운영기간</th>
											<td>
												<input type="text" id="useBeginDt" name="useBeginDt" class="datepicker" title="운영시작일" value="<c:out value="${result.useBeginDt}"/>" readonly="readonly">
												<input type="text" id="useEndDt" name="useEndDt" class="datepicker" title="운영종료일" value="<c:out value="${result.useEndDt}"/>" readonly="readonly">
											</td>
										</tr>
										<tr>
											<th scope="row">운영시간</th>
											<td>
												<input type="text" id="useBeginTime" name="useBeginTime" class="timepicker" title="운영시작시간" value="<c:out value="${result.useBeginTime}"/>" readonly="readonly">
												<input type="text" id="useEndTime" name="useEndTime" class="timepicker" title="운영종료시간" value="<c:out value="${result.useEndTime}"/>" readonly="readonly">
											</td>
										</tr>
										<tr>
											<th scope="row">신청시간</th>
											<td>
												<input type="text" id="reqstBgnde" name="reqstBgnde" class="datepicker" title="신청시작일" value="<c:out value="${result.reqstBgnde}"/>" readonly="readonly">
												<input type="text" id="reqstEndde" name="reqstEndde" class="datepicker" title="신청종료일" value="<c:out value="${result.reqstEndde}"/>" readonly="readonly">
											</td>
										</tr>
										<tr>
											<th scope="row">강사명</th>
											<td>
												<input type="text" id="recNm" name="recNm" title="강사명" value="<c:out value="${result.recNm}"/>">
											</td>
										</tr>
										<tr>
											<th scope="row">신청인원수</th>
											<td>
												<input type="text" id="maxAplyCnt" name="maxAplyCnt" title="신청인원수" value="<c:out value="${result.maxAplyCnt}"/>">
											</td>
										</tr>
										<tr>
											<th scope="row">내용</th>
											<td>
												<input type="text" id="resveCn" name="resveCn" title="내용 입력" value="<c:out value="${result.resveCn}"/>">
											</td>
										</tr>
									</tbody>
								</table>
								
								<div class="btn-cont ar">
									<c:choose>
										<c:when test="${not empty searchVO.resveId}">
											<c:url var="uptUrl" value="/admin/rsv/rsvRegist.do${_BASE_PARAM}">
												<c:param name="resveId" value="${result.resveId}"></c:param>
											</c:url>
											<a href="${uptUrl}" id="btn-reg" class="btn">수정</a>
											
											<c:url var="delUrl" value="/admin/rsv/rsvDelete.do${_BASE_PARAM}">
												<c:param name="resveId" value="${result.resveId}"></c:param>
											</c:url>
											<a href="${delUrl}" id="btn-del" class="btn"><i class="ico-del"></i> 삭제</a>
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
</div>

<script>


$(document).ready(function(){
	
	$(".datepicker").datepicker({
		dateFormat: 'yy-mm-dd'
	});
	
	$(".timepicker").timepicker({
		timeFormat : 'HH:mm',
		interval: 60,
		minTime: '10',
		maxTime: '18:00',
		startTime: '10:00'
	});


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
	if(!$("#resveSj").val()){
		alert("프로그램명을 입력해주세요");
		return false;
	}
}
</script>
</body>
</html>