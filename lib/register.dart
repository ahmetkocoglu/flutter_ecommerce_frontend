import 'package:flutter/material.dart';

import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Şifre alanının gizlenip gizlenmeyeceğini kontrol eden değişken
  bool _obscurePassword = true;

  void _register() {
    // Form doğrulamasını çalıştır
    if (_formKey.currentState!.validate()) {
      // Eğer doğrulama geçerliyse (alanlar doluysa ve şifreler eşleşiyorsa)
      final name = _nameController.text;
      final email = _emailController.text;

      // Buraya gerçek kayıt (Firebase, API vb.) mantığı eklenecek.
      print('Kayıt denemesi yapıldı:');
      print('Ad Soyad: $name');
      print('E-posta: $email');

      // Başarılı kayıt sonrası kullanıcıyı direkt Ana Sayfaya veya Giriş Sayfasına yönlendiriyoruz.
      // pushReplacement, mevcut sayfayı (Kayıt) kaldırıp yerine yenisini (Giriş) koyar.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kayıt Başarılı! Giriş sayfasına yönlendiriliyorsunuz.')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // AD SOYAD ALANI
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Ad Soyad',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen adınızı ve soyadınızı girin.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              // E-POSTA ALANI
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-posta',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Geçerli bir e-posta adresi girin.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              // ŞİFRE ALANI
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword, // Gizleme durumuna göre ayarla
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Şifre en az 6 karakter olmalıdır.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              // ŞİFRE TEKRAR ALANI (Onaylama)
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscurePassword,
                decoration: const InputDecoration(
                  labelText: 'Şifreyi Onayla',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.check_circle_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen şifreyi tekrar girin.';
                  }
                  // Şifrelerin EŞLEŞME kontrolü
                  if (value != _passwordController.text) {
                    return 'Şifreler eşleşmiyor.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24.0),

              // KAYIT OL BUTONU
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent, // Farklı buton rengi
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'KAYIT OL',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 12.0),

              // Giriş sayfasına dönme bağlantısı
              TextButton(
                onPressed: () {
                  // Mevcut Kayıt sayfasını kapat ve Giriş sayfasına dön
                  Navigator.pop(context);
                },
                child: const Text('Zaten hesabım var. Giriş yap.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}