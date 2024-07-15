import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/admin/presentation/providers/admin_provider.dart';
import 'package:tour_del_norte_app/features/admin/data/models/public_user.dart';
import 'package:tour_del_norte_app/features/admin/presentation/screens/user_edit_screen.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push(AppRouter.adminAddUser);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _SearchBar(),
          Expanded(
            child: _UserList(),
          ),
          SizedBox(
            height: AppSize.defaultPadding * 4.5,
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar usuarios...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: (value) {
              print('Search input: $value'); // Añade esta línea
              adminProvider.setSearchQuery(value);
            },
          ),
        );
      },
    );
  }
}

class _UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, child) {
        final users = adminProvider.users;
        return RefreshIndicator(
          onRefresh: () async {
            await adminProvider.loadUsers();
          },
          child: users.isEmpty
              ? ListView(
                  children: const [
                    Center(child: Text('No se encontraron usuarios')),
                  ],
                )
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return _UserCard(user: user);
                  },
                ),
        );
      },
    );
  }
}

class _UserCard extends StatelessWidget {
  final PublicUser user;

  const _UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);

    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: 8, vertical: AppSize.defaultPadding / 2),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            user.fullName.length >= 2
                ? user.fullName.substring(0, 2).toUpperCase()
                : (user.fullName.isNotEmpty
                    ? user.fullName[0].toUpperCase()
                    : ''),
          ),
        ),
        title: Text(
          user.fullName,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          user.email,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          context.push(
            '${AppRouter.adminUserDetail}/${user.id}',
            extra: user,
          );
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: user.role == 'admin',
              onChanged: (bool value) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Cambiar rol de usuario'),
                    content: const Text(
                        '¿Estás seguro de que quieres cambiar el rol de este usuario?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: const Text('Confirmar'),
                        onPressed: () {
                          adminProvider.toggleUserRole(user.id);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserEditScreen(user: user),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Eliminar usuario'),
                    content: const Text(
                        '¿Estás seguro de que quieres eliminar este usuario? Esta acción no se puede deshacer.'),
                    actions: [
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: const Text('Eliminar'),
                        onPressed: () {
                          adminProvider.deleteUser(user.id);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
