import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/contatos_back4app_model.dart';
import '../repositories/back4app/contatos_back4app_repository.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final TextEditingController _nomeController = TextEditingController(text: "");
  XFile? _imageFile;

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  var futureContatosData = Future.value(ContatosBack4AppModel([]));
  ContatosBack4AppRepository contatosBack4AppRepository =
      ContatosBack4AppRepository();

  List<Contact> contacts = [];

  ImageProvider loadImageOrFallback(String imagePath) {
    if (imagePath.isNotEmpty) {
      final imageFile = File(imagePath);
      if (imageFile.existsSync()) {
        return FileImage(imageFile);
      }
    }
    // Return a placeholder or fallback image if the file doesn't exist
    return const AssetImage(
        'lib/images/avatar2.png'); // Replace with your fallback image path
  }

  void _showAddModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.55,
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Editar Item'),
                TextField(
                  controller: _nomeController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                if (_imageFile != null)
                  Image.file(
                    File(_imageFile!.path),
                    height: 100,
                    width: 100,
                  ),
                ElevatedButton(
                  onPressed: _pickImageFromGallery,
                  child: const Text('Selecionar Imagem'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var contact = Contact(
                      name: _nomeController.text,
                      imagePath: _imageFile!.path,
                    );

                    await contatosBack4AppRepository.criar(
                        contact.name, contact.imagePath);

                    setState(() {
                      contacts.add(contact);
                      _imageFile = null;
                    });

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    futureContatosData = contatosBack4AppRepository.listar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contatos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddModal();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact.name),
            titleAlignment: ListTileTitleAlignment.bottom,
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: loadImageOrFallback(contact.imagePath),
            ),
            subtitle: Text(
              contact.name,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}

class Contact {
  String name;
  String imagePath;

  get getName => name;

  set setName(name) => this.name = name;

  get getImagePath => imagePath;

  set setImagePath(imagePath) => this.imagePath = imagePath;

  Contact({required this.name, required this.imagePath});
}
