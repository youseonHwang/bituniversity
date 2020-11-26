$(function(){
	//=================================== class 뷰 ============
	var pageSize = 10 //한페이지 몇개 레코드가 보일지
	var pageNum = 1
	var pageMax = 10 //페이지넘버 몇개까지 보이고 이전,다음 보일지
	var startPage
	var endPage
	
	var search = " "
	var option = "class_name"

	
	//=========search 이벤트
	$("#btnSearch").click(function(){
		search = $("#search").val();
		option = $("#option").val();
		if(search ===""){
			search= " "
			}
		if(option ===""){
			 option = "class_name"
			}
		getItems(1, pageSize, search, option)
		paging(true, search, option) 
		console.log("search: "+search)
		console.log("option: "+option)
	})

	//========== TR 선택 이벤트 - 수정/삭제
	$(document).on("click",".clk tr", function(){
		/* 초기화 */
			$("#aDel").removeAttr("href")
			$("tr").css({"color":"black","background-color": "white"})
			
			/* 본명령 */
			var classno = $(this).attr("classno")
			var urlDel = "adminClassDelete.do?classno="+classno
			$("#hiddenNo_forEdit").val(classno)
			$("#aDel").attr("href",urlDel)
			$(this).css({"color":"white","background-color":"#083B90"})
			
	})
	
		
		
	//==========페이지 선택 이벤트~!
	$(document).on("click","#paging_button > li", function(){
		$("li").removeClass("page-link")
		$("li").css({"color" : "black","background-color":"white","border":"none"})
		
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
		
		
	//==========페이지 생성 함수	
	var paging = function (onOff, search, option){  // 검색누를때 현재 페이지가 1이 아니면 1페이지부터 안떠서 false 옵션 추가
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
			
			var endPage = startPage+pageMax-1;

			if(endPage > totalPage) {
				endPage = totalPage;
			}
			
			if(startPage > 1) {
				var li = $("<li></li>").html("<<").attr({"data-page":startPage-1,"id":"before","class":"page-item"})
				$("#paging_button").append(li)
			}
			for(var i =startPage; i<=endPage; i++){
				var li = $("<li></li>").html(i).attr("data-page",i).addClass("page-item",).css("margin-right","10px")
				$("#paging_button").append(li)
			}
			if(totalPage > endPage) {
				var li = $("<li></li>").html(">>").attr({"data-page":endPage+1,"id":"next","class":"page-item"})
				$("#paging_button").append(li)
			}

		}})

	}

	//=========테이블 생성 함수
	var getItems = function(pageNum,pageSize,search, option){
	
		$("#tbody").empty();
	
		var data = {pageNum:pageNum, pageSize:pageSize, search:search, option:option};
	
		$.ajax({url:"/classList.do",data:data, success:function(res){
			$.each(res,function(idx,item){
				var tr = $("<tr></tr>").attr("classno",item.class_no)
				var td1 = $("<td></td>").html(item.rn)
				var td2 = $("<td></td>").html(item.college_no)
				var td3 = $("<td></td>").html(item.class_level)
				var td4 = $("<td></td>").html(item.class_type)
				var td5 = $("<td></td>").html(item.class_name+" ("+item.class_no+")")
				var td6 = $("<td></td>").html(item.class_credit)
				var td7 = $("<td></td>").html(item.class_startdate+" - "+item.class_enddate)
				var td8 = $("<td></td>").html(item.class_dayofweek+" "+item.class_time)
				var td9 = $("<td></td>").html(item.pro_name+" ("+item.pro_no+")")
				var td10 = $("<td></td>").html(item.class_room)
				var td11 = $("<td></td>").html(item.class_nowcnt+" / "+item.class_max)
				
				var test = $(tr).append(td1,td2,td3,td4,td5,td6,td7,td8,td9,td10,td11)
				$("#tbody").append(tr)
							
			})
	
		}})
	
	}
		

//======================================= insert 뷰
	/* 교수목록 불러오기 */
		$("#pro_type").change(function(){
			$("#proList").html("<option selected='selected'>선택</option>")
			
			if(this.value !== ""){
				var value = $("#pro_type option:selected").val()
				
				$.ajax({url:"/proList",data:{pro_type:value},success:function(res){
					$.each(res,function(idx,item){
						$("#proList").append("<option value='"+item.pro_no+"'>"+item.pro_name+"("+item.pro_no+") </option>")			
					})
				}})
			}

			
			/* 교수목록이 college 와 연동이 되어있지 않아 insert 를 위해 따로 변환. */
			
			var college_no = $("#pro_type").val()
			switch(college_no){
				case "인문학부" : $("#college_no").attr("value","1");break;
				case "사회경영학부" : $("#college_no").attr("value","2");break;
				case "공학부" : $("#college_no").attr("value","3");break;
				case "문화예술학부" : $("#college_no").attr("value","4");break;
				case "공통" : $("#college_no").attr("value","5");break;
			}
			
		})



//======================================= update 뷰

		
	$("#pro_type_update").change(function(){
		var value = $("#pro_type_update option:selected").val();
		$("#proList_update").html("<option hidden disable selected='selected'>선택</option>")
		proList();
		switch_colNo();
	});
	
	
	$(document).on("click","#btnEdit",function(){
		
		var class_no = $("#hiddenNo_forEdit").val()
		if(class_no == '') {
			$(location).attr("href","/admin/class.do")
			alert("수정할 강의를 선택하세요")
			return
		}
		var data = {class_no:class_no}
		$.ajax({url:"/admin/adminClassEdit.do", data:data,success:function(res){
			console.log(res)
			$("#class_no_update").val(res.class_no)
			$("#class_name_update").val(res.class_name)
			$("#class_startdate_update").val(res.class_startdate)
			$("#class_enddate_update").val(res.class_enddate)
			$("#class_dayofweek_update").val(res.class_dayofweek)
			$("#class_time_update").val(res.class_time)
			$("#class_room_update").val(res.class_room)
			$("#class_credit_update").val(res.class_credit)

			$("#class_type_update_op").val(res.class_type)
			$("#class_level_update").val(res.class_level).text(res.class_level)
			$("#changeProType").val(res.college_name).text(res.college_name)
			$("#college_no_update").val(res.college_no)
			$("#pro_no_update").val(res.pro_no).text(res.pro_name+"("+res.pro_no+")")
			$("#class_max_update").val(res.class_max).text(res.class_max)
			$("#changeProType").val(changeProType)	
			proList();
			switch_colNo();
			switch_classType();		
		
		}})
			
	})
	
	
			
	/* 교수목록 불러오기 */
	function proList(){
		var value = $("#pro_type_update option:selected").val();
		if(this.value !== ""){
			$.ajax({url:"/proList",data:{pro_type:value},success:function(res){
				$.each(res,function(idx,item){
					$("#proList_update").append("<option value='"+item.pro_no+"'>"+item.pro_name+"("+item.pro_no+") </option>");			
				});
			}});		
		}
	};
	
	/* 교수목록이 college 와 연동이 되어있지 않아 update 를 위해 따로 변환. */
   function switch_colNo () {
	   var college_no = $("#pro_type_update").val();
		switch(college_no){
			case "인문학부" : $("#college_no_update").attr("value","1");break;
			case "사회경영학부" : $("#college_no_update").attr("value","2");break;
			case "공학부" : $("#college_no_update").attr("value","3");break;
			case "문화예술학부" : $("#college_no_update").attr("value","4");break;
			case "공통" : $("#college_no_update").attr("value","5");break;
		};
	};

	/* 교수목록이 college 와 연동이 되어있지 않아 기입력 정보를 불러오기 위해 따로 변환. */
   function switch_proType() {
	   var pro_type = $("#changeProType").val();
		switch(pro_type){
			case "1" : $("#changeProType").html("인문학부").val("인문학부");break;
			case "2" : $("#changeProType").html("사회경영학부").val("사회경영학부");break;
			case "3" : $("#changeProType").html("공학부").val("공학부");break;
			case "4" : $("#changeProType").html("문화예술학부").val("문화예술학부");break;
			case "5" : $("#changeProType").html("공통").val("공통");break;
		};
		var check = $("#changeProType").text();
		return check;
   };

   /* 불러온 이수구분 숫자->글자로 보이기 */
   function switch_classType() {
		var class_type = $("#class_type_update_op").val();
		switch(class_type){
			case "0" : $("#class_type_update_op").html("전공필수");break;
			case "1" : $("#class_type_update_op").html("전공선택");break;
			case "10" : $("#class_type_update_op").html("교양필수");break;
			case "11" : $("#class_type_update_op").html("교양선택");break;
			case "21" : $("#class_type_update_op").html("일반선택");break;
		}
	   }
	   
	   
//======== 삭제

	$("#btnDel").click(function(){
		var cno = $("#aDel").attr("href")
		if(cno == '') {
			alert("삭제할 강의를 선택하세요")
		}
	})   
	
	
	 
	 
//======== 템플릿 이벤트

$(".py-1").mouseover(function(){
	$(this).addClass("hs-sub-menu-opened")
	$("#classSubMenu").attr("class", "list-inline hs-sub-menu u-header__sub-menu mb-0 animated fadeInUp")
	$("#classSubMenu").attr("style","min-width:200px;")
	
})	

$(".py-1").mouseout(function(){
    $(this).removeClass("hs-sub-menu-opened")
	$("#classSubMenu").attr("class","list-inline hs-sub-menu u-header__sub-menu mb-0 animated fadeOut")   
	$("#classSubMenu").attr("style","min-width:200px; display:none;")   
})		   
	   
		
		
paging(false,search,option)
getItems(1,pageSize, search,option)
})