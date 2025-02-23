import 'package:flutter/material.dart';
import 'package:my_app_firebase/repositories/firestore_repository.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final FirestoreRepository _firestoreRepository = FirestoreRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengguna'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String name = _nameController.text.trim();
                String email = _emailController.text.trim();

                if (name.isEmpty || email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Nama dan email tidak boleh kosong')),
                  );
                  return;
                }

                String userId = DateTime.now().millisecondsSinceEpoch.toString();
                try {
                  await _firestoreRepository.createUser(userId, name, email);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Data berhasil ditambahkan!')),
                  );
                  Navigator.pop(context); // Navigate back to previous screen
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal menambahkan data: $e')),
                  );
                }
              },
              child: Text('Tambah Data'),
            ),
          ],
        ),
      ),
    );
  }
}
