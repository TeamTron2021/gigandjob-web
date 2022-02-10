import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigandjob_web/create-job-offer/cubit/create_gig_cubit.dart';
import 'package:gigandjob_web/create-job-offer/cubit/get_employeers_cubit.dart';
import 'package:gigandjob_web/create-job-offer/data/models/employeer_response.dart';
import 'package:gigandjob_web/create-job-offer/data/models/gig.dart';
import 'package:gigandjob_web/create-job-offer/data/models/skill.dart';
import 'package:intl/intl.dart';

class CreateGigForm extends StatefulWidget {
  const CreateGigForm({Key? key}) : super(key: key);

  @override
  _CreateGigFormState createState() => _CreateGigFormState();
}

class _CreateGigFormState extends State<CreateGigForm> {

  final _formKey = GlobalKey<FormState>();
  String dropdownValue = '';
  String timeUnit = 'MONTHS';
  DateTime finalDate = DateTime.now();
  DateTime currentDate = DateTime.now();
  final descriptionController = TextEditingController();
  final titleController = TextEditingController();
  final salaryController = TextEditingController();
  final skill1Controller = TextEditingController();
  final skill2Controller = TextEditingController();
  final skill3Controller = TextEditingController();
  final skill4Controller = TextEditingController();
  final vacantController = TextEditingController();
  final amountController = TextEditingController();

  bool isLoading = true;
  bool saving = false;
  List<EmployeerResponse> employeerList = [];
  Future<void> _selectInitialDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        finalDate =
            DateTime(currentDate.year, currentDate.month, currentDate.day + 3);
      });
    }
  }


  void _submitData() {
    final title = titleController.text;
    final description =  descriptionController.text;
    final vacants = int.parse(vacantController.text);
    final salary = int.parse(salaryController.text);
    final time =  timeUnit;
    final amount = int.parse(amountController.text);
    List<Skill> skills = [];
    if(skill1Controller.text.isNotEmpty){
      skills.add(Skill(skill1Controller.text));
    }
    if(skill2Controller.text.isNotEmpty){
      skills.add(Skill(skill2Controller.text));
    }
    if(skill3Controller.text.isNotEmpty){
      skills.add(Skill(skill3Controller.text));
    }
    if(skill4Controller.text.isNotEmpty){
      skills.add(Skill(skill4Controller.text));
    }
    var jobOfferToSave = Gig(description: description, salary: salary, skills: skills, title: title, vacant: vacants, startDate: currentDate, finalDate: finalDate, time: time, amount: amount);
    BlocProvider.of<CreateGigCubit>(context).createGig(jobOfferToSave, dropdownValue);
  }

  Future<void> _selectFinalDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: finalDate,
        firstDate: finalDate,
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        finalDate = pickedDate;
      });
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetEmployeersCubit>(context).fetchEmployeers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateGigCubit, CreateGigState>(
      listener: (context, state) {
        if (state is CreateGigError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            duration: Duration(milliseconds: 1000),
            backgroundColor: Theme.of(context).errorColor,
          ));
          setState(() {
            saving = false;
          });
        }
        if (state is CreatingGig){
          setState(() {
            saving = true;
          });
        }

        if (state is GigCreated) {
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
      child: BlocBuilder<GetEmployeersCubit, GetEmployeersState>(
        builder: (context, state) {
          if(isLoading){
            if (state is FetchingEmployeers) {
              return const CircularProgressIndicator();
            }
            if(state is EmployeersFetched) {

              dropdownValue = state.employeers[0].id;
              employeerList = state.employeers;
              isLoading = false;

            }
            if(state is FetchingEmployeersError) {
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
                  Center(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Vacants'),
                      controller: vacantController,
                      validator: (value) {
                        if(value!.isNotEmpty && int.parse(value) >=1){
                          return null;
                        }
                        return 'The offer should have one vacant at least';
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Salary'),
                      keyboardType: TextInputType.number,
                      controller: salaryController,
                      validator: (value) {
                        if(value!.isNotEmpty && int.parse(value) >=10){
                          return null;
                        }
                        return 'The minimun wage is 10';
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Select the employeer',
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
                    items: employeerList
                        .map<DropdownMenuItem<String>>((employeer) {
                      return DropdownMenuItem<String>(
                        value: employeer.id,
                        child: Text(employeer.companyName),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Add at least one skill needed for the offer',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Skill 1'),
                      controller: skill1Controller,
                      validator: (value) {
                        var skill2 = skill2Controller.text.isNotEmpty;
                        var skill3 = skill3Controller.text.isNotEmpty;
                        var skill4 = skill4Controller.text.isNotEmpty;
                        if(skill2 || skill3 || skill4 || value!.isNotEmpty){
                          return null;
                        }

                        return 'You need to add at least one skill';

                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Skill 2'),
                        controller: skill2Controller,
                        validator: (value) {
                          var skill1 = skill1Controller.text.isNotEmpty;
                          var skill3 = skill3Controller.text.isNotEmpty;
                          var skill4 = skill4Controller.text.isNotEmpty;
                          if(skill1 || skill3 || skill4 || value!.isNotEmpty){
                            return null;
                          }

                          return 'You need to add at least one skill';

                        },
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Skill 3'),
                        controller: skill3Controller,
                        validator: (value) {
                          var skill1 = skill1Controller.text.isNotEmpty;
                          var skill2 = skill2Controller.text.isNotEmpty;
                          var skill4 = skill4Controller.text.isNotEmpty;
                          if(skill1 || skill2 || skill4 || value!.isNotEmpty){
                            return null;
                          }

                          return 'You need to add at least one skill';
                        },
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Skill 4'),
                        controller: skill4Controller,
                        validator: (value) {
                          var skill1 = skill1Controller.text.isNotEmpty;
                          var skill2 = skill2Controller.text.isNotEmpty;
                          var skill3 = skill3Controller.text.isNotEmpty;
                          if(skill1 || skill2 || skill3 || value!.isNotEmpty){
                            return null;
                          }

                          return 'You need to add at least one skill';
                        },
                      )),
                  const SizedBox(
                    height: 25,
                  ),

                  const Text(
                    'Please enter the Start Date',
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
                    DateFormat.yMMMd().format(currentDate),
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Please enter the final Date',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    label: const Text('Pick the date'),
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectFinalDate();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(finalDate),
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Please enter the duration of the gig',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Amount'),
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      validator: (value) {
                        if(value!.isNotEmpty && int.parse(value) >=1){
                          return null;
                        }
                        return 'The minimum amount of time is 1';
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  const Text(
                    'Please select the unit of time',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  DropdownButton<String>(
                      value: timeUnit,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                          setState(() {
                            timeUnit = newValue!;
                          });
                      },
                      items: <String>['DAYS', 'WEEKS', 'MONTHS']
                          .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                                );
                              }).toList(),
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
    currentDate = DateTime.now();
    finalDate = DateTime.now();
    dropdownValue = employeerList[0].id;
    timeUnit = 'MONTHS';
    amountController.clear();
    descriptionController.clear();
    titleController.clear();
    salaryController.clear();
    vacantController.clear();
    skill1Controller.clear();
    skill2Controller.clear();
    skill3Controller.clear();
    skill4Controller.clear();
    return;
  }
}
