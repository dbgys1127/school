package egovframework.let.temp.service;

import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface TempService {

	public TempVO selectTemp(TempVO vo) throws Exception;

	public String insertTemp(TempVO searchVO) throws Exception;

	//임시데이터를 리스트 형태로 가져옴
	public List<EgovMap> selectTempList(TempVO vo) throws Exception;
	
	//임시데이터 목록 수 
	public int selectTempListCnt(TempVO vo) throws Exception;
	
	//임시데이터 수정하기
	public void updateTemp(TempVO vo) throws Exception;
	
	//임시데이터 삭제하기
	public void deleteTemp(TempVO vo) throws Exception;

	
}
