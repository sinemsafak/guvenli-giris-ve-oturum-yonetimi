
import { useEffect, useState } from "react";
import {
  authenticate,
  createSession,
  isSessionExpired,
  validateEmail,
  validatePassword,
} from "./auth";

const initialForm = { email: "", password: "" };

export default function App() {
  const [form, setForm] = useState(initialForm);
  const [fieldErrors, setFieldErrors] = useState({});
  const [session, setSession] = useState(null);
  const [status, setStatus] = useState("loggedOut");
  const [message, setMessage] = useState("");

  function clearUserState() {
    setSession(null);
    setForm(initialForm);
    setFieldErrors({});
    setMessage("");
    setStatus("loggedOut");
  }

  function logout() {
    clearUserState();
  }

  function expireSession() {
    clearUserState();
    setStatus("expired");
    setMessage("Oturumunuzun süresi doldu. Lütfen yeniden giriş yapın.");
  }

  useEffect(() => {
    if (!session) return;

    const remaining = session.expiresAt - Date.now();

    if (remaining <= 0) {
      expireSession();
      return;
    }

    const timer = window.setTimeout(() => {
      if (isSessionExpired(session)) {
        expireSession();
      }
    }, remaining);

    return () => window.clearTimeout(timer);
  }, [session]);

  function handleChange(event) {
    const { name, value } = event.target;

    setForm((current) => ({ ...current, [name]: value }));
    setFieldErrors((current) => ({ ...current, [name]: "" }));
    setMessage("");
  }

  function handleSubmit(event) {
    event.preventDefault();

    const errors = {};

    if (!validateEmail(form.email)) {
      errors.email = "Geçerli bir e-posta adresi girin.";
    }

    if (!validatePassword(form.password)) {
      errors.password = "Parola en az 8 karakter olmalıdır.";
    }

    setFieldErrors(errors);
    setMessage("");

    if (Object.keys(errors).length > 0) return;

    const result = authenticate(form.email, form.password);

    if (!result.success) {
      setStatus("loginFailed");
      setMessage(result.message);
      return;
    }

    setSession(createSession(result.user));
    setStatus("authenticated");
    setForm(initialForm);
    setFieldErrors({});
    setMessage("");
  }

  if (status === "authenticated" && session) {
    return (
      <main className="page">
        <section className="panel dashboard">
          <div className="success-icon" aria-hidden="true">✓</div>
          <p className="eyebrow">OTURUM AÇIK</p>
          <h1>Hoş geldin, {session.user.name}!</h1>
          <p className="muted">
            Bu alan yalnızca etkin kullanıcının verilerini gösterir.
          </p>

          <div className="profile-card">
            <span className="label">Hesap</span>
            <strong>{session.user.email}</strong>
            <span className="label">Kullanıcı kimliği</span>
            <strong>{session.user.id}</strong>
          </div>

          <h2>Görevlerim</h2>
          <ul className="task-list">
            {session.user.tasks.map((task) => (
              <li key={task}>{task}</li>
            ))}
          </ul>

          <button className="primary-button" onClick={logout}>
            Güvenli çıkış yap
          </button>
          <button className="secondary-button" onClick={expireSession}>
            Oturum süresini dolmuş gibi göster
          </button>
          <p className="notice">
            Eğitim simülasyonu: Gerçek bir sunucu oturumu kullanılmıyor.
          </p>
        </section>
      </main>
    );
  }

  return (
    <main className="page">
      <section className="panel login-panel">
        <div className="brand-mark" aria-hidden="true">G</div>
        <p className="eyebrow">GÜVENLİ ALAN</p>
        <h1>Hesabına giriş yap</h1>
        <p className="muted">
          Devam etmek için e-posta adresini ve parolanı gir.
        </p>

        {status === "expired" && (
          <div className="alert warning" role="alert">
            {message}
          </div>
        )}

        {status === "loginFailed" && (
          <div className="alert error" role="alert">
            {message}
          </div>
        )}

        <form onSubmit={handleSubmit} noValidate>
          <div className="form-field">
            <label htmlFor="email">E-posta adresi</label>
            <input
              id="email"
              name="email"
              type="email"
              autoComplete="username"
              value={form.email}
              onChange={handleChange}
              placeholder="ornek@eposta.com"
              aria-invalid={Boolean(fieldErrors.email)}
              aria-describedby={fieldErrors.email ? "email-error" : undefined}
            />
            {fieldErrors.email && (
              <small id="email-error" className="field-error">
                {fieldErrors.email}
              </small>
            )}
          </div>

          <div className="form-field">
            <label htmlFor="password">Parola</label>
            <input
              id="password"
              name="password"
              type="password"
              autoComplete="current-password"
              value={form.password}
              onChange={handleChange}
              placeholder="En az 8 karakter"
              aria-invalid={Boolean(fieldErrors.password)}
              aria-describedby={
                fieldErrors.password ? "password-error" : undefined
              }
            />
            {fieldErrors.password && (
              <small id="password-error" className="field-error">
                {fieldErrors.password}
              </small>
            )}
          </div>

          <button className="primary-button" type="submit">
            Giriş yap
          </button>
        </form>

        <div className="demo-box">
          <strong>Yerel test hesapları</strong>
          <p>Ayşe: ayse@ornek.com / Deneme123!</p>
          <p>Mehmet: mehmet@ornek.com / Deneme456!</p>
        </div>

        <p className="notice">
          Bu proje yalnızca arayüz akışını simüle eder. Gerçek hesap
          doğrulaması yapmaz.
        </p>
      </section>
    </main>
  );
}
