import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_switch/flutter_switch.dart';

class StandPointPage extends StatefulWidget {
  const StandPointPage({Key? key}) : super(key: key);

  @override
  State<StandPointPage> createState() => _StandPointPageState();
}

class _StandPointPageState extends State<StandPointPage> {
  var mystyle = TextStyle(fontSize: 15);
  List<Marker> markers = [];
  bool status = false;
  LatLng? ppoint;
  var clat, clon;

  late SnackBar sb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: new AppBar(
        //   title: new Text('SELECT YOUR PICKUP POINT',
        //       style: TextStyle(fontSize: 16)),
        // ),
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              color: Colors.indigo,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 29,
                  ),
                  Text("SET YOUR STATUS",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 2, 2, 0),
                    child: FlutterSwitch(
                      width: 80.0,
                      height: 35.0,
                      valueFontSize: 15.0,
                      toggleSize: 45.0,
                      value: status,
                      borderRadius: 30.0,
                      padding: 8.0,
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          status = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 570,
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
                      ppoint = latlng;
                      print(ppoint);
                      clat = latlng.latitude;
                      clon = latlng.longitude;
                      markers:
                      markers.add(Marker(
                          markerId: MarkerId('myMarker'),
                          draggable: true,
                          position: LatLng(latlng.latitude, latlng.longitude)));
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
                  if (status == false) {
                    sb =
                        SnackBar(content: Text('Set Your Status Active First'));
                    ScaffoldMessenger.of(context).showSnackBar(sb);
                  } else {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           DropOffLocationPage(p_lat: plat, p_lon: plon)),
                    // );
                  }
                },
                child: const Text('Confirm', style: TextStyle(fontSize: 20)),
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
