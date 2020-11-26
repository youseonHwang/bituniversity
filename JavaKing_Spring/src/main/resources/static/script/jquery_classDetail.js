$(function(){

	//학생번호 세션으로 받기
	var std_no = $("#hiddenStdID").val() 
	

	//======== 학점 취득내역
	var getCrd = function(std_no,class_type){
		var crd
		var data = {std_no:std_no, class_type:class_type}	
		$.ajax({url:"/login/detailClassGetCrd.do", async: false, data:data, success:function(res){
			crd = res
		}})
		return crd
	}
	
	
	//======== 필수과목과 취득내역
	var getReq = function(std_no){
		
		var data = {std_no:std_no, class_year:null, classreg_semester:null}	
		var regList =[]
		
		$.ajax({url:"/login/detailClassRegListYS.do", async:false, data:data, success:function(res){
			if(res.length == 0){
				alert("조회내역이 없습니다")
			}else {
				$.each(res,function(idx,item){
					regList.push(item)
				})
			}
		}})
		
		
		var data = {std_no:std_no}	
		$.ajax({url:"/login/detailClassGetReq.do", data:data, success:function(res){
			$.each(res,function(idx,item){
				var tr = $("<tr></tr>")
				var td1 = $("<td></td>").html(item.college_name) 
				var td2 = $("<td></td>").html(item.class_type)
				var td3 = $("<td></td>").html(item.class_level)
				var td4 = $("<td></td>").html(item.class_name+" ("+item.class_no+")")
				var td5 = $("<td></td>").html(item.class_credit)
				var td6 = $("<td></td>")
				var td7 = $("<td></td>")
					$.each(regList, function(k,c){
						if(c.class_no == item.class_no){
							$(td6).html("이수완료")
							$(td7).html(c.classreg_date)
						}
					})
				$(tr).append(td1,td2,td3,td4,td5,td6,td7)
				$(".reqTbody").append(tr)
			})
		}})
	}		
	
	
	//======== 년도/학기별 신청 내역 출력함수
	var getRegList_ys = function(std_no,class_year,classreg_semester){
		$(".SearchTbody").empty()
		
		var data = {std_no:std_no, class_year:class_year, classreg_semester:classreg_semester}	
		$.ajax({url:"/login/detailClassRegListYS.do", async:false, data:data, success:function(res){
			if(res.length == 0){
				alert("조회내역이 없습니다")
			}else {
				$.each(res,function(idx,item){
					var tr = $("<tr></tr>")
					var td1 = $("<td></td>").html(item.class_year) 
					var td2 = $("<td></td>").html(item.classreg_semester)
					var td3 = $("<td></td>").html(item.college_name)
					var td4 = $("<td></td>").html(item.class_type)
					var td5 = $("<td></td>").html(item.class_name+" ("+item.class_no+")")
					var td6 = $("<td></td>").html(item.pro_name)
					var td7 = $("<td></td>").html(item.class_credit)
					var td8 = $("<td></td>").html(item.class_dayofweek+" / "+item.class_time)
					$(tr).append(td1,td2,td3,td4,td5,td6,td7,td8)
					$(".SearchTbody").append(tr)
				})
			}
		}})
	}	
	
// ====== 조회버튼 이벤트

	$("#btnSearch").click(function(){
		var class_year = $("#selectYear").val()
		var classreg_semester = $("#selectSemester").val()
		getRegList_ys(std_no,class_year,classreg_semester)
		console.log(class_year+","+classreg_semester)
	})	



//학점취득내역콜
$(".general-req").html(getCrd(std_no,10))
$(".general-elec").html(getCrd(std_no,11))
$(".major-req").html(getCrd(std_no,0))
$(".major-elec").html(getCrd(std_no,1))
$(".commonTd").html(getCrd(std_no,21))
$(".getTtl").html(getCrd(std_no,null))
getReq(std_no) // 필수과목내역콜
getRegList_ys(std_no,2014,1) // 년도학기별 이수목록콜






})