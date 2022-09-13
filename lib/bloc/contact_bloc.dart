import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_example/model/contact_model.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactLoading()) {
    on<LoadContacts>(_onLoadContacts);
    on<AddContacts>(_onAddContact);
    on<DeleteContacts>(_onDeleteContact);
    on<UpdateContacts>(_onUpdateContact);
  }
  void _onLoadContacts(LoadContacts event, Emitter<ContactState> emit) {
    emit(ContactLoaded(contacts: event.contacts));
  }

  void _onAddContact(AddContacts event, Emitter<ContactState> emit) {
    final state = this.state;
    if (state is ContactLoaded) {
      emit(ContactLoaded(
        contacts: List.from(state.contacts)..add(event.contact),
      ));
    }
  }

  void _onDeleteContact(DeleteContacts event, Emitter<ContactState> emit) {
    final state = this.state;
    if (state is ContactLoaded) {
      List<ContactModel> contacts = state.contacts.where((contact) {
        return contact.id != event.contact.id;
      }).toList();
      emit(ContactLoaded(contacts: contacts));
    }
  }

  void _onUpdateContact(UpdateContacts event, Emitter<ContactState> emit) {
    final state = this.state;
    if (state is ContactLoaded) {
      List<ContactModel> contacts = (state.contacts.map((contact) {
        return contact.id == event.contact.id ? event.contact : contact;
      })).toList();
      emit(ContactLoaded(contacts: contacts));
    }
  }
}
