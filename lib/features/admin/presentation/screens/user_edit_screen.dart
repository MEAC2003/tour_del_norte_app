import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/features/admin/data/models/public_user.dart';
import 'package:tour_del_norte_app/features/admin/presentation/providers/admin_provider.dart';

class UserEditScreen extends StatefulWidget {
  final PublicUser user;

  const UserEditScreen({super.key, required this.user});

  @override
  _UserEditScreenState createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dniController;
  late String _role;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.fullName);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _dniController = TextEditingController(text: widget.user.dni);
    _role = widget.user.role;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Editar Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre completo'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Teléfono'),
            ),
            TextField(
              controller: _dniController,
              decoration: const InputDecoration(labelText: 'DNI'),
            ),
            SwitchListTile(
              title: const Text('Es administrador'),
              value: _role == 'admin',
              onChanged: (bool value) {
                setState(() {
                  _role = value ? 'admin' : 'user';
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                final updatedUser = widget.user.copyWith(
                  fullName: _nameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  dni: _dniController.text,
                  role: _role,
                );
                Provider.of<AdminProvider>(context, listen: false)
                    .updateUser(updatedUser);
                Navigator.pop(context);
              },
              child: const Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dniController.dispose();
    super.dispose();
  }
}
