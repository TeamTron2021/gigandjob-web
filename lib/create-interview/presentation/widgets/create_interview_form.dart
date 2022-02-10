import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/create-interview/cubit/add_interview_cubit.dart';
import 'package:gigandjob_web/create-interview/cubit/add_interview_cubit.dart';
import 'package:gigandjob_web/create-interview/cubit/get_postulations_cubit.dart';
import 'package:gigandjob_web/create-interview/data/models/postulation_response.dart';
import 'package:gigandjob_web/create-interview/data/models/interview.dart';
import 'package:intl/intl.dart';

class CreateInterviewForm extends StatefulWidget {
  const CreateInterviewForm({Key? key}) : super(key: key);

  @override
  _CreateInterviewFormState createState() => _CreateInterviewFormState();
}

class _CreateInterviewFormState extends State<CreateInterviewForm> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = '';
  DateTime date = DateTime.now();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isLoading = true;
  bool saving = false;
  List<PostulationResponse> postulationList = [];
  Future<void> _selectInitialDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != date) {
      setState(() {
        date = pickedDate;
        finalDate =
            DateTime(date.year, date.month, date.day + 3);
      });
    }
  }


  void _submitData() {
    final title = titleController.text;
    final description =  descriptionController.text;
   
    var interviewToSave = Interview(title: title, description: description, date: date);
    BlocProvider.of<AddInterviewCubit>(context)
        .addInterview(interviewToSave, dropdownValue);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetPostulationsCubit>(context).fetchPostulations();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddInterviewCubit, AddInterviewState>(
      listener: (context, state) {
        if (state is AddInterviewError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            duration: Duration(milliseconds: 1000),
            backgroundColor: Theme.of(context).errorColor,
          ));
          setState(() {
            saving = false;
          });
        }
        if (state is AddingInterview){
          setState(() {
            saving = true;
          });
        }

        if (state is InterviewAdded) {
          _resetForm();
          Scaffold.of(context).showSnackBar(const SnackBar(
            content: const Text('Succeed'),
            duration: Duration(milliseconds: 1000),
            backgroundColor: Colors.green,
          ));
          setState(() {
            saving = false;
          });
        }
      },
      child: BlocBuilder<GetPostulationsCubit, GetPostulationsState>(
  builder: (context, state) {
    if(isLoading){
      if (state is FetchingPostulations) {
        return const CircularProgressIndicator();
      }
      if(state is PostulationsFetched) {

        dropdownValue = state.postulations[0].id;
        postulationList = state.postulations;
          isLoading = false;

      }
      if(state is FetchingPostulationsError) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
          duration: Duration(milliseconds: 1000),
          backgroundColor: Theme.of(context).errorColor,
        ));
    }

    }
    return (saving) ? const CircularProgressIndicator() : Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              Center(
                  child: TextFormField(
                            decoration: const InputDecoration(labelText: 'Title'),
                            controller: titleController,
                            validator: (value) {
                              if (value!.isNotEmpty && value.length >= 2) {
                                return null;
                              }
                              return 'The title should not be empty and should have 2 characters at least';
                            },
                          )
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Description'),
                  controller: descriptionController,
                  validator: (value) {
                    if (value!.isNotEmpty && value.length >= 5) {
                      return null;
                    }
                    return 'The description should not be empty , and should have 5 characters at least';
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
             
              const Text(
                'Select the postulation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;

                  });
                  print(dropdownValue);
                },
                items: postulationList
                    .map<DropdownMenuItem<String>>((postulation) {
                  return DropdownMenuItem<String>(
                    value: postulation.id,
                    child: Text(postulation.date),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 25,
              ),
             
              const Text(
                'Please enter the Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                label: const Text('Pick the date'),
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  _selectInitialDate();
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColorDark,
                ),
              ),
              Text(
                DateFormat.yMMMd().format(date),
                style: const TextStyle(fontSize: 17),
              ),
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
      );
  },
),
    );
  }

  void _resetForm() {
    date = DateTime.now();
    dropdownValue = postulationList[0].id;
    descriptionController.clear();
    titleController.clear();
    return;
  }
}
