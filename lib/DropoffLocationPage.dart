import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class DropOffLocationPage extends StatefulWidget {
  var p_lon;
  var p_lat;
  DropOffLocationPage({Key? key, required this.p_lat, required this.p_lon})
      : super(key: key);

  @override
  State<DropOffLocationPage> createState() => _DropOffLocationPageState();
}

class _DropOffLocationPageState extends State<DropOffLocationPage> {
  var mystyle = TextStyle(fontSize: 15);
  List<Marker> markers = [];
  LatLng? dpoint;
  late SnackBar sb;
  var d, cd;
  var dlat, dlon;
  String Distance(var lat1, var long1, var lat2, var long2, var unit) {
    var theta = long1 - long2;
    var dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2) * cos(deg2rad(theta)));
    dist = acos(dist);
    dist = rad2deg(dist);
    dist = dist * 60 * 1.1515;
    if (unit == "K") {
      dist = dist * 1.609344;
    } else if (unit == "N") {
      dist = dist * 0.8684;
    }
    return dist.toStringAsFixed(2);
    // return "lat1=${long2.runtimeType}";
  }

  double deg2rad(var deg) {
    return ((deg * pi) / 100.0);
  }

  double rad2deg(var rad) {
    return ((rad * 100.0) / pi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('SELECT YOUR DROPOFF POINT',
              style: TextStyle(fontSize: 16)),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 1),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 178,
                      color: Colors.blue.shade600,
                      child: Text(
                        "    Your Total Distance =$d KM",
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      color: Colors.blue.shade800,
                      height: 50,
                      width: 179,
                      child: Text(
                        "    Your Captain Distance = ",
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                    ),
                  ],
                ),
                Container(
                    height: 530,
                    width: 400,
                    color: Colors.black12,
                    child: Center(
                        child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(33.64352174389097, 73.0776060372591),
                          zoom: 14),
                      markers: Set.from(markers),
                      onMapCreated: (GoogleMapController controller) {},
                      onTap: (LatLng latlng) {
                        setState(() {
                          print("$latlng yeh wala");
                          dlat = latlng.latitude;
                          dlon = latlng.longitude;
                          print(dpoint);
                          print(dlat);
                          print(dlon);
                          d = Distance(
                              widget.p_lat, widget.p_lon, dlat, dlon, 'K');
                          sb = SnackBar(content: Text('$d'));
                          ScaffoldMessenger.of(context).showSnackBar(sb);
                          markers:
                          markers.add(Marker(
                              markerId: MarkerId('myMarker'),
                              draggable: true,
                              position:
                                  LatLng(latlng.latitude, latlng.longitude)));
                        });
                      },
                    ))),
                SizedBox(height: 10),
                Container(
                  width: 400,
                  height: 60,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      if (dpoint == null) {
                        sb = SnackBar(
                            content: Text('Give Your Destination Point'));
                        ScaffoldMessenger.of(context).showSnackBar(sb);
                      } else {
                        //        Navigator.push(context, MaterialPageRoute(builder: (context)=>DropOffLocationPage()),
                        //      );
                      }
                    },
                    child:
                        const Text('Confirm', style: TextStyle(fontSize: 20)),
                    color: Colors.indigo,
                    textColor: Colors.white,
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
