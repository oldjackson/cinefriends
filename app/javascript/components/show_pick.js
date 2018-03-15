import flatpickr from 'flatpickr';

function enableTheaters(date)
{
  const btnSelect = document.getElementById('new_post_btn');
  btnSelect.disabled = true;

  const theaterSelect = document.getElementById('show_theater');
  const theaterSelectLength = theaterSelect.options.length;
  for (let i=1; i<theaterSelectLength; i++ ){
    theaterSelect.options[i] = null;
  }

  const timeSelect = document.getElementById('show_time');
  const timeSelectLength = timeSelect.options.length;
  for (let i=1; i<timeSelectLength; i++ ){
    timeSelect.options[i] = null;
  }
  timeSelect.disabled = true;

  const id = window.location.href.split('/')[4];
  const dateForm = new FormData();
  const token = document.querySelector('meta[name=csrf-token]').content;

  dateForm.append('date', date);

  fetch(`${id}/filter_theaters`, {
    method: 'POST',
    body: dateForm,
    headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-Token': token
    },
    credentials: 'same-origin'
  }).then( response => response.json() )
  .then((json) => {
    const theaters = json.theaters;

    for(var i = 0; i < theaters.length; i++) {
      var opt = theaters[i];
      var el = document.createElement("option");
      el.textContent = opt.name;
      el.value = opt.id;
      theaterSelect.appendChild(el);
    }

    theaterSelect.disabled = false;

  });
}

function enableTimes(event){
  const timeSelect = document.getElementById('show_time');
  const timeSelectLength = timeSelect.options.length;
  for (let i=1; i<timeSelectLength; i++ ){
    timeSelect.options[i] = null;
  }

  const id = window.location.href.split('/')[4];
  const dateTheaterForm = new FormData();
  const token = document.querySelector('meta[name=csrf-token]').content;

  const showDateField = document.getElementById("show_date");
  dateTheaterForm.append('date', showDateField.value);;
  dateTheaterForm.append('theater_id', event.target.value);

  fetch(`${id}/filter_shows`, {
    method: 'POST',
    body: dateTheaterForm,
    headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-Token': token
    },
    credentials: 'same-origin'
  }).then( response => response.json() )
  .then((json) => {
    const shows = json.shows;

    for(var i = 0; i < shows.length; i++) {
      var opt = shows[i];
      var el = document.createElement("option");
      el.textContent = opt.time;
      el.value = opt.id;
      timeSelect.appendChild(el);
    }

    timeSelect.disabled = false;

  });
}

function enableSubmit(event){
  const btnSelect = document.getElementById('new_post_btn');
  if (btnSelect) {
    btnSelect.disabled = false;
  }
}

const showPickerForm = function() {
  const showDateField = document.getElementById("show_date");
  if (showDateField) {
    const dates = JSON.parse(showDateField.dataset.dates);
    showDateField.flatpickr({
      altInput: true,
      altFormat: "d M Y",
      dateFormat: "Y-m-d",
      enable: dates,
      onChange: enableTheaters
    });
  }
  const showTheaterField = document.getElementById("show_theater");
  if (showTheaterField) {
    showTheaterField.addEventListener('change', enableTimes);
  }

  const showTimeField = document.getElementById("show_time");
  if (showTimeField) {
    showTimeField.addEventListener('change', enableSubmit);
  }

};

export {showPickerForm}
