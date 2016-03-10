var highlight_text = function(search_term, search_target) {
  var new_string = search_target.replace(new RegExp(search_term, "ig"), "<span style='background-color: yellow'>$&</span>");
  return new_string;
}

var search_terms = [ "free food", "free pizza", "free slice", "free snacks", "free sandwich", 
                     "free sandwiches", "free refreshments", "will be served",
                     "eat free", "free eats", "free drinks", "free beer", "free wine",
                     "free cocktails", "free meal", "free homecooked", "free home-cooked",
                     "free home cooked", "free dessert", "provide food", "provide pizza",
                     "provide snacks", "provide sandwiches", "provide drinks", "provide beer",
                     "provide wine", "provide cocktails", "provide dessert",
                     "provide ice cream", "provide eats", "with pizza", "with snacks",
                     "with refreshments"];


$(function(){
  $(".description-text").each(function(){
    var search_target = $(this).text();

    for (var i = 0; i < search_terms.length; i++)
    {
      search_target = highlight_text(search_terms[i], search_target);
    }
    $(this).html(search_target);
  });
});

