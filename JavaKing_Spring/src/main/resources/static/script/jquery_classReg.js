$(function(){

	var class_no = "" //tr 누를 시 들어감
	var classreg_no = ""//tr 누를 시 들어감
	var std_no = $("#hiddenStdID").val() //학생번호 세션으로 받기	
	
//신청내역란		
	var RegpageSize = 5
	var RegpageNum = 1
	var RegpageMax = 5
	var RegstartPage
	var RegendPage
	
	
//검색란	
	var pageSize = 10 //한페이지 몇개 레코드가 보일지
	var pageNum = 1
	var pageMax = 10 //페이지넘버 몇개까지 보이고 이전,다음 보일지
	var startPage
	var endPage
	
	var search = " "
	var option = "class_name"

	
	
	//==========TR 선택 이벤트 classno, classregno 선택
	$(document).on("click",".clk tr", function(){
			/* 초기화 */
			$("tr").css({"color":"black", "background-color": "white"})
			
			/* 본명령 */
			class_no = $(this).attr("classno")
			classreg_no = $(this).attr("classregno")
			$(this).css({"color":"white", "background-color":"#083B90"})
			
	})
		
		
	
	
	
	//========= 학생정보 테이블 생성 함수
	var getStd = function(std_no){
	
		$.ajax({url:"/callStdInfo.do", data:{std_no}, success:function(res){
				var tr = $("<tr></tr>")
				var td1 = $("<td></td>").html(res.std_level) 
				var td2 = $("<td></td>").html(res.std_no) 
				var td3 = $("<td></td>").html(res.std_name) 
				var td4 = $("<td></td>").html(res.major_name+" / "+res.college_name) 
				var td5 = $("<td></td>").html(res.std_status) 
				$(tr).append(td1,td2,td3,td4,td5)
				$("#Stdtbody").append(tr)
			
		
		
		//년도,학기 추가
		var date = new Date()
		var year = date.getFullYear() 
		var semester = res.std_semester
		
		$("#spanYear").html(year)
		$("#spanSemester").html(semester)
		
	
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
	
	//신청내역 페이지 선택 이벤트 ~!
	$(document).on("click","#Reg_paging_button > li", function(){
		$("#Reg_paging_button > li").removeClass("page-link")
		$("#Reg_paging_button > li").css({"color" : "black","background-color":"white","border":"none"})
		
		RegpageNum = $(this).attr("Regdata-page")
		getRegList(std_no,RegpageSize,RegpageNum)
		$(this).addClass("page-link")
		$(this).css({"color" : "white","background-color":"#083B90", "border":"1px solid #083B90","border-radius":"10px"})
		
		
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
		$("#Reg_paging_button").empty();
		var RegtotalItem = getRegCnt(std_no)
		var RegtotalPage = Math.ceil(RegtotalItem/RegpageSize)
		RegstartPage = (RegpageNum-1)/RegpageMax*RegpageMax+1;
		RegendPage = RegstartPage+RegpageMax-1;

		if(RegendPage > RegtotalPage) {
			RegendPage = RegtotalPage;
		}
		
		if(RegstartPage > 1) {
			var li = $("<li></li>").html("<<").attr({"Regdata-page":RegstartPage-1,"id":"Regbefore","class":"page-item"})
			$("#Reg_paging_button").append(li)
		}
		for(var i =RegstartPage; i<=RegendPage; i++){
			var li = $("<li></li>").html(i).attr("Regdata-page",i).addClass("page-item").css("margin-right","10px")
			$("#Reg_paging_button").append(li)
		}
		if(RegtotalPage > RegendPage) {
			var li = $("<li></li>").html(">>").attr({"Regdata-page":RegendPage+1,"id":"Regnext","class":"page-item"})
			$("#Reg_paging_button").append(li)
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
	
	
	//수강신청 이벤트, 신청 버튼 누를 때 수강인원 증가 
	$("#btnAdd").click(function(){
		
		if(class_no =="") {
			alert("신청할 강의를 선택하세요")
			return
		}
	
		var data = {std_no:std_no,class_no:class_no}
		$.ajax({url:"/login/classregInsert.do",data:data, success:function(res){
			var re = res
			if(re < 0){
				alert("신청 실패했습니다!")
			}else {
				alert("신청 되었습니다.")
				getRegList(std_no,RegpageSize,RegpageNum)
				getItems(pageNum, pageSize, search,option) 
				Regpaging(std_no)
			}
		}})
		
	})
	
	//==========과목검색 페이지 선택 이벤트 ~!
	$(document).on("click","#paging_button > li", function(){
		$("#paging_button > li").removeClass("page-link")
		$("#paging_button > li").css({"color" : "black","background-color":"white","border":"none"})
		
		pageNum = $(this).attr("data-page")
		getItems(pageNum, pageSize, search, option)
		$(this).addClass("page-link")
		$(this).css({"color" : "white","background-color":"#083B90", "border":"1px solid #083B90","border-radius":"10px"})
	})
	
	$(document).on("click","#before",function(){
		pageNum = $(this).attr("data-page")
		paging(true, search,option)
	})
	
	$(document).on("click","#next",function(){
		pageNum = $(this).attr("data-page")
		paging(false, search,option)
	})
		
		
	//과목검색 페이지 생성 함수	
	var paging = function (onOff, search, option){  // 검색누를때 현재 페이지가 1이 아니면 1페이지부터 안떠서 onOff 옵션 추가
		$("#paging_button").empty();
		var data = {search:search, option:option}
		$.ajax({url: "/getTotalRecord.do", data:data, success:function(data){
			var totalItem = Number(data)
			var totalPage = Math.ceil(totalItem/pageSize)
			if(onOff == false){
				startPage = (pageNum-1)/pageMax*pageMax+1;
			}else{
				startPage = 1
				}
			
			var endPage = startPage+pageMax-1

			if(endPage > totalPage) {
				endPage = totalPage;
			}
			
			if(startPage > 1) {
				var li = $("<li></li>").html("<<").attr({"data-page":startPage-1,"id":"before","class":"page-item"})
				$("#paging_button").append(li)
			}
			for(var i =startPage; i<=endPage; i++){
				var li = $("<li></li>").html(i).attr("data-page",i).addClass("page-item").css("margin-right","10px")
				$("#paging_button").append(li)
			}
			if(totalPage > endPage) {
				var li = $("<li></li>").html(">>").attr({"data-page":endPage+1,"id":"next","class":"page-item"})
				$("#paging_button").append(li)
			}

		}})

	}

	
	//과목검색 테이블 생성 함수
	var getItems = function(pageNum,pageSize,search, option){
	
		$("#Searchtbody").empty()
		
		var data = {pageNum:pageNum, pageSize:pageSize, search:search, option:option};
	
		$.ajax({url:"/classList.do",data:data, success:function(res){
			$.each(res,function(idx,item){
				var tr = $("<tr></tr>").attr("classno",item.class_no)
				var td1 = $("<td></td>").html(item.college_no)
				var td2 = $("<td></td>").html(item.class_level)
				var td3 = $("<td></td>").html(item.class_type)
				var td4 = $("<td></td>").html(item.class_name+" ("+item.class_no+")")
				var td5 = $("<td></td>").html(item.class_credit)
				var td6 = $("<td></td>").html(item.class_dayofweek+" "+item.class_time)
				var td7 = $("<td></td>").html(item.class_room)
				var td8 = $("<td></td>").html(item.pro_name)
				var td9 = $("<td></td>").html(item.class_nowcnt+" / "+item.class_max)
				
				$(tr).append(td1,td2,td3,td4,td5,td6,td7,td8,td9)
				$("#Searchtbody").append(tr)
								
			})
	
		}})
			
	}
	
	
	//과목검색 search 이벤트
	$("#btnSearch").click(function(){
		search = $("#search").val()
		option = $("#option").val()
		if(search ===""){
			search= " "
			}
		if(option ===""){
			 option = "class_name"
			}
		getItems(1, pageSize, search, option)
		paging(true, search,option) 
	})
	
	
	//삭제 버튼 누를 때 수강인원 감소, 수강삭제 이벤트
	$("#btnDel").click(function(){
		
		if(classreg_no =="") {
			alert("삭제할 강의를 선택하세요")
			return
		}
		var data = {std_no:std_no,classreg_no:classreg_no,class_no:class_no}
		
		$.ajax({url:"/login/classregDel.do",data:data, success:function(res){
			var re = res
			if(re < 0){
				alert("삭제 실패했습니다.")
			}else {
				alert("삭제 되었습니다.")
				Regpaging(std_no)
				getRegList(std_no,RegpageSize,RegpageNum)
				getItems(pageNum, pageSize, search,option) 
			}
		}})
	})
	



getStd(std_no) //학생정보콜		
getRegList(std_no,RegpageSize,RegpageNum) //신청내역콜 (신청학점,갯수포함)
Regpaging(std_no) //신청내역 페이징 콜
getItems(1,pageSize, search,option) //서치내역콜
paging(false,search,option)//서치내역 페이징 콜
})