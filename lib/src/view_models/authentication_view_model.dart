class AuthenticationViewModel {
  bool authenticate(String name, int pin) {
    if ((name == 'ephrem' || name == 'Ephrem' || name == 'EPHREM') &&
        pin == 007493) {
      return true;
    } else if (name == 'demakk' && pin == 5732) {
      return true;
    }
    return false;
  }
}
