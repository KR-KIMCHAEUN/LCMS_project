package kr.or.ddit.manager.com.calendar.academiccalendar.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.student.info.service.InfoMainService;
import kr.or.ddit.vo.common.CalendarVO;

@Controller
@RequestMapping("manager/info/acaCalendar")
public class AcademicCalendarControllerM {
	
	@Inject
	private InfoMainService service;
	
	@GetMapping
	public String calendar() {
		
		return "tiles:manager/com/calendar/academiccalendar/acaCalendar";
	}
	
    @GetMapping("getInfo")
    public String main( Model model) {
    	
    	List<CalendarVO> aList= service.retrieveAList();
    	model.addAttribute("aList", aList);
    	
    	return "jsonView";
    }

}
