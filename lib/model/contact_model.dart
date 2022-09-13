import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
  final String id;
  final String name;
  final String email;

  const ContactModel({
    required this.id,
    required this.name,
    required this.email,
  });

  ContactModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
      ];

  // static List<ContactModel> contacs = [
  //   const ContactModel(
  //     id: '1',
  //     name: 'Sample Name',
  //     email: 'email@email.com',
  //   ),
  //   const ContactModel(
  //     id: '2',
  //     name: 'Sample Name2',
  //     email: 'email@email.com',
  //   )
  // ];
}
