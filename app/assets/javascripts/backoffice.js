//= require jquery
//= require jquery_ujs
//= require summernote/summernote-bs4.min
//= require summernote-init
//= require activestorage
//= require bootstrap_sb_admin_base_v2
//= require select2


// // Filtra os lições com base no nivel selecionado
jQuery(function() {

  $('#course_course_id').change(function() {
    var course_id = $(this).val();

    // $.ajax({url: '/backoffice/questions/list_levels', data: {course_id: course_id}})

    $.ajax({
      url: "/backoffice/questions/new",
      method: "GET",
      dataType: "json",
      data: {course_id: course_id},
      error: function (xhr, status, error) {
        console.error('AJAX Error: ' + status + error);
      },
      success: function (response) {
        var levels = response["levels"];
        console.log(levels);
        $("#level_level_id").empty();
        $("#level_level_id").append('<option>Selecione o nível</option>');
        for(var i=0; i< levels.length; i++){
          $("#level_level_id").append('<option value="' + levels[i]["id"] + '">' + levels[i]["title"] + '</option>');
        }
      }
    });

  });
});

// // Filtra os lições com base no nivel selecionado
jQuery(function() {

  $('#level_level_id').change(function() {
    var level_id = $(this).val();

    $.ajax({
      url: "/backoffice/questions/new",
      method: "GET",
      dataType: "json",
      data: {level_id: level_id},
      error: function (xhr, status, error) {
        console.error('AJAX Error: ' + status + error);
      },
      success: function (response) {
        var paths = response["paths"];
        console.log(paths);
        // para a questions#new
        $("#question_path_id").empty();
        $("#question_path_id").append('<option>Selecione a lição</option>');
        // para a questions#index
        $("#by_paths").empty();
        $("#by_paths").append('<option>Selecione a lição</option>');

        for(var i=0; i< paths.length; i++){
          $("#question_path_id").append('<option value="' + paths[i]["id"] + '">' + paths[i]["title"] + '</option>');
          $("#by_paths").append('<option value="' + paths[i]["id"] + '">' + paths[i]["title"] + '</option>');

        }
      }
    });

  });
});

// Adiciona placeholder ao select multiplo
$(".js-example-basic-single").select2({
  placeholder: "Por favor selecione"
});

// // // Filtra os lições com base no nivel selecionado
// jQuery(function() {
//   var paths;
//   paths = $('#question_path_id').html();
//   // console.log(paths);
//   return $('#path_level_id').change(function() {
//     var level, options;
//     level = $('#path_level_id :selected').text();
//     // console.log(level);

//     options = $(paths).filter("optgroup[label='" + level + "']").html();
//     // console.log(options);
//     if (options) {
//       return $('#question_path_id').html(options);
//     } else {
//       return $('#question_path_id').empty();
//     }
//   });
// });

// Exibe o campo de resposta com base no tipo de resposta
// selecionado ao trocar tipo de questao
jQuery(function() {
  $('#question_type_question').change(function() {

    opcao = $('#question_type_question').val();
    console.log(opcao);

    if (opcao == "Múltipla Escolha") {
      $('#question_options').removeClass("hide");
      $('#question_texts').addClass("hide");
      $('#question_texts_forca').addClass("hide");
      $('#question_combinations').addClass("hide");

    } else if(opcao == "Questão Aberta") {
      $('#question_texts').removeClass("hide");
      $('#question_options').addClass("hide");
      $('#question_texts_forca').addClass("hide");
      $('#question_combinations').addClass("hide");

    } else if(opcao == "Forca") {
      $('#question_texts_forca').removeClass("hide");
      $('#question_options').addClass("hide");
      $('#question_texts').addClass("hide");
      $('#question_combinations').addClass("hide");

    } else if(opcao == "Combinação") {
      $('#question_combinations').removeClass("hide");
      $('#question_texts').addClass("hide");
      $('#question_options').addClass("hide");
      $('#question_texts_forca').addClass("hide");
    }

  });
});



// Exibe o campo de resposta com base no tipo de resposta selecionado
// Ex: http://localhost:3000/backoffice/questions/38/edit
jQuery(function() {
    opcao = $('#question_type_question').val();
    console.log(opcao);
    if (opcao == "Múltipla Escolha") {
      $('#question_options').removeClass("hide");
      $('#question_texts').addClass("hide");
      $('#question_texts_forca').addClass("hide");
      $('#question_combinations').addClass("hide");


    } else if(opcao == "Questão Aberta") {
      $('#question_texts').removeClass("hide");
      $('#question_options').addClass("hide");
      $('#question_texts_forca').addClass("hide");
      $('#question_combinations').addClass("hide");
    }
    else if(opcao == "Forca") {
      $('#question_texts_forca').removeClass("hide");
      $('#question_texts').addClass("hide");
      $('#question_options').addClass("hide");
      $('#question_combinations').addClass("hide");
    }
    else if(opcao == "Combinação") {
      $('#question_combinations').removeClass("hide");
      $('#question_texts').addClass("hide");
      $('#question_options').addClass("hide");
      $('#question_texts_forca').addClass("hide");
    }
});

$(document).ready(function() {
  $('#question_description').summernote({
    maximumImageFileSize: 1048576,
    placeholder: 'As imagens devem ter no máximo 1 MB',


    // callbacks: {
    //   onImageUpload: function(files) {
    //     for (var i = files.length - 1; i >= 0; i--) {
    //       alert(files[i].size);
    //     }

    //   }
    // }
    callbacks: {
      onChange: function(contents, $editable) {
        console.log('onChange:', contents, $editable);
      }
    }
  });
});

// select2 componente de select personalizado
$(document).ready(function() {
  $('.js-example-basic-single').select2(
    {theme: "bootstrap"}
  );
});

// aplicado nos filtros no index
$(document).ready(function() {
  $('.js-example-basic-multiple').select2(
    {
      placeholder: "Selecione"
    }
  );
});
