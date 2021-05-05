// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= link_directory ../javascripts .js
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery_ujs

function elementCreate(tag, tag_id, tag_class, tag_text, tag_data_attr = {}) {
    let element = document.createElement(tag);
    element.textContent = tag_text;
    if (tag_id != '') {
        element.setAttribute('id', tag_id);
    }
    if (tag_class != '') {
        element.setAttribute('class', tag_class)
    }
    if (tag_data_attr != {}){
        for (let tag_attr in tag_data_attr){
            element.setAttribute(tag_attr, tag_data_attr[tag_attr])
            tag_data_attr[tag_attr]
        }
    }
    return element
}