class Admin {
  String id;
  String name;
  String email;
  String image;
  String password;

  Admin({
    this.id,
    this.name,
    this.email,
    this.image,
    this.password,
  });

  Map toMap() {
    return {
      id: id,
      name: name,
      email: email,
      image: image,
      password: password,
    };
  }
}