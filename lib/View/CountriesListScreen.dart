import 'package:covidtrackingapp/Services/stats_services.dart';
import 'package:covidtrackingapp/View/data_Screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  
  TextEditingController searchController = TextEditingController();
  
    // obejct of states services
    StatesServices statesServices = StatesServices();

  @override
  Widget build(BuildContext context) 
  {  
    return GestureDetector(
      onTap: (){
         FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Track Country'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {
                    
                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with Country name..',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18))
                ),
              ),
              Expanded(child: FutureBuilder(
                future: statesServices.fetchCountriesListApi() ,
                builder: (context , AsyncSnapshot<List<dynamic>> snapshot){
                      // For no data
                  if(!snapshot.hasData){
                     return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context , index){
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.green.shade200,
                        child: Column(
                        children: [
                          ListTile(
                             leading: Container(height:50, width:  50, color: Colors.white,), 
                            title: Container(height:10, width:  80, color: Colors.white,),
                            subtitle: Container(height:10, width:  80, color: Colors.white,),
                          ),
                        ],
                      )
                      );
                    });
                  }
                        // When data receive
                  else{
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context , index){
                          String name = snapshot.data![index]['country'];
                        if(searchController.text.isEmpty){
                          return Column(
                          children: [
                            InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => 
                             DetailedScreen(
                              image: snapshot.data![index]['countryInfo']['flag'],
                              name: snapshot.data![index]['country'],
                              totalCases: snapshot.data![index]['cases'],
                              totalDeaths: snapshot.data![index]['deaths'], 
                              totalRecovered: snapshot.data![index]['recovered'],
                              active: snapshot.data![index]['active'],
                              critical: snapshot.data![index]['critical'],
                              todayRecovered: snapshot.data![index]['todayRecovered'],
                              test: snapshot.data![index]['tests'],)));
                            },
                            child: ListTile(
                              leading: Image(
                                height: 50 ,
                                width: 50,
                                image: 
                              NetworkImage(
                                snapshot.data![index]['countryInfo']['flag']
                              ),),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                              ),
                          ),
                        ],
                      );
                      }else if(name.toLowerCase().contains(searchController.toString().toLowerCase())){
                           return Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              DetailedScreen(
                              image: snapshot.data![index]['countryInfo']['flag'],
                              name: snapshot.data![index]['country'],
                              totalCases: snapshot.data![index]['cases'],
                              totalDeaths: snapshot.data![index]['deaths'], 
                              totalRecovered: snapshot.data![index]['recovered'],
                              active: snapshot.data![index]['active'],
                              critical: snapshot.data![index]['critical'],
                              todayRecovered: snapshot.data![index]['todayRecovered'],
                              test: snapshot.data![index]['tests'],))); 
                              
                              
                            },
                            child: ListTile(
                              leading: Image(
                                height: 50 ,
                                width: 50,
                                image: 
                              NetworkImage(
                                snapshot.data![index]['countryInfo']['flag']
                              ),),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                            ),
                          ),
                        ],
                      );
                      }else{
                        return Container();
                      }
                    
                    });
                
                  }
        
                }))
            ]),
          ),
        ),
      ),
    );
  }
}