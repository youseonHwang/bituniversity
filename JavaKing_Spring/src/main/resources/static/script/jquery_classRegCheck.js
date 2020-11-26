$(function(){

	//학생번호 세션으로 받기
	var std_no = $("#hiddenStdID").val() 	
	
	//신청내역란		
	var RegpageSize = 100 //한쪽에 몇개보일지
	var RegpageNum = 1
	var RegpageMax = 5 //페이지 몇개까지보일지
	var RegstartPage
	var RegendPage
	

//========= 출력버튼 이벤트
	$("#btnPrint").click(function(){
	document.body.innerHTML = printArea.innerHTML;
	window.print();
	location.reload();
	
	})


//========= 학생정보 테이블 생성 함수
	var getStd = function(std_no){
	
		$.ajax({url:"/callStdInfo.do", data:{std_no}, success:function(res){
				var tr = $("<tr></tr>")
				var td1 = $("<td></td>").html(res.std_level) 
				var td2 = $("<td></td>").html(res.major_name+" / "+res.college_name) 
				var td3 = $("<td></td>").html(res.std_name) 
				var td4 = $("<td></td>").html(res.std_no) 
				var td5 = $("<td></td>").html(res.std_status) 
				$(tr).append(td1,td2,td3,td4,td5)
				$("#Stdtbody").append(tr)
			
		
		
		//년도,학기 추가
		var date = new Date()
		var year = date.getFullYear() 
		var semester = res.std_semester
		var month = date.getMonth()
		var date = date.getDate()
		
		$("#spanYear").html(year)
		$("#spanSemester").html(semester)
		$("#todayY").html(year)
		$("#todayM").html(month)
		$("#todayD").html(date)
		
	
		}})
	}
	

//======== 오늘 신청한 내역의 테이블 생성 함수
	var getRegList = function(std_no,RegpageSize,RegpageNum){
		$("#Regtbody").empty();
		
		var data = {std_no:std_no, pageSize:RegpageSize, pageNum:RegpageNum}	
		$.ajax({url:"/login/getRegList.do", data:data, success:function(res){
			$.each(res,function(idx,item){
				var tr = $("<tr></tr>").attr({"classregno":item.classreg_no,"classno":item.class_no})
				var td1 = $("<td></td>").html(item.std_level) 
				var td2 = $("<td></td>").html(item.class_type)
				var td3 = $("<td></td>").html(item.class_name+" ("+item.class_no+")")
				var td4 = $("<td></td>").html(item.class_credit)
				var td5 = $("<td></td>").html(item.class_dayofweek+" "+item.class_time)
				var td6 = $("<td></td>").html(item.class_room)
				var td7 = $("<td></td>").html(item.pro_name)
				var td8 = $("<td></td>").html(item.classreg_retake)
				$(tr).append(td1,td2,td3,td4,td5,td6,td7,td8)
				$("#Regtbody").append(tr)
			})
			getRegCnt(std_no)
			getRegCredit(std_no)
			
		}})
	}
	
	//신청내역 페이지 선택 이벤트
	$(document).on("click",".Reg_paging_button > li", function(){
		$(".Reg_paging_button > li").css({"color" : "black"});
		RegpageNum = $(this).attr("Regdata-page")
		getRegList(std_no,RegpageSize,RegpageNum)
		$(this).css({"color":"#d1d1d1"});
	})
	
	$(document).on("click","#Regbefore",function(){
		RegpageNum = $(this).attr("Regdata-page")
		Regpaging(search,option)
	})
	
	$(document).on("click","#Regnext",function(){
		RegpageNum = $(this).attr("Regdata-page")
		Regpaging(std_no)
	})
		
		
	//신청내역 페이지 생성 함수	
	var Regpaging = function (std_no){
		$(".Reg_paging_button").empty();
		var RegtotalItem = getRegCnt(std_no)
		var RegtotalPage = Math.ceil(RegtotalItem/RegpageSize)
		RegstartPage = (RegpageNum-1)/RegpageMax*RegpageMax+1;
		RegendPage = RegstartPage+RegpageMax-1;

		if(RegendPage > RegtotalPage) {
			RegendPage = RegtotalPage;
		}
		
		if(RegstartPage > 1) {
			var li = $("<li></li>").html("<<").attr({"Regdata-page":RegstartPage-1,"id":"Regbefore"})
			$(".Reg_paging_button").append(li)
		}
		for(var i =RegstartPage; i<=RegendPage; i++){
			var li = $("<li></li>").html(i).attr("Regdata-page",i)
			$(".Reg_paging_button").append(li)
		}
		if(RegtotalPage > RegendPage) {
			var li = $("<li></li>").html(">>").attr({"Regdata-page":RegendPage+1,"id":"Regnext"})
			$(".Reg_paging_button").append(li)
		}
	}
	
	
	//오늘 신청한 강의 갯수 출력
	var getRegCnt = function(std_no){
		var regcnt		
		
		$.ajax({url:"/login/getRegCnt.do", async: false, data:{std_no}, success:function(res){
				$("#cnt").html(res)
				regcnt = res
		}})
		return regcnt
	}
	//오늘 신청한 학점 출력
	var getRegCredit = function(std_no){
	
		$.ajax({url:"/login/getRegCredit.do", data:{std_no}, success:function(res){
				$("#crd").html(res)
		}})
	}
	


getStd(std_no) //학생정보콜	
getRegList(std_no,RegpageSize,RegpageNum)	//신청내역 콜
})