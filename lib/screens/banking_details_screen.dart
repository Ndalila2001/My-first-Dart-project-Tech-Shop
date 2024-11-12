import 'package:flutter/material.dart';

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
        title: const Text('Banking Details'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Bank Name',
                ),
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Account Number',
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Branch Code',
                ),
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Account Holder Name',
                ),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save form data
                    _formKey.currentState!.save();

                    // Process the banking details (e.g., send to backend, save locally)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Banking details saved!')),
                    );

                    Navigator.pop(context); // go back to the previous screen
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
