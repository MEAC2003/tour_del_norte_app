import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/features/admin/data/models/public_user.dart';
import 'package:tour_del_norte_app/features/admin/presentation/providers/admin_provider.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dniController = TextEditingController();
  String _selectedRole = 'user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New User')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter full name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextFormField(
              controller: _dniController,
              decoration: const InputDecoration(labelText: 'DNI'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: const InputDecoration(labelText: 'Role'),
              items: ['user', 'admin'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue!;
                });
              },
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final user = PublicUser(
        id: '',
        createdAt: DateTime.now().toString(), // Convert DateTime to String
        fullName: _fullNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        dni: _dniController.text,
        role: _selectedRole,
      );

      Provider.of<AdminProvider>(context, listen: false).addPendingUser(user);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Usuario añadido a la cola de procesamiento')),
      );
      Navigator.of(context).pop();
    }
  }
}
