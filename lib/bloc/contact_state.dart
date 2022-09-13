part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {}

class ContactLoading extends ContactState {
  @override
  List<Object?> get props => [];
}

class ContactLoaded extends ContactState {
  final List<ContactModel> contacts;

  ContactLoaded({this.contacts = const <ContactModel>[]});

  @override
  List<Object?> get props => [contacts];
}
