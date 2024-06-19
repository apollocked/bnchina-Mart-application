import 'package:apollo/utils/colors.dart';
import 'package:apollo/utils/data.dart';
import 'package:flutter/material.dart';

class BasketCard extends StatefulWidget {
  const BasketCard(
      {super.key,
      required this.product,
      required this.onMinus,
      required this.onplus});
  final Map<String, dynamic> product;
  final VoidCallback onplus;
  final VoidCallback onMinus;

  @override
  State<BasketCard> createState() => _BasketCardState();
}

class _BasketCardState extends State<BasketCard> {
  @override
  Widget build(BuildContext context) {
    return basketItems.isEmpty
        ? Container()
        : Container(
            width: double.infinity,
            height: 80,
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: darkGreyColor, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(8)),
                        height: 75,
                        width: 75,
                        child: Image.asset(widget.product["imgPath"]),
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product["name"],
                          style: TextStyle(
                              fontSize: 15,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'popins'),
                        ),
                        Text(
                          widget.product["details"],
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'popins',
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: widget.product["totalPrice"].toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'popins',
                                  color: textColor),
                            ),
                            TextSpan(
                              text: " IQD",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'popins',
                                  color: textColor),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        FloatingActionButton(
                          heroTag: "basket m ${widget.product["imgPath"]}",
                          onPressed: widget.onMinus,
                          backgroundColor: primaryColor,
                          shape: const CircleBorder(),
                          child: Icon(
                            Icons.remove,
                            size: 19,
                            color: inblack,
                          ),
                        ),
                        Text("${widget.product["quantity"]}"),
                        FloatingActionButton(
                          heroTag: "basket p ${widget.product["imgPath"]}",
                          onPressed: widget.onplus,
                          backgroundColor: primaryColor,
                          shape: const CircleBorder(),
                          child: Icon(
                            Icons.add,
                            size: 19,
                            color: inblack,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          );
  }
}
