class AuthService {
  bool signIn(String email, String password) {
    if (email == 'test@test.com' && password == '12345678') {
      return true;
    }
    return false;
  }

  bool signUp(String email, String password) {
    return true;
  }
}
