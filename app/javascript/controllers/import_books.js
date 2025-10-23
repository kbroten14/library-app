import $ from "jquery";

$(function() {
  const fileBtn = $('#choose-csv-btn');
  const submitBtn = $('#import-csv-btn');

  submitBtn.prop('disabled', true);

  fileBtn.on('change', validateFileInput);
});

function validateFileInput() {
  const file = $('#choose-csv-btn');
  
  // nothing special, just enabling if file exists
  // irl would also validate file type and size
  // choose-csv-btn currently only accepts .csv files anyways
  if (file.val()) {
    $('#import-csv-btn').prop('disabled', false);
  }
}

