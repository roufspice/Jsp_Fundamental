<!-- ajax_proxy.html -->
<!DOCTYPE html>
<html lang="en">
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

<title>Look for the AED</title>

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
                  var mapContainer = document.getElementById('map'), // ì§ ë  ë¥¼ í  ì  í   div 
                  mapOption = {
                     center : new kakao.maps.LatLng(37.56682, 126.97864), // ì§ ë  ì   ì¤ ì ¬ì¢ í  
                     level : 7, // ì§ ë  ì   í  ë   ë  ë²¨
                     mapTypeId : kakao.maps.MapTypeId.ROADMAP
                  // ì§ ë  ì¢ ë¥ 
                  };

                  // ì§ ë  ë¥¼ ì  ì ±í  ë ¤ 
                  var map = new kakao.maps.Map(mapContainer, mapOption);
                
                  // ì§ ë   í  ì   ë³ ê²½ ì»¨í ¸ë¡¤ì   ì  ì ±í  ë ¤
                  var mapTypeControl = new kakao.maps.MapTypeControl();

                  // ì§ ë  ì   ì  ë ¨ ì °ì¸¡ì   ì§ ë   í  ì   ë³ ê²½ ì»¨í ¸ë¡¤ì   ì¶ ê° í  ë ¤
                  map.addControl(mapTypeControl,
                        kakao.maps.ControlPosition.TOPRIGHT);

                  // ì§ ë  ì   í  ë   ì¶ ì   ì»¨í ¸ë¡¤ì   ì  ì ±í  ë ¤
                  var zoomControl = new kakao.maps.ZoomControl();

                  // ì§ ë  ì   ì °ì¸¡ì   í  ë   ì¶ ì   ì»¨í ¸ë¡¤ì   ì¶ ê° í  ë ¤
                  map.addControl(zoomControl,
                        kakao.maps.ControlPosition.RIGHT);
                  
                  if (navigator.geolocation) {
                      
                      // GeoLocationì   ì ´ì ©í ´ì   ì  ì   ì  ì¹ ë¥¼ ì »ì ´ì µë  ë ¤
                      navigator.geolocation.getCurrentPosition(function(position) {
                          
                          var lat = position.coords.latitude, // ì  ë  
                              lon = position.coords.longitude; // ê²½ë  
                          
                          var locPosition = new kakao.maps.LatLng(lat, lon), // ë§ ì»¤ê°  í  ì  ë   ì  ì¹ ë¥¼ geolocationì ¼ë¡  ì »ì ´ì ¨ ì¢ í  ë¡  ì  ì ±í ©ë  ë ¤
                              message = '<div style="padding:5px;">You are here!!</div>'; // ì ¸í ¬ì  ë  ì °ì   í  ì  ë   ë ´ì ©ì  ë  ë ¤
                          
                          // ë§ ì»¤ì   ì ¸í ¬ì  ë  ì °ë¥¼ í  ì  í ©ë  ë ¤
                          displayMarker(locPosition, message);
                              
                        });
                      
                  } else { // HTML5ì   GeoLocationì   ì ¬ì ©í   ì   ì  ì  ë   ë§ ì»¤ í  ì   ì  ì¹ ì   ì ¸í ¬ì  ë  ì ° ë ´ì ©ì   ì ¤ì  í ©ë  ë ¤
                      
                      var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
                          message = 'It is not work T.T'
                          
                      displayMarker(locPosition, message);
                  }
                  
                  function displayMarker(locPosition, message) {

                      // ë§ ì»¤ë¥¼ ì  ì ±í ©ë  ë ¤
                      var marker = new kakao.maps.Marker({  
                          map: map, 
                          position: locPosition
                      }); 
                      
                      var iwContent = message, // ì ¸í ¬ì  ë  ì °ì   í  ì  í   ë ´ì ©
                          iwRemoveable = true;

                      // ì ¸í ¬ì  ë  ì °ë¥¼ ì  ì ±í ©ë  ë ¤
                      var infowindow = new kakao.maps.InfoWindow({
                          content : iwContent,
                          removable : iwRemoveable
                      });
                      
                      // ì ¸í ¬ì  ë  ì °ë¥¼ ë§ ì»¤ì  ì   í  ì  í ©ë  ë ¤ 
                      infowindow.open(map, marker);
                      
                      // ì§ ë   ì¤ ì ¬ì¢ í  ë¥¼ ì  ì  ì  ì¹ ë¡  ë³ ê²½í ©ë  ë ¤
                      map.setCenter(locPosition);      
                  }    

                  for (var i = 0; i < latitudeArr.length; i++) {
                     var imageSrc = '../img/AED.png', // ë§ ì»¤ì ´ë¯¸ì§ ì   ì£¼ì  ì  ë  ë ¤    
                     imageSize = new kakao.maps.Size(20, 20), // ë§ ì»¤ì ´ë¯¸ì§ ì   í ¬ê¸°ì  ë  ë ¤
                     imageOption = {
                        offset : new kakao.maps.Point(27, 40)
                     }; // ë§ ì»¤ì ´ë¯¸ì§ ì   ì µì  ì  ë  ë ¤. ë§ ì»¤ì   ì¢ í  ì   ì ¼ì¹ ì  í ¬ ì ´ë¯¸ì§  ì  ì  ì  ì   ì¢ í  ë¥¼ ì ¤ì  í ©ë  ë ¤.
                     var markerImage = new kakao.maps.MarkerImage(
                           imageSrc, imageSize, imageOption), markerPosition = new kakao.maps.LatLng(
                           latitudeArr[i], longitudeArr[i]); // ë§ ì»¤ì   ì  ì¹ 
                     // ë§ ì»¤ë¥¼ ì  ì ±í ©ë  ë ¤
                     var marker = new kakao.maps.Marker({
                        map : map, // ë§ ì»¤ë¥¼ í  ì  í   ì§ ë  
                        position : markerPosition,
                        image : markerImage
                     //
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
                     // ë§ ì»¤ì   í  ì  í   ì ¸í ¬ì  ë  ì °ë¥¼ ì  ì ±í ©ë  ë ¤ 
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

                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     // ë§ ì»¤ì   mouseover ì ´ë²¤í ¸ì   mouseout ì ´ë²¤í ¸ë¥¼ ë ±ë¡ í ©ë  ë ¤
                     // ì ´ë²¤í ¸ ë¦¬ì ¤ë  ë¡ ë   í ´ë¡ ì  ë¥¼ ë§ ë ¤ì ´ ë ±ë¡ í ©ë  ë ¤ 
                     // forë¬¸ì  ì   í ´ë¡ ì  ë¥¼ ë§ ë ¤ì ´ ì£¼ì§  ì  ì ¼ë©´ ë§ ì§ ë§  ë§ ì»¤ì  ë§  ì ´ë²¤í ¸ê°  ë ±ë¡ ë ©ë  ë ¤
                     kakao.maps.event.addListener(marker, 'mouseover',
                           makeOverListener(map, marker, infowindow));
                     kakao.maps.event.addListener(marker, 'mouseout',
                           makeOutListener(infowindow));
                  }

                  // ì ¸í ¬ì  ë  ì °ë¥¼ í  ì  í  ë   í ´ë¡ ì  ë¥¼ ë§ ë  ë   í ¨ì  ì  ë  ë ¤ 
                  function makeOverListener(map, marker, infowindow) {
                     return function() {
                        infowindow.open(map, marker);
                     };
                  }

                  // ì ¸í ¬ì  ë  ì °ë¥¼ ë «ë   í ´ë¡ ì  ë¥¼ ë§ ë  ë   í ¨ì  ì  ë  ë ¤ 
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

</html>