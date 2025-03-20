import 'package:flutter/material.dart';
import 'package:pn_fl_foody_delivery/theme/theme.dart';
import 'package:pn_fl_foody_delivery/widget/column_builder.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  final tabList = ["Todos", "Entregados", "Pendientes", "Rechazados"];

  int selectedTab = 0;

  PageController pageController = PageController();

  static final allList = [
    {
      "title": "Hoy",
      "list": [
        {
          "OrderID": "PCG1458756",
          "date": "22-Nov-2024",
          "paymentMethod": "Pago contra entrega",
          "status": "Rechazado",
          "amount": 24.00
        },
        {
          "OrderID": "PCG1458756",
          "date": "22-Nov-2024",
          "paymentMethod": "En línea",
          "status": "Entregado",
          "amount": 34.00
        },
      ]
    },
    {
      "title": "Otro",
      "list": [
        {
          "OrderID": "DCG1458756",
          "date": "21-Nov-2024",
          "paymentMethod": "En línea",
          "status": "Pendiente",
          "amount": 20.00
        },
        {
          "OrderID": "ICG1458756",
          "date": "21-Nov-2024",
          "paymentMethod": "Pago contra entrega",
          "status": "Entregado",
          "amount": 14.00
        },
        {
          "OrderID": "DCG1458756",
          "date": "21-Nov-2024",
          "paymentMethod": "Pago contra entrega",
          "status": "Pendiente",
          "amount": 20.00
        },
        {
          "OrderID": "UCG1458756",
          "date": "20-Nov-2024",
          "paymentMethod": "En línea",
          "status": "Rechazado",
          "amount": 20.00
        },
        {
          "OrderID": "ICG1458756",
          "date": "19-Nov-2024",
          "paymentMethod": "En línea",
          "status": "Entregado",
          "amount": 54.00
        },
      ]
    },
  ];

  static List getOrderByCategory(List allList, String status) {
    List orders = [];

    for (var category in allList) {
      List list = [];
      for (var order in category['list']) {
        if (order['status'] == status) {
          list.add(order);
        }
      }
      if (list.isNotEmpty) {
        orders.add(
          {"title": category['title'], "list": list},
        );
      }
    }

    return orders;
  }

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  final List deliveredOrdersList = getOrderByCategory(allList, "Entregado");
  final List pendingOrdersList = getOrderByCategory(allList, "Pendiente");
  final List rejectedOrdersList = getOrderByCategory(allList, "Rechazado");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
        titleSpacing: 20.0,
        title: const Text(
          "Historial",
          style: bold18Black,
        ),
      ),
      body: Column(
        children: [
          tabBar(),
          heightBox(2.0),
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  selectedTab = index;

                  tabController.animateTo(selectedTab);
                });
              },
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              children: [
                allListContent(),
                deliverdOrderListContent(),
                pendingOrdersListContent(),
                rejectedOrdersListContent(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rejectedOrdersListContent() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: rejectedOrdersList.length,
      itemBuilder: (context, index) {
        final orders = rejectedOrdersList[index];
        final List ordersList = orders['list'] as List;
        return listContent(orders, ordersList);
      },
    );
  }

  Widget pendingOrdersListContent() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: pendingOrdersList.length,
      itemBuilder: (context, index) {
        final orders = pendingOrdersList[index];
        final List ordersList = orders['list'] as List;
        return listContent(orders, ordersList);
      },
    );
  }

  Widget deliverdOrderListContent() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: deliveredOrdersList.length,
      itemBuilder: (context, index) {
        final orders = deliveredOrdersList[index];
        final List ordersList = orders['list'] as List;
        return listContent(orders, ordersList);
      },
    );
  }

  Widget allListContent() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: allList.length,
      itemBuilder: (context, index) {
        final orders = allList[index];
        final List ordersList = orders['list'] as List;
        return listContent(orders, ordersList);
      },
    );
  }

  Widget listContent(Map orders, List ordersList) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2.0, vertical: fixPadding * 1.3),
          width: double.maxFinite,
          color: recColor,
          child: Text(
            orders['title'].toString(),
            style: semibold16Black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: fixPadding),
          child: ColumnBuilder(
            itemBuilder: (context, i) {
              final orderData = ordersList[i];
              return Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 2.0, vertical: fixPadding),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: boxShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(fixPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            orderInfo(
                              "ID de Pedido",
                              orderData['OrderID'].toString(),
                            ),
                            height5Space,
                            orderInfo(
                              "Fecha",
                              orderData['date'].toString(),
                            ),
                            height5Space,
                            orderInfo(
                              "Método de Pago",
                              orderData['paymentMethod'].toString(),
                            ),
                          ],
                        ),
                      ),
                      if (orderData['status'] == "Pendiente")
                        statusAndAmountBox(orderData, const Color(0xFFFFA500)),
                      if (orderData['status'] == "Entregado")
                        statusAndAmountBox(orderData, primaryColor),
                      if (orderData['status'] == "Rechazado")
                        statusAndAmountBox(orderData, const Color(0xFFFF3D00))
                    ],
                  ),
                ),
              );
            },
            itemCount: ordersList.length,
          ),
        )
      ],
    );
  }

  Widget statusAndAmountBox(orderData, Color color) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(fixPadding),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              orderData['status'].toString(),
              style: bold16White.copyWith(
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          widthSpace,
          Text(
            "\$${(orderData['amount'] as double).toStringAsFixed(2)}",
            style: bold16White.copyWith(
              color: color,
            ),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget orderInfo(String title, String info) {
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
        width: double.maxFinite,
        color: recColor,
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorPadding: EdgeInsets.zero,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          labelPadding: EdgeInsets.zero,
          tabAlignment: TabAlignment.center,
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 1.25),
          tabs: List.generate(
            tabList.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTab = index;
                    pageController.jumpToPage(selectedTab);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: fixPadding * 0.75,
                      vertical: fixPadding * 1.3),
                  padding: const EdgeInsets.symmetric(
                      vertical: fixPadding * 0.8, horizontal: fixPadding * 3.0),
                  decoration: BoxDecoration(
                    color: selectedTab == index ? primaryColor : whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    tabList[index].toString(),
                    style: selectedTab == index
                        ? semibold16White
                        : semibold16Black,
                  ),
                ),
              );
            },
          ),
        )
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   physics: const BouncingScrollPhysics(),
        //   padding: const EdgeInsets.symmetric(
        //       horizontal: fixPadding * 1.25, vertical: fixPadding * 1.5),
        //   child: Row(
        //     children: List.generate(
        //       tabList.length,
        //       (index) {
        //         return GestureDetector(
        //           onTap: () {
        //             setState(() {
        //               selectedTab = index;
        //               pageController.jumpToPage(selectedTab);
        //             });
        //           },
        //           child: Container(
        //             margin:
        //                 const EdgeInsets.symmetric(horizontal: fixPadding * 0.75),
        //             padding: const EdgeInsets.symmetric(
        //                 vertical: fixPadding * 0.8, horizontal: fixPadding * 3.0),
        //             decoration: BoxDecoration(
        //               color: selectedTab == index ? primaryColor : whiteColor,
        //               borderRadius: BorderRadius.circular(10.0),
        //             ),
        //             child: Text(
        //               tabList[index].toString(),
        //               style: selectedTab == index
        //                   ? semibold16White
        //                   : semibold16Black,
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),
        );
  }
}
