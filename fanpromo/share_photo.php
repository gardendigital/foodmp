<?php 
//header("X-Frame-Options:sameorigin");

error_reporting(E_ERROR);
ini_set('display_errors', 1);

include_once ('../include/config.php');
include_once "main.php";


if (isset($_POST) && $_POST["share"]){
    $rs =     share_photo();
}
 


?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Share Email</title>
    <style>         
        body {
            background-image: url(http://kreativo.se/backlogin.jpg);
            font-family: "Helvetica Neue", Helvetica, Arial;
            padding-top: 20px;
        }
        .container {
            width: 406px;
            max-width: 406px;
            margin: 0 auto;
        }
        #vote-form {
            padding: 0px 25px 25px;
            background: #fff;
            box-shadow: 
                0px 0px 0px 5px rgba( 255,255,255,0.4 ), 
                0px 4px 20px rgba( 0,0,0,0.33 );
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
            display: table;
            position: static;
        }
        
        #vote-form .header {
            margin-bottom: 20px;
        }
        
        #vote-form .header h3 {
            color: #333333;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        #vote-form .header p {
            color: #8f8f8f;
            font-size: 14px;
            font-weight: 300;
        }
        
        #vote-form .sep {
            height: 1px;
            background: #e8e8e8;
            width: 406px;
            margin: 0px -25px;
        }
        
        #vote-form .inputs {
            margin-top: 25px;
            font-size: 21px;
        }
        
        #vote-form .inputs label {
            color: #8f8f8f;
            font-size: 12px;
            font-weight: 300;
            letter-spacing: 1px;
            margin-bottom: 7px;
            display: block;
        }
        
        input::-webkit-input-placeholder {
            color:    #b5b5b5;
        }
        
        input:-moz-placeholder {
            color:    #b5b5b5;
        }
        
        #vote-form .inputs input, #vote-form textarea {
            background: #f5f5f5;
            font-size: 20px;
            -moz-border-radius: 3px;
            -webkit-border-radius: 3px;
            border-radius: 3px;
            border: none;
            padding: 13px 10px;
            width: 330px;
            margin-bottom: 20px;
            box-shadow: inset 0px 2px 3px rgba( 0,0,0,0.1 );
            clear: both;
        }
        
        #vote-form .inputs input[type=email]:focus, input[type=password]:focus {
            background: #fff;
            box-shadow: 0px 0px 0px 3px #fff38e, inset 0px 2px 3px rgba( 0,0,0,0.2 ), 0px 5px 5px rgba( 0,0,0,0.15 );
            outline: none;   
        }        
        
        
        #vote-form .inputs label.terms {
            float: left;
            font-size: 14px;
            font-style: italic;
        }
        
        #vote-form .inputs #submit {
            width: 100%;
            margin-top: 20px;
            padding: 15px 0;
            color: #fff;
            font-size: 14px;
            font-weight: 500;
            letter-spacing: 1px;
            text-align: center;
            text-decoration: none;
                background: -moz-linear-gradient(
                top,
                #b9c5dd 0%,
                #a4b0cb);
            background: -webkit-gradient(
                linear, left top, left bottom, 
                from(#b9c5dd),
                to(#a4b0cb));
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
            border: 1px solid #737b8d;
            -moz-box-shadow:
                0px 5px 5px rgba(000,000,000,0.1),
                inset 0px 1px 0px rgba(255,255,255,0.5);
            -webkit-box-shadow:
                0px 5px 5px rgba(000,000,000,0.1),
                inset 0px 1px 0px rgba(255,255,255,0.5);
            box-shadow:
                0px 5px 5px rgba(000,000,000,0.1),
                inset 0px 1px 0px rgba(255,255,255,0.5);
            text-shadow:
                0px 1px 3px rgba(000,000,000,0.3),
                0px 0px 0px rgba(255,255,255,0);
            display: table;
            position: static;
            clear: both;
        }
        
        #vote-form .inputs #submit:hover {
            background: -moz-linear-gradient(
                top,
                #a4b0cb 0%,
                #b9c5dd);
            background: -webkit-gradient(
                linear, left top, left bottom, 
                from(#a4b0cb),
                to(#b9c5dd));
        }
    </style>
    
    
</head>
<body>
<div class="container popup">
    <form method="post" action="" id="vote-form">
        <div class="header">    
            <h3>Share photo with your friends</h3>
        </div>    
        <span class="invalid"> 
        
        <?php
        if ($rs["message"]){
            echo  $rs["message"];
        }
        ?>
        </span>
        
        <div class="inputs">
            To Email
             <input type="text" id="to_email" name="to_email" class="input">
            Message
            <textarea rows="5" cols="45" name="message"></textarea>
            <input type="hidden" id="photop_id" name="photop_id" value="<?php echo $_REQUEST["photo_id"]?>">
            <input type="hidden" id="brand_image" name="brand_image" value="<?php echo $_REQUEST["brand_image"]?>">
            <input type="hidden" id="share_url" name="share_url" value="<?php echo $_REQUEST["share_url"]?>">
            <input type="submit" value="Share" name="share" id="submit">
        </div>
    </form>
</div>

<?php 
function share_photo(){

	$email_to = filter_var( $_REQUEST["to_email"], FILTER_VALIDATE_EMAIL );
	//$message = trim ($_REQUEST["message"]);
	
	if ($email_to == false){
		$error = true;
		$rs = array("message" => "Invalid Email", "error_code" => 2, "email_to"=> $email_to, "email_from" => $email_from);
	}
	if ($error == false){
		$emaildomain = substr(SOC_HTTP_HOST,strpos(SOC_HTTP_HOST,':')+3,-1);
	    $message = "<p>To 'Become a Fan' of this photo in the FoodMarketplace $1,000,000 Fan Frenzy, click here:   <a href='{$_REQUEST["share_url"]}'>{$_REQUEST["share_url"]}</a></p>";
	    $message .= "<p>".trim ($_REQUEST["message"])."</p>";
		$headers  = 'MIME-Version: 1.0' . "\r\n";
		$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
		$headers .= 'From: FoodMarketplace <FanFrenzy@'.$emaildomain.'>' . "\r\n";
		mail($email_to, "Your friend {$email_from} is sharing a photo from FoodMarketplace", $message, $headers);
		$rs = array("message" => "Share successfull", "error_code" =>0);
	}
	return $rs;
	
}
?>

</body>

</html>