$(document).on('turbolinks:load', function() {
  $('.project__form_create').on('ajax:success', function(e) {
    $('.errors').html('');
    var title = e.detail[0].project.title;
    var id = e.detail[0].project.id;
    console.log(title);
    console.log(e.detail[0]);
    $('.projects').append(JST['templates/project']({
      title: title,
      id: id
    }));
    $(this).find('input').val('');
    $('.button_toggle_show_hide_form_create, .project__form_create').toggleClass('d-none')
  }).on('ajax:error', function(e) {
    $('.errors').html('');
    var messages = e.detail[0].messages;
    $('.errors').append(JST['templates/errors']({
      messages: messages
    }))
  })
});
