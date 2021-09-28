import 'dart:math';

import 'package:demakk_hisab/src/view_models/order_view_model.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final Function onCancel;
  final bool cancelButtonNotVisible;
  final OrderViewModel order;
  const OrderTile(
      {Key? key,
      required this.order,
      required this.onCancel,
      this.cancelButtonNotVisible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.black54),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 2), blurRadius: 6.0, color: Colors.black26)
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          order.isCancelled
              ? Opacity(
                  opacity: 0.7,
                  child: Transform.rotate(
                    angle: -pi / 5,
                    child: const Text(
                      'የተሰረዘ',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.red, fontSize: 55, letterSpacing: 15),
                    ),
                  ),
                )
              : SizedBox.shrink(),
          Column(
            children: [
              _OrderTileElement(
                title: 'ስም: ',
                detail: order.orderName,
              ),
              _OrderTileElement(title: 'አይነት: ', detail: order.orderType),
              _OrderTileElement(title: 'ብዛት: ', detail: order.orderAmount),
              _OrderTileElement(
                  title: 'የአንዱ ዋጋ: ', detail: order.pricePerSingle),
              _OrderTileElement(title: 'የተከፈለ: ', detail: order.totalPaid),
              order.isPayment
                  ? SizedBox.shrink()
                  : _OrderTileElement(
                      title: 'ያልተከፍለ ቀሪ', detail: order.paymentLeft),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    order.isCancelled ||
                            order.isPayment ||
                            cancelButtonNotVisible
                        ? const SizedBox.shrink()
                        : IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('መሰርዣ'),
                                    content: const Text(
                                        'እርግጠኛ ነህ/ነሽ? ትእዛዙን መሰረዝ ትፈልጋልህ/ሽ?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          return Navigator.pop(context);
                                        },
                                        child: const Text('አይ አልፈልግም'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          onCancel();
                                          return Navigator.pop(context);
                                        },
                                        child: const Text('አዎ'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child:
                          _OrderTileElement(title: '', detail: order.orderDate),
                    )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderTileElement extends StatelessWidget {
  final double? size;
  final String title;
  final String detail;
  const _OrderTileElement(
      {Key? key, required this.title, required this.detail, this.size = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Text(
            detail,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
