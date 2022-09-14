import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;

  const ContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  ContactModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
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
