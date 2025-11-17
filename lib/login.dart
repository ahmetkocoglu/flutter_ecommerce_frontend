import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_frontend/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Eğer doğrulama geçerliyse:
      print('Giriş denemesi yapıldı:');
      print('E-posta: ${_emailController.text}');

      // Başarılı girişten sonra kullanıcıyı Ana Sayfaya geri yönlendiriyoruz.
      // pop metodu, şu anki sayfayı yığından kaldırır.
      Navigator.pop(context);

      // Başarılı mesajı gösterebiliriz.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Giriş Başarılı! Ana sayfaya yönlendiriliyorsunuz.')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
        // Geri butonu (Ana Sayfaya dönmek için) otomatik olarak görünür.
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Şifre en az 6 karakter olmalıdır.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24.0),

              // GİRİŞ YAP BUTONU
              ElevatedButton(
                onPressed: _login, // Giriş başarılıysa Navigator.pop(context) çağrılır.
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'GİRİŞ YAP',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 12.0),

              // Kayıt Ol bağlantısı
              TextButton(
                onPressed: () {
                  // RegisterPage'e git
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text('Hesabın yok mu? Kayıt Ol.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}