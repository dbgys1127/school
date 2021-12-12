package egovframework.let.rsv.service;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.FileVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface ReservationApplyService {

	//예약 목록 가져오기
	public List<EgovMap> selectReservationApplyList(ReservationApplyVO vo) throws Exception;
	
	//예약 목록 수
	public int selectReservationApplyListCnt(ReservationApplyVO vo) throws Exception;

	//예약 상세정보
	public ReservationApplyVO selectReservationApply(ReservationApplyVO vo) throws Exception;
	
	//예약 등록
	public ReservationApplyVO insertReservationApply(ReservationApplyVO vo) throws Exception;
	
	//예약 수정
	public void updateReservationApply(ReservationApplyVO vo) throws Exception;
	
	//예약 삭제
	public void deleteReservationApply(ReservationApplyVO vo) throws Exception;

	//예약자 승인 처리
	public void updateReservationConfirm(ReservationApplyVO vo) throws Exception;
	
	//예약 가능 여부 처리
	public ReservationApplyVO rsvCheck(ReservationApplyVO vo) throws Exception;
	
	//예약자 엑셀 업로드
	public Map<String, Object> excelUpload(FileVO file, ReservationApplyVO vo) throws Exception;
}
