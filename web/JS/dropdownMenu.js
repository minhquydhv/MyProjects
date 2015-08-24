$(document) .ready(function()
{
	$("#nav li").hover(function()
	{
		$(this).find('ul:first').css({visibility:"visible",display:"none"}).show(800);
	},function(){
		$(this).find('ul:first').css({visibility:"hidden"});
	});
});