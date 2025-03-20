import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/typcn.dart';
import 'package:pn_fl_foody_delivery/theme/theme.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: whiteColor,
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
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding / 2,
            fixPadding * 2.0, fixPadding * 2.0),
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: boxShadow,
            ),
            child: Column(
              children: [
                orderInfo(),
                locationInfo(),
                customerInfo(),
                paymentInfo(),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: data == 0
          ? Row(
              children: [
                Expanded(
                  child: buttonWidget("Rechazar", () {
                    rejectDialog(context);
                  }),
                ),
                widthBox(3.0),
                Expanded(
                  child: buttonWidget("Aceptar", () {
                    Navigator.pushNamed(context, '/trackOrder');
                  }),
                ),
              ],
            )
          : buttonWidget("Comenzar", () {
              Navigator.pushNamed(context, '/trackOrder');
            }),
    );
  }

  Future<dynamic> rejectDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(fixPadding * 2.0),
          clipBehavior: Clip.hardEdge,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: whiteColor,
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: fixPadding * 2.0, vertical: fixPadding * 1.3),
                  width: double.maxFinite,
                  color: primaryColor,
                  child: const Text(
                    "Motivo del rechazo",
                    style: bold18White,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: constraints.maxHeight - 130,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(fixPadding * 2.0,
                        fixPadding * 1.5, fixPadding * 2.0, fixPadding * 2.0),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Escribe un motivo específico para rechazar el pedido.",
                          style: medium16Black,
                        ),
                        heightSpace,
                        height5Space,
                        Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: recColor,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: boxShadow,
                          ),
                          child: const TextField(
                            expands: true,
                            minLines: null,
                            maxLines: null,
                            style: medium16Black,
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Ingrese el motivo aquí...",
                                hintStyle: medium16Grey,
                                contentPadding: EdgeInsets.all(fixPadding)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: buttonWidget("Cancelar", () {
                        Navigator.pop(context);
                      }),
                    ),
                    widthBox(fixPadding * 0.3),
                    Expanded(
                      child: buttonWidget("Enviar", () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }),
                    )
                  ],
                )
              ],
            );
          }),
        );
      },
    );
  }

  Widget buttonWidget(String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(fixPadding * 1.3),
        width: double.maxFinite,
        color: primaryColor,
        child: Text(
          title,
          style: bold18White,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget paymentInfo() {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          color: recColor,
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding, vertical: fixPadding * 1.2),
          child: const Text(
            "Pago",
            style: bold16Primary,
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: fixPadding, vertical: fixPadding * 1.5),
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
        Container(
          width: double.maxFinite,
          color: recColor,
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding, vertical: fixPadding * 1.2),
          child: const Text(
            "Cliente",
            style: bold16Primary,
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: fixPadding, vertical: fixPadding * 1.5),
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
        Container(
          width: double.maxFinite,
          color: recColor,
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding, vertical: fixPadding * 1.2),
          child: const Text(
            "Ubicación",
            style: bold16Primary,
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: fixPadding, vertical: fixPadding * 1.5),
          child: Row(
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
                          height: 0.7,
                          fontSize: 8.0,
                          color: Colors.transparent),
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
          ),
        )
      ],
    );
  }

  Widget orderInfo() {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          color: primaryColor,
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding, vertical: fixPadding * 1.3),
          child: const Text(
            "ID de orden: ACG1458756",
            style: bold16White,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: fixPadding * 1.5, horizontal: fixPadding),
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
      ],
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
}
