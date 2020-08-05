// jQuery(function() {
//     var paths;
//     paths = $('#question_path_id').html();
//     console.log(paths);
//     return $('#level_level_id').change(function() {
//         var country, options;
//         country = $('#level_level_id :selected').text();
//         options = $(paths).filter("optgroup[label=" + country + "]").html();
//         console.log(options);
//         if (options) {
//         return $('#question_path_id').html(options);
//         } else {
//         return $('#question_path_id').empty();
//         }
//     });
// });