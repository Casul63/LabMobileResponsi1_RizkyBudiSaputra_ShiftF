import 'package:flutter/material.dart';
import 'package:responsi1/model/fasilitas.dart';
import 'package:responsi1/ui/fasilitas_form.dart';
import 'package:responsi1/bloc/fasilitas_bloc.dart';
import 'package:responsi1/ui/fasilitas_page.dart';
import 'package:responsi1/widget/warning_dialog.dart';

// ignore: must_be_immutable
class FasilitasDetail extends StatefulWidget {
  Fasilitas? fasilitas;
  FasilitasDetail({Key? key, this.fasilitas}) : super(key: key);

  @override
  FasilitasDetailState createState() => FasilitasDetailState();
}

class FasilitasDetailState extends State<FasilitasDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Fasilitas'),
        backgroundColor: const Color(0xFF8c9cf5),
      ),
      body: Container(
        color: const Color(0xFFbbd7fd),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Facility: ${widget.fasilitas?.facility ?? 'Unknown'}",
                style: const TextStyle(fontSize: 20.0),
              ),
              Text(
                "Type: ${widget.fasilitas?.type ?? 'Unknown'}",
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                "Status: ${widget.fasilitas?.facilityStatus ?? 'Unknown'}",
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20),
              _tombolHapusEdit()
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF98d688))),
          child: const Text(
            "EDIT",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FasilitasForm(
                  fasilitas: widget.fasilitas!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10), // Menambahkan jarak antar tombol
        // Tombol Hapus
        OutlinedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFFf17041))),
          child: const Text(
            "DELETE",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            FasilitasBloc.deleteFasilitas(id: widget.fasilitas!.id!)
                .then((value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const FasilitasPage()))
                    });
          },
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
