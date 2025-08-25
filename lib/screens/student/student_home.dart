import 'package:flutter/material.dart';
import 'student_complaint_form.dart';

class StudentHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildComplaintButton(context, 'Electrical', Icons.electrical_services),
            _buildComplaintButton(context, 'Plumbing', Icons.plumbing),
            _buildComplaintButton(context, 'Carpenter', Icons.carpenter),
          ],
        ),
      ),
    );
  }

  Widget _buildComplaintButton(BuildContext context, String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 30),
        label: Text(title, style: TextStyle(fontSize: 20)),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ComplaintForm(complaintType: title)),
        ),
      ),
    );
  }
}