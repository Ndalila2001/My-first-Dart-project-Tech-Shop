class Users {
  String usrEmail;
  String usrPassword;

  Users({
    required this.usrEmail,
    required this.usrPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'usrEmail': usrEmail,
      'usrPassword': usrPassword,
    };
  }
}
