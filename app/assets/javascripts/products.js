//= require typeahead.bundle
console.log('Manju')

$(document).on('turbolinks:load', function(){
  console.log('loaded')
  var products = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/products/autocomplete?query=%QUERY',
      wildcard: '%QUERY'
    }
  });
  $('#product_search').typeahead(null, {
    source: products
  });
}) 