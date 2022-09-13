part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class LoadContacts extends ContactEvent {
  final List<ContactModel> contacts;

  const LoadContacts({this.contacts = const <ContactModel>[]});

  @override
  List<Object?> get props => [contacts];
}

class AddContacts extends ContactEvent {
  final ContactModel contact;

  const AddContacts({required this.contact});

  @override
  List<Object?> get props => [];
}

class UpdateContacts extends ContactEvent {
  final ContactModel contact;

  const UpdateContacts({required this.contact});

  @override
  List<Object?> get props => [];
}

class DeleteContacts extends ContactEvent {
  final ContactModel contact;

  const DeleteContacts({required this.contact});

  @override
  List<Object?> get props => [];
}
