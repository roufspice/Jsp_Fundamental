<!-- ajax_proxy.html -->
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FireStation</title>
<script type="text/javascript" src="../js/jquery-3.5.1.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=39c6c1c8b379d7eb9472eff045d57c1b"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=39c6c1c8b379d7eb9472eff045d57c1b&libraries=clusterer"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">

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

							//var info =  "ì´ë¦: "+name +"<br/>"+
							//"ìë: "+lat+"<br/>"+
							//"ê²½ë: "+lon+ "<br/>"+"<br/>";

							//$('#sel').append(info);
						});
						//ê° ë°°ì´ì ë¤ ë¤ì´ê°ìë ìí©! 
						//ì´ì  ì§ëë¥¼ ë³´ì¬ì¤ ì°¨ë¡!
						var mapContainer = document.getElementById('map'), // ì§ëë¥¼ íìí  div 
						mapOption = {
							center : new kakao.maps.LatLng(37.56682, 126.97864), // ì§ëì ì¤ì¬ì¢í
							level : 7, // ì§ëì íë ë ë²¨
							mapTypeId : kakao.maps.MapTypeId.ROADMAP
						// ì§ëì¢ë¥
						};

						// ì§ëë¥¼ ìì±íë¤ 
						var map = new kakao.maps.Map(mapContainer, mapOption);

						// ì§ë íì ë³ê²½ ì»¨í¸ë¡¤ì ìì±íë¤
						var mapTypeControl = new kakao.maps.MapTypeControl();

						// ì§ëì ìë¨ ì°ì¸¡ì ì§ë íì ë³ê²½ ì»¨í¸ë¡¤ì ì¶ê°íë¤
						map.addControl(mapTypeControl,
								kakao.maps.ControlPosition.TOPRIGHT);

						// ì§ëì íë ì¶ì ì»¨í¸ë¡¤ì ìì±íë¤
						var zoomControl = new kakao.maps.ZoomControl();

						// ì§ëì ì°ì¸¡ì íë ì¶ì ì»¨í¸ë¡¤ì ì¶ê°íë¤
						map.addControl(zoomControl,
								kakao.maps.ControlPosition.RIGHT);

						for (var i = 0; i < latitudeArr.length; i++) {
							var imageSrc = '../img/rescue119.png', // ë§ì»¤ì´ë¯¸ì§ì ì£¼ììëë¤    
							imageSize = new kakao.maps.Size(20, 20), // ë§ì»¤ì´ë¯¸ì§ì í¬ê¸°ìëë¤
							imageOption = {
								offset : new kakao.maps.Point(27, 69)
							}; // ë§ì»¤ì´ë¯¸ì§ì ìµììëë¤. ë§ì»¤ì ì¢íì ì¼ì¹ìí¬ ì´ë¯¸ì§ ìììì ì¢íë¥¼ ì¤ì í©ëë¤.
							var markerImage = new kakao.maps.MarkerImage(
									imageSrc, imageSize, imageOption), markerPosition = new kakao.maps.LatLng(
									latitudeArr[i], longitudeArr[i]); // ë§ì»¤ì ìì¹
							// ë§ì»¤ë¥¼ ìì±í©ëë¤
							var marker = new kakao.maps.Marker({
								map : map, // ë§ì»¤ë¥¼ íìí  ì§ë
								position : markerPosition,
								image : markerImage
							//
							});

							// ë§ì»¤ì íìí  ì¸í¬ìëì°ë¥¼ ìì±í©ëë¤ 
							var infowindow = new kakao.maps.InfoWindow(
									{
										content : '<div class="info" style="font-weight: bolder;  margin-left: 5px; text-align: center; ">'
												+ '<div class="title" style ="color: red;">'
												+ nameArr[i]
												+ '</div>'
												+ '<div class ="body" style="width: 220px; margin: 5px 0 5px 0; text-align: center; ">'
												+ '<div class="addr" style="font-size:10px;">'
												+ addrArr[i]
												+ '</div>'
												+ '<div class="tel" style="font-size:10px;">'
												+ telArr[i]
												+ '</div>'
												+ '</div>' + '</div>'

									});

							// ë§ì»¤ì mouseover ì´ë²¤í¸ì mouseout ì´ë²¤í¸ë¥¼ ë±ë¡í©ëë¤
							// ì´ë²¤í¸ ë¦¬ì¤ëë¡ë í´ë¡ì ë¥¼ ë§ë¤ì´ ë±ë¡í©ëë¤ 
							// forë¬¸ìì í´ë¡ì ë¥¼ ë§ë¤ì´ ì£¼ì§ ìì¼ë©´ ë§ì§ë§ ë§ì»¤ìë§ ì´ë²¤í¸ê° ë±ë¡ë©ëë¤
							kakao.maps.event.addListener(marker, 'mouseover',
									makeOverListener(map, marker, infowindow));
							kakao.maps.event.addListener(marker, 'mouseout',
									makeOutListener(infowindow));
						}

						// ì¸í¬ìëì°ë¥¼ íìíë í´ë¡ì ë¥¼ ë§ëë í¨ììëë¤ 
						function makeOverListener(map, marker, infowindow) {
							return function() {
								infowindow.open(map, marker);
							};
						}

						// ì¸í¬ìëì°ë¥¼ ë«ë í´ë¡ì ë¥¼ ë§ëë í¨ììëë¤ 
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
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<li class="page-item disabled"></li>
			<button type="button" class="btn btn-outline-info"
				onclick="location='../main.jsp'">Home</button>
			<button type="button" class="btn btn-outline-danger">fire</button>
			<button type="button" class="btn btn-outline-warning"
				onclick="location='sampAED.jsp'">AED</button>
			<button type="button" class="btn btn-outline-success"
				onclick="location='sampetc.jsp'">etc</button>
			<li class="page-item"></li>
			</li>
		</ul>
	</nav>
	<div id="map" style="width: 100%; height: 100vh;"></div>
	<div id="sel"></div>

</body>
</html>