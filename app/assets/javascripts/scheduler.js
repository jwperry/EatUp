$(function(){  
  $(".scheduler-events-card-wrapper").on("click", ".scheduler-event-wrapper", function(){
    $(this).hide().appendTo(".scheduler-selected-card-wrapper").fadeIn("slow");
  });

  $(".scheduler-selected-card-wrapper").on("click",  ".scheduler-event-wrapper", function(){
    $(this).hide().appendTo(".scheduler-events-card-wrapper").fadeIn("slow");
  });

$(".clear-button").click(function(event){
    event.preventDefault();
    $(".scheduler-selected-card-wrapper .scheduler-event-wrapper").each(function(){
      $(this).hide().appendTo(".scheduler-events-card-wrapper").fadeIn("slow");
    });
  });
    
  $(".save-button").click(function(){
    var events = [];

    $(".scheduler-selected-card-wrapper .scheduler-event-wrapper").each(function(){
      var event=$(this).data("event");
      events.push(event);
    });


    $.ajax({
      method: "POST",
      contentType: "application/json",
      url: "/events",
      data: JSON.stringify(events)
    });
    
  });
});
