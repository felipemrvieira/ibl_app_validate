$(window).load ->
  $('[data-provider="summernote"]').each ->
    $(this).summernote
      height: 300