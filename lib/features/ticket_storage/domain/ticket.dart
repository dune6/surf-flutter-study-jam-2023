/// Ticket entity
class Ticket {
  final int? id;
  final String name;
  final String pdfFileName;
  final bool isLoaded;

  Ticket(
      {required this.name,
      required this.pdfFileName,
      required this.isLoaded,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pdfFileName': pdfFileName,
      'isLoaded': isLoaded ? 1 : 0,
    };
  }

  static Ticket fromMap(Map<String, dynamic> map) {
    return Ticket(
        name: map['name'] as String,
        pdfFileName: map['pdfFileName'] as String,
        isLoaded: map['isLoaded'] as int == 1 ? true : false);
  }

  @override
  List<Object> get props => [id ?? '', name, pdfFileName, isLoaded];

  Ticket copyWith({
    int? id,
    String? name,
    String? pdfFileName,
    bool? isLoaded,
  }) =>
      Ticket(
          id: id ?? this.id,
          name: name ?? this.name,
          pdfFileName: pdfFileName ?? this.pdfFileName,
          isLoaded: isLoaded ?? this.isLoaded);
}
