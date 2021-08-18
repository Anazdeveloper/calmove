import 'package:calmove/Modals/doctors_list_modal.dart';
import 'package:calmove/Screens/DoctorsList/doctors_list_bloc.dart';
import 'package:calmove/UIComponents/doctor_cell_widget.dart';
import 'package:calmove/UIComponents/progress.dart';
import 'package:calmove/UIComponents/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';

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
  late List<DoctorData> doctorList;

  TextEditingController queryTextController = TextEditingController();

  List<String> locations = <String>['All','Dammam','Jeddah','Madinah','Makkah','Riyadh'];
  String? dropdownValue = 'All';

  List<DoctorData> doctors = [];
  String query = '';

  // List locations = [
  //   Item('Dammam'),
  //   Item('Jeddah'),
  //   Item('Madinah'),
  //   Item('Makkah'),
  //   Item('Riyadh')
  // ];
  @override
  Widget build(BuildContext context) {
    //doctors = doctorList;
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
            actions: [
              IconButton(
                  onPressed: () {

                  },
                  icon: const Icon(
                    Icons.filter_alt,
                    color: Colors.white,
                  )
              )
            ],
          ),
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Colors.cyan[700]
                ),
              ),
              Column(
                children: [
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
                    alignment: Alignment.topCenter,
                    //padding: EdgeInsets.only(top: 90.0),
                    child: buildSearch(),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 180.0),
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
                        final dataList = dropdownValue == 'All' ? state.data! : state.data!.where((data) => data.region == dropdownValue).toList();
                        doctorList = dataList;
                        final finalList = doctors.isEmpty ? dataList : doctors;
                        print(finalList.length);
                        return SingleChildScrollView(
                          child: Column(
                            children: List.generate(finalList.length, (index) {
                              return DoctorCellWidget(thumbnailPath: finalList[index].thumpImage,branchName: finalList[index].branchName,designation: finalList[index].designation,doctorName: finalList[index].doctorName,);
                            }),
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

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Search for a doctor',
    onChanged: searchDoctor,
  );

  void searchDoctor(String query) {
    final doctors = doctorList.where((doctor) {
      final doctorName = doctor.doctorName;
      final searchName = query;
      return doctorName!.contains(searchName);
    }).toList();

    setState(() {
      this.doctors = doctors;
      this.query = query;
    });
  }

}