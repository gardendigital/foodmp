<link type="text/css" href="/skin/red/css/swfupload.css" rel="stylesheet" media="screen"/>
<script type="text/javascript" src="/skin/red/js/swfupload.js"></script>
<script type="text/javascript" src="/skin/red/js/jquery-asyncUpload-0.1.js"></script>
<script>
var StoreID = "{$smarty.session.ShopID}";
var soc_http_host="{$soc_http_host}";
</script>
{literal}
<script language="javascript">
function checkemailform() {
	if($('#own_name').val()==""){
		alert('Own Name is required.');
		return false;
	}
	if($('#own_email').val()==""){
		alert('Own Email is required.');
		return false;
	}else{
		if(!ifEmail($('#own_email').val(),false)){
			alert('Own Email is invalid.');
			return false;
		}
	}
	if($('#is_choose_upload').val()!="0"){
		if($('#is_csv_upload').val()=="0"){
			alert("CSV file is invalid.");
			return false;
		}
	}
	$("#ref_submit").attr('disabled','disabled');
	$("#ref_form").attr('target','_self');
	$("#optval").val('send');
	document.ref_form.submit();
	return true;
}
function ifEmail(str,allowNull){
	if(str.length==0) return allowNull;
	i=str.indexOf("@");
	j=str.lastIndexOf(".");
	if (i == -1 || j == -1 || i > j) return false;
	return true;
}
function showtabfunc(obj){
	if(obj=='uploadtab'){
		$('#normaltab').hide();
		$('#is_choose_upload').val(1);
	}else{
		$('#uploadtab').hide();
		$('#is_choose_upload').val(0);
	}
	$('#'+obj).show();
}
$(function() {
	$("#csvupload").makeAsyncUploader({
		upload_url: soc_http_host+"uploadcsvemail.php?type=referrer&StoreID="+StoreID,
		flash_url: '/skin/red/js/swfupload.swf',
		button_image_url: '/skin/red/images/blankButton.png',
		disableDuringUpload: 'INPUT[type="submit"]',
		file_types:'*.csv',
		file_size_limit:'10MB',
		file_types_description:'CSV files',
		button_window_mode:"transparent",
		button_text:"",
		height:"29",
		debug:false
	});
});
function uploadresponse(response){
	var aryResult = response.split('|');
	if(parseInt(aryResult[0])>0){
		$('#is_csv_upload').val(1);
	}else{
		$('#is_csv_upload').val(0)
	}
	$('#uploadmsg').html(aryResult[1]);
}
function uploadprocess(bl){
	if(!bl){
		$('INPUT[type="submit"]').css('background','url(/skin/red/images/buttons/gray-submit.gif)');
	}else{
		$('INPUT[type="submit"]').css('background','url(/skin/red/images/buttons/or-submit.gif)');
	}
}
function sendOnkeyDown(event)
{
	if (event.keyCode==13) 
	{ 
		return checkemailform();
	} 
	return true;
}
</script>
<style>
#messagebox {
	background-color: #DE1111;
    border-radius: 10px 10px 10px 10px;
    color: #FFFFFF;
    font-weight: bold;
    margin-bottom: 10px;
    padding: 10px;
}
#ref_form table td {
	padding: 5px;
}
</style>
{/literal}
<div>
	 {if $smarty.get.msg}
	<div align="center" id="messagebox">
		{$smarty.get.msg}
	</div>
	 {/if}
	<div align="center" style=" margin-right:auto; margin-left:auto; text-align:justify; width:488px;">
		<strong style="font-size:16px;">Refer Your Family and Friends</strong>
	</div>
	<form action="" method="post" name="ref_form" id="ref_form">
		<div align="center">
			<div style="width:537px; padding-bottom:10px;" align="center">
				<div align="left" style="width:360px">
				</div>
			</div>
			<div style="margin:0;padding:0; width:488px;">
				<img src="/skin/red/images/step1_top.jpg" border="0" style="float:left"/>
				<div style="clear:both;">
				</div>
			</div>
			<div style="padding:0;margin:0;width:488px;background: rgb(241, 241, 241); overflow: hidden;">
				<table cellspacing="4" cellpadding="0">
				<tr>
					<td align="left" valign="top">
						Your Name:*
					</td>
					<td>
						<input type="text" name="own_name" id="own_name" value="{$req.own_name}" class="inputB" onkeydown="previewOnkeyDown(event);"/>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td style="width:75px;+width:76px;" align="left" valign="top">
						Your Email:*
					</td>
					<td>
						<input type="text" name="own_email" id="own_email" value="{$req.own_email}" class="inputB" onkeydown="previewOnkeyDown(event);"/>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td style="width:75px;+width:76px;" align="left" valign="top">
						Personal Note
					</td>
					<td>
						<textarea name="personal_note" class="inputB" style="height:50px;*height:52px;*padding-bottom:0;"></textarea>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td style="width:75px;+width:76px;" align="left" valign="top">
						Message/Inscription:
					</td>
					<td>
						<textarea name="inscription" class="inputB" style="height:50px;*height:52px;*padding-bottom:0;">Regards,&#013;{$req.own_name}</textarea>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td style="width:75px;+width:76px;" align="left">
						&nbsp;
					</td>
					<td align="right">
						<a href="javascript:void(0);" onclick="return priview();"><img src="/skin/red/images/buttons/bu-preview.gif" width="90" height="28" style="padding:1px;"/></a>
					</td>
					<td>
					</td>
				</tr>
				</table>
			</div>
			<img src="/skin/red/images/step1_bottom.jpg" style=""/>
			<br/><br/>
		</div>
		<div align="center">
			<div style="width:437px">
				<strong>Please Select:</strong> &nbsp;&nbsp;<input type="radio" name="up_tab" checked="checked" onclick="showtabfunc('normaltab');"/>Standard Mode &nbsp;&nbsp; <input type="radio" name="up_tab" onclick="showtabfunc('uploadtab');"/>Bulk Upload Mode
			</div>
			<input type="hidden" id="is_choose_upload" name="is_choose_upload" value="0"/>
			<input type="hidden" id="is_csv_upload" name="is_csv_upload" value="0"/>
			<table cellpadding="0" cellpadding="4" width="474" id="uploadtab" style="border:1px solid #ccc; margin:10px 0; display:none;">
			<tr>
				<td>
					&nbsp;
				</td>
				<td width="80" align="left">
					Upload CSV:
				</td>
				<td align="left" width="390">
					<input type="file" name="csvupload" id="csvupload" style="display:none"/><span style="float:left; height:29px; line-height:29px;">&nbsp;&nbsp;<a href="/pdf/emailcsv.csv">CSV Sample</a></span>
				</td>
			</tr>
			<tr>
				<td>
				</td>
				<td colspan="2" id="uploadmsg" align="left" style="color:#F00">
				</td>
			</tr>
			</table>
			<table cellpadding="0" cellspacing="4" width="437px" id="normaltab">
			<tr>
				<td style="background:#9E99C1; height:23px; color:#FFFFFF;font-weight:bold;" align="center">
					#
				</td>
				<td style=" background:#9E99C1;height:23px;color:#FFFFFF;font-weight:bold;" align="center">
					Friends
				</td>
				<td style=" background:#9E99C1;height:23px;color:#FFFFFF; font-weight:bold;" align="center">
					Email
				</td>
			</tr>
			 {section name=foo start=0 loop=10 step=1}
			<tr>
				<td width="3%">
					{$smarty.section.foo.index+1}.
				</td>
				<td>
					<input class="inputB" style="width:150px" type="text" name="nickname[]" value="{$req.nickname[$smarty.section.foo.index]}" onkeydown="return sendOnkeyDown(event);"/>
				</td>
				<td>
					<input class="inputB" type="text" name="emailaddress[]" value="{$req.emailaddress[$smarty.section.foo.index]}" onkeydown="return sendOnkeyDown(event);"/>
				</td>
			</tr>
			 {/section}
			</table>
			<table cellpadding="0" cellpadding="4" width="474">
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left">
					<p>
						<a href="/soc.php?cp=refemaillist" title="View list of Emails already sent">View list of Emails already sent</a>
					</p>
					<p>
						<a href="/soc.php?cp=buyrefer" title="Members who have joined under your referral code">Members who have joined under your referral code</a>
					</p>
				</td>
				<td align="right">
					<a href="javascript:void(0);" onclick="return checkemailform();" id="ref_submit"><img src="/skin/red/images/referFriends.gif" width="122" height="29"/></a>
				</td>
			</tr>
			</table>
			<input type="hidden" name="optval" id="optval" value="send"/>
		</div>
	</form>
</div>
 {literal}
<script type="text/javascript">
	function previewOnkeyDown(event)
    {
		if (event.keyCode==13) 
		{ 
			priview();
		} 
		return true;
    }
	function priview()
	{		
		$("#optval").val('preview');
		document.ref_form.target = '_blank';
		//alert($("#optval").val());return;
		document.ref_form.submit();
	}
</script>
{/literal}