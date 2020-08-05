//= require bootstrap
//= require morris

//= require jquery-ui
//= require jquery-ui/core
//= require jquery-ui/widget
//= require jquery-ui/position

// = require jquery.ui.touch-punch



$(document).ready(function () {
    $('.shrinker').removeClass('timelapse');
    setTimeout(function () {
      $('.shrinker').addClass('timelapse');
    }, 500)
});

// Questão combinar
$(document).ready(function () {
  var container = $('.container-opcoes');
  var container1= $('.container1');
  var container2 = $('.container2');
  var opcao = $('.opcao');
  var input = $('#quiz_question_text');

  $('.btn').click(function(){
    var cc = $(this).attr('parent_combination');
    console.log(cc);
    var ret1='',
        ret2='',
        ar1 = $('#'+cc+'1').sortable('toArray', {attribute: 'value'}),
        ar2 = $('#'+cc+'2').sortable('toArray', {attribute: 'value'});
      for (key in ar1) {
        ret1 += ar1[key];
      }
      for (key in ar2) {
        ret2 += ar2[key];
      }
      $('#'+cc+'-input').val(ret1+ ":"+ ret2);
  });

  function handleMouse(e) {
    if (e.type == "mouseenter") {
      $(this).addClass('highlight');
    }
    else if (e.type == "mouseout") {
      $(this).removeClass('highlight');
    }

    var cc = $(this).attr('parent')

      var ret1='',
        ret2='',
        ar1 = $('#'+cc+'1').sortable('toArray', {attribute: 'value'}),
        ar2 = $('#'+cc+'2').sortable('toArray', {attribute: 'value'});
      for (key in ar1) {
        ret1 += ar1[key];
      }
      for (key in ar2) {
        ret2 += ar2[key];
      }
      $('#'+cc+'-input').val(ret1+ ":"+ ret2);
  }

  container1.delegate('.opcao','mouseenter mouseout',handleMouse);
  container1.sortable();
  container1.disableSelection();

  container2.delegate('.opcao','mouseenter mouseout',handleMouse);
  container2.sortable();
  container2.disableSelection();

  opcao.sortable();

});


/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */
// function showCourses() {
//   document.getElementById("myDropdown").classList.toggle("show-dropdown");
// }

// Close the dropdown if the user clicks outside of it
// window.onclick = function(event) {
//   if (!event.target.matches('.dropdown')) {

//     var dropdowns = document.getElementsByClassName("dropdown-content");
//     var i;
//     for (i = 0; i < dropdowns.length; i++) {
//       var openDropdown = dropdowns[i];
//       if (openDropdown.classList.contains('show-dropdown')) {
//         openDropdown.classList.remove('show-dropdown');
//       }
//     }
//   }
// }

$(document).ready(function () {
  $('.dropdown').click(function(e) {
    $('#myDropdown').toggleClass('show-dropdown');
  });

});

function mostraMenu() {
  var x = document.getElementById("info");
  if (x.style.display === "block") {
    x.style.display = "none";
  } else {
    x.style.display = "block";
  }
}

$(document).ready(function () {

  $(window).scroll(function () {
    var sc = $(window).scrollTop()
    if (sc > 100) {
        $(".navbar").addClass("fixed")
    } else {
        $(".navbar").removeClass("fixed")
    }
  })
});

$(document).ready( function() {
  $('.alert').delay(3000).fadeOut();
});

$(document).ready(function(){

  // Aprender
  $('.form-aprender').first().removeClass('hide');
  $('.form-aprender-0').removeClass('hide');
  $('.form-aprender-erro').first().removeClass('hide');
  // Praticar
  $('.form-praticar').first().removeClass('hide');
  $('.form-praticar-0').removeClass('hide');
  $('.form-praticar-erro').first().removeClass('hide');

  $("form:first-of-type").removeClass('hide');

});


