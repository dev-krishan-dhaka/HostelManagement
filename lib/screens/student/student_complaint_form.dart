import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/complaint_service.dart';

class ComplaintForm extends StatefulWidget {
  final String complaintType;
  const ComplaintForm({required this.complaintType, Key? key}) : super(key: key);

  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final ComplaintService _complaintService = ComplaintService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _hostelController = TextEditingController();
  XFile? _image;

  @override
  void dispose() {
    _descriptionController.dispose();
    _roomController.dispose();
    _hostelController.dispose();
    super.dispose();
  }

  Future<void> _submitComplaint() async {
    if (_formKey.currentState!.validate()) {
      // Upload image logic here (you'll need Firebase Storage)
      // For now, we'll proceed without image

      await _complaintService.submitComplaint(
        userId: FirebaseAuth.instance.currentUser!.uid,
        type: widget.complaintType,
        description: _descriptionController.text,
        hostelName: _hostelController.text,
        roomNumber: _roomController.text,
      );

      Navigator.pop(context);
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() => _image = pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.complaintType} Complaint')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Problem Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _hostelController,
                decoration: InputDecoration(
                  labelText: 'Hostel Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _roomController,
                decoration: InputDecoration(
                  labelText: 'Room Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              SizedBox(height: 20),
              if (_image != null)
                Image.file(File(_image!.path), height: 150),
              ElevatedButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text(_image == null ? 'Add Image' : 'Change Image'),
                onPressed: _pickImage,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text('Submit Complaint'),
                onPressed: _submitComplaint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}