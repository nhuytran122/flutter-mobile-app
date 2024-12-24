import 'package:flutter/material.dart';
import 'package:shopping_app/components/input_field.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/shoppingCart.dart';
import 'package:shopping_app/thank_you.dart';

class CheckOutScreen extends StatefulWidget {
  static String routeName = "/check_out";

  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  void userTappedPay() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Confirm payment"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Full Name: ${fullNameController.text}"),
                Text("Phone Number: ${phoneNumberController.text}"),
                Text("Address: ${addressController.text}"),
                Text(
                    "Total Price: ${CommonMethod.formatPrice(cart.getTotal())}"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                cart.items.clear();
                Navigator.pushNamed(context, ThankYouScreen.routeName)
                    .then((value) {
                  if (value == true) {
                    setState(() {});
                  }
                });
              },
              child: Text("Confirm"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  MyCustomInputField(
                    labelText: 'Full Name',
                    iconData: Icons.person,
                    hintText: 'Enter your full name',
                    obscureText: false,
                    controller: fullNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),
                  MyCustomInputField(
                    labelText: 'Phone Number',
                    iconData: Icons.phone,
                    hintText: 'Enter your phone number',
                    obscureText: false,
                    controller: phoneNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),
                  MyCustomInputField(
                    labelText: 'Address',
                    iconData: Icons.location_on,
                    hintText: 'Enter your address',
                    obscureText: false,
                    controller: addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  var item = cart.items[index];
                  return _buildCartItem(item);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '${CommonMethod.formatPrice(cart.getTotal())}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity, // chiếm toàn bộ chiều ngang
              child: buildButtonConfirm(),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildButtonConfirm() {
    return ElevatedButton(
      onPressed: userTappedPay,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.all(16),
      ),
      child: const Text(
        'Confirm Order',
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
    );
  }

  Widget _buildCartItem(ItemInCart item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(item.thumbnail),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      CommonMethod.formatPrice(item.price),
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                        width: 8), // Khoảng cách giữa giá hiện tại và giá gốc
                    Text(
                      CommonMethod.formatPrice(
                        CommonMethod.calculateOriginalPrice(
                            item.price, item.discountPercentage),
                      ),
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              'x${item.quantity}',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30,
        ),
      ),
      centerTitle: true,
      title: Text(
        "Checkout",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
