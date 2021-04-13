import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:team_gp/Model/category.dart';
import 'package:team_gp/Screens/Admin/category/add.dart';
import 'package:team_gp/Screens/Services/categ.dart';
import 'package:team_gp/Screens/Widget/button.dart';
class ViewCategory extends StatefulWidget{

  @override
  _ViewCategoryState createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  final _store = Store();
/*
@override
  void initState() {
    super.initState();
  }
  */
  @override 
  Widget build (BuildContext context)
  { 
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Color(0xfff2cbd0),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      
      backgroundColor: Colors.white, //Colors.pink[50],
      body: StreamBuilder<QuerySnapshot>(
                stream: _store.loadCategory(),
                builder:(context,snapshot)
                {
                  if(snapshot.hasData){
                    List<Category> categories =[];
                        for(var doc in snapshot.data.docs){
                        var data = doc.data();
                        categories.add(Category(
                          name: data['name'],
                          image: data['image'],
                        ));
                      }
        
        return StaggeredGridView.countBuilder(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
            crossAxisCount: 2,
            crossAxisSpacing: 45,
            mainAxisSpacing: 30,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ), 
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),],
                      ),
                child: Stack(
                    children: [
                    Positioned.fill(
                    child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                       child: Image(
                    image: NetworkImage(categories[index].image,),
                    fit: BoxFit.fill,
                    ),
                  ),
                    ),
                    Positioned(
                     bottom: 30,
                     child: Opacity(
                       opacity: 0.9,
                        child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(categories[index].name.toUpperCase(),
                             textAlign: TextAlign.center,
                             style: 
                             TextStyle(color: Color(0xff6a515e),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 1,
                                    height: 2,
                                    ),)
                          ],
                        ),
                    ),
                     ),
                  ),
                    ],
                ),
              );
            },
            staggeredTileBuilder: (index) {
              return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.6);
            }
            );
            }else{
              return Center(
              child:
                Text('Loading....', textAlign: TextAlign.center,style: TextStyle(fontSize: 40.0, color: Color(0xff6a515e),fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,shadows: [Shadow(blurRadius: 10.0,color: Colors.black54,offset: Offset(5.0, 5.0),),Shadow(color: Color(0xFFE0F7FA),blurRadius: 10.0,offset: Offset(-5.0, 5.0),)],letterSpacing: -1.0,wordSpacing: 5.0,),),);
            }
          }
      ),

      
      ////// كا اللي فات دا الهوم بتاع الكاتيجوري

      /* body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadCategory(),
         builder:(context,snapshot)
         {
           if(snapshot.hasData){
             
  List<Category> categories =[];
              for(var doc in snapshot.data.docs){
      var data = doc.data();
      categories.add(Category(
        name: data['name'],
        image: data['image'],
      ));
    }
         return GridView.builder(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.9),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
              child: Stack(
              children: [
                 Positioned.fill(
                    child: Image(
                    image: NetworkImage(categories[index].image,),
                    fit: BoxFit.fill,
                    width: 300,
                   // height: 300,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                     child: Opacity(
                       opacity: 0.7,
                        child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        color: Colors.pink[50],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(categories[index].name,textAlign: TextAlign.center,style: TextStyle(color: Color(0xff6a515e),
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 25),)
                          ],
                        ),
                    ),
                     ),
                  ),
              ],
            ),
          ),
            itemCount: categories.length,
        );
        }else{
          return Center(
      child:
            Text('Loading....', textAlign: TextAlign.center,style: TextStyle(fontSize: 40.0, color: Colors.cyan[900],fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,shadows: [Shadow(blurRadius: 10.0,color: Colors.black54,offset: Offset(5.0, 5.0),),Shadow(color: Color(0xFFE0F7FA),blurRadius: 10.0,offset: Offset(-5.0, 5.0),)],letterSpacing: -1.0,wordSpacing: 5.0,),),);
        
        }
         },
      ), */

      //// دا البوتن بتاع الاد
      
      floatingActionButton: GradientButton(
        width: 70,
        height: 70,
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) => CustomDialog());
        },
      //  child: const Icon(Icons.add, size: 50,),
      //  backgroundColor: Color(0xfff2cbd0),
       // foregroundColor: Color(0xff8f93ea),
       // focusColor: Color(0xff8f93ea),
       text: 
       Text(''),
       icon: Icon(
         Icons.add,
                  color: Colors.white,
                  size: 22,
       ),
      ),
    );
  }
}