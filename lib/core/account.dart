class Account {
  String name;
  String email;
  String password;
  String phone;
  // String category;

  Account(this.name, this.email, this.password, this.phone);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
