<!-- ajax_proxy.html -->
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Look for the FIRE STATION</title>
<script type="text/javascript" src="../js/jquery-3.5.1.js"></script>
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=39c6c1c8b379d7eb9472eff045d57c1b"></script>
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=39c6c1c8b379d7eb9472eff045d57c1b&libraries=clusterer"></script>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
   integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
   crossorigin="anonymous">
   
   
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
               url : '../xml/fireStation.xml',
               type : 'GET',
               dataType : 'xml',
               error : function() {
                  alert('error');
               },
               success : function(xml) {
                  const nameArr = [];
                  const latitudeArr = [];
                  const longitudeArr = [];
                  const addrArr = [];
                  const telArr = [];

                  $(xml).find("item").each(function() {
                     let name = $(this).find("facilityName").text();
                     let latitude = $(this).find("latitude").text();
                     let longitude = $(this).find("longitude").text();
                     let addr = $(this).find("addrNm").text();
                     let tel = $(this).find("tel").text();

                     nameArr.push(name);
                     latitudeArr.push(latitude);
                     longitudeArr.push(longitude);
                     addrArr.push(addr);
                     telArr.push(tel);

                     //var info =  "ì ´ë¦ : "+name +"<br/>"+
                     //"ì  ë  : "+lat+"<br/>"+
                     //"ê²½ë  : "+lon+ "<br/>"+"<br/>";

                     //$('#sel').append(info);
                  });
                  //ê°  ë°°ì ´ì   ë ¤ ë ¤ì ´ê° ì  ë   ì  í ©! 
                  //ì ´ì   ì§ ë  ë¥¼ ë³´ì ¬ì¤  ì°¨ë¡ !
                  var mapContainer = document.getElementById('map'), // ì§ ë  ë¥¼ í  ì  í   div 
                  mapOption = {
                     center : new kakao.maps.LatLng(37.56682, 126.97864), // ì§ ë  ì   ì¤ ì ¬ì¢ í  
                     level : 7, // ì§ ë  ì   í  ë   ë  ë²¨
                     mapTypeId : kakao.maps.MapTypeId.ROADMAP
                  // ì§ ë  ì¢ ë¥ 
                  };

                  // ì§ ë  ë¥¼ ì  ì ±í  ë ¤ 
                  var map = new kakao.maps.Map(mapContainer, mapOption);
                  
                   if (navigator.geolocation) {
                           
                           // GeoLocation을 이용해서 접속 위치를 얻어옵니다
                           navigator.geolocation.getCurrentPosition(function(position) {
                               
                               var lat = position.coords.latitude, // 위도
                                   lon = position.coords.longitude; // 경도
                               
                               var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
                                   message = '<div style="padding:5px;">You are here!!</div>'; // 인포윈도우에 표시될 내용입니다
                               
                               // 마커와 인포윈도우를 표시합니다
                               displayMarker(locPosition, message);
                                   
                             });
                           
                       } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
                           
                           var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
                               message = 'It is not work T.T'
                               
                           displayMarker(locPosition, message);
                       }

                       // 지도에 마커와 인포윈도우를 표시하는 함수입니다
                       function displayMarker(locPosition, message) {

                           // 마커를 생성합니다
                           var marker = new kakao.maps.Marker({  
                               map: map, 
                               position: locPosition
                           }); 
                           
                           var iwContent = message, // 인포윈도우에 표시할 내용
                               iwRemoveable = true;

                           // 인포윈도우를 생성합니다
                           var infowindow = new kakao.maps.InfoWindow({
                               content : iwContent,
                               removable : iwRemoveable
                           });
                           
                           // 인포윈도우를 마커위에 표시합니다 
                           infowindow.open(map, marker);
                           
                           // 지도 중심좌표를 접속위치로 변경합니다
                           map.setCenter(locPosition);      
                       }    
                  
                  

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

                  for (let i = 0; i < latitudeArr.length; i++) {
                     var imageSrc = '../img/rescue119.png', // ë§ ì»¤ì ´ë¯¸ì§ ì   ì£¼ì  ì  ë  ë ¤    
                     imageSize = new kakao.maps.Size(30, 30), // ë§ ì»¤ì ´ë¯¸ì§ ì   í ¬ê¸°ì  ë  ë ¤
                     imageOption = {
                        offset : new kakao.maps.Point(15, 40)
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

                     // ë§ ì»¤ì   í  ì  í   ì ¸í ¬ì  ë  ì °ë¥¼ ì  ì ±í ©ë  ë ¤ 
                     var infowindow = new kakao.maps.InfoWindow(
                           {
                              content : '<div class="area">'   
                                    + '<div class="info" style="font-weight: bolder;  text-align: center; background-color:#ff7733;">'
                                    + '<div class="title" style ="color: black; font:bolder;">'
                                    + (i+1)+ '.' + nameArr[i]
                                    + '</div>'
                                    + '<div class ="body" style="width: 220px; margin: 0 0 5px 0; text-align: center; background-color:white; ">'
                                    + '<div class="addr" style="font-size:10px;">'
                                    + addrArr[i]
                                    + '</div>'
                                    + '<div class="tel" style="font-size:10px;">'
                                    + telArr[i] + '</div>'
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
                  //정보 클릭 이벤트 발생!
                  $(function(){
                     
                     for(let i =0; i<nameArr.length; i++){
                        
                     }
                  
                  });

               }
            });

   });
</script>
</head>
<body>

    <div style="position: absolute;">

<div style = "position:relative;z-index:2; left: 10px; top: 10px;">
<div class="btn-group-vertical">


         <button type="button" class="btn btn-info"
            onclick="location='../main.jsp'">HOME</button>
         <button type="button" class="btn btn-danger">FIRE STATION</button>
         <button type="button" class="btn btn-warning"
            onclick="location='sampAED.jsp'">AED</button>
         <button type="button" class="btn btn-success"
            onclick="location='sampetc.jsp'">EMERGENCY</button>
</div>
</div>
</div>
    <div style = "position:relative;z-index:1;">
    <div class="container">
    <div class="row">
    <div class="col-12" id="upper" style="background-color:#DC3545; width:100%;height:8vh;">
    <div id="upperText" style ="float:right; color: white;">Built and Designed by PARK.JOO-HYEOK, YANG.IN-KI, LEE.SANG-HYO, HA.DAE-YOUN</div></div>
    </div>
     <div class="row">
    <div class = "col-12" id="map" style="width:100%;height:93vh;"></div>
    </div>
    
  
</body>
</html>