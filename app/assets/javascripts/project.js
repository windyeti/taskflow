$(document).on('turbolinks:load', function() {
  $('.project__form_create').on('ajax:success', function(e) {
    $('.errors').html('');
    var title = e.detail[0].project.title;
    var id = e.detail[0].project.id;
    var status = e.detail[0].status;
    var typejobs = e.detail[0].typejobs;
    var cost = e.detail[0].cost;
    $('.projects').prepend(JST['templates/project']({
      title: title,
      id: id,
      status: status,
      typejobs: typejobs,
      cost: cost,
    }));
    $(this).find('input[type="text"], textarea').val('');
    $('.button_toggle_show_hide_form_create, .project__form_create').toggleClass('d-none')
  }).on('ajax:error', function(e) {
    $('.errors').html('');
    var messages = e.detail[0].messages;
    $('.errors').append(JST['templates/errors']({
      messages: messages
    }))
  })
});
