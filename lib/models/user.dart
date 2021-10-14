class CustomUser {

  final String? userID;
  final String _userName;

  CustomUser(this._userName, {this.userID});

  String getUserName() {
    return _userName;
  }

  String getUserIdentifier() {
    return userID!;
  }

}