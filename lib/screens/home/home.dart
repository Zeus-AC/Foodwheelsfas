import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/typcn.dart';
import 'package:pn_fl_foody_delivery/theme/theme.dart';

bool isOffline = true;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tabBarList = ["Nuevos pedidos", "Órdenes activas"];

  int selectedTabBar = 0;

  PageController pageController = PageController();

  final newOrdersList = [
    {
      "orderId": "ACG1458756",
      "paymentMethod": "Online",
      "amount": 32.00,
      "time": "1 min ago",
      "startLocation": "491, Sai Section, Ambernath",
      "destinationLocation": "491, Sai Section, Ambernath"
    },
    {
      "orderId": "BCG1458756",
      "paymentMethod": "Online",
      "amount": 32.00,
      "time": "1 min ago",
      "startLocation": "Jain Tower Distt Centere, Karachi",
      "destinationLocation": "175, Jawahar Nagar, Amizara"
    },
    {
      "orderId": "GCG1458756",
      "paymentMethod": "Online",
      "amount": 32.00,
      "time": "1 min ago",
      "startLocation": "48, Hunters Road, Veperyh",
      "destinationLocation": "Great Western, Mcc Lane, Fort"
    },
    {
      "orderId": "DCG1458756",
      "paymentMethod": "Online",
      "amount": 32.00,
      "time": "1 min ago",
      "startLocation": "21, 5th Cross Doble Road, Benai",
      "destinationLocation": "Great Western, Mcc Lane, Fort"
    },
  ];

  final activeOrderList = [
    {
      "orderId": "ACG1458756",
      "paymentMethod": "Online",
      "amount": 32.00,
      "time": "1 min ago",
      "startLocation": "48, Hunters Road, Vepery",
      "destinationLocation": "Great Western, Mcc Lane, Fort"
    },
    {
      "orderId": "BCG1458756",
      "paymentMethod": "Cash on delivery",
      "amount": 62.00,
      "time": "1 min ago",
      "startLocation": "175, Jawahar Nagar, Amizara",
      "destinationLocation": "Jain Tower Distt Centere, Karachi"
    },
    {
      "orderId": "CCG1428756",
      "paymentMethod": "Online",
      "amount": 40.00,
      "time": "1 min ago",
      "startLocation": "48, Hunters Road, Veperyh",
      "destinationLocation": "Great Western, Mcc Lane, Fort"
    },
    {
      "orderId": "ACG1458756",
      "paymentMethod": "Cash on Delivery",
      "amount": 30.00,
      "time": "1 min ago",
      "startLocation": "491, Sai Section, Ambernath",
      "destinationLocation": "21, 5th cross Doble Road, Ambernath"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: false,
        titleSpacing: 20.0,
        title: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: const DecorationImage(
                  image: AssetImage("assets/profile/user-image.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            widthSpace,
            const Expanded(
              child: Text(
                "Hola, Usuario",
                style: bold15White,
              ),
            ),
            widthSpace,
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
            icon: const Iconify(
              Ep.bell_filled,
              color: whiteColor,
              size: 22.0,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          goOnlineOffline(),
          Expanded(
            child: isOffline
                ? offlineContent(size)
                : Column(
                    children: [
                      heightBox(fixPadding * 0.2),
                      tabBar(),
                      Expanded(
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (index) {
                            setState(() {
                              selectedTabBar = index;
                            });
                          },
                          children: [
                            newOrderListContent(),
                            activeOrderListContent(),
                          ],
                        ),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }

  Widget activeOrderListContent() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          vertical: fixPadding, horizontal: fixPadding * 2.0),
      itemCount: activeOrderList.length,
      itemBuilder: (context, index) {
        final orderData = activeOrderList[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/orderDetail', arguments: 1);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: fixPadding),
            clipBehavior: Clip.hardEdge,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: boxShadow,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(fixPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            infoWidget(
                              "ID de pedido",
                              orderData['orderId'].toString(),
                            ),
                            height5Space,
                            infoWidget(
                              "Metodo de pago",
                              orderData['paymentMethod'].toString(),
                            ),
                            height5Space,
                            infoWidget(
                              "Cantidad",
                              "\$${(orderData['amount'] as double).toStringAsFixed(2)}",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 10.0,
                        width: 10.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                locationDetail(orderData),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget newOrderListContent() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          vertical: fixPadding, horizontal: fixPadding * 2.0),
      itemCount: newOrdersList.length,
      itemBuilder: (context, index) {
        final orderData = newOrdersList[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/orderDetail', arguments: 0);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: fixPadding),
            clipBehavior: Clip.hardEdge,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: boxShadow,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(fixPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: infoWidget(
                              "ID de pedido",
                              orderData['orderId'].toString(),
                            ),
                          ),
                          widthSpace,
                          Text(
                            orderData['time'].toString(),
                            style: semibold14Grey,
                          )
                        ],
                      ),
                      height5Space,
                      infoWidget(
                        "Metodo de pago",
                        orderData['paymentMethod'].toString(),
                      ),
                      height5Space,
                      infoWidget(
                        "Cantidad",
                        "\$${(orderData['amount'] as double).toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ),
                locationDetail(orderData),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget locationDetail(Map<String, Object> orderData) {
    return Container(
      width: double.maxFinite,
      color: recColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                  fixPadding, fixPadding, fixPadding, fixPadding * 1.5),
              color: recColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
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
                          orderData['startLocation'].toString(),
                          style: semibold14Black,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Text(
                          "•\n•\n•",
                          style: TextStyle(
                              height: 0.7,
                              fontSize: 8.0,
                              color: Colors.transparent),
                        ),
                        Text(
                          orderData['destinationLocation'].toString(),
                          style: semibold14Black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 30.0,
            width: 30.0,
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
              ),
            ),
            child: const Icon(
              Icons.east,
              color: whiteColor,
              size: 20.0,
            ),
          )
        ],
      ),
    );
  }

  Widget infoWidget(String title, String info) {
    return Text.rich(
      TextSpan(
        text: "$title: ",
        style: medium14Grey,
        children: [
          TextSpan(
            text: info,
            style: semibold14Black,
          )
        ],
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget tabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding, vertical: fixPadding * 1.5),
      width: double.maxFinite,
      color: recColor,
      child: Row(
        children: List.generate(
          tabBarList.length,
          (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTabBar = index;
                    pageController.jumpToPage(selectedTabBar);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: fixPadding),
                  padding: const EdgeInsets.all(fixPadding * 0.8),
                  decoration: BoxDecoration(
                    color: selectedTabBar == index ? primaryColor : whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    tabBarList[index].toString(),
                    style: selectedTabBar == index
                        ? semibold16White
                        : semibold16Black,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget offlineContent(Size size) {
    return Container(
      color: primaryColor,
      width: double.maxFinite,
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(fixPadding * 2.0),
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: Image.asset(
              "assets/home/deliveryBoy.png",
              height: size.height * 0.25,
              fit: BoxFit.cover,
            ),
          ),
          heightSpace,
          heightSpace,
          const Text(
            "¡Estás desconectado ahora!",
            style: bold20White,
            textAlign: TextAlign.center,
          ),
          heightSpace,
          height5Space,
          const Text(
            "Conéctese en línea, acepte sus pedidos y haga satisfecho al cliente con sus servicios",
            style: medium16White,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget goOnlineOffline() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOffline = !isOffline;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 1.5, vertical: fixPadding * 1.2),
        width: double.maxFinite,
        color: recColor,
        child: Row(
          children: [
            Expanded(
              child: Text(
                isOffline ? "Conectarse" : "Desconectarse",
                style: bold20Primary,
              ),
            ),
            widthSpace,
            const Icon(
              Icons.east,
              color: primaryColor,
              size: 26.0,
            )
          ],
        ),
      ),
    );
  }
}

class Basil {}
