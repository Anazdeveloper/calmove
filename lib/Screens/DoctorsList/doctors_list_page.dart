import 'package:calmove/Screens/DoctorsList/doctors_list_bloc.dart';
import 'package:calmove/UIComponents/doctor_cell_widget.dart';
import 'package:calmove/UIComponents/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsListPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return DoctorsListPageState();
  }

}

class Item {
  String location;
  Item(this.location);
}

class DoctorsListPageState extends State<DoctorsListPage> {

  List<String> locations = <String>['Dammam','Jeddah','Madinah','Makkah','Riyadh'];
  String? dropdownValue;
  // List locations = [
  //   Item('Dammam'),
  //   Item('Jeddah'),
  //   Item('Madinah'),
  //   Item('Makkah'),
  //   Item('Riyadh')
  // ];
  @override
  Widget build(BuildContext context) {
    final blocprovider = BlocProvider.of<DoctorsListBloc>(context);
    blocprovider.add(DoctorsListUiLoadedEvent());
    return SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: const Text(
              'Doctors',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            backgroundColor: Colors.cyan[700],
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
              ),
          ),
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Colors.cyan[700]
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top:60.0),
                //alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    DropdownButton(
                      value: locations[0],
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      elevation: 0,
                      dropdownColor: Colors.cyan[700],
                      iconEnabledColor: Colors.white,
                      style: const TextStyle(color: Colors.cyan),
                      selectedItemBuilder: (BuildContext context) {
                        return locations.map((String value) {
                          return Text(
                            dropdownValue ?? locations[0],
                            style: const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                      items: locations.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          child: Text(
                            value,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                          value: value,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 80.0),
                child: BlocListener(
                  bloc: blocprovider,
                  listener: (context, state) {
                    if(state is DoctorsListInputNotLoadedYet) {
                      Progress();
                    }
                  },
                  child: BlocBuilder(
                    bloc: blocprovider,
                    builder: (context, state) {
                      if(state is DoctorsListLoadedState) {
                        return Container(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(state.data.length, (index) {
                                return DoctorCellWidget(thumbnailPath: state.data[index].thumpImage,branchName: state.data[index].branchName,designation: state.data[index].designation,doctorName: state.data[index].doctorName,);
                              }),
                            ),
                          ),
                        );
                      }
                      return Progress();
                    },
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

}