import 'package:flutter/material.dart';
import 'package:gigandjob_web/create-employeer/widgets/google_maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateEmployerForm extends StatefulWidget {
  const CreateEmployerForm({Key? key}) : super(key: key);

  @override
  _CreateEmployerFormState createState() => _CreateEmployerFormState();
}

class _CreateEmployerFormState extends State<CreateEmployerForm> {
  final _formKey = GlobalKey<FormState>();
  LatLng latLng = LatLng(1.3521, 103.8198);
  Set<Marker> _markers = new Set<Marker>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Center(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Company Name'),
                )),
            const SizedBox(
              height: 25,
            ),
            Center(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Company Mail'),
                )),
            const SizedBox(
              height: 25,
            ),
            Center(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'RIF'),
                )),
            const SizedBox(
              height: 25,
            ),
            Center(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Industry'),
                )),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton.icon(
              label: const Text('Send', style: TextStyle(fontSize: 20),),
              icon: const Icon(Icons.send),
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColorDark,
                  fixedSize: Size(150, 50)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
