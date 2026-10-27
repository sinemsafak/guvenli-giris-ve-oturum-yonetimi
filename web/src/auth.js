
const testUsers = [
  {
    id: "kullanici-1",
    email: "ayse@ornek.com",
    password: "Deneme123!",
    name: "Ayşe Yılmaz",
    tasks: ["Proje planını incele", "Günlük hedefleri belirle"],
  },
  {
    id: "kullanici-2",
    email: "mehmet@ornek.com",
    password: "Deneme456!",
    name: "Mehmet Demir",
    tasks: ["Tasarım dosyalarını kontrol et", "Testleri tamamla"],
  },
];

export function validateEmail(email) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.trim());
}

export function validatePassword(password) {
  return password.length >= 8;
}

export function authenticate(email, password) {
  const normalizedEmail = email.trim().toLowerCase();

  const user = testUsers.find(
    (item) =>
      item.email.toLowerCase() === normalizedEmail &&
      item.password === password
  );

  if (!user) {
    return {
      success: false,
      message: "Bu e-posta veya parola hatalı.",
    };
  }

  // Parolayı oturum nesnesine veya arayüze taşımıyoruz.
  const { password: unusedPassword, ...safeUser } = user;

  return {
    success: true,
    user: {
      ...safeUser,
      tasks: [...safeUser.tasks],
    },
  };
}

export function createSession(user) {
  return {
    user,
    expiresAt: Date.now() + 5 * 60 * 1000,
  };
}

export function isSessionExpired(session) {
  return !session || Date.now() >= session.expiresAt;
}
