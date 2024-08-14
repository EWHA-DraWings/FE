class GuardianData {
  //guardian info
  String? id;
  String? name;
  String? password;
  String? email;
  String? phone;
  String? address;
  String? birth;
  String? job;
  //elderly info
  String? existingConditions;
  String? elderlyName;
  String? elderlyPhone;
  String? elderlyAddress;
  String? elderlyBirthday;
  String? role;

  GuardianData({
    this.id,
    this.name,
    this.password,
    this.email,
    this.phone,
    this.address,
    this.birth,
    this.job,
    this.existingConditions,
    this.elderlyName,
    this.elderlyPhone,
    this.elderlyBirthday,
    this.elderlyAddress,
    this.role,
  });

  GuardianData copyWith({
    String? id,
    String? name,
    String? password,
    String? email,
    String? phone,
    String? address,
    String? birth,
    String? job,
    String? existingConditions,
    String? elderlyName,
    String? elderlyPhone,
    String? elderlyAddress,
    String? elderlyBirthday,
    String? role,
  }) {
    return GuardianData(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      birth: birth ?? this.birth,
      job: job ?? this.job,
      existingConditions: existingConditions ?? this.existingConditions,
      elderlyName: elderlyName ?? this.elderlyName,
      elderlyPhone: elderlyPhone ?? this.elderlyPhone,
      elderlyAddress: elderlyAddress ?? this.elderlyAddress,
      elderlyBirthday: elderlyBirthday ?? this.elderlyBirthday,
      role: role ?? this.role,
    );
  }
}
