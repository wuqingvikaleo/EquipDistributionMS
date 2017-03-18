<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%-- <%@ page language="java" import="com.guanghua.ywgl.util.SessionUtil"%> --%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cabinetId=request.getParameter("cabinetId");//cabinetId
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <jsp:include page="/jspRef/MainFrameworkRef.jsp"></jsp:include>
    <script  type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.form.js"></script>
    <title>导入板卡</title>
     
	<style type="text/css">
	.btn {
		border-right: #7b9ebd 1px solid;
		padding-right: 2px;
		border-top: #7b9ebd 1px solid;
		padding-top: 2px;
		border-left: #7b9ebd 1px solid;
		padding-left: 2px;
		border-bottom: #7b9ebd 1px solid;
		font-size: 12px;
		color: black;
		filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#cecfde);
		cursor: expression((this.type == 'file')?'':'hand');
	}
	.fi {
		border-right: #7b9ebd 1px solid;
		padding-right: 2px;
		border-top: #7b9ebd 1px solid;
		padding-top: 2px;
		border-left: #7b9ebd 1px solid;
		padding-left: 2px;
		border-bottom: #7b9ebd 1px solid;
		font-size: 12px;
		color: black;
	}
	</style>

  </head>
  
  <body>
  <SCRIPT type="text/javascript">
	function addFileInput(obj) {
		obj.insertAdjacentHTML("beforeBegin", "<input type='file' name='file' size='36' class='fi' onchange='javascript:validFileName(this)'/><input type='button' style='width:40px;height:20px' value='去除' class='btn' onclick='javascript:removeFileInput(this)'/><br>");
	}

	function removeFileInput(obj) {
		obj.previousSibling.removeNode();
		obj.nextSibling.removeNode();
		obj.removeNode();
	}
	
	function validFileName(obj) {
		var v = obj.value;
		var os = document.getElementsByName('file');
		for (var i = 0; i < os.length; i ++) {
			if (obj != os[i] && v == os[i].value) {
				//alert("您选择的文件重复,请确认是否一定要上传两个相同的文件");
				break;
			}
		}
	}
	function resetFile(){ 
        	var html=document.getElementById('uploadFileTd').innerHTML; 
			document.getElementById('uploadFileTd').innerHTML=html; 
		} 

	function subimtBtn() {  
		var equipId=$("#equipId").combobox("getValue");
		if(equipId==null ||equipId==""){
			alert("请选择设备再导入!");
		}else{
			//判断是否选择了文件
			if($("#uploadFile").val() == ""){
				alert("请选择文件!");
			}else{
				//alert("daoru");
				var filename=$("#uploadFile").val();
				var xlss = filename.toLowerCase().substr(filename.lastIndexOf(".")); 
				if(xlss!=".xls"&&xlss!=".xlsx"){
					alert("请选择以.xls和.xlsx结尾的表格文件导入！");
					return;
				}else{
					//alert(filename+"   "+xlss);
					$("#uploadFileForm").attr('action','<%=path%>/bkxx/cardinfo_import.action?equipId='+equipId);
					$("#uploadFileForm").submit();
				}
			}
		}
	
    }
	//导出模板
	function exc(){
		//window.location='${pageContext.request.contextPath}/ywgl/platform/cardResourceInfo.xls';
		var strUrl = '<%=path%>/jgxx/doExport.action?filename='+encodeURI(encodeURI("板卡模板"));
		window.location.href=strUrl;
	}
	
</SCRIPT>
    <center>
		<!-- <form id="commentUploadFileForm" name="commentUploadFileForm"  enctype="multipart/form-data" method="POST">
		 -->	<table border="0" cellspacing="0" cellpadding="0" style="border:1px solid #CCCCCC;" width="350">
				<tr><td height="10"></td></tr>
				<tr>
					<td align="center">
					<%-- <input type="hidden" name="globe.fileupload.objectid" value="${param.objectId}"/>
					<input type="hidden" name="globe.fileupload.objecttype" value="${param.objectType}"/>
					<input type="hidden" name="globe.fileupload.beanid" value="${param.beanId}"/>
					<input type="hidden" name="uploaderId" value="${param.uploaderId}"/>
				
					<input type="file" id="file" name="file" size="44" class="fi" onchange="javascript:validFileName(this)" /><br>
					 --%>
					 <form id="uploadFileForm" enctype="multipart/form-data" class="form-horizontal" method="post" >
						<table border="0" cellspacing="0" cellpadding="0" style="border:1px solid #CCCCCC;" width="350">
						<tr><td height="10">选择设备：<input class="easyui-combobox" id="equipId" name="equipId"  style="width:300px"></input></td></tr>
						<tr><td align="center">
							<label for="lastname" class="col-sm-2 control-label">选择要上传的文件</label>
							<div class="col-sm-10">
								<input id="uploadFile" name="uploadFile" id="uploadFile" type="file" class="form-control">
							</div>
						</td></tr>
						<tr><td height="10"></td></tr>
						</table>
					</form>
					<input type="button" class="btn" value="导入" style="width:60px" onclick="javascript:subimtBtn();"/>
					
				<!-- <input type="hidden" id="txtFile" name="txtFile"></input> -->
					</td>
				</tr>
				<tr>
					<td align="left">
					  <a href="javascript:void(0);" onclick="exc();">模板导出</a>
					</td>
				</tr>
				<tr><td height="10"></td></tr>
			</table>
		<!-- </form> -->
		</center>
  </body>
   <SCRIPT type="text/javascript">
  
  $('#equipId').combobox({
		url:'<%=path%>/bkxx/equipment_list_search.action?cabinetId=<%=cabinetId%>',
	    valueField:'EQUIP_ID',
	    textField:'equipname',
	   //select equip_id,concat(equip_name,concat('--',cabinet_surface)) from tlmanage.jfzs_equipment_manage where cabinet_id=4
	    method:'get'
	});
	</SCRIPT>
</html>
