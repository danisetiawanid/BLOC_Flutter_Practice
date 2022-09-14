import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/bloc/contact_bloc.dart';
import 'package:flutter_example/model/contact_model.dart';
import 'package:flutter_example/screens/update_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'CRUD App',
        ),
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoading) {
            return const CircularProgressIndicator();
          }
          if (state is ContactLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  return _contactCard(context, state.contacts[index]);
                },
              ),
            );
          } else {
            return const Text('Something went wrong !');
          }
        },
      ),
    );
  }
}

Card _contactCard(BuildContext context, ContactModel contact) {
  return Card(
    margin: const EdgeInsets.only(bottom: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID : ${contact.id}',
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Name : ${contact.name}',
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Email : ${contact.email}',
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Phone : ${contact.phone}',
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateScreen(contact: contact),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  context
                      .read<ContactBloc>()
                      .add(DeleteContact(contact: contact));
                },
                icon: const Icon(Icons.cancel),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
