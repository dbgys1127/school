package egovframework.let.rsv.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.rsv.service.ReservationService;
import egovframework.let.rsv.service.ReservationVO;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class ReservationController {
	
	@Resource(name="reservationService")
	private ReservationService reservationService;
	
	@RequestMapping("/admin/rsv/rsvSelectList.do")
	public String rsvSelectList(@ModelAttribute("searchVO") ReservationVO searchVO, Model model) throws Exception{
	
	PaginationInfo paginationInfo = new PaginationInfo();
	paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
	paginationInfo.setPageSize(searchVO.getPageSize());
	
	searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
	searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
	List<EgovMap> resultList = reservationService.selectReservationList(searchVO);
	model.addAttribute("resultList", resultList);
	
	int totCnt = reservationService.selectReservationListCnt(searchVO);
	paginationInfo.setTotalRecordCount(totCnt);
	model.addAttribute("paginationInfo", paginationInfo);
	
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	model.addAttribute("USER_INFO", user);
	
	return "admin/rsv/RsvSelectList";
	}
	
	@RequestMapping("/admin/rsv/rsvRegist.do")
	public String rsvRegist(@ModelAttribute("searchVO") ReservationVO ReservationVO, Model model, HttpServletRequest request) throws Exception{
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if(user == null) {
			model.addAttribute("message", "로그인 후 사용가능합니다");
			return "forward:/admin/rsv/rsvSelectList.do";
		}else {
			model.addAttribute("USER_INFO", user);
		}
		
		ReservationVO result = new ReservationVO();
		if(!EgovStringUtil.isEmpty(ReservationVO.getResveId())) {
			result = reservationService.selectReservation(ReservationVO);
		}
		model.addAttribute("result", result);
		request.getSession().removeAttribute("sessionReservation");
		
		return "admin/rsv/RsvRegist";
	}
	
	
	@RequestMapping("/admin/rsv/rsvInsert.do")
	public String insert(@ModelAttribute("searchVO") ReservationVO searchVO, Model model, HttpServletRequest request) throws Exception{
		//이중 서브밋 방지 체크
		if(request.getSession().getAttribute("sessionReservation") != null) {
			return "forward:/admin/rsv/rsvSelectList.do";
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if(user == null) {
			model.addAttribute("message", "로그인 후 사용가능합니다.");
			return "forward:/admin/rsv/rsvSelectList.do";
		}
		
		searchVO.setUserId(user.getId());
		
		reservationService.insertReservation(searchVO);
		
		//이중 서브밋 체크
		request.getSession().setAttribute("sessionReservation", searchVO);
		return "forward:/admin/rsv/rsvSelectList.do";
	}
	
	//예약 정보 수정
	@RequestMapping("/admin/rsv/rsvUpdate.do")
	public String rsvUpdate(@ModelAttribute("searchVO") ReservationVO searchVO, Model model, HttpServletRequest request) throws Exception{
		if(request.getSession().getAttribute("sessionReservation") != null) {
			return "forward:/admin/rsv/rsvSelectList.do";
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if(user == null) {
			model.addAttribute("message", "로그인 후 사용가능합니다.");
			return "forward:/admin/rsv/rsvSelectList.do";
		}
		
		searchVO.setUserId(user.getId());
		
		reservationService.updateReservation(searchVO);
		
		//이중 서브밋 체크
		request.getSession().setAttribute("sessionReservation", searchVO);
		return "forward:/admin/rsv/rsvSelectList.do";
	}
	
	@RequestMapping("/admin/rsv/rsvDelete.do")
	public String rsvDelete(@ModelAttribute("searchVO") ReservationVO searchVO, Model model, HttpServletRequest request) throws Exception{
		
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		if(user == null) {
			model.addAttribute("message", "로그인 후 사용가능합니다.");
			return "forward:/admin/rsv/rsvSelectList.do";
		}
		searchVO.setUserId(user.getId());
		
		reservationService.deleteReservation(searchVO);
		
		return "forward:/admin/rsv/rsvSelectList.do";
	}
	
}
