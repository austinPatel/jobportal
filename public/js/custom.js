/*
* ----------------------------------------------------------------------------------------
Author       :  pixshed
Template Name:  Mega Jobs - Job board
Version      :  1.0
* ----------------------------------------------------------------------------------------
*/

$(document).on('ready', function() {

// DROPDOWN ANIMATION
	$('.dropdown').on('show.bs.dropdown', function() {
    	$(this).find('.dropdown-menu').first().stop(true, true).slideDown();
  	});
  	$('.dropdown').on('hide.bs.dropdown', function() {
    	$(this).find('.dropdown-menu').first().stop(true, true).slideUp();
  	});
//	CLIENTS SLIDER
	$(".clients").slick({
		dots:false,
		arrows:false,
		infinite:true,
		slidesToShow:10,
		slidesToScroll:1,
		autoplay:true,
		autoplaySpeed:2000,
		responsive:[
		{
			breakpoint:770,
			settings:{
				slidesToShow:8,
				slidesToScroll:1
			}
		},
		{
			breakpoint:650,
			settings:{
				slidesToShow:6,
				slidesToScroll:2
			}
		},
		{
			breakpoint:490,
			settings:{
				slidesToShow:4,
				slidesToScroll:1
			}
		},
		{
			breakpoint:370,
			settings:{
				slidesToShow:2,
				slidesToScroll:1
			}
		}]
	});
//	ALERT VERTICAL SLIDER
	$(".alert-list").slick({
		dots:false,
		arrows:false,
		infinite:true,
		slidesToShow:8,
		slidesToScroll:1,
		autoplay:true,
		autoplaySpeed:1500,
		vertical:true
	});
//	A to Z FILTER SLIDER
	$(".filter-by").slick({
		dots:false,
		arrows:false,
		infinite:false,
		slidesToShow:28,
		slidesToScroll:1,
		autoplay:false,
		autoplaySpeed:2000,
		responsive:[
		{
			breakpoint:770,
			settings:{
				slidesToShow:16,
				slidesToScroll:15
			}
		},
		{
			breakpoint:650,
			settings:{
				slidesToShow:14,
				slidesToScroll:13
			}
		},
		{
			breakpoint:490,
			settings:{
				slidesToShow:10,
				slidesToScroll:9
			}
		},
		{
			breakpoint:370,
			settings:{
				slidesToShow:7,
				slidesToScroll:6
			}
		}]
	});

//	MARK AND UNMARK FAVORITE
	$("a.mark-favorite").on("click", function(){
		$(this).find("i").toggleClass("fa-star-o");
		$(this).find("i").toggleClass("fa-star");
	});

//	TOGGLE LIST AND GRID VIEW ON HOME PAGE

	var toggleView = $(".change-view a");
	var toggleList = $(".change-view a.list");
	var toggleGrid = $(".change-view a.grid");
	var classicListView = $(".classic-list-view");
	var gridView = $(".grid-view");

	// Toggle active class to toggle buttons
	toggleView.on("click", function(){
		toggleView.removeClass("active");
		$(this).addClass("active");
	});

	// Toggle between list view and grid view
	toggleList.on("click", function(){
		classicListView.slideDown();
		gridView.slideUp();
	});
	toggleGrid.on("click", function(){
		gridView.slideDown();
		classicListView.slideUp();
	});

//	TOGGLE JOBLISTING FILTERS
	var categoryExpand = $(".category-title a.expand");
	categoryExpand.on("click", function(){
		var categoryExpandIcon = $(this).find("i");
		var filterList = $(this).closest("div.filters-wrap").find("div.filter-list")

		// Toogle icon class
		categoryExpandIcon.toggleClass("fa-plus");
		categoryExpandIcon.toggleClass("fa-minus");
		
		// Toggle filter wrapper
		filterList.slideToggle(500);
	});

//	COUNTDOWN TIMER
	$('#clock').countdown('2020/12/31').on('update.countdown', function(event) {
	  var $this = $(this).html(event.strftime(''
	    + '<span>%-w<small>week%!w</small></span>'
	    + '<span>%-d<small>day%!d</small></span>'
	    + '<span>%H<small>hr</small></span>'
	    + '<span>%M<small>min</small></span>'
	    + '<span>%S<small>sec</small></span>'));
	});

// TEXT EDITOR
	$('.summernote').summernote({
		height: 200,                 // set editor height
		minHeight: null,             // set minimum height of editor
		maxHeight: null,             // set maximum height of editor
		focus: true,
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica Neue', 'Helvetica', 'Impact', 'Lucida Grande', 'Tahoma', 'Times New Roman', 'Verdana']
	});
});