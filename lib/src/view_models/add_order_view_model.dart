import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/model.dart';

class AddOrderViewModel {
  Future<bool> addOrder(String name, String orderType, int amount,
      double pricePerSingle, int payment, String id) async {
    double _paymentLeft = 0;
    if (pricePerSingle != 0 && amount != 0) {
      _paymentLeft = (pricePerSingle * amount) - payment;
    } else {
      _paymentLeft = (-payment * 1.0);
    }
    bool isSaved = false;
    final Order _order = Order(
        name: name,
        amount: amount,
        pricePerSingle: pricePerSingle,
        paid: payment,
        orderType: orderType,
        orderDate: DateTime.now());
    try {
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(id)
          .collection('orders')
          .add(_order.toMap());
      isSaved = true;
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final secureSnapshot = await transaction
            .get(FirebaseFirestore.instance.collection('customers').doc(id));
        final double paymentLeft = secureSnapshot.get('paymentLeft') as double;
        transaction.update(secureSnapshot.reference,
            {'paymentLeft': paymentLeft + _paymentLeft});
      });
    } on FirebaseException catch (e) {
      print('error: $e');
    } catch (e) {
      print('error: $e');
    }
    return isSaved;
  }
}
