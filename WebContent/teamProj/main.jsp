<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나만의 응급지도에 오신걸 환영합니다</title>
    <script type="text/javascript" src="../js/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=39c6c1c8b379d7eb9472eff045d57c1b"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    
    <style>
    body {
    	 
    	 background-image: url('img/ryan.png');
    	 background-repeat: no-repeat;
    	 background-size: cover;
    	 
    	 
    
    }
    .dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#ffffff;}
	.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
	.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
	.number {font-weight:bold;color:#ee6152;} 
	.distanceInfo .label {display:inline-block;width:50px; font-weight:bold; color: black;}
    
    
    </style>
    
<script>
    
	
    var scrt_var = 10; 
    $(function(){
            $.ajax({
                url : 'xml/fireStation.xml',
                type :'GET',
                dataType : 'xml',
                error : function(){
                    alert('error');
                },
                success : function(xml){
                   const nameArr = [];
                   const latitudeArr =[];
                   const longitudeArr=[];
                   $(xml).find("item").each(function(){
                        let name = $(this).find("facilityName").text();
                        let latitude = $(this).find("latitude").text();
                        let longitude = $(this).find("longitude").text();
                        nameArr.push(name);
                        latitudeArr.push(latitude);
                        longitudeArr.push(longitude);
                    });
                    var mapContainer = document.getElementById('map'),
                    mapOption = {
                      center : new kakao.maps.LatLng(37.56682, 126.97864),
                      level : 4,
                      mapTypeId : kakao.maps.MapTypeId.ROADMAP
                    }; 
                    var drawingFlag = false;
                    var moveLine;
                    var clickLine;
                    var distanceOverlay;
                    var dots ={};

                    var map = new kakao.maps.Map(mapContainer, mapOption); 

                    if (navigator.geolocation) {
                         
                        navigator.geolocation.getCurrentPosition(function(position) {
                        	
                             
                            var lat = position.coords.latitude,

                                lon = position.coords.longitude;
                            
                            console.log(lat);
                            
                            console.log(lon);
                            var locPosition = new kakao.maps.LatLng(lat, lon),
                            message = '<div style="padding:5px;"><span>내 위치!<div></span><p style="font-size:9px; font-weight:bolder; color:red; margin :0;">마우스 왼쪽버튼 을 클릭해보세요</p><p style="font-size:9px;font-weight:bolder; color:red; margin :0;">거리/시간을 알려줍니다!</p></div></div>';
                            
                             

                            displayMarker(locPosition, message);
                                 
                        }, function(error) {
                            console.log('Error occurred. Error code: ' + error.code);
                            // error.code can be:
                            //   0: unknown error
                            //   1: permission denied
                            //   2: position unavailable (error response from location provider)
                            //   3: timed out
                          });
                         
                    } else {
                         
                        var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
                            message = 'It is not work T.T'
                            console.log(message);
                             
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
                
                 
                
                    //추가 함수
                    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

                        var clickPosition= mouseEvent.latLng;

                        //테스트
                        if (!drawingFlag){
                            drawingFlag = true;
                            deleteClickLine();
                            deleteDistnce();
                            deleteCircleDot();
                            clickLine = new kakao.maps.Polyline({
                                map: map,
                                path : [clickPosition],
                                //선 디자인 편집(두께,색,투명도,스타일)
                                strokeWeight : 3,
                                strokeColor : '#db4040',
                                strokeOpacity : 0.8,
                                strokeStyle: 'solid'
                            });
                            moveLine = new kakao.maps.Polyline({
                                strokeWeight : 3,
                                strokeColor : '#db4040',
                                strokeOpacity : 1,
                                strokeStyle: 'solid'

                            });

                            displayCircleDot(clickPosition, 0);
                        }else {
                            var path = clickLine.getPath();
                            path.push(clickPosition);
                            clickLine.setPath(path);
                            
                            var distance = Math.round(clickLine.getLength());
                            displayCircleDot(clickPosition, distance);


                        }
                    });

                    kakao.maps.event.addListener(map, 'mousemove', function(mouseEvent) {

                        if (drawingFlag) {
                            var mousePosition = mouseEvent.latLng;
                            var path = clickLine.getPath();

                            var movepath = [ path[path.length - 1], mousePosition ];
                            moveLine.setPath(movepath);
                            moveLine.setMap(map);

                            var distance = Math.round(clickLine.getLength() + moveLine.getLength()),
                            content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>';

                            showDistance(content, mousePosition);
                        }

                    });

                    kakao.maps.event.addListener(map, 'rightclick', function(mouseEvent) {

                        if(drawingFlag) {
                            moveLine.setMap(null);
                            moveLine =null;

                            var path = clickLine.getPath();

                            if(path.length >1){
                                if (dots[dots.length - 1].distance){
                                    dots[dots.length -1].distance.setMap(null);
                                    dots[dots.length -1].distance = null;

                                }
                                //선의 거리 계산
                                var distance = Math.round(clickLine.getLength()),
                                content = getTimeHTML(distance);

                                showDistance(content, path[path.length -1]);

                            } else{

                                deleteClickLine();
                                deleteCircleDot();
                                deleteDistnce();

                            }

                            drawingFlag = false;

                        }
                    });
                    function deleteClickLine() {
		                if (clickLine) {
			                clickLine.setMap(null);
			                clickLine = null;
		                }
	                }

                    //function showDistance(){}
                    function showDistance(content, position) {

                        if(distanceOverlay) {
                            distanceOverlay.setPosition(position);
			                distanceOverlay.setContent(content);
                        } else {
                            distanceOverlay = new kakao.maps.CustomOverlay({
                                map : map,
                                content : content,
                                position : position,
                                xAnchor : 0,
                                yAnchor : 0,
                                zIndex : 3
                            });
                        }
                    }

                    function deleteDistnce(){
                        if (distanceOverlay) {
			                distanceOverlay.setMap(null);
			                distanceOverlay = null;
		                }
                    }

                    //function displayCircleDot(){}
                    function displayCircleDot(position, distance) {
                        var circleOverlay = new kakao.maps.CustomOverlay({
			                content : '<span class="dot"></span>',
			                position : position,
			                zIndex : 1
                        });

                        circleOverlay.setMap(map);

                        if (distance > 0) {
                            var distanceOverlay = new kakao.maps.CustomOverlay({
                                content : '<div class="dotOverlay">직선거리 <span class="number">'
                                            + distance + '</span>m</div>',
                                position : position,
                                yAnchor : 1,
                                zIndex : 2
                            });

                            distanceOverlay.setMap(map);

                        }

                        dots.push({
                            circle : circleOverlay,
                            distance : distanceOverlay
                        });
                    }
                    //function deleteCircleDot(){}

                    function deleteCircleDot(){
                        let i;

                        for(i =0; i< dots.length; i++) {
                            if (dots[i].circle) {
                                dots[i].circle.setMap(null);
                            }

                            if (dots[i].distance) {
                                dots[i].distance.setMap(null);
                            }
                        }

                        dots = [];
                    }

                    function getTimeHTML(distance) {

                        var walkTime = distance / 67 | 0;
                        var walkHour = '', walkMin = '';

                        if (walkTime > 60) {
                            walkHour = '<span class="number">' + Math.floor(walkTime / 60) + '</span>시간 '

                        }
                        walkMin = '<span class="number">' + walkTime % 60 + '</span>분'

                        var content = '<ul class="dotOverlay distanceInfo">';
                        
                        content += '    <li>';
                        content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
                        content += '    </li>';
                        content += '    <li>';
                        content += '        <span class="label">도보</span>' + walkHour + walkMin;
                        content += '    </li>';
                        content += '    </ul>'

                        return content;
                    } 




                    var mapTypeControl = new kakao.maps.MapTypeControl();
                     map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);   
                     var zoomControl = new kakao.maps.ZoomControl();
                     map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT); 

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
<body>
<div style="position: absolute;">

    <div style = "position:relative;z-index:2;left: 10px; top: 10px;">
<div class="btn-group-vertical">

		   <button type="button" class="btn btn-info" >HOME</button>
			<button type="button" class="btn btn-danger" onclick="location='map/sampfire.jsp?'">FIRE STATION</button>
			<button type="button" class="btn btn-warning" onclick="location='map/sampAED.jsp'">AED</button>
			<button type="button" class="btn btn-success" onclick="location='map/sampetc.jsp'">EMERGENCY</button>
</div>
</div>
</div>
	
    <div style = "position:relative;z-index:1;">
    <div class="container">
    <div class="row">
    <div class="col-12" id="upper" style="background-color:#17A2B8; width:100%;height:8vh;">
    <span id="title"style ="color: white; font-weight: bolder; font-size: 18px; padding: 0 0 0 20px; margin:10px 0 0 0;">나만의응급지도</span>
    <div id="upperText" style ="float:right; color: white;">Built and Designed by PARK.JOO-HYEOK, YANG.IN-KI, LEE.SANG-HYO, HA.DAE-YOUN</div></div>
    </div>
     <div class="row">
    <div class = "col-12" id="map" style="width:100%;height:93vh;"></div>
    </div>
    
  
    
    </div>
    </div>
    </body>
</html>   
    
    
    
