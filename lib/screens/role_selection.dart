import 'package:flutter/material.dart';
import 'auth/login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hostel Management System')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRoleButton(
              context,
              icon: Icons.school,
              label: 'STUDENT',
              role: 'Student',
            ),
            SizedBox(height: 30),
            _buildRoleButton(
              context,
              icon: Icons.handyman,
              label: 'SERVICE PROVIDER',
              role: 'Service Provider',
            ),
            SizedBox(height: 30),
            _buildRoleButton(
              context,
              icon: Icons.admin_panel_settings,
              label: 'WARDEN',
              role: 'Warden',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, {required IconData icon, required String label, required String role}) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 30),
      label: Text(label, style: TextStyle(fontSize: 20)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen(role: role)),
      ),
    );
  }
}