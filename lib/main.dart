import 'package:flutter/material.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login Akışı Demo',
      // Uygulama açılışta HomePage ile başlayacak
      home: HomePage(),
    );
  }
}

// ==========================================================
// 1. ANA SAYFA (HOME PAGE)
// ==========================================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Uygulamanın Ana İçeriği',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            // Giriş Sayfasına Gitme Butonu
            ElevatedButton(
              onPressed: () {
                // Navigator ile LoginPage'e geçiş yapıyoruz.
                // push metodu, yeni sayfayı eskisinin üstüne ekler.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'Giriş Yap',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}