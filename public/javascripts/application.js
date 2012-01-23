if (navigator.geolocation) {
  //alert('yep GPS!')
    navigator.geolocation.getCurrentPosition(
        getPosition,
        displayError,
        { enableHighAccuracy: true, timeout: 1000, maximumAge: 1000 }
      );


    function getPosition(position)
{
    lati = position.coords.latitude;
    longi = position.coords.longitude;
  //  form.latitude.value = lati;
  //  form.longitude.value = longi;
}
}
    function displayPosition(position) {
  alert("Latitude: " + position.coords.latitude + ", Longitude: " + position.coords.longitude);
    //    alert("hi");
}
    function displayError(position) {
  alert("error");
}


$(function () {
  $(window.applicationCache).bind('error', function () {
    alert('There was an error when loading the cache manifest.');
  });
 //////////////////////////Retrievedata///////////////////////////
//    $.retrieveJSON("/coversheet.json", function(data) {
//    $("#coversheet").html($("#coversheet_template").tmpl(data));
//  });

//     $.retrieveJSON("/orderpads/edit.json", function(data) {
//    $("#coversheet").html($("#coversheet_template").tmpl(data));
//  });

//});


//////////////////////////Senddata///////////////////////////
    if (!localStorage["pendingItems"]) {
    localStorage["pendingItems"] = JSON.stringify([]);
  }

    if (!localStorage["pendingOrders"]) {
    localStorage["pendingOrders"] = JSON.stringify([]);
  }


      $("#Po").click(function(e) {
          //var plat = displayPosition(position);
          var pendingOrders = $.parseJSON(localStorage["pendingOrders"]);
          var pendingOrderId = $.parseJSON(localStorage["pendingOrderId"]);
          var POE = $.parseJSON(localStorage["POE"]);
          var POC = $.parseJSON(localStorage["POC"]);
          var PAT = $.parseJSON(localStorage["PAT"]);
          var PES = $.parseJSON(localStorage["PES"]);
          var CheckInResultId = $('input[name="checkstatus"]:checked').val();
          var TemperatureId = $('input[name="order[TemperatureId]"]:checked').val();
          var WeatherId = $('input[name="order[WeatherId]"]:checked').val();
          var WindId = $('input[name="order[WindId]"]:checked').val();
          var WindSpeedId = $('input[name="order[WindSpeedId]"]:checked').val();
          var tin = $('#tin').val();
          var CheckInNote = $('#order_CheckInNote').val();
          var WorkOrderNote = $('#order_WorkOrderNote').val();
          var OrderId = $('input[name="oid"]').val();
          var CheckLatitude = lati; // position.coords.latitude;
          var CheckLongitude = longi;

          var OrderEquipment = [];
   $('input[name="order[Equipment_ids][]"]:checked').each(function(i, selected) {
     var role = [i];
     OrderEquipment[role] = {};
     OrderEquipment[role]["OrderId"] = OrderId;
     OrderEquipment[role]["EquipmentId"] = $(selected).val() ;
    var POE =   localStorage.setItem("POE",  JSON.stringify(OrderEquipment));
   });

             var OrderComment = [];
   $('input[name="order[Checkcomment_ids][]"]:checked').each(function(i, selected) {
     var role = [i];
     OrderComment[role] = {};
     OrderComment[role]["OrderId"] = OrderId;
     OrderComment[role]["CheckCommentId"] = $(selected).val() ;
    var POC =   localStorage.setItem("POC",  JSON.stringify(OrderComment));
   });

            var AreaTreated = [];
   $('input[name="order[Areatreated_ids][]"]:checked').each(function(i, selected) {
     var role = [i];
     AreaTreated[role] = {};
     AreaTreated[role]["OrderId"] = OrderId;
     AreaTreated[role]["AreaTreatedId"] = $(selected).val() ;
    var PAT =   localStorage.setItem("PAT",  JSON.stringify(AreaTreated));
   });

    var SelectPest = [];
   $('input[name="order[Pest_ids][]"]:checked').each(function(i, selected) {
    var role = [i];
    SelectPest[role] = {};
    SelectPest[role]["OrderId"] = OrderId;
    SelectPest[role]["PestId"] = $(selected).val() ;
    var PES =   localStorage.setItem("PES",  JSON.stringify(SelectPest));
    });




//var $fields8 = $('input[name="order[Pest_ids][]"]:checked');
//var fields5 = $('input[name="order[Areatreated_ids][]"]:checked');
  //        var Price =  $("input#orderprice").val();
  //        var areatreated = [];
  //    $('input[name="order[Areatreated_ids][]"]:checked +label').each(function(i, selected){
  //      areatreated[i] = $(selected).text();
//});



   //     var amount =  $('#orderbalance').val();

      alert('Order Stored' + OrderEquipment );

      var od = {"data":{"OrderId":OrderId, "CheckInResultId":CheckInResultId,"TemperatureId":TemperatureId,"WeatherId":WeatherId,"WindId":WindId, "WindSpeedId":WindSpeedId, "tin":tin, "WorkOrderNote":WorkOrderNote, "CheckInNote":CheckInNote, "CheckLatitude":CheckLatitude, "CheckLongitude":CheckLongitude}};
  pendingOrders.push(od);
  localStorage["pendingOrders"] = JSON.stringify(pendingOrders);

 //     var oe = OrderEquipment

//  POE.push(oe);
//  localStorage["POE"] = JSON.stringify(POE);

 //  pendingOrderEquipment
 //  sendPending();

  e.preventDefault();
});


    $('#Pe').live('click', function (e) {
  var pendingItems = $.parseJSON(localStorage["pendingItems"]);
  var quanfield = $(this).closest("tr").find(".quanclass");
  var chemidfield =  $(this).closest("tr").find(".chemidclass");
  var ordidfield = $(this).closest("tr").find(".ordidclass");
  var item = {"data":{"ChemId":chemidfield.val(),"OrderId":ordidfield.val(),"Quantity":quanfield.val()}, "orderchemical":{"Quantity":quanfield.val(),"OrderId":ordidfield.val()}};
  $("#oc_template").tmpl(item).appendTo("#oc");
  pendingItems.push(item);
  localStorage["pendingItems"] = JSON.stringify(pendingItems);
 //  sendPending();
  //$("#Quantity").val("");
  e.preventDefault();
});

    function sendChemical(){

        var pendingItems = $.parseJSON(localStorage["pendingItems"]);
        if (pendingItems.length > 0) {
        var item = pendingItems[0];
        $.post('/orderchemicals', item.data, function (data) {
          var pendingItems = $.parseJSON(localStorage["pendingItems"]);
          pendingItems.shift();
          localStorage["pendingItems"] = JSON.stringify(pendingItems);
          setTimeout(sendChemical, 100);

        });
      }
       }
     function sendOrder(){
        var pendingOrders = $.parseJSON(localStorage["pendingOrders"]);
        if (pendingOrders.length > 0) {
        var oitem = pendingOrders[0];
        $.get('/orders/update/'+ oitem.data.OrderId, oitem.data, function (data) {
          var pendingOrders = $.parseJSON(localStorage["pendingOrders"]);
          pendingOrders.shift();
          localStorage["pendingOrders"] = JSON.stringify(pendingOrders);
          //   setTimeout(sendOrder, 100);
        });
      }
                             }

     function sendOrderequipment(){
        var  POE = $.parseJSON(localStorage["POE"]);
        if (POE.length > 0) {
        var eitem = POE[0];
        $.post('/orderequipments', eitem, function (data) {
          var POE = $.parseJSON(localStorage["POE"]);
          POE.shift();
          localStorage["POE"] = JSON.stringify(POE);
             setTimeout(sendOrderequipment(), 100);
        });
                                   }
      }

      function sendOrdercheckcomment(){
         var  POC = $.parseJSON(localStorage["POC"]);
        if (POC.length > 0) {
        var fitem = POC[0];
        $.post('/ordercheckcomments', fitem, function (data) {
          var POC = $.parseJSON(localStorage["POC"]);
          POC.shift();
          localStorage["POC"] = JSON.stringify(POC);
             setTimeout(sendOrdercheckcomment(), 100);
        });
        }
      }

    function sendOrderarea(){
          var  PAT = $.parseJSON(localStorage["PAT"]);
         if (PAT.length > 0) {
         var hitem = PAT[0];
         $.post('/orderareas', hitem, function (data) {
           var PAT = $.parseJSON(localStorage["PAT"]);
           PAT.shift();
           localStorage["PAT"] = JSON.stringify(PAT);
              setTimeout(sendOrderarea, 100);
         });
         }
       }
        function sendOrderpest(){
         var  PES = $.parseJSON(localStorage["PES"]);
        if (PES.length > 0) {
        var gitem = PES[0];
        $.post('/orderpests', gitem, function (data) {
          var PES = $.parseJSON(localStorage["PES"]);
          PES.shift();
          localStorage["PES"] = JSON.stringify(PES);
            setTimeout(sendOrderpest, 100);
        });
       }
      }
function sendPending() {
    if (window.navigator.onLine) {
       sendChemical();
        sendOrder();
        sendOrderequipment();
        sendOrdercheckcomment();
        sendOrderarea();
         sendOrderpest();
      }
      }


    $("#clearLog2").live('click', function() {
             var pendingItems = $.parseJSON(localStorage["pendingItems"]);
      //   var pendingItems = localStorage["pendingItems"];
        alert('I am clicked');
       //  var ordidfield = $(this).closest("tr").find(".ordidclass");
     //   var item = {"OrderId":ordidfield.val(),"Quantity":quanfield.val()}, "orderchemical":{"Quantity":quanfield.val(),"OrderId":ordidfield.val()}};
        localStorage.removeItem(pendingItems);
      //   localStorage.clear(pendingItems);
     //  pendingItems.removeItem(ordidfield);
       //    alert('I am clicked');
        //    $.post(this.href, { _method: 'delete' }, null, "script");

   //   var row = $(this).closest("tr").get(0);
   //    $(row).hide();

   //    return false;
       });


     $("#showBtn2").click(function() {
          alert('Data Sent');
         sendPending();
     });



    $("#clearLog").click(function() {
    var answer = confirm("Are you sure you want to delete the chemicals?");
     if (answer) {
       localStorage.clear();
       // localStorage.removeItem('pendingItems');
      //  localStorage.setItem('pendingItems', '[]');

    return false;

    }
});

});











