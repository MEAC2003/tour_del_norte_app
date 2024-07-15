// En un nuevo archivo llamado select_user_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/features/admin/data/models/public_user.dart';
import 'package:tour_del_norte_app/features/admin/presentation/providers/admin_provider.dart';

class SelectUserScreen extends StatelessWidget {
  const SelectUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Usuario'),
      ),
      body: FutureBuilder<List<PublicUser>>(
        future:
            Provider.of<AdminProvider>(context, listen: false).getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay usuarios disponibles'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return ListTile(
                title: Text(user.fullName),
                subtitle: Text(user.email),
                onTap: () {
                  Navigator.of(context).pop(user);
                },
              );
            },
          );
        },
      ),
    );
  }
}
