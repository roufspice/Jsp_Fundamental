<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="../js/jquery-3.5.1.js"></script>
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=39c6c1c8b379d7eb9472eff045d57c1b"></script>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
   integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
   crossorigin="anonymous">

<title>AED위치</title>

<style>
    body {
    	 background-image: url('../img/ryan.png');
    	 background-repeat: no-repeat;
    	 background-size: cover;
    
    }
     </style>

<script>

   $(function() {

      $
            .ajax({
               url : '../xml/aed.xml',
               type : 'GET',
               dataType : 'xml',
               error : function() {
                  alert('error');
               },
               success : function(xml) {
                  const addrArr = [];
                  const placeArr = [];
                  const latitudeArr = [];
                  const longitudeArr = [];
                  $(xml).find("item").each(function() {
                     let addr = $(this).find("buildAddress").text();
                     let place = $(this).find("buildPlace").text();
                     let lat = $(this).find("wgs84Lat").text();
                     let lon = $(this).find("wgs84Lon").text();

                     addrArr.push(addr);
                     placeArr.push(place);
                     latitudeArr.push(lat);
                     longitudeArr.push(lon);

                  });

                  //Show the map!!
                  var mapContainer = document.getElementById('map'),
                  mapOption = {
                     center : new kakao.maps.LatLng(37.56682, 126.97864),
                     level : 7,
                     mapTypeId : kakao.maps.MapTypeId.ROADMAP
                  };

                  var map = new kakao.maps.Map(mapContainer, mapOption);
                
                  var mapTypeControl = new kakao.maps.MapTypeControl();

                  map.addControl(mapTypeControl,
                        kakao.maps.ControlPosition.TOPRIGHT);

                  var zoomControl = new kakao.maps.ZoomControl();

                  map.addControl(zoomControl,
                        kakao.maps.ControlPosition.RIGHT);
                  
                  if (navigator.geolocation) {
                      
                      navigator.geolocation.getCurrentPosition(function(position) {
                          
                          var lat = position.coords.latitude,
                              lon = position.coords.longitude;
                          
                          var locPosition = new kakao.maps.LatLng(lat, lon),
                              message = '<div style="padding:5px;">내 위치!</div>';
                         displayMarker(locPosition, message);
                              
                        });
                      
                  } else {
                      
                      var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
                          message = 'It is not work T.T'
                          
                      displayMarker(locPosition, message);
                  }
                  
                  function displayMarker(locPosition, message) {

                      var marker = new kakao.maps.Marker({  
                          map: map, 
                          position: locPosition
                      }); 
                      
                      var iwContent = message,
                          iwRemoveable = true;

                      var infowindow = new kakao.maps.InfoWindow({
                          content : iwContent,
                          removable : iwRemoveable
                      });
                      
                      infowindow.open(map, marker);
                      
                      map.setCenter(locPosition);      
                  }    

                  for (var i = 0; i < latitudeArr.length; i++) {
                     var imageSrc = '../img/AED.png',
                     imageSize = new kakao.maps.Size(20, 20),
                     imageOption = {
                        offset : new kakao.maps.Point(27, 40)
                     };
                     var markerImage = new kakao.maps.MarkerImage(
                           imageSrc, imageSize, imageOption), markerPosition = new kakao.maps.LatLng(
                           latitudeArr[i], longitudeArr[i]);
                     var marker = new kakao.maps.Marker({
                        map : map,
                        position : markerPosition,
                        image : markerImage
                     });
                     
                           
                     //console.log(addrArr[i]);
                     
                     var arrayObj = addrArr[i].split(' ');
                     var addr = "";
                     for(var k=0;k<arrayObj.length;k++){
                        if(k==3){
                           addr +=arrayObj[k] +"<br>";
                        }else{
                           addr +=arrayObj[k]+" "; 
                        }
                        
                     }
                     var infowindow = new kakao.maps.InfoWindow({
                        content : '<div class="area">'   
                                    + '<div class="info" style="font-weight: bolder;  text-align: center; background-color:#FACC2E;">'
                                    + '<div class="title" style ="font-size:15px; color: black; font:bolder;">'
                                    + addr
                                    + '</div>'
                                    + '<div class ="body" style="width: 300px; margin: 0 0 10px 0; text-align: center; background-color:white; ">'
                                    + '<div class="addr" style="font-size:12px;">'
                                    + placeArr[i]
                                    + '</div>'
                                    + '</div>' + '</div>'
                                    + '</div>'
                           
                           
                     });

                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     kakao.maps.event.addListener(marker, 'mouseover',
                           makeOverListener(map, marker, infowindow));
                     kakao.maps.event.addListener(marker, 'mouseout',
                           makeOutListener(infowindow));
                  }

                  function makeOverListener(map, marker, infowindow) {
                     return function() {
                        infowindow.open(map, marker);
                     };
                  }

                  function makeOutListener(infowindow) {
                     return function() {
                        infowindow.close();
                     };
                  }

               }
            });

   });
</script>
</head>

<div style="position: absolute;">

<div style = "position:relative; z-index:2; left: 10px; top: 10px;">
<div class="btn-group-vertical">

			<button type="button" class="btn btn-info" onclick="location='../main.jsp'">HOME</button>
			<button type="button" class="btn btn-danger" onclick="location='sampfire.jsp'">FIRE STATION</button>
			<button type="button" class="btn btn-warning">AED</button>
			<button type="button" class="btn btn-success" onclick="location='sampetc.jsp'">EMERGENCY</button>
		  
</div>
</div>
</div>


	<div style = "position:relative;z-index:1;">
    <div class="container">
    <div class="row">
    <div class="col-12" id="upper" style="background-color:#FFC107; width:100%;height:8vh;">
    <div id="upperText" style ="float:right; color: white;">Built and Designed by PARK.JOO-HYEOK, YANG.IN-KI, LEE.SANG-HYO, HA.DAE-YOUN</div></div>
    </div>
     <div class="row">
    <div class = "col-12" id="map" style="width:100%;height:93vh;"></div>
    </div>
    
  

</body>

