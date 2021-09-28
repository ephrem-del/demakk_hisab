import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demakk_hisab/src/models/model.dart';

class AddCustomerViewModel {
  Future<bool> addCustomer(customerName, customerNo) async {
    bool isSaved = false;
    final Customer _person = Customer(name: customerName, phoneNo: customerNo);
    try {
      await FirebaseFirestore.instance
          .collection('customers')
          .add(_person.toMap());
      isSaved = true;
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return isSaved;
  }
}
