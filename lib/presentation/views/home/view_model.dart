
import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import '../../../application/common/enum.dart';
import '../../../base/base_view_model.dart';
import '../../../data/models/get_available_numbers.dart';
import '../../../data/models/get_states.dart';
import '../../../data/models/registered_customer_history.dart';
import '../../../widgets/primary_button.dart';


class ViewModel extends BaseViewModel {
  List<String> identities = [];

  List<StateModel> states = [];

  List<Number> availableNumbers = [];

  List<Customer> customerHistory = [];
  int count = 0;

  PaginationState _state = PaginationState.uninitialized;

  PaginationState get state => _state;

  int _quantity = 0;
  int _availableStock = 20;
  String? _quantityError;
  TextEditingController quantityController = TextEditingController();

  int get quantity => _quantity;
  int get availableStock => _availableStock;
  String? get quantityError => _quantityError;

  set quantity(int value) {
    _quantity = value;
    setState();
  }
  set availableStock(int value) {
    _availableStock = value;
    setState();
  }
  set quantityError(String? value) {
    _quantityError = value;
    setState();
  }
  void decrementQuantity() {
    if (_quantity > 0) {
      _quantity--;
      _quantityError = null;
      quantityController.text= _quantity.toString();
      setState();
    }
  }

  void incrementQuantity() {
    if (_quantity < _availableStock) {
      _quantity++;
      _quantityError = null;
      quantityController.text= _quantity.toString();
      setState();
    }
  }
  void resetOrderSimState() {
    // Reset values without notifying listeners
    _quantity = 0;
    _quantityError = null;
    // No setState() call here
  }

  void validateAndPlaceOrder(BuildContext context)  {
    if (quantity >= 1) {
      if (quantity <= availableStock) {
        quantityError=null;
        setState();
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title:  Text("Confirm Order",style: context.textTheme.displaySmall,),
            content:
            Text("You have ordered $quantity SIM(s)."),
            actions: [
              PrimaryButton(
                  issquare: true,
                  childText: 'Confirm & Pay',
                  isSafeArea: false,
                  onPressed: () {}),
            ],
          ),
        );
      } else {
        quantityError =
        'Exceeds stock limit';
        setState();
      }
    } else {
      quantityError = 'Quantity must be at least 1';
      setState();
    }
  }

  set state(PaginationState value) {
    _state = value;
    setState();
  }

  int _currentPage = 1;

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    setState();
  }

  bool _nextExist = true;

  bool get nextExist => _nextExist;

  set nextExist(bool value) {
    _nextExist = value;
    setState();
  }

}
