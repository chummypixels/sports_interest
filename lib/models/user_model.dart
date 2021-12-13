//This is our authentication model class
class User {
  final String uid;
  final String? email;

  User(this.uid, this.email);

  Map<String, dynamic> toJson() => {'uid': uid, 'email': email};
}
