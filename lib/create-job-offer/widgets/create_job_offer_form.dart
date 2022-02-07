import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
class CreateJobOfferForm extends StatefulWidget {
  const CreateJobOfferForm({Key? key}) : super(key: key);

  @override
  _CreateJobOfferFormState createState() => _CreateJobOfferFormState();
}

class _CreateJobOfferFormState extends State<CreateJobOfferForm> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'One';
  DateTime finalDate =  DateTime.now();
  DateTime currentDate = DateTime.now();
  Future<void> _selectInitialDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        finalDate = DateTime(currentDate.year , currentDate.month, currentDate.day +3);
      });
    }
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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: <Widget>[
            Center(
                child: TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
            )),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Description'),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Vacants'),
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
              },
              items: <String>['One', 'Two', 'Free', 'Four']
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
            const Text(
              'Add at least one skill needed for the offer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Center(
                child: TextFormField(
              decoration: const InputDecoration(labelText: 'Skill 1'),
            )),
            const SizedBox(
              height: 25,
            ),
            Center(
                child: TextFormField(
              decoration: const InputDecoration(labelText: 'Skill 2'),
            )),
            const SizedBox(
              height: 25,
            ),
            Center(
                child: TextFormField(
              decoration: const InputDecoration(labelText: 'Skill 3'),
            )),
            const SizedBox(
              height: 25,
            ),
            Center(
                child: TextFormField(
              decoration: const InputDecoration(labelText: 'Skill 4'),
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
            Text(DateFormat.yMMMd().format(currentDate), style: const TextStyle(fontSize: 17),),
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
            Text(DateFormat.yMMMd().format(finalDate), style: const TextStyle(fontSize: 17),),
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
