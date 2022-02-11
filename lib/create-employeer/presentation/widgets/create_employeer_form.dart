import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/create-employeer/cubit/register_employeer_cubit.dart';
import 'package:gigandjob_web/create-employeer/data/models/employeer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateEmployerForm extends StatefulWidget {
  const CreateEmployerForm({Key? key}) : super(key: key);

  @override
  _CreateEmployerFormState createState() => _CreateEmployerFormState();
}

class _CreateEmployerFormState extends State<CreateEmployerForm> {
  final companyNameController = TextEditingController();
  final companyMailController = TextEditingController();
  final rifController = TextEditingController();
  final industryController = TextEditingController();
  bool _isLoading = false;
  List<Marker> markers = <Marker>[];
  late final GoogleMapController _controller;
  final _formKey = GlobalKey<FormState>();
  var latitude = 0.0;
  var longitude = 0.0;
  void _submitData() {
    var companyName = companyNameController.text;
    var companyMail = companyMailController.text;
    var rif = rifController.text;
    var industry = industryController.text;

    if(latitude == 0.0 || longitude == 0.0 ){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please tap on your location'),
        duration: Duration(milliseconds: 1000),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return ;
    }
    var newEmployeer = Employeer(
        companyName: companyName,
        companyMail: companyMail,
        rif: rif,
        latitude: latitude.toString(),
        longitude: longitude.toString(),
        industry: industry);
    BlocProvider.of<RegisterEmployeerCubit>(context).registerEmployeer(newEmployeer);
  }

  void _clearForm() {
    companyNameController.clear();
    companyMailController.clear();
    rifController.clear();
    industryController.clear();
    latitude = 0.0;
    longitude = 0.0;
  }
  @override

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterEmployeerCubit, RegisterEmployeerState>(
      listener: (context, state) {
        if (state is RegisteringEmployeer) {
          setState(() {
            _isLoading = true;
          });
        }
        if (state is RegisterEmployeerError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            duration: Duration(milliseconds: 1000),
            backgroundColor: Theme.of(context).errorColor,
          ));
          setState(() {
            _isLoading = false;
          });
        }
        if (state is EmployeerRegistered) {
          _clearForm();
          Scaffold.of(context).showSnackBar(const SnackBar(
            content: const Text('Succeed'),
            duration: Duration(milliseconds: 1000),
            backgroundColor: Colors.green,
          ));
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: (_isLoading)
          ? const CircularProgressIndicator()
          : Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Company Name'),
                        controller: companyNameController,
                        validator: (value) {
                          if (value!.isNotEmpty && value.length >= 2) {
                            return null;
                          }
                          return 'The company name should not be empty, and have at least 2 characters';
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                        child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Company Mail'),
                      controller: companyMailController,
                      validator: (value) {
                        if (value!.isNotEmpty &&
                            RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return null;
                        }
                        return 'The company mail should no be empty and should be a valid email';
                      },
                    )),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                        child: TextFormField(
                      decoration: const InputDecoration(labelText: 'RIF'),
                      controller: rifController,
                      validator: (value) {
                        if (value!.isNotEmpty &&
                            RegExp(r'^[J][-][0-9]{8}[-][0-9]$')
                                .hasMatch(value)) {
                          return null;
                        }
                        return 'The rif should not be empty, and should be valid';
                      },
                    )),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                        child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Industry'),
                      controller: industryController,
                      validator: (value) {
                        if (value!.isNotEmpty && value.length >= 2) {
                          return null;
                        }
                        return 'The industry should not be empty, and should be valid';
                      },
                    )),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Please tap on your localization ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(child:
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(10.4806, -66.9036),
                          zoom: 14,
                        ),
                        onTap: (latLng) {
                          setState(() {
                            latitude = latLng.latitude;
                            longitude = latLng.longitude;
                          });
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('The selected location is ${latitude}, ${longitude}'),
                            duration: Duration(milliseconds: 3000),
                            backgroundColor: Colors.green,
                          ));
                        },
                        onMapCreated: (GoogleMapController controller) {
                          _controller = controller;
                        },

                      )
                      , height: 500,),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton.icon(
                      label: const Text(
                        'Send',
                        style: TextStyle(fontSize: 20),
                      ),
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _submitData();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColorDark,
                          fixedSize: Size(150, 50)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
