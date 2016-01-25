function postToApi(url, data1){
  $.ajax({
    url: "",
    type: "POST", 
    beforeSend: function(xhr){
      xhr.setRequestHeader("X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content"));
    },
    data: { request_data: data1},
    success: function(response){
      console.log(response)
    }

  });

}