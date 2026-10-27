Güvenli Giriş ve Oturum Yönetimi

Proje Hakkında

Güvenli Giriş ve Oturum Yönetimi, kullanıcıların giriş yapma, oturum yönetimi ve güvenli çıkış işlemlerini örnekleyen bir projedir. Proje, web ve mobil platformlar için geliştirilmiştir.

Projenin amacı; form doğrulama, hatalı girişlerin yönetimi, oturum süresinin dolması, çıkış yapıldığında kullanıcı bilgilerinin temizlenmesi ve farklı kullanıcıların verilerinin birbirinden ayrı tutulması gibi temel kimlik doğrulama kavramlarını uygulamalı olarak göstermektir.

Önemli: Bu proje eğitim ve demo amaçlıdır. Kullanıcı hesapları ve parolalar kod içerisinde tanımlanmıştır. Gerçek bir kimlik doğrulama sunucusu veya üretim ortamına uygun güvenlik altyapısı içermez.


Kullanılan Teknolojiler

Web: React, JavaScript, Vite, CSS

Mobil: Flutter, Dart

Sürüm kontrolü: Git ve GitHub

📁 Proje Yapısı

guvenli-giris-ve-oturum-yonetimi/
├── web/
│   ├── src/
│   │   ├── App.jsx
│   │   ├── auth.js
│   │   ├── main.jsx
│   │   └── index.css
│   ├── package.json
│   └── ...
├── mobil/
│   ├── lib/
│   │   └── main.dart
│   ├── test/
│   ├── pubspec.yaml
│   └── ...
├── .gitignore
└── README.md

✨ Özellikler

E-posta adresi ve parola ile giriş yapma

E-posta biçimini kontrol etme

En az 8 karakterlik parola doğrulaması

Hatalı girişlerde genel hata mesajı gösterme

Başarılı giriş sonrasında kullanıcı panelini açma

Beş dakika sonra oturumu otomatik sonlandırma

Kullanıcının oturumunu manuel olarak sonlandırma

Çıkışta kullanıcı durumunu ve giriş formu alanlarını temizleme

Farklı kullanıcıların görevlerini birbirinden ayrı gösterme

Oturum süresinin dolmasını test edebilme

👤 Test Hesapları

Uygulamayı test etmek için aşağıdaki örnek hesaplar kullanılabilir.

Kullanıcı

E-posta

Parola

Ayşe Yılmaz

ayse@ornek.com

Deneme123!

Mehmet Demir

mehmet@ornek.com

Deneme456!

Bu hesaplar yalnızca yerel test amacıyla oluşturulmuştur. Gerçek kullanıcı hesapları değildir.

🚀 Kurulum ve Çalıştırma

1. Gereksinimler

Node.js ve npm

Flutter SDK ve Dart

Android Studio, VS Code veya tercih edilen bir geliştirme ortamı

Git (isteğe bağlı, sürüm kontrolü için)

2. Web uygulamasını çalıştırma

Terminalde proje klasörünün içindeki web dizinine gir:

cd web
npm install
npm run dev

Terminalde gösterilen yerel adresi tarayıcıda aç. Vite genellikle http://localhost:5173 adresini kullanır.

3. Mobil uygulamayı çalıştırma

Yeni bir terminal aç ve mobil dizinine gir:

cd mobil
flutter pub get
flutter analyze
flutter run

Çalıştırmadan önce bir Android emülatörü veya desteklenen bir cihaz başlat. Kullanılabilir cihazları görmek için:

flutter devices

🧪 Test Senaryoları

Ayşe hesabıyla giriş yap ve yalnızca Ayşe'ye ait görevlerin gösterildiğini doğrula.

Çıkış yap ve giriş ekranına dönüldüğünü kontrol et.

Mehmet hesabıyla giriş yap ve yalnızca Mehmet'e ait görevlerin gösterildiğini doğrula.

Yanlış e-posta veya parola ile giriş yap ve genel hata mesajını kontrol et.

Parola alanına 8 karakterden kısa bir değer girerek doğrulama mesajını kontrol et.

Oturum süresini dolmuş gibi gösteren test seçeneğini kullan ve giriş ekranına dönüldüğünü doğrula.

Oturum kapandıktan sonra önceki kullanıcının bilgilerinin yeni kullanıcıya ait panelde görünmediğini kontrol et.

🔐 Güvenlik Yaklaşımı

Bu proje temel oturum yönetimi davranışlarını göstermek üzere hazırlanmıştır:

Hatalı girişlerde e-posta adresinin sistemde bulunup bulunmadığını açıklamayan genel bir hata mesajı kullanılır.

Oturum sona erdiğinde etkin kullanıcı durumu temizlenir.

Parolalar kullanıcı panelinde gösterilmez.

Kullanıcıya ait örnek görevler, giriş yapılan test hesabına göre gösterilir.

Üretim ortamı için: Gerçek bir uygulamada kimlik doğrulama sunucu tarafında yapılmalı; parolalar güvenli parola özetleme algoritmalarıyla saklanmalı; oturum veya erişim belirteçleri güvenli biçimde yönetilmeli ve yetkilendirme sunucu tarafında doğrulanmalıdır. İstemci tarafındaki bu örnek tek başına gerçek güvenlik sağlamaz.

📌 Bilinen Sınırlamalar

Test hesapları ve örnek veriler uygulama kodunda tutulur.

Gerçek bir veritabanı veya kimlik doğrulama API'si kullanılmaz.

Oturum zamanlayıcısı uygulama çalışırken bellekte tutulur; kalıcı ve sunucu tarafından doğrulanan bir oturum değildir.

Sayfa veya uygulama yeniden başlatıldığında oturum durumu kalıcı olarak korunmaz.

🎯 Projenin Amacı

Bu proje; React ve Flutter ile form doğrulama, durum yönetimi, oturum süresi kontrolü ve kullanıcı verilerinin oturumlar arasında ayrıştırılması konularında pratik deneyim kazanmak amacıyla geliştirilmiştir.

📄 Lisans

Bu proje eğitim ve öğrenme amacıyla hazırlanmıştır. Projeyi kullanmadan veya dağıtmadan önce uygun bir lisans ekleyebilirsiniz.