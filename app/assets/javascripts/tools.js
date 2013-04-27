function log(mssg) {
    if (typeof(console) != 'undefined' &&
        typeof(console.log) == 'function') {
        console.log(mssg);
    }
}

function select_option(value, text, object) {
  var obj = "";
  var option = $('<option value="'+value+'">'+text+'</option>');

  if (typeof object !== "undefined")
    option.data("object", object);

  return option;
}

function select_options(data, value_key, text_key, container) {
  var options = [];
  if (typeof value_key == "undefined") value_key = "id";
  if (typeof text_key == "undefined") text_key = "nombre";
  
  _.each(data, function(item) {
    if (typeof container !== "undefined")
      options.push( select_option(item[container][value_key], item[container][text_key], item) );
    else
      options.push( select_option(item[value_key], item[text_key], item) );
  });

  return options;
}

jQuery.fn.appendEach = function( arrayOfWrappers ) {
  var rawArray = jQuery.map(
    arrayOfWrappers,
    function( value, index ){
    return( value.get() );

    }
  );
  this.append( rawArray );
  return( this );
};