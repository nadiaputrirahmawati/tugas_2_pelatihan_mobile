import 'package:flutter/material.dart';
import 'package:my_app_firebase/repositories/firestore_repository.dart';
import 'package:my_app_firebase/model/user_model.dart';

class EditUserScreen extends StatefulWidget {
  final User user;
  EditUserScreen({required this.user});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final FirestoreRepository _firestoreRepository = FirestoreRepository();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
  }

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
        title: Text('Edit Pengguna'),
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

                try {
                  await _firestoreRepository.updateUser(
                    widget.user.id,
                    {'name': name, 'email': email},
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Data berhasil diperbarui!')),
                  );
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal memperbarui data: $e')),
                  );
                }
              },
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
