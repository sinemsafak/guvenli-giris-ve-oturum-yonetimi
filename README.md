# Güvenli Giriş ve Oturum Yönetimi

React ve Flutter kullanılarak geliştirilen bu proje, web ve mobil uygulamalarda temel kimlik doğrulama ve oturum yönetimi süreçlerini örneklemek amacıyla hazırlanmıştır.

## Görseller 
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/690e67ee-1a9d-46ad-b29b-74ed786af454" width="220" alt="Giriş ekranı" />
      <br />
      <b>Giriş Ekranı</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/159d2391-4292-4b20-8ce0-ee6f9eb05dec" width="220" alt="Kullanıcı paneli" />
      <br />
      <b>Kullanıcı Paneli</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/42dbb4d8-bd14-4ad0-a314-50ca8c923c07" width="220" alt="Oturum yönetimi" />
      <br />
      <b>Oturum Yönetimi</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/ee873fa2-6fdb-4506-b6e7-78284cb07dac" width="220" alt="Oturum süresi doldu ekranı" />
      <br />
      <b>Oturum Süresi Doldu</b>
    </td>
  </tr>
## Özellikler

- E-posta ve parola doğrulama
- Hatalı girişlerde genel hata mesajı
- 5 dakika sonra otomatik oturum sonlandırma
- Güvenli çıkış ve kullanıcı bilgilerinin temizlenmesi
- Farklı kullanıcılar için ayrı görev ve kullanıcı verileri

## Kullanılan Teknolojiler

- **Web:** React, JavaScript, Vite, CSS
- **Mobil:** Flutter, Dart
- **Sürüm Kontrolü:** Git, GitHub

## Test Hesapları

| Kullanıcı | E-posta | Parola |
|---|---|---|
| Ayşe Yılmaz | ayse@ornek.com | Deneme123! |
| Mehmet Demir | mehmet@ornek.com | Deneme456! |

## Kurulum

**Web uygulaması:**

```bash
cd web
npm install
npm run dev
```

**Mobil uygulama:**

```bash
cd mobil
flutter pub get
flutter run
```

## Test Senaryoları

- Doğru ve yanlış giriş bilgilerini deneme
- Oturum süresinin dolmasını test etme
- Çıkış yaptıktan sonra farklı kullanıcıyla giriş yapma
- Kullanıcı verilerinin hesaplar arasında karışmadığını kontrol etme

## Önemli Not

Bu proje eğitim ve test amaçlıdır. Kullanıcı hesapları örnektir; gerçek bir sunucu tabanlı kimlik doğrulama sistemi içermez. Üretim ortamında kullanıma uygun değildir.
