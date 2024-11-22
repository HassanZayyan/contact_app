import 'package:flutter/material.dart';
import 'package:flutter_contact_apps/database/db_helper.dart';
import 'package:flutter_contact_apps/model/kontak.dart';
import 'form_kontak.dart';

class ListKontakPage extends StatefulWidget {
  const ListKontakPage({Key? key}) : super(key: key);

  @override
  State<ListKontakPage> createState() => _ListKontakPageState();
}

class _ListKontakPageState extends State<ListKontakPage> {
  List<Kontak> listKontak = [];
  final DbHelper db = DbHelper();

  @override
  void initState() {
    super.initState();
    _getAllKontak();
  }

  Future<void> _getAllKontak() async {
    List<Map<String, dynamic>> kontakList = (await db.getAllKontak())!.cast<Map<String, dynamic>>();

    setState(() {
      listKontak = kontakList.map((kontak) => Kontak.fromMap(kontak)).toList();
    });
  }

  void _deleteKontak(Kontak kontak, int index) async {
    await db.deleteKontak(kontak.id!);
    setState(() {
      listKontak.removeAt(index);
    });
  }

  Future<void> _openForm(Kontak? kontak) async {
    String? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormKontak(kontak: kontak)),
    );
    if (result != null) _getAllKontak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact List')),
      body: ListView.builder(
        itemCount: listKontak.length,
        itemBuilder: (context, index) {
          final kontak = listKontak[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(kontak.name),
              subtitle: Text(kontak.mobileNo),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _openForm(kontak),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteKontak(kontak, index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}