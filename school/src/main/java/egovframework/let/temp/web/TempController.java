package egovframework.let.temp.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.let.temp.service.TempService;
import egovframework.let.temp.service.TempVO;

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
	
	@RequestMapping("/temp/tempRegist.do")
	public String tempRegist() throws Exception{
		return "temp/TempRegist";
	}
	
	@RequestMapping("/temp/insert.do")
	public String insert(@ModelAttribute("searchVO") TempVO searchVO) throws Exception{
		tempService.insertTemp(searchVO);
		return "redirect:TempList";
	
	
	}
	
	
	
}
