import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark Mode', style: TextStyle(fontSize: 16)),
                Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Preguntas frecuentes'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Acción para Preguntas frecuentes
              },
            ),
            ListTile(
              title: const Text('Cerrar sesión'),
              onTap: () {
                // Acción para cerrar sesión
              },
            ),
          ],
        ),
      ),
    );
  }
}
