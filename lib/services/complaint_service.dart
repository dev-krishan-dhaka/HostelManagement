import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Submit new complaint
  Future<void> submitComplaint({
    required String userId,
    required String type,
    required String description,
    required String hostelName,
    required String roomNumber,
    String? imageUrl,
  }) async {
    await _firestore.collection('complaints').add({
      'userId': userId,
      'type': type,
      'description': description,
      'hostelName': hostelName,
      'roomNumber': roomNumber,
      'imageUrl': imageUrl,
      'status': 'Pending',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Get complaints for student
  Stream<QuerySnapshot> getStudentComplaints(String userId) {
    return _firestore
        .collection('complaints')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Get complaints for service provider
  Stream<QuerySnapshot> getServiceProviderComplaints(String type) {
    return _firestore
        .collection('complaints')
        .where('type', isEqualTo: type)
        .where('status', isEqualTo: 'Pending')
        .snapshots();
  }

  // Update complaint status
  Future<void> updateComplaintStatus(String complaintId, String status) async {
    await _firestore.collection('complaints').doc(complaintId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}