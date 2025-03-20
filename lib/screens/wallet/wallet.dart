import 'package:flutter/material.dart';
import 'package:pn_fl_foody_delivery/theme/theme.dart';
import 'package:pn_fl_foody_delivery/widget/column_builder.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final tabBarList = ["Hoy", "Otros"];

  int selectedTabBar = 0;

  PageController pageController = PageController();

  final todayEarningList = [
    {"orderId": "ACG1458756", "date": "22-Nov-2024", "amount": 32.00},
    {"orderId": "ABG1458756", "date": "22-Nov-2024", "amount": 12.00},
    {"orderId": "FCG1458756", "date": "22-Nov-2024", "amount": 50.00},
    {"orderId": "KLG1458756", "date": "22-Nov-2024", "amount": 20.00},
    {"orderId": "PCG1458756", "date": "22-Nov-2024", "amount": 24.00},
  ];

  final otherEarningList = [
    {"orderId": "ACG1458756", "date": "22-Nov-2024", "amount": 32.00},
    {"orderId": "ABG1458756", "date": "22-Nov-2024", "amount": 12.00},
    {"orderId": "FCG1458756", "date": "22-Nov-2024", "amount": 50.00},
    {"orderId": "KLG1458756", "date": "22-Nov-2024", "amount": 20.00},
    {"orderId": "PCG1458756", "date": "22-Nov-2024", "amount": 24.00},
    {"orderId": "ACG1458756", "date": "22-Nov-2024", "amount": 32.00},
    {"orderId": "ABG1458756", "date": "22-Nov-2024", "amount": 12.00},
    {"orderId": "FCG1458756", "date": "22-Nov-2024", "amount": 50.00},
    {"orderId": "KLG1458756", "date": "22-Nov-2024", "amount": 20.00},
    {"orderId": "PCG1458756", "date": "22-Nov-2024", "amount": 24.00},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
        titleSpacing: 20.0,
        title: const Text(
          "Ganancias",
          style: bold18Black,
        ),
      ),
      body: Column(
        children: [
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
                todayEarningListContent(),
                ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(fixPadding * 2.0,
                      fixPadding * 2.0, fixPadding * 2.0, fixPadding),
                  children: [
                    totalEarningInfo("\$276.00"),
                    heightSpace,
                    ColumnBuilder(
                      itemCount: otherEarningList.length,
                      itemBuilder: (context, index) {
                        final earningData = otherEarningList[index];
                        return Container(
                          margin:
                              const EdgeInsets.symmetric(vertical: fixPadding),
                          padding: const EdgeInsets.all(fixPadding),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: boxShadow,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: "ID de Pedido: ",
                                        style: medium14Grey,
                                        children: [
                                          TextSpan(
                                            text: earningData['orderId']
                                                .toString(),
                                            style: semibold14Black,
                                          ),
                                        ],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    height5Space,
                                    Text.rich(
                                      TextSpan(
                                        text: "Fecha: ",
                                        style: medium14Grey,
                                        children: [
                                          TextSpan(
                                            text:
                                                earningData['date'].toString(),
                                            style: semibold14Black,
                                          ),
                                        ],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                              widthSpace,
                              Text(
                                "\$${(earningData['amount'] as double).toStringAsFixed(2)}",
                                style: bold16Primary,
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget todayEarningListContent() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
          fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, fixPadding),
      children: [
        totalEarningInfo("\$138.00"),
        heightSpace,
        ColumnBuilder(
          itemCount: todayEarningList.length,
          itemBuilder: (context, index) {
            final earningData = todayEarningList[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: fixPadding),
              padding: const EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: boxShadow,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "ID de Pedido: ",
                            style: medium14Grey,
                            children: [
                              TextSpan(
                                text: earningData['orderId'].toString(),
                                style: semibold14Black,
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        height5Space,
                        Text.rich(
                          TextSpan(
                            text: "Fecha: ",
                            style: medium14Grey,
                            children: [
                              TextSpan(
                                text: earningData['date'].toString(),
                                style: semibold14Black,
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  widthSpace,
                  Text(
                    "\$${(earningData['amount'] as double).toStringAsFixed(2)}",
                    style: bold16Primary,
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget totalEarningInfo(String amount) {
    return Container(
      padding: const EdgeInsets.all(fixPadding * 1.5),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: recColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Ganancias de Hoy",
              style: bold18Primary,
            ),
          ),
          widthSpace,
          Text(
            amount,
            style: bold18Primary,
          )
        ],
      ),
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
}
