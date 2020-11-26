$(function(){

	var pageSize = 10 //한페이지 몇개 레코드가 보일지
	var pageNum = 1
	var pageMax = 10 //페이지넘버 몇개까지 보이고 이전,다음 보일지
	var startPage
	var endPage
	
	var search = " "
	var option = "class_name"


	//==========페이지 선택 이벤트 ~!
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
				var li = $("<li></li>").html(i).attr("data-page",i).addClass("page-item").css("margin-right","10px")
				$("#paging_button").append(li)
			}
			if(totalPage > endPage) {
				var li = $("<li></li>").html(">>").attr({"data-page":endPage+1,"id":"next","class":"page-item"})
				$("#paging_button").append(li)
			}

		}})

	}

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
		paging(true, search,option) 
	})
	
	
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
		
		
		
paging(false,search,option)
getItems(1,pageSize, search,option)

})