package egovframework.let.temp.service;

import java.io.Serializable;

import egovframework.com.cmm.ComDefaultVO;


public class TempVO extends ComDefaultVO implements Serializable {

	//ComDefaultVO 는 egov 에서 사용하는 유틸 패키지와 같은 느낌.
	
	
	
	
	private String tempId;
	private String tempVal;
	
	
	public String getTempId() {
		return tempId;
	}
	public void setTempId(String tempId) {
		this.tempId = tempId;
	}
	public String getTempVal() {
		return tempVal;
	}
	public void setTempVal(String tempVal) {
		this.tempVal = tempVal;
	}

	
	
}