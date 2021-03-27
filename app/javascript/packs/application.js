// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// External imports
import "bootstrap";

// Internal imports
import { updateLibrary } from "../plugins/update_library";

document.addEventListener('turbolinks:load', () => {
  
  $(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
  });

  updateLibrary()

  if (document.querySelector('.carousel-item')) {
    document.querySelector('.carousel-container-1').classList.add('active');
    document.querySelector('.carousel-container-2').classList.add('active');
    document.querySelector('.carousel-container-3').classList.add('active');
  }

  if (document.getElementById('btn-write-review')) {
    document.getElementById('btn-write-review').addEventListener('click', (event) => {
      $('#review-form').modal();
    });
  }

});
