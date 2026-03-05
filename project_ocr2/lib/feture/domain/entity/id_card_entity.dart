class IdCardEntity {
  final String idCard;
  final String fullName;
  final String birthDate;
  final String issueDate;
  final String expiryDate;

  const IdCardEntity({
    required this.idCard,
    required this.fullName,
    required this.birthDate,
    required this.issueDate,
    required this.expiryDate,
  });

  List<Object?> get props => [
    idCard,
    fullName,
    birthDate,
    issueDate,
    expiryDate,
  ];
}
