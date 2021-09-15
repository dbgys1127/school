package egovframework.let.temp.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.let.temp.service.TempService;
import egovframework.let.temp.service.TempVO;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class TempController {
	
	@Resource(name ="tempService")
	private TempService tempService;
	
	@RequestMapping("/temp/select.do")
	public String select(@ModelAttribute("searchVO") TempVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		model.addAttribute("searchVO", searchVO);
		
		TempVO result = tempService.selectTemp(searchVO);
		
		
		model.addAttribute("result", result);
		
		return "temp/TempSelect";
	}

	
	//임시데이터 등록 및 수정 - 등록과 수정이 한 컨트롤러 안에서 됨.
	@RequestMapping("/temp/tempRegist.do")
	public String tempRegist(@ModelAttribute("searchVO") TempVO tempVO,  HttpServletRequest request, Model model) throws Exception{
		TempVO result = new TempVO();
		if(!EgovStringUtil.isEmpty(tempVO.getTempId() )) {
			result = tempService.selectTemp(tempVO);
		}
		model.addAttribute("result", result);
		
		return "temp/TempRegist";
	}
	
	
	@RequestMapping("/temp/insert.do")
	public String insert(@ModelAttribute("searchVO") TempVO searchVO) throws Exception{
		tempService.insertTemp(searchVO);
		return "redirect:TempList";
	
	
	}
	
	//임시데이터 리스트로 가져옴
	@RequestMapping("/temp/selectList.do")
	public String selectList(@ModelAttribute("searchVO") TempVO searchVO, HttpServletRequest request, Model model) throws Exception{
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<EgovMap> resultList = tempService.selectTempList(searchVO);
		model.addAttribute("resultList", resultList);
		
		int totCnt = tempService.selectTempListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo",paginationInfo);
		
		return "temp/TempSelectList";
		
		
	}
	

	
	@RequestMapping("/temp/update.do")
	public String update(@ModelAttribute("searchVO") TempVO searchVO,  HttpServletRequest request, Model model) throws Exception{
		tempService.updateTemp(searchVO);
		return "forward:/temp/selectList.do";
	}
	
	@RequestMapping("/temp/delete.do")
	public String delete(@ModelAttribute("searchVO") TempVO searchVO,  HttpServletRequest request, Model model) throws Exception{
		tempService.deleteTemp(searchVO);
		return "forward:/temp/selectList.do";
	}
	
	
	
}
