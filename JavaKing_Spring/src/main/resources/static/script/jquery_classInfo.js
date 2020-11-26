$(function(){
	$(".title").click(function(){
		$(".page").empty()
		$(".page").attr("visibility","hidden")
		$(".page").css("height",0)
		var colNo =Number( $(this).attr("collegeno") )

		$.ajax({url:"/classInfoList.do", data:{colNo:colNo}, success:function(res){
				var cnt = 0
			$.each(res,function(idx,item){
				cnt++
				var check = Number(cnt% 7)  // 한줄에 7개씩 표현
				console.log("cnt: "+cnt+"나머지:"+check)
								
				if(check == 0){ 
					var p = $()
					$("#page"+colNo).append(item.class_name+" | <br><br>")
				}else {
					$("#page"+colNo).append(item.class_name+" | ")
				}
			})
			$("#page"+colNo).css({"visibility":"visible","font-size":"12px"});
			$("#page"+colNo).animate({
				height:500
			},500);
		}})
	})
})