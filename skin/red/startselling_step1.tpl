<link type="text/css" href="/skin/red/css/global.css" rel="stylesheet" media="screen" />
<script language="Javascript1.2">
	var langCP = '{$lang.labelContactPerson}*';
	var langNK = '{$lang.labelNickName}*';
</script> 


{literal}
<script language="Javascript1.2">
<!--// load htmlarea
_editor_url = "";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'js/editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
}
else 
{ 
	document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); 
}

var mailstatu = "success";
var webstatu = "success";
var bunamestatu='success';

function changeUrl(url){
	newurl = url.replace(/[^\d\w]/g,'');
	newurl = newurl.replace(/_/g,'');
	if (newurl.length > 60){
		alert("The URL String must be less than 60 characters.\n");
	}else{
		//$('#bu_urlstring').val(newurl);
		document.getElementById("url").innerHTML = 'www.socexchange.com.au/'+newurl;
	}
}

function checkBuNameUnique(Obj){
	ObjClewID = "#"+ Obj.id + "_clew";
	$(ObjClewID).removeClass().addClass('messagebox').text('Checking...').fadeIn("slow");
	
	$.post("soc.php?act=signon&step=checkBunameUnique",{ bu_name : $("#"+Obj.id).val() } ,function(data,textstatu)
	{
	  if(textstatu == 'success'){
		if(data=='existed')
			{
				$(ObjClewID).fadeTo(200,0.1,function() {
					$(this).html('This Website Name is invalid or exists.').addClass('messageboxerror').fadeTo(900,1);
				});
				$("#bu_name").val('');
			} else if(data=='empty') {
				$(ObjClewID).fadeTo(200,0.1,function() {
					$(this).html('Please enter Website Name to register.').addClass('messageboxerror').fadeTo(900,1);
				});
			} else {
				$(ObjClewID).fadeTo(200,0.1,function(){
					$(this).html('Website Name available to register.').addClass('messageboxok').fadeTo(900,1);
				});	
			}
		  }
		bunamestatu = textstatu;
	});
	
}

function selectSuburb(obj,params)
{
	try{
		ajaxLoadPage('soc.php','&act=signon&step=suburb&SID='+params,'GET',document.getElementById(obj),false,false,true);
	}
	catch(ex)
	{}
}
 
function selectZip(obj){
	var strTemp	=obj.options[obj.selectedIndex].text;
	if(strTemp != 'Select City'){
		var arrTemp = strTemp.split(',');
		document.getElementById('bu_postcode').value = arrTemp[1].replace(/(^\s)|($\s)/g,'');
	}else{
		document.getElementById('bu_postcode').value = '';
	}
}

function clickSuburb()
{
	document.getElementById("suburb").value = document.getElementById("bu_suburb").value;
}

function ifEmail(str,allowNull){
	if(str.length==0) return allowNull;
	i=str.indexOf("@");
	j=str.lastIndexOf(".");
	if (i == -1 || j == -1 || i > j) return false;
	return true;
}

function changePayOption(val){
	
	if(typeof(val) == 'undefined'){
		$('#payOptions1').css('display','');
		$('#payDivContainer_image1').css('display','');
		$('#payDivContainer_image2').css('display','');
		$('#payDivContainer_content').css({height:'110px' , background:'#F1F1F1'});
		$('#payDivContainer').css({width:'488px'});
		
	}else{
		if(val == 0){
			$('#payDivContainer_image1').css('display','');
			$('#payDivContainer_image2').css('display','');
			$('#payDivContainer_content').css({height:'110px' , background:'#F1F1F1'});
			$('#payDivContainer').css({width:'488px'});	
			$("#trprocode").css('display', 'none');
		}else{
			$('#payDivContainer_image1').css('display','');
			$('#payDivContainer_image2').css('display','');
			$("#trprocode").css('display', '');
			if(val==3){
				$('#payDivContainer_content').css({height:'118px' , background:'#F1F1F1'});
			}else if(val==5){
				$('#payDivContainer_content').css({height:'110px' , background:'#F1F1F1'});
			}else{
				$('#payDivContainer_content').css({height:'100px' , background:'#F1F1F1'});
			}
			$('#payDivContainer').css({width:'488px'});
		}
		
		for (i=1 ; i < 7 ; i++){
			if(val == (i-1)){
				$('#payOptions' + i.toString()).css('display','');
			}else{
				$('#payOptions' + i.toString()).css('display','none');
			}
		}
	}
}

function paymentSubmitSet(){
	$("#amount").val("");
	//if($("input[@name=attribute][@checked]").val() > 0){
		$("#amount").val(10);
	//}else{
		//$("#amount").val( $("input[@name=amount1][@checked]").val() );
	//}
}

function checkForm(obj){
	try{
		RegExp.multiline=true;
		var errors 	=	'';
		var flag 	=	1;
		var emailID=obj.bu_user;
		clickSuburb();
		
		{/literal}{if !$isUpdate}{literal}
		if(obj.bu_user.value==''){
			errors += '-  Email Address is required.\n';
		}else if(!ifEmail(obj.bu_user.value,false)){
			errors += '-  Email Address is invalid.\n';
		}
		{/literal}{/if}{literal}
		
		if(obj.bu_password.value==''){
			errors += '-  Password is required.\n';
		}else if(obj.bu_password.value != obj.bu_password1.value){
			errors += '-  The passwords you have entered did not match.\n';
		}
		
		if($('#divSubattrib1').css('display')!='none'){
			var s1 = false;
			for(var z=0;z<obj.subattr1.length;z++){
				if(obj.subattr1[z].checked==true){
					s1 = true;
				}
			}
			if(!s1){
				errors += '-  Sub Attribute is required.\n';
			}
		}
		if($('#divSubattrib2').css('display')!='none'){
			var s1 = false;
			for(var z=0;z<obj.subattr2.length;z++){
				if(obj.subattr2[z].checked==true){
					s1 = true;
				}
			}
			if(!s1){
				errors += '-  Sub Attribute is required.\n';
			}
		}
		
		{/literal}{if  !$isUpdate || $userlevel eq 2}{literal}
		if($('#divSubattrib3').css('display')!='none'){
			var s1 = false;
			for(var z=0;z<obj.subattr3.length;z++){
				if(obj.subattr3[z].checked==true){
					s1 = true;
				}
			}
			if(!s1){
				errors += '-  Sub Attribute is required.\n';
			}
		}
		{/literal}{/if}{literal}
		
		if($('#divSubattrib5').css('display')!='none'){
			var s1 = false;
			for(var z=0;z<obj.subattr5.length;z++){
				if(obj.subattr5[z].checked==true){
					s1 = true;
				}
			}
			if(!s1){
				errors += '-  Sub Attribute is required.\n';
			}
			
			if($('#bu_username').val() == '') {
				errors += '-  Username is required.\n';
			}
		}
		
		if(obj.bu_name.value==''){
			errors += '-  Website Name is required.\n';
		}else{
			newurl = obj.bu_name.value;
			newurl = newurl.replace(/[^\d\w]/g,'');
			if (newurl.length > 60){
				errors += "-  The website name must be less than 60 characters.\n";
			}
		}
		
		if(obj.bu_urlstring.value==''){
			errors += '-  URL String is required.\n';
		}else{
			var urlstring = obj.bu_urlstring.value;
			urlstring = urlstring.replace(/[^\d\w]/g,'');
			if(urlstring.length > 60){
				errors += "-  The URL String must be less than 60 characters.\n";
			}
		}
	
		if(obj.bu_nickname.value==''){
			errors += '-  Nickname is required.\n';
		}
		
		if(obj.bu_address.value==''){
			errors += '-  {/literal}{$lang.labelAddress}{literal} is required.\n';
		}
		
		if(obj.bu_catag.value==''){
			errors += '-  Category is required.\n';
		}
	
		if(obj.bu_state.value==''){
			errors += '-  State is required.\n';
		}
		
		if(obj.bu_suburb.value==''){
			errors += '-  City/ Suburb is required.\n';
		}
		
		if(obj.bu_area.value==''){
			errors += '-  Phone Area Code is required.\n';
		}
		
		/*if($('input[@name=attribute][@checked]').val() == 1 && $('input[@name=subattr1][@checked]').val()==1 && $('#mobile').val() == ''){
			errors += '-  {/literal}{$lang.labelMobile}{literal} is required.\n';
		}*/

		if(obj.bu_phone.value==''){
			errors += '-  {/literal}{$lang.labelPhone}{literal} is required.\n';
		}
	
		if(obj.contact.options[obj.contact.selectedIndex].value==''){
			errors += '-  Preferred Contact is required.\n';
		}
		
	
		if(obj.bu_postcode.value==''){
			errors += '-  {/literal}{$lang.labelZIP}{literal} is required.\n';
		}
		{/literal}
		{if $isUpdate == false || $userlevel eq 2}
			{literal}
			if(!obj.agree.checked){
				errors += '-  You must agree to the terms.\n';
			}
			{/literal}
		{/if}
		{literal}
		{/literal}
		{if !$isUpdate || $userlevel eq 2}{literal}
			if (!$('#amount').val()>0){
				errors += '-  Amount is required.\n';
			}else{
				hasAmount	=	true;
			}
		{/literal}
		{/if}
		{literal}
	}catch(ex)
	{
		alert(ex);
	}

	if(errors!=''){
		errors = 'Sorry, the following fields are required.\n'+errors;
		alert(errors);
		return false;
	}
	else
	{
		if(document.mainForm.cp.value=='next' || document.mainForm.cp.value=='save') {
			
			document.mainForm.action='';
		}	
		
		if($("input[@name=attribute][@checked]").val() == 0) {
			
			document.mainForm.action='/soc.php?act=signon&step=payment_paypal';
		}
		
		document.mainForm.submit();
		return false;
	}
}

function checkEmail()
{

	//remove all the class add the messagebox classes and start fading
	$("#msgbox").removeClass().addClass('messagebox').text('Checking...').fadeIn("slow");
	//check the username exists or not from ajax
	$.post("soc.php?act=signon&step=checkEmailExist",{ bu_user:$("#bu_user").val(),attribute:$("input[name='attribute']:checked").val() } ,function(data,textstatu)
	{
		mailstatu = textstatu;
		if(data=='invalid' || data=='existed') //if username not avaiable
		{
			$("#msgbox").fadeTo(200,0.1,function() //start fading the messagebox
			{
				//add message and change the class of the box and start fading
				$(this).html('This Email Address is invalid or exists.').addClass('messageboxerror').fadeTo(100,1);
			});
			$("#bu_user").val('');
		} else if(data=='empty') {
			$("#msgbox").fadeTo(200,1,function()  //start fading the messagebox
			{
				//add message and change the class of the box and start fading
				$(this).html('Please enter a email to register.').addClass('messageboxerror').fadeTo(100,1);
			});
		} else {
			$("#msgbox").fadeTo(200,1,function()  //start fading the messagebox
			{
				//add message and change the class of the box and start fading
				$(this).html('Email available to register.').addClass('messageboxok').fadeTo(100,1);
			});	
		}

	});
}


function checkEmailIfExists(){
	if ($("#bu_user").val()!=''){
		checkEmail();
	}
}
function checkrefid(){
	$('#referrer_tips').show();
	$("#msgbox5").removeClass().text('Checking...').fadeIn("slow");
	$.post("/include/jquery_svr.php?svr=check_RefID",{ refID:$("#referrer").val() } ,function(data,textstatu){if(data=='0'){
		$("#msgbox5").fadeTo(200,0.1,function(){
				$(this).html('Invalid Referrer ID.').removeClass().addClass('errormsg').fadeTo(900,1);
		});
		$("#referrer").val('');
	}else{
		$("#msgbox5").fadeTo(200,0.1,function(){
				$(this).html(data).removeClass().addClass('sucmsg').fadeTo(900,1);
		});
	}});
}
function checkWebsite()
{
	//remove all the class add the messagebox classes and start fading
	$("#msgbox1").removeClass().addClass('messagebox').text('Checking...').fadeIn("slow");
	//check the username exists or not from ajax
	$.post("soc.php?act=signon&step=checkWebsiteExist",{ bu_name:$("#bu_urlstring").val() } ,function(data,textstatu)
	{
		webstatu = textstatu;
		if(data=='existed') //if username not avaiable
		{
			$("#msgbox1").fadeTo(200,0.1,function() //start fading the messagebox
			{
				//add message and change the class of the box and start fading
				$(this).html('This URL string has already been used. Please create another.').addClass('messageboxerror').fadeTo(900,1);
			});
			$("#bu_urlstring").val('');
		} else if(data=='empty') {
			$("#msgbox1").fadeTo(200,0.1,function()  //start fading the messagebox
			{
				//add message and change the class of the box and start fading
				$(this).html('Please enter a URL String.').addClass('messageboxerror').fadeTo(900,1);
			});
		} else {
			$("#msgbox1").fadeTo(200,0.1,function()  //start fading the messagebox
			{
				//add message and change the class of the box and start fading
				$(this).html('URL String available to register.').addClass('messageboxok').fadeTo(900,1);
			});	
		}

	});
}


function checkUsername()
{
	//remove all the class add the messagebox classes and start fading
	$("#msgbox6").removeClass().addClass('messagebox').text('Checking...').fadeIn("slow");
	//check the username exists or not from ajax
	$.post("soc.php?act=signon&step=checkUsernameExist",{ bu_username:$("#bu_username").val() } ,function(data,textstatu)
	{
		webstatu = textstatu;
		if(data=='existed') //if username not avaiable
		{
			$("#msgbox6").fadeTo(200,0.1,function() //start fading the messagebox
			{
				//add message and change the class of the box and start fading
				$(this).html('This Username has already been used. Please create another.').addClass('messageboxerror').fadeTo(900,1);
			});
			$("#bu_username").val('');
		} else if(data=='empty') {
			$("#msgbox6").fadeTo(200,0.1,function()  //start fading the messagebox
			{
				//add message and change the class of the box and start fading
				$(this).html('Please enter a Username.').addClass('messageboxerror').fadeTo(900,1);
			});
		} else if(data=='invalid') {
			$("#msgbox6").fadeTo(200,0.1,function()  //start fading the messagebox
			{
				//add message and change the class of the box and start fading
				$(this).html('This Username is invalid.').addClass('messageboxerror').fadeTo(900,1);
			});				
			$("#bu_username").val('');
		} else {
			$("#msgbox6").fadeTo(200,0.1,function()  //start fading the messagebox
			{
				//add message and change the class of the box and start fading
				$(this).html('Username available to register.').addClass('messageboxok').fadeTo(900,1);
			});	
		}

	});
}
/* select sub item when changed type of seller **/
function selectSellerType(value){
	$("#email_tip").html('Cannot be changed.');
	$("#tr_username").css('display','none');
	$("#tr_username_tip").css('display','none');
	value = value ? value : $("input[name='attribute']:checked").val();
	
	changePayOption(value);
	
	if(!value){
	   value=0;
	}
	if(value==0){
	   //$('#tnk').html(langNK);
	}else{
	   //$('#tnk').html(langCP);  
	}
	closeSellerTypeSub();
	hasPayments(0);
	if (value == 0) {
	
		$('#bu_name').bind('blur', function(){bunamestatu='error';checkBuNameUnique(this);});
		
	}else if(value==1){
		$("#divSubattrib1").css('display','');
		
		hasMobile($('input[@name=subattr1][@checked]').val());
		
	}else if(value==2){
		$("#divSubattrib2").css('display','');
		hasLicence($('input[@name=subattr2][@checked]').val());

	}else if(value==3){
	
		$("#divSubattrib3").css('display','');
		$('#jobIocnDisplay').css('display','');
		$('#normalDisplay').css('display','none');
		
		var subvalue = $('input[@name=subattr3][@checked]').val();
		typeof(subvalue) == 'undefined' ? $('input[@name=subattr3]').attr("checked",'1') : '';
		hasPayments($('input[@name=subattr3][@checked]').val());

	}else if(value==5){
		$("#divSubattrib5").css('display','');
		$("#email_tip").html('Cannot be changed.<br />Can be used with multiple Usernames.');		
		$("#tr_username").css('display','');
		{/literal}{if !$isUpdate}{literal}
		$("#tr_username_tip").css('display','');
		{/literal}{/if}{literal}
	}
	
}

function closeSellerTypeSub(){

	$('#bu_name').unbind('blur');
	bunamestatu='success';
	$('#bu_name_clew').css('display','none');
	
	for(i=1; i<=5; i++){
		$("#divSubattrib"+i).css('display','none');
	}
	$('#jobIocnDisplay').css('display','none');
	$('#normalDisplay').css('display','');
	hasLicence();
	hasMobile();
}

function hasLicence(value){
	if(value == 2){
		$("#divLicence").css('display','');
	}else{
		$("#divLicence").css('display','none');
	}
}

function hasMobile(value){
	//if(value == 1){
		$("#divMobile").css('display','');
	//}else{
		//$("#divMobile").css('display','none');
		//$("#mobile").val('');
	//}
}

function hasPayments(value){
	if( value == 3 ){
		$('#payDivContainer').css('display','none');
		$('#payDivContainer2').css('display','');
		$('#mainForm').attr('action','/soc.php?act=regfree');
		{/literal}
		{if $req.StoreID eq ""}
		{literal}
			$('#trprocode').css('display','none');
			$('#referid').css('display','none');
		{/literal}
		{/if}
		{literal}
	}else{
		$('#payDivContainer').css('display','');
		$('#payDivContainer2').css('display','none');
		$('#mainForm').attr('action','{/literal}{$paypalInfo.paypal_url}{literal}');
		{/literal}
		{if $req.StoreID eq ""}
		{literal}
			if(value != 0) {
				$('#trprocode').css('display','');
			}
			$('#referid').css('display','');
		{/literal}
		{/if}
		{literal}
	}
}

windowOnload(function(){selectSellerType({/literal}{$req.attribute}{literal});});

{/literal}


{if $req.paymentMethod eq ''}

{literal}

function checkForm_paypal(obj){
	try{
		RegExp.multiline=true;
		var errors 	=	'';
		var flag 	=	1;
		var emailID=obj.bu_user;
		clickSuburb();
		
		if($('#divSubattrib1').css('display')!='none'){
			var s1 = false;
			for(var z=0;z<obj.subattr1.length;z++){
				if(obj.subattr1[z].checked==true){
					s1 = true;
				}
			}
			if(!s1){
				errors += '-  Sub Attribute is required.\n';
			}
		}
		if($('#divSubattrib2').css('display')!='none'){
			var s1 = false;
			for(var z=0;z<obj.subattr2.length;z++){
				if(obj.subattr2[z].checked==true){
					s1 = true;
				}
			}
			if(!s1){
				errors += '-  Sub Attribute is required.\n';
			}
		}
		
		{/literal}{if  !$isUpdate || $userlevel eq 2}{literal}
		if($('#divSubattrib3').css('display')!='none'){
			var s1 = false;
			for(var z=0;z<obj.subattr3.length;z++){
				if(obj.subattr3[z].checked==true){
					s1 = true;
				}
			}
			if(!s1){
				errors += '-  Sub Attribute is required.\n';
			}
		}
		{/literal}{/if}{literal}
		
		if($('#divSubattrib5').css('display')!='none'){
			var s1 = false;
			for(var z=0;z<obj.subattr5.length;z++){
				if(obj.subattr5[z].checked==true){
					s1 = true;
				}
			}
			if(!s1){
				errors += '-  Sub Attribute is required.\n';
			}
		}
		
		{/literal}{if !$isUpdate}{literal}
		if(obj.bu_user.value==''){
			errors += '-  Email Address is required.\n';
		}else if(!ifEmail(obj.bu_user.value,false)){
			errors += '-  Email Address is invalid.\n';
		}
		if(obj.re_bu_user.value=='' || obj.bu_user.value != obj.re_bu_user.value){
			errors += '-  The Email Address you have entered did not match.\n';
		}
		{/literal}{/if}{literal}
		
		if(obj.bu_password.value==''){
			errors += '-  Password is required.\n';
		}else if(obj.bu_password.value != obj.bu_password1.value){
			errors += '-  The passwords you have entered did not match.\n';
		}
	
		if(obj.bu_name.value==''){
			errors += '-  Website Name is required.\n';
		}else{
			var webname = obj.bu_name.value;
			webname = webname.replace(/[^\d\w]/g,'');
			if (webname.length > 60){
				errors += "-  The Website Name must be less than 60 characters.";
			}
		}		
		if(obj.bu_urlstring.value==''){
			errors += '-  URL String is required.\n';
		}else{
			newurl = obj.bu_urlstring.value;
			newurl = newurl.replace(/[^\d\w]/g,'');
			if (newurl.length > 60){
				errors += "-  The URL String must be less than 60 characters.";
			}
		}
	
		if(obj.bu_nickname.value==''){
			errors += '-  Nickname is required.\n';
		}
		
		if(obj.bu_address.value==''){
			errors += '-  {/literal}{$lang.labelAddress}{literal} is required.\n';
		}

		if(obj.bu_catag.value==''){
			errors += '-  Category is required.\n';
		}
	
		if(obj.bu_state.value==''){
			errors += '-  State is required.\n';
		}
		
		if(obj.bu_suburb.value==''){
			errors += '-  City/ Suburb is required.\n';
		}
		
		if(obj.bu_area.value==''){
			errors += '-  Phone Area Code is required.\n';
		}

		if(obj.bu_phone.value==''){
			errors += '-  {/literal}{$lang.labelPhone}{literal} is required.\n';
		}
	
		if(obj.contact.options[obj.contact.selectedIndex].value==''){
			errors += '-  Preferred Contact is required.\n';
		}
		
	
		if(obj.bu_postcode.value==''){
			errors += '-  {/literal}{$lang.labelZIP}{literal} is required.\n';
		}
		{/literal}
		{if $isUpdate == false || $userlevel eq 2}
		{literal}
		if(!obj.agree.checked){
			errors += '-  You must agree to the terms.\n';
		}
		{/literal}
		{/if}
		{literal}
		{/literal}
		{if !$isUpdate || $userlevel eq 2}{literal}
			if (!$('#amount').val()>0){
				errors += '-  Amount is required.\n';
			}else{
				hasAmount	=	true;
			}
		{/literal}
		{/if}
		{literal}
	}catch(ex)
	{
		alert(ex);
	}

	if(errors!=''){
		errors = 'Sorry, the following fields are required.\n'+errors;
		alert(errors);
		return false;
	}
	else
	{
		if(document.mainForm.cp.value=='next' || document.mainForm.cp.value=='save') {
			
			document.mainForm.action='';
		}
		
		/**
		** modify by roy 20081211
		**/
		return true;
		//document.mainForm.submit();
	}
}



{/literal}

{/if}

{literal}
//-->
</script>
<style type="text/css">
.messagebox{
	font-familly:Arial;
	position:absolute;
	width:100px;
	margin-left:30px;
	padding:3px;
}
.messageboxok{
	position:absolute;
	width:auto;
	margin-left:30px;
	padding:3px;
	color:#008000;
}
.messageboxerror{
	position:absolute;
	width:auto;
	margin-left:30px;
	padding:3px;
	color:#CC0000;
}

#container #wrapper_2col #rightCol{
	_width:760px;
	_padding-left:10px;
	_padding-right:0px;
	_margin:0;
}

#rightCol .adminTitle {
	_padding:4px;
	_width:752px;
	
}
.errormsg{
	color:#CC0000;
}
.sucmsg{
	color:#008000;
}
#searchresults #link_to_aus{
	color:#999999;
}
#searchresults #link_to_aus:hover{
	color:#0000FF;
}
</style>
{/literal}
<div id="searchresults" style="position:relative">
<table width="720" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="right">
			<!--<img src="/skin/red/images/free_payment/free_reg_banner.jpg" title="Greatest run in history" alt="Greatest run in history" style=" margin-left:10px;_margin-left:0; _padding-left:0; *+margin-left:10px;*+margin-left:0;"/>-->
		</td>
    </tr>
	
</table>
<p align="center" class="txt" style="width:560px;"><font style="color:red;">{$req.msg|nl2br}</font></p>
<form method="post" name="mainForm" id="mainForm" action="{$paypalInfo.paypal_url}"  onsubmit="{if $req.paymentMethod eq ''}return checkForm_paypal(this);{else}return checkForm(this);{/if}">
<table width="720" border="0" cellpadding="0" cellspacing="4" id="table14">
	<tr>
		<td width="150" height="30">
			<input name="bu_catag" id="bu_catag" type="hidden" value="11" />
			<input type="hidden" name="StoreID" id="StoreID" value="{$req.StoreID}" />
			<input type="hidden" name="cp" value="payment" />
		</td>
		<td colspan="2" class="tip">
			{$lang.msgCreateStore}&nbsp;<img src="/skin/red/images/icon-question.gif" width="21" height="20" border="0" />		</td>
	 </tr>
     {if !$isUpdate || $userlevel eq 2}
     <tr>
     <td style="padding:5px 0 5px 90px;color:#F11F44" colspan="2" align="center">{$lang.labelSelectMarketPlace}</td>
     <td>&nbsp;</td>
     </tr>
     <tr height="35" valign="top">
     	<td colspan="3" style="padding-left:90px;">
       {foreach from=$lang.seller.attribute item=l key=k}
	  	 <div style="float:left; width:80px;">
         <span style="text-align:center; display:block">{$l.text}</span>
         <span style="text-align:center; width:80px; display:block;"><input onclick="javascript:selectSellerType(this.value);changePayOption(this.value);checkEmailIfExists();" type="radio" name="attribute" value="{$k}" {if $req.attribute eq $k}checked{/if} style="border:none"/></span>
         </div>
	   {/foreach}
       </td>
     </tr>
	{else}
	<tr>
	  <td height="25" align="right"><span class="txt"><span class="lbl">{$lang.labelAttribute}*</span></span></td>
	  <td colspan="2">
	   {$lang.seller.attribute[$req.attribute].text}
	   <input name="attribute" id="attribute" type="hidden" value="{$req.attribute}" />
	   	   </td>
      </tr>
    {/if}
	<tr id="divSubattrib1" style="display:none;">
	  <td height="25" align="right"><span class="txt"><span class="lbl">{$lang.labelSubattrib}*</span></span></td>
	  <td colspan="2">
	 {foreach from=$lang.seller.attribute.1.subattrib item=l key=k}<input id="subattr1[]" name="subattr1" type="radio" style="border:none" value="{$k}" onclick="javascript:hasMobile({$k});" {if $req.attribute eq '1' && $req.subAttrib eq $k || $req.subattr1 eq $k}checked{/if}/> {$l}  {/foreach}	 </td>
	  </tr>
	<tr id="divSubattrib2" style="display:none;">
	  <td height="25" align="right"><span class="txt"><span class="lbl">{$lang.labelSubattrib}*</span></span></td>
	  <td colspan="2">
	 {foreach from=$lang.seller.attribute.2.subattrib item=l key=k}<input id="subattr2[]" name="subattr2" type="radio" value="{$k}" onclick="javascript:hasLicence({$k})" {if $req.attribute eq '2' && $req.subAttrib eq $k || $req.subattr2 eq $k }checked{/if} style="border:none"/> {$l} {/foreach}	 </td>
	  </tr>
	
	<tr id="divSubattrib3" style="display:none;">
	  <td height="25" align="right"><span class="txt"><span class="lbl">{$lang.labelSubattrib}*</span></span></td>
	  <td colspan="2">
	  {if $isUpdate && $req.attribute eq 3 }
	  	{if $req.subAttrib eq 0 or  $showRadio}
			{foreach from=$lang.seller.attribute.3.subattrib item=l key=k}
			 <input id="subattr3[]" name="subattr3" type="radio" style="border:none" value="{$k}" onclick="javascript:hasPayments({$k})" {if $req.attribute eq 3 && $req.subAttrib eq $k || $req.subattr3 eq $k  || (($req.subAttrib eq '' ||$req.subAttrib eq '0') && $k eq 1) }checked{/if}/> <font {if $k neq 3}style='color:#0000FF'{/if}>{$l}</font>
			 {/foreach}
		{else}
			{valueOfArray arrValue=$lang.seller.attribute.3.subattrib value=$req.subAttrib}
			<input name="subattr3" id="subattr3" type="hidden" value="{$req.subAttrib}" />
		{/if}
	  {else}
		 {foreach from=$lang.seller.attribute.3.subattrib item=l key=k}
		 	{if !($isUpdate && $req.attribute eq 3 && $k eq 3)}
		 <input id="subattr3[]" name="subattr3" type="radio" value="{$k}" onclick="javascript:hasPayments({$k})" style="border:none" {if $req.attribute eq 3 && $req.subAttrib eq $k || $req.subattr3 eq $k  || (($req.subAttrib eq '' ||$req.subAttrib eq '0') && $k eq 1) }checked{/if}/> <font {if $k neq 3}style='color:#0000FF'{/if}>{$l}</font>
		 	{/if}
		 {/foreach}
	 {/if}
	 </td>
	 </tr>


	<tr id="divSubattrib5" style="display:none;">
		  <td height="25" align="right"><span class="txt"><span class="lbl">{$lang.labelSubattrib}*</span></span></td>
		  <td>
            {foreach from=$lang.seller.attribute.5.subattrib item=l key=k}
	  	      <span style="display:block; padding:3px 0; float:left; width:140px;"><input type="radio" name="subattr5" value="{$k}" {if $req.attribute eq '5' && $req.subAttrib eq $k || $req.subattr5 eq $k }checked{/if} style="border:none"/>{$l}</span>
	   {/foreach}
		 </td>
         <td>&nbsp;</td>
	 </tr>

	<tr id="divLicence" style="display:none;">
	  <td align="right" ><span class="txt"><span class="lbl">{$lang.labelLicence}</span></span></td>
	  <td colspan="2"><input name="licence" class="inputB" id="licence" value="{$req.licence}" maxlength="25"></td>
	</tr>
	  
	  
	<tr style="display:{if $req.attribute neq "5"}none{/if}" id="tr_username">
		<td align="right" valign="top"><span class="txt" style="height:25px; line-height:25px;"><span class="lbl" style="color:#F11F44">{$lang.labelUsername}*</span></span></td>
		<td colspan="2"><span class="style11"><font face="Verdana" size="1">
		{if $isUpdate == false}
			<input name="bu_username" id="bu_username" type="text" class="inputB" value="{$req.bu_username}" size="30" onblur="checkUsername();" onfocus="javascript:mailstatu='error';" />
            <div id="msgbox6" style="display:none; clear:both; position:relative; margin:0;"></div>
		{else}
			<span style="color:#F11F44">{$req.bu_username}</span>
			<input type="hidden" name="bu_username" value="{$req.bu_username}" id="bu_username" />
		{/if}
			<input type="hidden" name="bu_username_default" value="{$req.bu_username}" /></font></span>   
        </td>
	</tr>
	<tr style="display:{if $req.attribute neq "5" || $isUpdate}none{/if}" id="tr_username_tip">
      <td height="30" align="right">&nbsp;</td>
	  <td colspan="2"><span style="color: #F11F44">Unique to each user/store across the site.<br />Usernames cannot be changed once created.</span></td>
	  </tr>
	<tr>
		<td align="right" valign="top"><span class="txt" style="height:25px; line-height:25px;"><span class="lbl" style="color:#F11F44">{$lang.labelEmail}*</span></span></td>
		<td colspan="2"><span class="style11"><font face="Verdana" size="1">
		{if $isUpdate == false}
			<input name="bu_user" id="bu_user" type="text" class="inputB" value="{$req.bu_user}" size="30" onblur="checkEmail();" onfocus="javascript:mailstatu='error';" />
            <div id="msgbox" style="display:none; clear:both; position:relative; margin:0;"></div>
		{else}
			<span style="color:#F11F44">{$req.bu_user}</span>
			<input type="hidden" name="bu_user" value="{$req.bu_user}" id="bu_user" />
		{/if}
			<input type="hidden" name="bu_user_default" value="{$req.bu_user}" /></font></span></td>
	</tr>
	{if $isUpdate == false}
    <tr>
		<td align="right"><span class="txt"><span class="lbl" style="color:#F11F44">Re-enter {$lang.labelEmail}*</span></span></td>
		<td colspan="2">
        <input name="re_bu_user" id="re_bu_user" type="text" class="inputB" value="{$req.re_bu_user}" size="30" />
        </td>
    </tr>
	<tr>
      <td align="right" height="30">&nbsp;</td>
	  <td colspan="2"><span style="color: #F11F44" id="email_tip">Cannot be changed.</span></td>
	  </tr>
	  {/if}
	  <tr>
		<td align="right"><span class="txt"><span class="lbl">{$lang.labelPassword}*</span></span></td>
		<td colspan="2"><span class="style11"><font face="Verdana" size="1"><input name="bu_password" type="password" class="inputB" id="bu_password" value="{$req.bu_password}" size="30" /></font></span></td>
	</tr>
	  <tr>
		<td align="right"><span class="txt"><span class="lbl">{$lang.labelRePassword}*</span></span></td>
		<td colspan="2"><span class="style11"><font face="Verdana" size="1"><input name="bu_password1" type="password" class="inputB" id="bu_password1" value="{$req.bu_password1}" size="30" /></font></span></td>
	</tr>
	<tr>
		<td align="right"><span class="txt"><span class="lbl" id="tnk" style="color:#F11F44">

		{$lang.labelNickName}*
		</span></span></td>
		<td colspan="2"><span class="style11"><font face="Verdana" size="1">{if $isUpdate == false}<input name="bu_nickname" type="text" class="inputB" id="bu_nickname" value="{$req.bu_nickname}" size="30" />{else}<span style="color:#F11F44">{$req.bu_nickname}</span><input name="bu_nickname" type="hidden" class="inputB" id="bu_nickname" value="{$req.bu_nickname}" size="30" />{/if}</font></span></td>
	</tr>
	
	{if $isUpdate == false}
	<tr>
      <td align="right" height="20">&nbsp;</td>
	  <td colspan="2"><span style="color: #F11F44">This will be visible to others on the website and cannot be changed!</span></td>
	  </tr>
	{/if}
	<tr>
		<td align="right" height="30"><span class="txt"><span id="tnk" class="lbl">
		Gender*</span></span></td>
		<td colspan="2"><span class="style11"><input type="radio" name="gender" value="0" {if $req.gender eq '0' or $req.gender eq ''}checked{/if}/> Male &nbsp;&nbsp;<input type="radio" name="gender" value="1" {if $req.gender eq '1'}checked{/if}/> Female </span></td>
	</tr>
	<tr>
		<td align="right" valign="top"><span class="txt" style="height:25px; line-height:25px;"><span class="lbl">{$lang.labelBusinessName}*</span></span></td>
		<td colspan="2"><span class="style11"><font face="Verdana" size="1"><input name="bu_name" type="text" class="inputB" id="bu_name" value="{$req.bu_name}" size="30" maxlength="60" /><a  class="help" href="#" ><img src="/skin/red/images/icon-question.gif" width="21" height="20" border="0" align="top" style="margin:4px 5px;" /><span><span style="color:#777; z-index:100">This is the name you will create for yourself in Food Marketplace.</span></span></a>
		</font></span>
        <div id="bu_name_clew" style="display:none;margin-left:0; position:static;"></div></td>
	</tr>
	
	<tr>
		<td align="right" valign="top"><span class="txt" style="height:25px; line-height:25px;"><span class="lbl">{$lang.labelurlstring}*</span></span></td>
		<td colspan="2"><span class="style11"><font face="Verdana" size="1">{if $userlevel==2}<input name="bu_urlstring" type="text" class="inputB" id="bu_urlstring" size="30" value="{$req.bu_urlstring}" onkeyup="changeUrl(this.value)" onblur="checkWebsite();" onfocus="javascript:webstatu='error';" maxlength="60"/>{else}<input name="bu_urlstring" type="text" class="inputB" id="bu_urlstring" value="{$req.bu_urlstring}" size="30" onkeyup="changeUrl(this.value)" onblur="checkWebsite();"  onfocus="javascript:webstatu='error';" maxlength="60"/><input type="hidden" name="bu_name_default" value="{$req.bu_urlstring}">{/if}<a  class="help" href="#" ><img src="/skin/red/images/icon-question.gif" width="21" height="20" border="0" align="top" style="margin:4px 5px;" /><span><span style="color:#777; z-index:100">This is the URL you will create for yourself on Food Marketplace so that people can visit your website directly from the internet.
</span></span></a></font></span>
        <div id="msgbox1" style="display:none;width:220px; margin-left:0; position:static;"></div></td>
	</tr>
	
	
	
	<tr>
		<td align="right" height="50">&nbsp;</td>
		<td colspan="2" class="tip">The URL String will automatically become your URL. <br />E.g. <span id="url" style="color: #0000FF">www.socexchange.com.au/{$req.bu_urlstring}</span></td>
	</tr>
	<tr valign="top">
		<td align="right" valign="middle"><span class="txt"><span class="lbl">{$lang.labelAddress}*<font color="#F11F44"></font></span></span></td>
		<td width="200"><span><font face="Verdana" size="1">
		<input type="text" class="inputB" id="bu_address" name="bu_address" value="{$req.bu_address}"/>
		</font></span></td>
		<td valign="middle"><input name="address_hide" type="checkbox" id="address_hide" value="1" {if $req.address_hide eq '1' } checked {/if}/> <span style="font-size:11px">Hide Address</span></td>
	</tr>
	<tr>
		<td align="right"><span class="txt"><span class="lbl">{$lang.labelState}*</span></span></td>
		<td colspan="2">
			<span class="style11">
			<select name="bu_state" class="select" id="bu_state" value="{$req.bu_state}" onchange="javascript:selectSuburb('bu_suburbobj', document.mainForm.bu_state.options[document.mainForm.bu_state.options.selectedIndex].value);" onfocus="document.getElementById('bu_postcode').value = '';">
			{$req.State}
			</select>
			</span>
			<input name="suburb" type="hidden" id="suburb" value="{$req.suburb}"/>		</td>
	</tr>
	<tr>
		<td align="right"><span class="txt"><span class="lbl">{$lang.labelCity}*</span></span></td>
		<td colspan="2">
			<span class="style11"><font face="Verdana" size="1"><font face="Verdana" size="1" id="bu_suburbobj">
			<select name="bu_suburb" id="bu_suburb" class="select" >
			{$req.Subburb}
			</select>
			</font></font></span>		</td>
	</tr>
	<tr>
		<td align="right"><span class="txt"><span class="lbl">{$lang.labelZIP}*</span></span></td>
		<td colspan="2">
			<span class="style11"><font face="Verdana" size="1">
			<input name="bu_postcode" type="text" class="inputB" id="bu_postcode" value="{$req.bu_postcode}" size="7" maxlength="7" />
			</font></span>		</td>
	</tr>
	<tr>
		<td align="right"><span class="txt"><span class="lbl">{$lang.labelPAC}*</span></span></td>
		<td colspan="2"><span class="style11"><font face="Verdana" size="1">
		<input name="bu_area" type="text" class="inputB" id="bu_area" value="{$req.bu_area}" size="5" maxlength="4" />
		</font></span></td>
	</tr>
	
	<tr>
		<td align="right"><span class="txt"><span class="lbl">{$lang.labelPhone}*</span></span></td>
		<td><span><font face="Verdana" size="1">
		<input name="bu_phone" type="text" class="inputB" id="bu_phone" value="{$req.bu_phone}" size="30" />
		</font></span></td>
		<td width="250"><input name="phone_hide" type="checkbox" id="phone_hide" value="1" {if $req.phone_hide eq '1' } checked {/if}/>
		<span style="font-size:11px">Hide Phone</span> </td>
	</tr>
	
	<tr id="divMobile" style="display:none;">
	  <td align="right"><span class="txt"><span class="lbl">{$lang.labelMobile}</span></span></td>
	  <td colspan="2">
	  <input name="mobile" class="inputB" id="mobile" value="{$req.mobile}" maxlength="25"></td>
	</tr>
	
	<tr align="left">
		<td align="right"><span class="txt"><span class="lbl">{$lang.labelContact}</span><span class="star">*</span></span></td>
		<td colspan="2">
			<select name="contact" id="contact" class="select">
			{foreach from=$lang.Contact item=cl}
			<option value="{$cl}" {if $cl eq $req.contact}selected{/if}>{$cl}</option>
			{/foreach}
			</select>		</td>
	</tr>
	
	<tr>
		<td align="right"><span class="txt"><span class="lbl">{$lang.labelFax} </span></span></td>
		<td colspan="2"><span class="style11"><font face="Verdana" size="1">
		<input name="bu_fax" type="text" class="inputB" id="bu_fax" value="{$req.bu_fax}" size="30" />
		</font></span></td>
	</tr>
{if false}	
	<tr id="trprocode" {if $req.StoreID neq "" || empty($req.attribute)}style="display:none"{/if}>
      <td align="right"><span class="txt"><span class="lbl">{$lang.labelProcode} </span></span></td>
	  <td colspan="2"><span class="style11"><font face="Verdana" size="1">
        <input name="bu_procode" type="text" class="inputB" id="bu_procode" value="{$req.bu_procode}" size="30" />
      </font></span></td>
	</tr>
{/if}	
	
{if $isUpdate eq false}
	<tr id="referid" style="display:none">
      <td align="right"><span class="txt"><span class="lbl">{$lang.labelreferrer} </span></span></td>
	  <td colspan="2"><span class="style11"><font face="Verdana" size="1">		
		{if $isUpdate == false} <input name="referrer" type="text" class="inputB" id="referrer" value="{$req.referrer}" size="30" onblur="checkrefid();" /><a  class="help" href="#" ><img src="/skin/red/images/icon-question.gif" width="21" height="20" border="0" align="top" style=" margin:4px 5px;" /><span><span style="color:#777; z-index:100">Enter the Referrer ID of the person who referred you to the site, or otherwise leave it blank.</span></span></a>{else}<span class="lbl" style="color:#F11F44">{$req.referrer}</span><input name="referrer" type="hidden" class="inputB" id="referrer" value="{$req.referrer}" size="30" />{/if}	
      </font></span></td>
	</tr>
{elseif $req.ref_name neq ''}


		<tr id="referid">
      <td align="right"><span class="txt"><span class="lbl" style="color:#F11F44">{$lang.labelreferrer} </span></span></td>
	  <td colspan="2"><span class="style11"><font face="Verdana" size="1">		
		<span class="lbl" style="color:#F11F44">{$req.ref_name}</span><input name="referrer" type="hidden" class="inputB" id="referrer" value="{$req.referrer}" size="30" />
      </font></span></td>
	</tr>

{/if}	
	<tr id="referrer_tips" style="display:none">
      <td align="right"><span class="txt"><span class="lbl" style="color:#F11F44"></span></span></td>
	  <td colspan="2"><span id="msgbox5" style="display:none; margin:5px 5px;width:220px;"></span></td>
	</tr>
	<tr id="trprocode" {if $req.StoreID neq "" || empty($req.attribute)}style="display:none"{/if}>
      <td align="right"><span class="txt"><span class="lbl">{$lang.labelProcode} </span></span></td>
	  <td colspan="2"><span class="style11"><font face="Verdana" size="1">
        <input name="bu_procode" type="text" class="inputB" id="bu_procode" value="{$req.bu_procode}" size="30" />
      </font></span></td>
	</tr>
	
	{if $isUpdate == false||$userlevel eq 2}
	<tr>
		<td height="30">&nbsp;</td>
		<td colspan="2"><b>
			<input name="agree" type="checkbox" id="agree" value="1" {if $req.agree==1 } checked {/if} />
			I agree to the site <a href="soc.php?cp=terms" target="_blank">terms of use</a>. </b></td>
	</tr>
	{/if}
</table>

<div id="right_flash_signon" >
<div id="" style="margin-top:17px;">
	<!--<img src="/skin/red/images/earn_tell_friend.jpg" border="0" usemap="#mapms" title="Earn $$$.. Tell a friend"  alt="Earn $$$.. Tell a friend" style="margin-bottom:7px;" />-->
	<img src="/skin/red/images/sell_online_year_flat_rate.jpg" border="0" usemap="#mapms" title="Sell everything online For $10 a year rate"  alt="Sell everything online For $10 a year rate"/>
	
</div>

</div>

<!-- payment for registration -->
{if !$isUpdate || $userlevel eq 2}
	<input type="hidden" name="item_name" value="Deposit money in your account">
	<input type="hidden" name="currency_code" value="AUD">
	<input type="hidden" name="amount" id="amount" value="10">
    <input name="amount1" type="hidden" value="10" />
	{if $req.paymentMethod eq ''}
	<input type="hidden" name="cmd" value="_xclick">
	<input type="hidden" name="rm" value="2">
	<input type="hidden" name="business" value="{$paypalInfo.paypal_email}">
	<input type="hidden" name="return" value="{$paypalInfo.paypal_siteurl}soc.php?act=signon&step=startSelling_ipn">
	<input type="hidden" name="cancel_return" value="{$paypalInfo.paypal_siteurl}">
	<input type="hidden" name="notify_url" value="{$paypalInfo.paypal_siteurl}soc.php?act=signon&step=startSelling_ipn">
	<input type="hidden" name="custom" id="custom" value="">
	{/if}

	<div id="payDivContainer" style="padding:0px; margin:0px 0px 0px 30px;">
	<img id="payDivContainer_image1" src="/skin/red/images/step1_top.jpg"  style="padding:0px; margin:0px;"/><div id="payDivContainer_content" style="padding:10px;" align="center">
		<div id="payOptions1" style="width:450px; margin-bottom:10px; font-size:14px; line-height: 150%; {if $req.attribute neq "1"}display:block;{/if}">
			<!--<font style="font-weight:normal;font-size:18px;">Open your website now for </font><font style="font-size:26px;color:#F11F44">just <b style="font-size:26px;color:#F11F44;font-weight:bold;">$10</b> per year</font><br /><font style="font-size:18px;">that's <font style="color:#3D2F84;font-size:18px;"><font style="font-weight:bold;font-size:18px;color:#3D2F84;">83 cents</font> per month</font> or only<font style="color:#3D2F84;font-size:18px;"> <font style="font-weight:bold;font-size:18px;color:#3D2F84;">2.7 cents</font> per day!</font></font>-->
            <font style="font-weight:normal;font-size:18px; color:#f6670f;">Register to get your </font>			
			<font style="font-size:18px;color:#3c2a86; font-weight:bold;">1 yr <b style="font-size:22px;color:#3c2a86;font-weight:bold;">FREE</b> membership.</font><br /><font style="font-size:18px;">Open your SOC store and start selling now!</font>
		</div>
		<div id="payOptions2" style="width:450px; margin-bottom:10px; font-size:14px; line-height: 150%; {if $req.attribute neq "1"}display:none;{/if}">
			Yes! <font style="font-weight:bold; font-size:14px;">Sell as many Real Estate properties</font> as you like for <font style="font-weight:bold; color:#0000FF; font-size:14px;">$10 per Year Flat Rate!</font>
		</div>
			
		<div id="payOptions3" style="width:450px; margin-bottom:10px; font-size:14px; line-height: 150%; {if $req.attribute neq 2}display:none;{/if}">
			Yes! <font style="font-weight:bold; font-size:14px;">Sell as many cars or bikes</font> as you like for <font style="font-weight:bold; color:#0000FF; font-size:14px;">$10 per Year Flat Rate!</font>
		</div>
			 
		<div id="payOptions4" style="width:450px; margin-bottom:10px; font-size:14px; line-height: 150%; {if $req.attribute neq 3}display:none;{/if}">
			Yes! <font style="font-weight:bold; font-size:14px;">Find your entire workforce, post as many 'positions vacant' or post as many resume's</font> as you like for <font style="font-weight:bold; color:#0000FF; font-size:14px;">$10 per Year Flat Rate!</font>
		</div>
		
		<div id="payOptions6" style="width:450px; margin-bottom:10px; font-size:14px; line-height: 150%; {if $req.attribute neq 5}display:none;{/if}">
			<font style="font-weight:normal;font-size:18px;">Open your website now for </font><font style="font-size:26px;color:#F11F44">just <b style="font-size:26px;color:#F11F44;font-weight:bold;">$10</b> per year</font><br /><font style="font-size:18px;">that's <font style="color:#3D2F84;font-size:18px;"><font style="font-weight:bold;font-size:18px;color:#3D2F84;">83 cents</font> per month</font> or only<font style="color:#3D2F84;font-size:18px;"> <font style="font-weight:bold;font-size:18px;color:#3D2F84;">2.7 cents</font> per day!</font></font>
		</div>
        <div class="clear"></div>
        <div style="width:380px; margin-bottom:10px;font-size:10px;">All state and federal taxes are included.
        </div>
		<fieldset style="margin-right:10px;">
		<input src="/skin/red/images/bu-continuepayment.gif" class="submit form-continuepayment" type="image" onclick="paymentSubmitSet(); document.mainForm.cp.value='payment';">
		</fieldset>
	</div>	
	<img id="payDivContainer_image2" src="/skin/red/images/step1_bottom.jpg" />
<br /><br />
		{if $paymentMethod eq 'paypal'}
		<ul id="creditcards" style="width:75px; padding:0px; margin:5px 0px 12px 0px;">
		<li style="margin-left:10px;"><img src="/skin/red/images/logo-paypal.gif"></li>
		</ul>
		<div style=" width:400px; float:right;">
			<small style="font-size:10px;">You will be taken to Paypal for payment. Please make sure you return back to Food Marketplace from the payment confirmation page on Paypal.</small>
		</div>
        {/if}
	</div>
	
	<div id="payDivContainer2" style=" margin-left:160px; display:none;">
		<input src="/skin/red/images/bu-nextsave.gif" class="submit form-continuepayment" type="image" onclick="paymentSubmitSet(); document.mainForm.cp.value='payment';">
	</div>

{/if}
<fieldset style="text-align:left; padding-left:158px; padding-top:20px;">
	{if $isUpdate == true}
		{if $userlevel eq 1}
		<input src="{if $smarty.session.attribute == 0}/skin/red/images/buyseller_step_button/edit_store_details.gif{else}/skin/red/images/bu-nextsave.gif{/if}" class="submit form-save" type="image" {if $isUpdate == false}disabled{/if} onclick="document.mainForm.cp.value='next';">
		<!--<input src="/skin/red/images/bu-saveexit.gif" class="submit form-save" type="image" {if $isUpdate == false}disabled{/if} onclick="document.mainForm.cp.value='save';">-->
		{/if}
	{/if}
</fieldset>
</form>
</div>
