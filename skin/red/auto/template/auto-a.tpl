<link type="text/css" href="/skin/red/css/global.css" rel="stylesheet" media="screen" />
{include_php file='include/jssppopup.php'}

<div id="seller" class="auto-a">
{if $req.images.mainImage.0.bname.text neq '/images/243x100.jpg'}
<img src="{$req.images.mainImage.0.bname.text}" width="{$req.images.mainImage.0.bname.width}" height="{$req.images.mainImage.0.bname.height}"/>
	<div style="height:5px;"></div>
{/if}

{include file='auto/template/auto-summary.tpl'}
</div>
<div id="products">
{include file='auto/template/auto-product-list.tpl'}
</div>