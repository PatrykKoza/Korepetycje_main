import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/models/cartitem.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/models/useerr.dart';
import 'package:flutter_app2/models/userr.dart';
import 'package:flutter_app2/screens/home/appbar.dart';
import 'package:flutter_app2/screens/home/lessonl_ist.dart';
import 'package:flutter_app2/screens/home/my_products/products.dart';
import 'package:flutter_app2/screens/home/settings.dart';
import 'package:flutter_app2/services/auth.dart';
import 'package:flutter_app2/utilities/constants.dart';
import 'package:flutter_app2/screens/authenticate/sign_up_screen.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel, EventList;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_app2/screens/home/cart.dart';
import 'package:flutter_app2/services/database.dart';
import 'package:provider/provider.dart';

import 'brews_list.dart';


class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  final DataBaseService _db = DataBaseService();
  String category = "Wszystko";

  int _selectedIndex = 0;

  //tu chyba baze danych trzeba
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Color(0xFFECB6B6),
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
        ),
      ],
    },
  );

  DateTime _currentDate = new DateTime.now();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String dropdownValue = 'Wszystko';
  Widget _menuScreen() {
      return Container(
        child: Column(children:<Widget> [
          _dropDownCategory(),
          Expanded(
            child:LesonList(),
            ),
        ],),
      );
  }

  Widget _cartScreen(BuildContext context) {
    final user = Provider.of<Userr>(context);
     return StreamProvider<List<CartItem>>.value(
       value: _db.cartItemOwner(user.uid),
       initialData: [],
        child: Column(children:<Widget> [
        Expanded(
          child:CartPage(),
        ),
      ],),
     );

    // return Container(
    //   child: Column(children:<Widget> [
    //     Expanded(
    //       child:CartPage(),
    //     ),
    //   ],),
    // );
  }

  Widget _myProducts(BuildContext context){
      final user = Provider.of<Userr>(context);
      return StreamProvider<List<Product>>.value(
      value: _db.productOwner(user.uid),
      initialData: [],
      child: Column(children:<Widget> [
         Expanded(
           child:Products(),
        ),
      ],
    ),
    );
  }

  Widget _dropDownCategory(){
    return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('category').snapshots(),
    builder: (context, snapshot){
      if (!snapshot.hasData) return const Center(
        child: const CupertinoActivityIndicator(),
      );
      return new Container(
        child: new Row(
          children: <Widget>[
            new Expanded(
                flex: 2,
                child: new Container(
                  padding: EdgeInsets.fromLTRB(17.0,10.0,10.0,10.0),
                  child: new Text("Category"),
                )
            ),
            new Expanded(
              flex: 3,
              child:new InputDecorator(
                decoration: const InputDecoration(
                  hintText: 'Choose an category',
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.normal,
                  ),
                ),
                isEmpty: category == null,
                child: new DropdownButton(
                  value: category,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      category = newValue;
                      dropdownValue =newValue;
                    });
                  },
                  items: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new DropdownMenuItem<String>(
                        value: document.data()['category_name'],
                        child: new Container(
                          height: 30.0,
                          padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                          child: new Text(document.data()['category_name']),
                        )
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    }
  );
}

  Widget _calendarScreen() {
    return Container(
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _currentDate = date);
        },
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.grey,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
        selectedDayButtonColor: Color(0xFFECB6B6),
        selectedDayBorderColor: Color(0xFFECB6B6),
        selectedDayTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        customDayBuilder: (   /// you can provide your own build function to make custom day containers
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,
            ) {
          /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
          /// This way you can build custom containers for specific days only, leaving rest as default.

          // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
          if (day.day == 15) {
            return Center(
              child: Icon(Icons.local_airport),
            );
          } else {
            return null;
          }
        },
        weekFormat: false,
        markedDatesMap: _markedDateMap,
        height: 620.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  Widget _selectScreen(BuildContext context){
    if(_selectedIndex == 0) return _menuScreen(); 
    if(_selectedIndex == 2) return _myProducts(context);
    if(_selectedIndex == 3) return _cartScreen(context);
      else return _calendarScreen();
  }

 @override
  Widget build(BuildContext context){
    final user = Provider.of<Userr>(context);

    return StreamProvider<List<Product>>.value(
    value: _db.productCat(category),
    initialData: [],
    child: Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/tlo.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _selectScreen(context),
           ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ogłoszenie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Kalendarz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Moje',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Koszyk',
          ),
        ],
        currentIndex: _selectedIndex,
        iconSize: 30,
        unselectedItemColor: Color(0xFF3B3A3A),
        selectedItemColor: Color(0xFFECB6B6),
        onTap: _onItemTapped,
      ),
      
     // ),////////jak cos dac koma
      appBar: BaseAppBar(
          title: Text('title'),
          appBar: AppBar(),
          widgets: <Widget>[Icon(Icons.more_vert)],
        ),
    ),
    );
  }
}

