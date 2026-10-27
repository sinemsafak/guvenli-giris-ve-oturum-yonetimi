
import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const GuvenliGirisUygulamasi());
}

class TestUser {
  final String id;
  final String email;
  final String password;
  final String name;
  final List<String> tasks;

  const TestUser({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.tasks,
  });
}

const List<TestUser> testUsers = [
  TestUser(
    id: 'kullanici-1',
    email: 'ayse@ornek.com',
    password: 'Deneme123!',
    name: 'Ayşe Yılmaz',
    tasks: [
      'Proje planını incele',
      'Günlük hedefleri belirle',
    ],
  ),
  TestUser(
    id: 'kullanici-2',
    email: 'mehmet@ornek.com',
    password: 'Deneme456!',
    name: 'Mehmet Demir',
    tasks: [
      'Tasarım dosyalarını kontrol et',
      'Testleri tamamla',
    ],
  ),
];

bool isValidEmail(String email) {
  return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
      .hasMatch(email.trim());
}

bool isValidPassword(String password) {
  return password.length >= 8;
}

TestUser? authenticate(String email, String password) {
  for (final user in testUsers) {
    if (user.email.toLowerCase() == email.trim().toLowerCase() &&
        user.password == password) {
      return user;
    }
  }

  return null;
}

class GuvenliGirisUygulamasi extends StatelessWidget {
  const GuvenliGirisUygulamasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Güvenli Giriş ve Oturum Yönetimi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3659C9),
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F5FA),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

enum AuthStatus {
  loggedOut,
  loginFailed,
  authenticated,
  expired,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthStatus _status = AuthStatus.loggedOut;
  TestUser? _currentUser;
  Timer? _sessionTimer;
  DateTime? _expiresAt;
  String? _message;

  void _login() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = authenticate(
      _emailController.text,
      _passwordController.text,
    );

    if (user == null) {
      setState(() {
        _currentUser = null;
        _status = AuthStatus.loginFailed;
        _message = 'Bu e-posta veya parola hatalı.';
      });
      return;
    }

    _sessionTimer?.cancel();

    setState(() {
      _currentUser = user;
      _status = AuthStatus.authenticated;
      _message = null;
      _expiresAt = DateTime.now().add(
        const Duration(minutes: 5),
      );

      _emailController.clear();
      _passwordController.clear();
    });

    _sessionTimer = Timer(
      const Duration(minutes: 5),
      _expireSession,
    );
  }

  void _clearSession() {
    _sessionTimer?.cancel();
    _sessionTimer = null;

    setState(() {
      _currentUser = null;
      _expiresAt = null;
      _emailController.clear();
      _passwordController.clear();
      _status = AuthStatus.loggedOut;
      _message = null;
    });
  }

  void _logout() {
    _clearSession();
  }

  void _expireSession() {
    if (!mounted || _currentUser == null) return;

    _sessionTimer?.cancel();

    setState(() {
      _currentUser = null;
      _expiresAt = null;
      _emailController.clear();
      _passwordController.clear();
      _status = AuthStatus.expired;
      _message =
          'Oturumunuzun süresi doldu. Lütfen yeniden giriş yapın.';
    });
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_status == AuthStatus.authenticated &&
        _currentUser != null) {
      return _buildDashboard(_currentUser!);
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3659C9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            'G',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'GÜVENLİ ALAN',
                          style: TextStyle(
                            color: Color(0xFF526CC0),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Hesabına giriş yap',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Devam etmek için e-posta adresini ve '
                          'parolanı gir.',
                          style: TextStyle(
                            color: Color(0xFF68738A),
                            height: 1.5,
                          ),
                        ),
                        if (_status == AuthStatus.expired ||
                            _status == AuthStatus.loginFailed) ...[
                          const SizedBox(height: 20),
                          _buildAlert(
                            _message ?? '',
                            expired: _status == AuthStatus.expired,
                          ),
                        ],
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.username],
                          decoration: const InputDecoration(
                            labelText: 'E-posta adresi',
                            hintText: 'ornek@eposta.com',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value == null ||
                                !isValidEmail(value)) {
                              return 'Geçerli bir e-posta adresi girin.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          autofillHints: const [
                            AutofillHints.password,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Parola',
                            hintText: 'En az 8 karakter',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          validator: (value) {
                            if (value == null ||
                                !isValidPassword(value)) {
                              return 'Parola en az 8 karakter olmalıdır.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: _login,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text('Giriş yap'),
                        ),
                        const SizedBox(height: 22),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6F8FC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE6EAF2),
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Yerel test hesapları',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text('Ayşe: ayse@ornek.com'),
                              Text('Parola: Deneme123!'),
                              SizedBox(height: 8),
                              Text('Mehmet: mehmet@ornek.com'),
                              Text('Parola: Deneme456!'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Bu uygulama yalnızca arayüz akışını '
                          'simüle eder. Gerçek hesap doğrulaması yapmaz.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF788196),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlert(String text, {required bool expired}) {
    final color = expired
        ? const Color(0xFF854D0E)
        : const Color(0xFF9B1C1C);
    final background = expired
        ? const Color(0xFFFFF8E5)
        : const Color(0xFFFFF0F0);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }

  Widget _buildDashboard(TestUser user) {
    final remaining = _expiresAt == null
        ? 0
        : _expiresAt!.difference(DateTime.now()).inSeconds;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı paneli'),
        actions: [
          IconButton(
            onPressed: _logout,
            tooltip: 'Çıkış yap',
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF238654),
                        size: 54,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Hoş geldin, ${user.name}!',
                        style: const TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Yalnızca etkin kullanıcıya ait bilgiler '
                        'gösteriliyor.',
                        style: TextStyle(
                          color: Color(0xFF68738A),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _profileRow('E-posta', user.email),
                      _profileRow('Kullanıcı kimliği', user.id),
                      _profileRow('Kalan süre', '$remaining saniye'),
                      const SizedBox(height: 24),
                      const Text(
                        'Görevlerim',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...user.tasks.map(
                        (task) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.task_alt,
                            color: Color(0xFF3659C9),
                          ),
                          title: Text(task),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: _logout,
                        icon: const Icon(Icons.logout),
                        label: const Text('Güvenli çıkış yap'),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: _expireSession,
                        child: const Text(
                          'Oturum süresini dolmuş gibi göster',
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Eğitim simülasyonu: Gerçek bir sunucu '
                        'oturumu kullanılmıyor.',
                        style: TextStyle(
                          color: Color(0xFF788196),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F8FC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF68738A),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            SelectableText(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
