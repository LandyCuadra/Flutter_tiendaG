class credencial_basedatos{
  String username;
  String password;
  String dabatase;

  Map<String, dynamic> toMap(){
    return {
      "username": username,
      "password" : password,
      "database" : dabatase
    };
  }
}