class GuardianData {
  String? id;
  String? name;
  String? password;
  String? email;
  String? phone;
  String? address;
  String? birth;
  String? job;
  String? residenceArea;
  //String? existingConditions;
  String? elderlyPhone;
  String? elderlyAddress;
  //String? role; // 추가된 필드

  GuardianData({
    this.id,
    this.name,
    this.password,
    this.email,
    this.phone,
    this.address,
    this.birth,
    this.job,
    this.residenceArea,
    //this.existingConditions,
    this.elderlyPhone,
    this.elderlyAddress,
    //this.role,
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
    String? residenceArea,
    //String? existingConditions,
    String? elderlyPhone,
    String? elderlyAddress,
    //String? role,
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
      residenceArea: residenceArea ?? this.residenceArea,
      //existingConditions: existingConditions ?? this.existingConditions,
      elderlyPhone: elderlyPhone ?? this.elderlyPhone,
      elderlyAddress: elderlyAddress ?? this.elderlyAddress,
      //role: role ?? this.role,
    );
  }
}
