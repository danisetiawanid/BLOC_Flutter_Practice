part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class ContactLoad extends ContactEvent {
  final List<ContactModel> contacs;

  const ContactLoad({this.contacs = const <ContactModel>[]});

  @override
  List<Object?> get props => [contacs];
}

class AddContact extends ContactEvent {
  final ContactModel contact;

  const AddContact({required this.contact});

  @override
  List<Object?> get props => [];
}

class UpdateContact extends ContactEvent {
  final ContactModel contact;

  const UpdateContact({required this.contact});

  @override
  List<Object?> get props => [];
}

class DeleteContact extends ContactEvent {
  final ContactModel contact;

  const DeleteContact({required this.contact});

  @override
  List<Object?> get props => [];
}
