class Account {
  String firstName;
  String lastName;
  String email;
  String userID;
  String phone;
  // String category;

  Account(this.firstName, this.lastName, this.email, this.userID, this.phone);

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'user_id': userID,
      'phone': phone,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
