import 'package:cargo/models/branch_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class BranchProvider with ChangeNotifier {
  List<BranchModel> branches = [];
  Future<void> addBranch(BranchModel branch) async {
    final ref = FirebaseFirestore.instance.collection('branches').doc();
    final upload = await FirebaseStorage.instance
        .ref('branches/${ref.id}')
        .putFile(branch.imageFile!);

    final downloadUrl = await upload.ref.getDownloadURL();
    branch.imageUrl = downloadUrl.toString();

    await ref.set(branch.toJson());
    notifyListeners();
  }

  Future<void> deleteBranch(String id) async {
    await FirebaseFirestore.instance.collection('branches').doc(id).delete();
  }

  Future<void> editBranch(BranchModel branch) async {
    if (branch.imageFile != null) {
      final upload = await FirebaseStorage.instance
          .ref('branches/${branch.id}')
          .putFile(branch.imageFile!);

      final downloadUrl = await upload.ref.getDownloadURL();
      branch.imageUrl = downloadUrl.toString();
    }

    await FirebaseFirestore.instance
        .collection('branches')
        .doc(branch.id)
        .update(branch.toJson());
    notifyListeners();
  }

  Future<void> getBranches() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('branches').get();

    branches = snapshot.docs.map((doc) => BranchModel.fromJson(doc)).toList();
    notifyListeners();
  }
}
