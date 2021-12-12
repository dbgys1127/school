package egovframework.let.rsv.web;

import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.rsv.service.ReservationApplyService;
import egovframework.let.rsv.service.ReservationApplyVO;
import egovframework.let.rsv.service.ReservationService;
import egovframework.let.rsv.service.ReservationVO;
import egovframework.rte.fdl.string.EgovStringUtil;
import net.sf.json.JSONObject;

@Controller
public class ReservationApplyController {
	
	@Resource(name="reservationServiceApply")
	private ReservationApplyService reservationServiceApply;
	
	@Resource(name="reservationService")
	private ReservationService reservationService;
	
	
	//예약정보 등록 및 수정
	@RequestMapping("/rsv/rsvApplyRegist.do")
	public String rsvApplyRegist(@ModelAttribute("searchVO") ReservationApplyVO ReservationApplyVO, Model model, HttpServletRequest request) throws Exception{
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if(user == null) {
			model.addAttribute("message", "로그인 후 사용가능합니다");
			return "forward:/rsv/selectList.do";
		}else {
			model.addAttribute("USER_INFO", user);
		}
		
		//프로그램 정보
		ReservationVO reservation = new ReservationVO();
		if(!EgovStringUtil.isEmpty(ReservationApplyVO.getResveId())) {
			reservation = reservationService.selectReservation(ReservationApplyVO);
		}
		model.addAttribute("reservation", reservation);
		
		//예약정보
		ReservationApplyVO result = new ReservationApplyVO();
		if(!EgovStringUtil.isEmpty(ReservationApplyVO.getResveId())) {
			result = reservationServiceApply.selectReservationApply(ReservationApplyVO);
		}
		model.addAttribute("result", result);
		
		request.getSession().removeAttribute("sessionReservation");
		
		return "rsv/RsvApplyRegist";
	}
	
	
	
	//예약자 정보 등록하기
	@RequestMapping("/rsv/rsvApplyInsert.do")
	public String rsvApplyinsert(@ModelAttribute("searchVO") ReservationApplyVO searchVO, Model model, HttpServletRequest request) throws Exception{
		//이중 서브밋 방지 체크
		if(request.getSession().getAttribute("sessionReservationApply") != null) {
			return "forward:/rsv/selectList.do";
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if(user == null) {
			model.addAttribute("message", "로그인 후 사용가능합니다.");
			return "forward:/rsv/selectList.do";
		}
		searchVO.setUserId(user.getId());
		searchVO.setCreatIp(request.getRemoteAddr());
		
		ReservationApplyVO result = reservationServiceApply.insertReservationApply(searchVO);
		
		if(!EgovStringUtil.isEmpty(result.getErrorCode())) {
			model.addAttribute("message", result.getMessage());
		}else {
			model.addAttribute("message", "신청완료 되었습니다.");
		}
		
		//이중 서브밋 체크
		request.getSession().setAttribute("sessionReservationApply", searchVO);
		return "forward:/rsv/selectList.do";
	}
	
	

	//예약 정보 수정
	@RequestMapping("/rsv/rsvApplyUpdate.do")
	public String rsvApplyUpdate(@ModelAttribute("searchVO") ReservationApplyVO searchVO, Model model, HttpServletRequest request) throws Exception{
		
		//이중 서브밋 방지
		if(request.getSession().getAttribute("sessionReservationApply") != null) {
			return "forward:/rsv/selectList.do";
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if(user == null) {
			model.addAttribute("message", "로그인 후 사용가능합니다.");
			return "forward:/rsv/selectList.do";
		}
		
		searchVO.setUserId(user.getId());
		
		reservationServiceApply.updateReservationApply(searchVO);
		
		//이중 서브밋 체크
		request.getSession().setAttribute("sessionReservationApply", searchVO);
		return "forward:/rsv/selectList.do";
	}

	
	

	//예약정보 삭제하기
	@RequestMapping("/rsv/rsvApplyDelete.do")
	public String rsvApplyDelete(@ModelAttribute("searchVO") ReservationApplyVO searchVO, Model model, HttpServletRequest request) throws Exception{
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if(user == null) {
			model.addAttribute("message", "로그인 후 사용가능합니다.");
			return "forward:/rsv/selectList.do";
		}
		searchVO.setUserId(user.getId());
		
		reservationServiceApply.deleteReservationApply(searchVO);
		
		return "forward:/rsv/selectList.do";
	}
		
	
	
	//예약여부 체크
	@RequestMapping("/rsv/rsvCheck.json")
	public void rsvCheck(@ModelAttribute("searchVO") ReservationApplyVO searchVO, Model model, HttpServletResponse response ,HttpServletRequest request) throws Exception{
		String successYn = "Y";
		String message = "성공";
		
		JSONObject jo = new JSONObject();
		
		response.setContentType("text/javascript; charset=utf-8");
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if(user == null) {
			successYn = "N";
			message = "로그인 후 사용 가능합니다";
		}
		searchVO.setUserId(user.getId());
		
		ReservationApplyVO result = reservationServiceApply.rsvCheck(searchVO);
		if(!EgovStringUtil.isEmpty(result.getErrorCode())) {
			successYn = "N";
			message = result.getMessage();
		}
		
		jo.put("successYn", successYn);
		jo.put("message", message);
		
		// TODO : PrintWriter
		PrintWriter printwriter = response.getWriter();
		printwriter.println(jo.toString());
		printwriter.flush();
		printwriter.close();
	}
	
	
	
}
