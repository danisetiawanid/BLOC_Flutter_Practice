import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_example/model/contact_model.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactLoading()) {
    on<ContactLoad>(_onLoadContact);
    on<AddContact>(_onAddContact);
    on<DeleteContact>(_onDeleteContact);
    on<UpdateContact>(_onUpdateContact);
  }
  void _onLoadContact(ContactLoad event, Emitter<ContactState> emit) {
    emit(ContactLoaded(contacts: event.contacs));
  }

  void _onAddContact(AddContact event, Emitter<ContactState> emit) {
    final state = this.state;
    if (state is ContactLoaded) {
      emit(ContactLoaded(
        contacts: List.from(state.contacts)..add(event.contact),
      ));
    }
  }

  void _onDeleteContact(DeleteContact event, Emitter<ContactState> emit) {
    final state = this.state;
    if (state is ContactLoaded) {
      List<ContactModel> contacts = state.contacts.where((contact) {
        return contact.id != event.contact.id;
      }).toList();
      emit(ContactLoaded(contacts: contacts));
    }
  }

  void _onUpdateContact(UpdateContact event, Emitter<ContactState> emit) {
    final state = this.state;
    if (state is ContactLoaded) {
      List<ContactModel> contacs = (state.contacts.map((modelData) {
        return modelData.id == event.contact.id ? event.contact : modelData;
      })).toList();
      emit(ContactLoaded(contacts: contacs));
    }
  }
}
