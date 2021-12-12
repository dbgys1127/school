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
	<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}"></c:param></c:if>
	<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}"></c:param></c:if>
</c:url>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신청한 사람들의 리스트</title>


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
					
					</div>
						
				<!-- 목록영역 -->		
			<div id="bbs_wrap">
				<div class="total">
					총 예약수 <strong><c:out value="${fn:length(resultList)}" /></strong>건
					<c:url var="excelUrl" value="/admin/rsv/selectApplyList.do">
						<c:param name="resveId" value="${param.resveId}" />
						<c:param name="excelAt" value="Y" />
					</c:url>
					<a href="${excelUrl}" class="btn">엑셀 다운로드</a>
					<c:url var="excelUrl" value="/admin/rsv/excel.do">
						<c:param name="resveId" value="${param.resveId}" />
					</c:url>
					<a href="${excelUrl}" class="btn">JAVA 엑셀 다운로드</a>
				</div>
				
				<div class="bss_list">
					<table class="list_table">
						<thead>
							<tr>
								<th class="num" scope="col">번호</th>
								<th scope="col">신청자명</th>
								<th scope="col">신청일</th>
								<th scope="col">신청상태</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="num"><c:out value="${fn:length(resultList) - (status.index)}" /></td>
									<td>
										<c:url var="viewUrl" value="/admin/rsv/rsvApplySelect.do${_BASE_PARAM}">
											<c:param name="resveId" value="${result.resveId}" />
											<c:param name="reqstId" value="${result.reqstId}" />
											<c:param name="pageIndex" value="${searchVO.pageIndex}" />
										</c:url>
										<a href="${viewUrl}">
											<c:out value="${result.chargerNm}"/>
											(<c:out value="${result.frstRegisterId}"/>)
										</a>
									</td>
									<td>
										<fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/>
									</td>
									<td>
										<c:choose>
											<c:when test="${result.confmSeCode eq 'R'}">신청 접수 중</c:when>
											<c:when test="${result.confmSeCode eq 'O'}">승인 완료</c:when>
											<c:when test="${result.confmSeCode eq 'X'}">신청 반려</c:when>
										</c:choose>
									</td>
									<td>
										<c:url var="deleteUrl" value="/admin/rsv/rsvApplyDelete.do${_BASE_PARAM}">
											<c:param name="resveId" value="${result.resveId}"/>
											<c:param name="reqstId" value="${result.reqstId}"/>
											<c:param name="pageIndex" value="${result.pageIndex}"/>
										</c:url>
										<a href="${deleteUrl}" class="btn spot btn-del">삭제</a>
									</td>
								</tr>
							</c:forEach>
							
							<%-- 글이 없는 경우 --%>
							<c:if test="${fn:length(resultList) == 0}">
								<tr class="empty"><td colspan="5">신청자가 없습니다.</td></tr>
							</c:if>
						</tbody>
					</table>
				</div>
				
				<div class="btn-cont ar">
					<c:url var="listUrl" value="/admin/rsv/rsvSelectList.do${_BASE_PARAM}" />
					<a href="${listUrl}" class="btn">목록</a>
				</div>
				
				<div class="excelUploadBox">
					<form id="excelForm" name="excelForm" action="/admin/rsv/excelUpload.json" enctype="multipart/form-data" method="post">
						<input type="hidden" name="resveId" id="resveId" value="${param.resveId}" />
						<input type="hidden" name="resveDe" value="TYPE01" />
						
						<a href="/excel/rqtExcel_sample.xls" class="btn" download>
							엑셀 업로드 샘플 다운로드
						</a>
						<br/>
						<label for="registerExcelFile">파일첨부</label>
						<input type="file" id="registerExcelFile" name="registerExcelFile">
						<a href="#" id="excelReg" class="btn btn_blue">등록</a>
					</form>
				</div>
				
			</div>
			<!-- //목록영역 끝-->
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

//예약 글 삭제
$(".btn-del").click(function(){
	if(!confirm("삭제하시겠습니까?")){
		return false;
	}
	
});
$(document).on('click', '#excelReg', function(e){
	if($('#registerExcelFile').val() == ''){
		alert('파일을 등록해주세요.');
		return false;
	}
	
	var form = new FormData($('#excelForm')[0]);
	var url = $('#excelForm').attr('action');
	
	$.ajax({
		url:url,
		type: 'POST',
		data:form,
		dataType:'json',
		success: function(result){
			var message="";
			if(result.success){
				window.location.reload();
			} else{
				for(i=0; i<result.data.length; i++){
					if(i != 0){
						message += "\n";
					}
					message += result.data[i].userId + " : " + result.data[i].message;
				}
				alert(message);
				window.location.reload();
			}
			
		}
	});
	return false;
})

</script>	
</body>
</html>
