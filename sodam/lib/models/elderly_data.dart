class ElderlyData {
  String? name;
  String? id;
  String? password;
  String? guardianPhone;
  String? role;

  ElderlyData({
    this.name,
    this.id,
    this.password,
    this.guardianPhone,
    this.role,
  });

  ElderlyData copyWith({
    String? name,
    String? id,
    String? password,
    String? guardianPhone,
    String? role,
  }) {
    return ElderlyData(
      name: name ?? this.name,
      id: id ?? this.id,
      password: password ?? this.password,
      guardianPhone: guardianPhone ?? this.guardianPhone,
      role: role ?? this.role,
    );
  }
}
