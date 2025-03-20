import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/typcn.dart';
import 'package:pn_fl_foody_delivery/constant/key.dart';
import 'package:pn_fl_foody_delivery/theme/theme.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  GoogleMapController? mapController;

  List<Marker> allMarkers = [];
  static const CameraPosition _currentPosition =
      CameraPosition(target: LatLng(51.498851, -0.147758), zoom: 14.0);

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  final startLat = 51.498528;
  final startLng = -0.158019;
  final endLat = 51.513011;
  final endLng = -0.136560;

  @override
  void initState() {
    getDirections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.west,
            color: blackColor,
          ),
        ),
        title: const Text(
          "ACG1458756",
          style: bold18Black,
        ),
      ),
      body: Stack(
        children: [
          googleMap(size),
          deliveryDetail(size),
        ],
      ),
    );
  }

  deliveryDetail(Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              orderInfoDialog(size);
            },
            child: Container(
              height: 40.0,
              width: 40.0,
              margin: const EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: boxShadow,
                color: whiteColor,
              ),
              alignment: Alignment.center,
              child: const Iconify(
                Ep.list,
                color: primaryColor,
                size: 24.0,
              ),
            ),
          ),
          heightSpace,
          height5Space,
          Container(
            height: 40.0,
            width: 40.0,
            margin: const EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: boxShadow,
              color: whiteColor,
            ),
            alignment: Alignment.center,
            child: const Iconify(
              Carbon.phone_filled,
              color: primaryColor,
              size: 22.0,
            ),
          ),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(fixPadding * 1.5),
            margin: const EdgeInsets.all(fixPadding * 1.5),
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: boxShadow,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                          image: AssetImage(
                            "assets/trackOrder/customer-image.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    widthSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Usuario01",
                            style: semibold16Black,
                            overflow: TextOverflow.ellipsis,
                          ),
                          heightBox(fixPadding * 0.3),
                          const Text(
                            "+52 5487596585",
                            style: medium15Grey,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    widthSpace,
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/chat');
                      },
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        alignment: Alignment.center,
                        child: const Iconify(
                          IconParkSolid.message,
                          color: whiteColor,
                          size: 20.0,
                        ),
                      ),
                    )
                  ],
                ),
                heightSpace,
                locationWidget(),
                heightSpace,
                GestureDetector(
                  onTap: () {
                    Timer(const Duration(seconds: 3), () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/bottomBar', (route) => false);
                    });
                    successDialog();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0, vertical: fixPadding * 1),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      "Finalizar",
                      style: bold18White,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> orderInfoDialog(Size size) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: whiteColor,
          clipBehavior: Clip.hardEdge,
          insetPadding: const EdgeInsets.all(fixPadding * 2.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.maxFinite,
                color: primaryColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding, vertical: fixPadding * 1.3),
                child: const Text(
                  "ID de orden : ACG1458756",
                  style: bold16White,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: size.height - 220),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(fixPadding * 1.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            orderinfoWidget("Classic Cheese Burger", "\$32.00"),
                            heightSpace,
                            orderinfoWidget("Chatni Sandwich", "\$12.00"),
                            heightSpace,
                            orderinfoWidget("Margherita Pizza", "\$50.00"),
                            heightSpace,
                            orderinfoWidget("Delivery Charge", "\$2.00"),
                            heightSpace,
                            totalPrice(),
                          ],
                        ),
                      ),
                      locationInfo(),
                      customerInfo(),
                      paymentInfo(),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: fixPadding * 1.3,
                    horizontal: fixPadding * 2.0,
                  ),
                  width: double.maxFinite,
                  color: primaryColor,
                  child: const Text(
                    "OK",
                    style: bold18White,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget paymentInfo() {
    return Column(
      children: [
        title("Pago"),
        const Padding(
          padding: EdgeInsets.all(fixPadding * 1.5),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Metodo de pago",
                  style: semibold14Black,
                ),
              ),
              widthSpace,
              Text(
                "En linea",
                style: semibold14Black,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget customerInfo() {
    return Column(
      children: [
        title("Cliente"),
        const Padding(
          padding: EdgeInsets.all(fixPadding * 1.5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Nombre",
                      style: semibold14Black,
                    ),
                  ),
                  widthSpace,
                  Text(
                    "Usuario01",
                    style: semibold14Black,
                  ),
                ],
              ),
              heightSpace,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Número de teléfono móvil",
                      style: semibold14Black,
                    ),
                  ),
                  widthSpace,
                  Text(
                    "(+52) 1235487965",
                    style: semibold14Black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget locationInfo() {
    return Column(
      children: [
        title("Ubicación"),
        Padding(
          padding: const EdgeInsets.all(fixPadding * 1.5),
          child: locationWidget(),
        )
      ],
    );
  }

  Widget locationWidget() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Iconify(
              Typcn.location,
              color: primaryColor,
              size: 18.0,
            ),
            Text(
              "•\n•\n•",
              style: TextStyle(height: 0.7, fontSize: 10.0),
            ),
            Iconify(
              MaterialSymbols.navigation,
              color: primaryColor,
              size: 18.0,
            ),
          ],
        ),
        width5Space,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "48, Hunters Road, Vepery",
                style: semibold14Black,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "•\n•\n•",
                style: TextStyle(
                    height: 0.7, fontSize: 8.0, color: Colors.transparent),
              ),
              Text(
                "Great Western, Mcc Lane, Fort",
                style: semibold14Black,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget title(String title) {
    return Container(
      width: double.maxFinite,
      color: recColor,
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding, vertical: fixPadding * 1.2),
      child: Text(
        title,
        style: bold16Primary,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget totalPrice() {
    return const Row(
      children: [
        Expanded(
          child: Text(
            "Total",
            style: bold14Primary,
          ),
        ),
        width5Space,
        Text(
          "\$96.00",
          style: bold14Primary,
        )
      ],
    );
  }

  Widget orderinfoWidget(String title, String price) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: semibold14Black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        widthSpace,
        Text(
          price,
          style: semibold14Black,
        )
      ],
    );
  }

  Future<dynamic> successDialog() {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return PopScope(
          canPop: false,
          child: Dialog(
            insetPadding: const EdgeInsets.all(fixPadding * 2.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: whiteColor,
            clipBehavior: Clip.hardEdge,
            child: ListView(
              padding: const EdgeInsets.all(fixPadding * 2.0),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColor,
                    boxShadow: boxShadow,
                  ),
                  child: const Iconify(
                    Ep.success_filled,
                    color: primaryColor,
                  ),
                ),
                heightSpace,
                const Text(
                  "Exito",
                  style: semibold18Black,
                  textAlign: TextAlign.center,
                ),
                height5Space,
                const Text(
                  "Felicitaciones el pedido se completo con éxito.",
                  style: semibold16Grey,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  googleMap(Size size) {
    return SizedBox(
      height: double.maxFinite,
      width: size.width,
      child: GoogleMap(
        mapType: MapType.terrain,
        polylines: Set<Polyline>.of(polylines.values),
        initialCameraPosition: _currentPosition,
        markers: Set.from(allMarkers),
        onMapCreated: mapCreated,
        zoomControlsEnabled: false,
      ),
    );
  }

  mapCreated(GoogleMapController controller) async {
    mapController = controller;
    await marker();
    if (mounted) {
      setState(() {});
    }
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(startLat, startLng),
        destination: PointLatLng(endLat, endLng),
        mode: TravelMode.driving,
        wayPoints: [
          PolylineWayPoint(location: "Regent St, London W1B 5AS"),
        ],
      ),
      googleApiKey: googleMapApiKey,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: primaryColor,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
    if (mounted) {
      setState(() {});
    }
  }

  marker() async {
    allMarkers.add(
      Marker(
        markerId: const MarkerId("0"),
        rotation: 0.1,
        visible: true,
        position: LatLng(startLat, startLng),
        anchor: const Offset(0.4, 0.25),
        icon: BytesMapBitmap(
          await getBytesFromAsset("assets/trackOrder/marker-1.png", 90),
          bitmapScaling: MapBitmapScaling.none,
        ),
      ),
    );
    allMarkers.add(
      Marker(
        markerId: const MarkerId("1"),
        position: LatLng(endLat, endLng),
        icon: BytesMapBitmap(
          await getBytesFromAsset("assets/trackOrder/marker-2.png", 90),
          bitmapScaling: MapBitmapScaling.none,
        ),
        anchor: const Offset(0.35, 0.4),
      ),
    );
  }
}
