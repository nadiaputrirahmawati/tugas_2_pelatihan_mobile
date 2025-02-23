import 'package:flutter/material.dart';
import 'package:my_app_firebase/model/user_model.dart';
import 'package:my_app_firebase/repositories/firestore_repository.dart';
import 'package:my_app_firebase/screens/add_user_screen.dart';
import 'package:my_app_firebase/screens/detail_user_screen.dart';
import 'package:my_app_firebase/screens/edit_user_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirestoreRepository _firestoreRepository = FirestoreRepository();

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pengguna - Pengguna '),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreRepository.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Tidak ada data pengguna.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var user = User.fromFirestore(doc.data() as Map<String, dynamic>);

              return Card(
                elevation: 4.0,
                color: Colors.pink[100],  // Memberikan warna pink pada card
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0), // Padding antara card
                child: ListTile(
                  title: Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 18,  // Ukuran font lebih besar untuk nama
                      fontWeight: FontWeight.bold,  // Bold untuk nama
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit_document),
                        color: const Color.fromARGB(255, 26, 85, 134),  // Mengganti warna ikon edit menjadi biru
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUserScreen(user: user),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_forever_sharp),
                        color: Colors.red,  // Mengganti warna ikon delete menjadi merah
                        onPressed: () async {
                          await _firestoreRepository.deleteUser(user.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Data berhasil dihapus!')),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.info),
                        color: Colors.white,  // Mengganti warna ikon info menjadi hijau
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailUserScreen(user: user),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      // Menambahkan FloatingActionButton dengan warna custom
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,  // Mengubah warna background FloatingActionButton menjadi pink
        foregroundColor: Colors.white,  // Mengubah warna ikon menjadi putih
        tooltip: 'Tambah Pengguna',
      ),
    );
  }
}
