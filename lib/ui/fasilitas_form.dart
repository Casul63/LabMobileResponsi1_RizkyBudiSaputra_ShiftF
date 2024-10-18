import 'package:flutter/material.dart';
import 'package:responsi1/bloc/fasilitas_bloc.dart';
import 'package:responsi1/model/fasilitas.dart';
import 'package:responsi1/ui/fasilitas_page.dart';
import 'package:responsi1/widget/warning_dialog.dart';

class FasilitasForm extends StatefulWidget {
  final Fasilitas? fasilitas;

  FasilitasForm({Key? key, this.fasilitas}) : super(key: key);

  @override
  FasilitasFormState createState() => FasilitasFormState();
}

class FasilitasFormState extends State<FasilitasForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH FASILITAS";
  String tombolSubmit = "SIMPAN";

  final _facilityTextboxController = TextEditingController();
  final _typeTextboxController = TextEditingController();
  final _facilityStatusTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.fasilitas != null) {
      setState(() {
        judul = "UBAH FASILITAS";
        tombolSubmit = "UBAH";
        _facilityTextboxController.text = widget.fasilitas!.facility!;
        _typeTextboxController.text = widget.fasilitas!.type!;
        _facilityStatusTextboxController.text =
            widget.fasilitas!.facilityStatus!;
      });
    } else {
      judul = "TAMBAH FASILITAS";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: const Color(0xFF8c9cf5),
      ),
      body: Container(
        color: const Color(0xFFbbd7fd),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _facilityTextField(),
                const SizedBox(height: 16),
                _typeTextField(),
                const SizedBox(height: 16),
                _facilityStatusTextField(),
                const SizedBox(height: 16),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _facilityTextField() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          decoration: const InputDecoration(labelText: "Facility"),
          keyboardType: TextInputType.text,
          controller: _facilityTextboxController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Facility harus diisi";
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _typeTextField() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          decoration: const InputDecoration(labelText: "Type"),
          keyboardType: TextInputType.text,
          controller: _typeTextboxController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Type harus diisi";
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _facilityStatusTextField() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          decoration: const InputDecoration(labelText: "Status"),
          keyboardType: TextInputType.text,
          controller: _facilityStatusTextboxController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Status harus diisi";
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xFF98d688)),
        ),
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.fasilitas != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Fasilitas createFasilitas = Fasilitas(id: null);
    createFasilitas.facility = _facilityTextboxController.text;
    createFasilitas.type = _typeTextboxController.text;
    createFasilitas.facilityStatus = _facilityStatusTextboxController.text;
    FasilitasBloc.addFasilitas(fasilitas: createFasilitas).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const FasilitasPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Fasilitas updateFasilitas = Fasilitas(id: widget.fasilitas!.id!);
    updateFasilitas.facility = _facilityTextboxController.text;
    updateFasilitas.type = _typeTextboxController.text;
    updateFasilitas.facilityStatus = _facilityStatusTextboxController.text;
    FasilitasBloc.updateFasilitas(fasilitas: updateFasilitas).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const FasilitasPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
