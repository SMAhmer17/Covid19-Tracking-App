// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:covidtrackingapp/Model/World_States_Model.dart';
import 'package:covidtrackingapp/Services/stats_services.dart';
import 'package:covidtrackingapp/View/CountriesListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> with TickerProviderStateMixin  {
 
   // Animation
 late final AnimationController  controller = AnimationController(
  duration: const Duration(seconds: 5),
  vsync: this)..repeat();


  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];


    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  
    controller.dispose();
  }
 
 
  @override
  Widget build(BuildContext context) {
    // obejct of states services
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('World Stats Screen'),
      ),
      body: SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [ 
            SizedBox(height: MediaQuery.of(context).size.height * .01,),
            FutureBuilder(
            future: statesServices.fetchWorldStatesRecord(), 
            builder: (context , AsyncSnapshot<WorldStatesModel> snapshot){
              
              if(!snapshot.hasData){
                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(color: Colors.white,
                  size: 50,
                  controller: controller,
                  )
                  );

              }else{
                return Column(
                  children: [
                                PieChart(dataMap:  {
              'Total' : double.parse(snapshot.data!.cases!.toString()),
              'Recovered'  : double.parse(snapshot.data!.recovered!.toString()),
              'Deaths'  :double.parse(snapshot.data!.deaths!.toString()),
            },
            chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            legendOptions:const LegendOptions(
              legendPosition: LegendPosition.left
            ),
            animationDuration: Duration(milliseconds: 1200),
            chartType: ChartType.ring,
            colorList: colorList,),
            SizedBox(height: 12,),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .01,),
              child: Card(
                color: Color.fromARGB(255, 54, 36, 44),
                child: Column(children: [
                  ReuseableRow(title: 'Cases', value: snapshot.data!.cases.toString()),
                  ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                  ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                  ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                  ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                  ReuseableRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                  ReuseableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                  ReuseableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
             
                ]),
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesListScreen()));
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * .8,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(18)
                ),
                child: Center(
                  child: Text('Track Countries' , style: TextStyle(
                    fontSize: 16 , fontWeight: FontWeight.w500
                  ),),
                ),
              ),
            )
            
                  ],
                );
              }
            } )

          ],
        ),
      )),
    );
  }
}

class ReuseableRow extends StatelessWidget {

  String title , value;
 ReuseableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
         
    
          Divider( color: Colors.grey,)
        ],
      ),
    );
  }
}
