import 'package:flutter/material.dart';
import 'package:responsi1/bloc/fasilitas_bloc.dart';
import 'package:responsi1/model/fasilitas.dart';
import 'package:responsi1/ui/login_page.dart';
import 'package:responsi1/ui/fasilitas_detail.dart';
import 'package:responsi1/ui/fasilitas_form.dart';
import 'package:responsi1/bloc/logout_bloc.dart';

class FasilitasPage extends StatefulWidget {
  const FasilitasPage({super.key});

  @override
  FasilitasPageState createState() => FasilitasPageState();
}

class FasilitasPageState extends State<FasilitasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FASILITAS',
          style: TextStyle(
            fontFamily: 'Calibri',
          ),
        ),
        backgroundColor: const Color(0xFF8c9cf5),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FasilitasForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFbbd7fd),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFbbd7fd),
        ),
        child: FutureBuilder<List>(
          future: FasilitasBloc.getFasilitas(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListFasilitas(
                    list: snapshot.data,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ListFasilitas extends StatelessWidget {
  final List? list;
  const ListFasilitas({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemFasilitas(
            fasilitas: list![i],
          );
        });
  }
}

class ItemFasilitas extends StatelessWidget {
  final Fasilitas fasilitas;
  const ItemFasilitas({Key? key, required this.fasilitas}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FasilitasDetail(
                      fasilitas: fasilitas,
                    )));
      },
      child: Card(
        color: Color(0xFFfee6ed),
        child: ListTile(
          title: Text(fasilitas.facility!),
          subtitle: Text(fasilitas.type!),
          trailing: Text(fasilitas.facilityStatus!),
        ),
      ),
    );
  }
}
