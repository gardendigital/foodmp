<link type="text/css" href="/skin/red/css/global.css" rel="stylesheet" media="screen" />
{include_php file='include/jssppopup.php'}
{literal}
<script language="javascript">
window.onload=function(){
Nifty("div#seller-left-head","medium tl ");
Nifty("div#seller-infonew","big bl");
}
</script>
{/literal}
<div id="seller" class="estate-c">
{include file='estate/template/estate-display-product-summary.tpl'}
</div>
<div id="products">
{include file='estate/template/estate-display-product-content.tpl'}

<div id="paging" style="background:#{$templateInfo.bgcolor}; width:487px;"><strong><a href="/soc.php?cp=disprolist&StoreID={$req.info.StoreID}">All Properties</a>&nbsp;&nbsp;({$req.itemNumbers})</strong> </div>

</div>