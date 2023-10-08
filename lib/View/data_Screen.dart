// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:covidtrackingapp/View/WorldStatsScreen.dart';
import 'package:flutter/material.dart';

class DetailedScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases, totalDeaths ,
  totalRecovered , active , critical , todayRecovered , test;
  DetailedScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  }) : super(key: key);

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [ 
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                child: Card(child:
                 Column(
                
                  children: [
                     SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    ReuseableRow(title: 'Cases', value: widget.totalCases.toString()),
                    ReuseableRow(title: 'Test', value: widget.test.toString()),
                    ReuseableRow(title: 'Active', value: widget.active.toString()),
                    ReuseableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                    ReuseableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                    ReuseableRow(title: 'Critical', value: widget.critical.toString()),
                    ReuseableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                  ],
                 ),),
              ),
               CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image ),
               )
            ],
          )
        ],
      ),
    );
  }
}