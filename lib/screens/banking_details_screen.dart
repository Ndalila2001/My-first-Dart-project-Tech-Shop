import 'package:flutter/material.dart';
import 'package:tech_shop_app2/screens/product_screen.dart';

class BankingDetailsScreen extends StatefulWidget {
  const BankingDetailsScreen({super.key});

  @override
  State<BankingDetailsScreen> createState() => _BankingDetailsScreenState();
}

class _BankingDetailsScreenState extends State<BankingDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String bankName = '';
  String accountNumber = '';
  String branchCode = '';
  String accountHolderName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banking Details',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFCBD7D1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Bank Name',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your bank name';
                  }
                  return null;
                },
                onSaved: (value) {
                  bankName = value!;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Account Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your account number';
                  }
                  return null;
                },
                onSaved: (value) {
                  accountNumber = value!;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Branch Code',
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your branch code';
                  }
                  return null;
                },
                onSaved: (value) {
                  branchCode = value!;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Account Holder Name',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the account holder name';
                  }
                  return null;
                },
                onSaved: (value) {
                  accountHolderName = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save form data
                    _formKey.currentState!.save();

                    // Process the banking details
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order submitted!')),
                    );

                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProductScreen())); // go back to the previous screen
                  }
                },
                child: const Text(
                  'Submit Order',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
