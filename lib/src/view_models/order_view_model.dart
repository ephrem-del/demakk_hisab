import 'package:demakk_hisab/src/models/model.dart';
import 'package:demakk_hisab/src/utils/time_converter.dart';

class OrderViewModel {
  final Order order;

  OrderViewModel({required this.order});

  String get orderName {
    return order.name;
  }

  String get orderType {
    if (order.pricePerSingle == 0 && order.amount == 0) {
      return 'Payment';
    }
    return order.orderType;
  }

  String get orderAmount {
    return '${order.amount}';
  }

  String get pricePerSingle {
    return '${order.pricePerSingle}';
  }

  String get totalPaid {
    return '${order.paid}';
  }

  bool get isPayment {
    if (order.amount == 0 && order.pricePerSingle == 0) {
      return true;
    }
    return false;
  }

  String get paymentLeft {
    if (order.amount == 0 && order.pricePerSingle == 0) {
      return '';
    } else {
      return '${(order.amount * order.pricePerSingle) - order.paid}';
    }
  }

  bool get isCancelled {
    return order.isCancelled;
  }

  String get id {
    return order.id;
  }

  String get orderDate {
    final hour = order.orderDate.toLocal().hour;
    final converted = TimeConverter(hour: hour).convertedTime;
    if (order.orderDate.day == DateTime.now().day &&
        order.orderDate.month == DateTime.now().month &&
        order.orderDate.year == DateTime.now().year) {
      return 'Today @ $converted : ${order.orderDate.minute}';
    } else if (!(DateTime.now().difference(order.orderDate) >
        const Duration(days: 1))) {
      return 'Yesterday $converted : ${order.orderDate.minute}';
    } else {
      switch (order.orderDate.weekday) {
        case 1:
          return 'Monday $converted : ${order.orderDate.minute}  ${order.orderDate.toLocal().day}/${order.orderDate.toLocal().month}/${order.orderDate.toLocal().year}';
        case 2:
          return 'Tuesday $converted : ${order.orderDate.minute}  ${order.orderDate.toLocal().day}/${order.orderDate.toLocal().month}/${order.orderDate.toLocal().year}';
        case 3:
          return 'Wednesday $converted : ${order.orderDate.minute}  ${order.orderDate.toLocal().day}/${order.orderDate.toLocal().month}/${order.orderDate.toLocal().year}';
        case 4:
          return 'Thursday $converted : ${order.orderDate.minute}  ${order.orderDate.toLocal().day}/${order.orderDate.toLocal().month}/${order.orderDate.toLocal().year}';
        case 5:
          return 'Friday $converted : ${order.orderDate.minute}  ${order.orderDate.toLocal().day}/${order.orderDate.toLocal().month}/${order.orderDate.toLocal().year}';
        case 6:
          return 'Saturday $converted : ${order.orderDate.minute}  ${order.orderDate.toLocal().day}/${order.orderDate.toLocal().month}/${order.orderDate.toLocal().year}';
        case 7:
          return 'Sunday $converted : ${order.orderDate.minute}  ${order.orderDate.toLocal().day}/${order.orderDate.toLocal().month}/${order.orderDate.toLocal().year}';
        default:
          return order.orderDate.toLocal().toString();
      }
    }
    //return order.orderDate.toString();
  }
}
