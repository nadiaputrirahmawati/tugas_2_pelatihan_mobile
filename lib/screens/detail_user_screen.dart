import 'package:flutter/material.dart';
import 'package:my_app_firebase/model/user_model.dart';

class DetailUserScreen extends StatelessWidget {
  final User user;

  DetailUserScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengguna'),
        backgroundColor:  Color.fromARGB(255, 241, 221, 228),  // Warna AppBar menjadi hitam
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),  // Padding di sekitar body
        child: Container(
          width: 400,  // Menentukan lebar container
          height: 200, // Menentukan tinggi container
          child: Card(
            elevation: 4.0,
            color: const Color.fromARGB(255, 241, 221, 228),  // Memberikan warna pink pada card
            margin: EdgeInsets.symmetric(vertical: 16.0),  // Padding antara card
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Data Diri :',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Nama: ${user.name}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${user.email}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Jika ada data lain yang ingin ditampilkan, bisa ditambahkan di sini
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
