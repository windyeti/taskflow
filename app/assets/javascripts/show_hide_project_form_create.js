$(document).on('turbolinks:load', function() {
  $('.button_toggle_show_hide_form_create').on('click', function() {
    $('.button_toggle_show_hide_form_create, .project__form_create').toggleClass('d-none')
  })
});
