$(document).on('turbolinks:load', function() {
  $('.project__form_create').on('ajax:success', function(e) {
    $('.errors').html('');
    var title = e.detail[0].project.title;
    console.log(title)
    console.log(e.detail[0])
    $('.projects').append(JST['templates/project']({
      title: title
    }));
    $(this).find('input').val('')
  }).on('ajax:error', function(e) {
    $('.errors').html('');
    var messages = e.detail[0].messages;
    $('.errors').append(JST['templates/errors']({
      messages: messages
    }))
  })
});
