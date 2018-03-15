import "bootstrap";
import {showPickerForm} from "../components/show_pick.js"

showPickerForm();
$(document).ready(function(){
  // After 3 seconds the alerts are vanishing
  setTimeout(
    function() {
      $('.alert').slideUp();
  }, 2000);
})
