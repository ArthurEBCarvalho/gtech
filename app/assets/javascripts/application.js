// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// Masks
$('input.data').mask('00/00/0000');

// Altera a mask do filtro
$(document).on('change','select#filtro',function(){
	if($(this).val() == 'nascimento')
		$('input#valor').mask('00/00/0000');
	else
		$('input#valor').unmask();
});

if($("select#filtro").val() == "nascimento")
	$("input#valor").mask("99/99/9999");