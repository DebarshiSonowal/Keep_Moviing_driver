import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/ticketView.dart';
import '../appTheme.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';

class PickupScreen extends StatefulWidget {
  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  GoogleMapController mapController;
  PolylinePoints polylinePoints;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero,(){
    //   try {
    //     setState(() {
    //             seticonimage(context);
    //             seticonimage2(context);
    //             customn();
    //           });
    //   } catch (e) {
    //     print(e);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    seticonimage(context);
    seticonimage2(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SizedBox(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).textTheme.headline6.color,
                ),
              ),
            ),
            Text(
              AppLocalizations.of('Pick up'),
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            compassEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(26.4798399, 90.3048006),
              zoom: 20,
              bearing: 4,
              tilt: 6,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              setLDMapStyle();
              setState(() {
                seticonimage(context);
                seticonimage2(context);
                customn();
              });
            },
            markers: Set<Marker>.of(markers),
            polylines: Set<Polyline>.of(polylines.values),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.15,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.isLightTheme
                          ? Colors.black.withOpacity(0.2)
                          : Colors.white.withOpacity(0.2),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 150, left: 150),
                      child: Container(
                        height: 2.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 14, right: 14),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 22,
                            child: Text(
                              "A",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ConstanceData.secoundryFontColor,
                                  ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of('Pick up at'),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).disabledColor,
                                    ),
                              ),
                              Text(
                                AppLocalizations.of('London Bridge Walk'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 14, left: 14, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'EST',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context).disabledColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                AppLocalizations.of('5 min'),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of('Distance'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context).disabledColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '2.2 km',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of('Fare'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context).disabledColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '\$25.00',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TicketDesign(),
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of('DROP OFF'),
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: ConstanceData.secoundryFontColor,
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 14, left: 14, top: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_upward,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            AppLocalizations.of('Head southwest on Madison St'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 46, top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            AppLocalizations.of('18 miles'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              width: 50,
                              color: Theme.of(context).dividerColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 14, left: 14, top: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.subdirectory_arrow_left,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            AppLocalizations.of('Turn left onto 4th Ave'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 46, top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            AppLocalizations.of('12 miles'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              width: 50,
                              color: Theme.of(context).dividerColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 14, left: 14, top: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.subdirectory_arrow_right,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            AppLocalizations.of('Turn Right at 105th'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 46, top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            AppLocalizations.of('40 miles'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              width: 50,
                              color: Theme.of(context).dividerColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 14, left: 14, top: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.subdirectory_arrow_right,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            AppLocalizations.of('Turn Right at William St'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 46, top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            AppLocalizations.of('40 miles'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              width: 50,
                              color: Theme.of(context).dividerColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 14, left: 14, top: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_upward,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            AppLocalizations.of('Continue straight stay'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 46, top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            AppLocalizations.of('24 miles'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              width: 50,
                              color: Theme.of(context).dividerColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 16,
                    ),
                  ],
                ),
              );
            },
          ),
          Column(
            children: <Widget>[
              Container(
                height: AppBar().preferredSize.height,
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.only(right: 14, left: 14),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.assistant_photo,
                        color: ConstanceData.secoundryFontColor,
                      ),
                      Text(
                        '250m',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ConstanceData.secoundryFontColor,
                            ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(
                              'Turn right at 105 William St,Chicago, US'),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ConstanceData.secoundryFontColor,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  customn() async {
    // List<Location> startPlacemark = await locationFromAddress(_startAddress);
    // List<Location> destinationPlacemark = await locationFromAddress(_destinationAddress);
//https://www.google.com/maps/@26.4792999,90.3058874,18.12z
// Storing latitude & longitude of start and destination location
//  26.4798399,90.3048006
    Location startPlacemark = Location(
      longitude: 90.3048006,
      latitude: 26.4798399,
      timestamp: DateTime.now(),
    );
    Location destinationPlacemark = Location(
      longitude: 90.2926186,
      latitude: 26.4362356,
      timestamp: DateTime.now(),
    );

    double startLatitude = startPlacemark.latitude;
    double startLongitude = startPlacemark.longitude;
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(startPlacemark.latitude, startPlacemark.longitude));
    var startCoordinatesString = addresses.first.addressLine;
    print('start ${addresses}');
    var addresses1 = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(
            destinationPlacemark.latitude, destinationPlacemark.longitude));
    print('end ${addresses1}');
    var destinationCoordinatesString = addresses1.first.addressLine;
    double destinationLatitude = destinationPlacemark.latitude;
    double destinationLongitude = destinationPlacemark.longitude;

    checkIt(startLatitude, startLongitude, destinationLatitude,
        destinationLongitude);
    setMarkers(startCoordinatesString, startPlacemark,
        destinationCoordinatesString, destinationPlacemark);
    _createPolylines(
      startLatitude,
      startLongitude,
      destinationLatitude,
      destinationLongitude,
    );
  }

  setMarkers(
    startCoordinatesString,
    startPlacemark,
    destinationCoordinatesString,
    destinationPlacemark,
  ) {
    Marker startMarker = Marker(
      markerId: MarkerId(startPlacemark.toString()),
      position: LatLng(startPlacemark.latitude, startPlacemark.longitude),
      infoWindow: InfoWindow(
        title: '$startCoordinatesString',
        // snippet: _startAddress,
      ),
      icon: bitmapDescriptorStartLocation2,
    );

// Destination Location Marker
    Marker destinationMarker = Marker(
      markerId: MarkerId(destinationPlacemark.toString()),
      position:
          LatLng(destinationPlacemark.latitude, destinationPlacemark.longitude),
      infoWindow: InfoWindow(
        title: '${destinationCoordinatesString}',
        // snippet: _destinationAddress,
      ),

      icon: bitmapDescriptorStartLocation,
    );

    markers.add(startMarker);
    markers.add(destinationMarker);
  }

  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyB8ifq-XuxU1OIKxEwVohxAcE7cywSajMk', // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      print('points ${result.points}');
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }else{
      print('points1 ${result.errorMessage}');
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    setState(() {
      polylines[id] = polyline;
    });
  }

  checkIt(startLatitude, startLongitude, destinationLatitude,
      destinationLongitude) {
    double miny = (startLatitude <= destinationLatitude)
        ? startLatitude
        : destinationLatitude;
    double minx = (startLongitude <= destinationLongitude)
        ? startLongitude
        : destinationLongitude;
    double maxy = (startLatitude <= destinationLatitude)
        ? destinationLatitude
        : startLatitude;
    double maxx = (startLongitude <= destinationLongitude)
        ? destinationLongitude
        : startLongitude;

    double southWestLatitude = miny;
    double southWestLongitude = minx;

    double northEastLatitude = maxy;
    double northEastLongitude = maxx;

// Accommodate the two locations within the
// camera view of the map
    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude, northEastLongitude),
          southwest: LatLng(southWestLatitude, southWestLongitude),
        ),
        100.0,
      ),
    ).then((value)=>{
      print('Dona'),
    });
  }

  Map<PolylineId, Polyline> getPolyLine(BuildContext context) {
    Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
    List<LatLng> latlng1 = [
      LatLng(51.505923, -0.086936),
      LatLng(51.506061, -0.087631),
      LatLng(51.506171, -0.088258),
      LatLng(51.507129, -0.087974),
      LatLng(51.509693, -0.087075),
      LatLng(51.509065, -0.082206),
      LatLng(51.509119, -0.081204)
    ];
    final PolylineId polylineId = PolylineId('polylineId');
    final Polyline polyline = Polyline(
      polylineId: polylineId,
      color: Theme.of(context).primaryColor,
      consumeTapEvents: false,
      points: latlng1,
      width: 4,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
    _polylines.addAll({polylineId: polyline});
    return _polylines;
  }

  BitmapDescriptor bitmapDescriptorStartLocation;
  BitmapDescriptor bitmapDescriptorStartLocation2;

  var lat2 = 51.505923;
  var long2 = -0.086936;

  var lat3 = 51.509119;
  var long3 = -0.081204;

  Map<MarkerId, Marker> getMarkerList(BuildContext context) {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    final MarkerId markerId2 = MarkerId("markerId2");
    final MarkerId markerId3 = MarkerId("markerId3");

    final Marker marker2 = Marker(
      markerId: markerId2,
      position: LatLng(lat2, long2),
      anchor: Offset(0.5, 0.5),
      icon: bitmapDescriptorStartLocation2,
    );

    final Marker marker3 = Marker(
      markerId: markerId3,
      position: LatLng(lat3, long3),
      anchor: Offset(0.5, 0.5),
      icon: bitmapDescriptorStartLocation,
    );
    markers.addAll({markerId2: marker2});
    markers.addAll({markerId3: marker3});

    return markers;
  }

  Future seticonimage2(BuildContext context) async {
    if (bitmapDescriptorStartLocation2 == null) {
      final ImageConfiguration imagesStartConfiguration =
          createLocalImageConfiguration(context);
      bitmapDescriptorStartLocation2 = await BitmapDescriptor.fromAssetImage(
        imagesStartConfiguration,
        ConstanceData.mylocation1,
      );
      setState(() {

      });
    }
  }

  Future seticonimage(BuildContext context) async {
    if (bitmapDescriptorStartLocation == null) {
      final ImageConfiguration imagesStartConfiguration =
          createLocalImageConfiguration(context);
      bitmapDescriptorStartLocation = await BitmapDescriptor.fromAssetImage(
        imagesStartConfiguration,
        ConstanceData.mylocation3,
      );
      setState(() {

      });
    }
  }

  void setLDMapStyle() async {
    if (mapController != null) {
      if (AppTheme.isLightTheme) {
        mapController.setMapStyle(await DefaultAssetBundle.of(context)
            .loadString("jsonFile/lightmapstyle.json"));
      } else {
        mapController.setMapStyle(await DefaultAssetBundle.of(context)
            .loadString("jsonFile/darkmapstyle.json"));
      }
    }
  }
}
