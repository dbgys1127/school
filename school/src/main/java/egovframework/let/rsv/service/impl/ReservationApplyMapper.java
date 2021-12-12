package egovframework.let.rsv.service.impl;

import java.util.List;

import egovframework.let.rsv.service.ReservationApplyVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("reservationApplyMapper")
public interface ReservationApplyMapper {
		//예약 목록 가져오기
		List<EgovMap> selectReservationApplyList(ReservationApplyVO vo) throws Exception;
		
		//예약 목록 수
		int selectReservationApplyListCnt(ReservationApplyVO vo) throws Exception;

		//예약 상세정보-
		ReservationApplyVO selectReservationApply(ReservationApplyVO vo) throws Exception;
		
		//예약 등록-
		void insertReservationApply(ReservationApplyVO vo) throws Exception;
		
		//예약 수정-
		void updateReservationApply(ReservationApplyVO vo) throws Exception;
		
		//예약 삭제-
		void deleteReservationApply(ReservationApplyVO vo) throws Exception;

		//예약자 승인 처리-
		void updateReservationConfirm(ReservationApplyVO vo) throws Exception;
		
		//예약 가능 여부 확인
		void rsvCheck(ReservationApplyVO vo) throws Exception;
		
		//기존 신청 여부-
		int duplicateApplyCheck(ReservationApplyVO vo) throws Exception;
		
}
