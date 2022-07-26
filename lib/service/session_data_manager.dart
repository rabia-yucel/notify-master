
class SessionDataManager {
  static final SessionDataManager _singleton = SessionDataManager._internal();

  static String _phoneNumber = '';
  static String _refCode = '';
  static String _userId = '';
  static bool _allowBankNotifications = true;
  static bool _allowMerchantNotifications = true;
  static bool _allowDataNotifications = true;

  static String getPhoneNumber() {
    return _phoneNumber;
  }

  static setPhoneNumber(value) {
    _phoneNumber = value;
  }

  static String getRefCode() {
    return _refCode;
  }

  static setRefCode(value) {
    _refCode = value;
  }

  static String getUserId() {
    return _userId;
  }

  static setUserId(value) {
    _userId = value;
  }

  static bool getAllowBankNotifications() {
    return _allowBankNotifications;
  }

  static setAllowBankNotifications(value) {
    _allowBankNotifications = value;
  }

  static bool getAllowMerchantNotifications() {
    return _allowMerchantNotifications;
  }

  static setAllowMerchantNotifications(value) {
    _allowMerchantNotifications = value;
  }
  static bool getAllowDataNotifications() {
    return _allowDataNotifications;
  }
  static setAllowDataNotifications(value) {
    _allowDataNotifications = value;
  }


  factory SessionDataManager() {
    return _singleton;
  }

  SessionDataManager._internal();
}