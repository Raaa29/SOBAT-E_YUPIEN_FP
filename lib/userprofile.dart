class UserProfile {
  String name;
  String programStudi;
  String npm;
  String phone;
  String? profilePicture; // URL foto profil, bisa null jika tidak ada

  UserProfile({
    required this.name,
    required this.programStudi,
    required this.npm,
    required this.phone,
    this.profilePicture, // Atribut untuk URL foto profil
  });
}