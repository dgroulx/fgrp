$(document).ready( function() {
  $(".user_set_admin_checkbox").on("change", function() {
    url = '/admin/users/' + $(this).data('id') + '.json';
    var is_checked = $(this).is(":checked");
    data = {_method: 'PUT',
            user: {admin: is_checked}};
    $.ajax({
      url: url,
      type: 'POST',
      data: data
    });
  });
});
