import 'package:flutter/material.dart';


typedef OnDaySelect = void Function(DateTime selectDay);

class Calander extends StatefulWidget {
  
  /* User Parameters.
    year,
    Focused Date,
    Focused Date highlight color,
    MonthStyle,
    DayStyle,
    DateStyle,
    onDaySelect func.
  */
  
  final DateTime focusedDate;
  final int year;
  final OnDaySelect? onDaySelect;

  const Calander({
    super.key,
    required this.focusedDate,
    required this.year,
    this.onDaySelect
  });

  @override
  State<Calander> createState() => _CalanderState();
}

class _CalanderState extends State<Calander> {
  
  @override
  Widget build(BuildContext context) {
    
    // ScreenSize
    final Size size = MediaQuery.of(context).size;

    // Full Year Calander View.
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height*0.8,
        child: ListView.builder(
          itemCount: 12,
          itemBuilder: (context, index){
             // Month Wise Calander View;
             return Column(
                children: [
                    MonthlyCalView(
                        focusedDate: widget.focusedDate,
                        month: index, 
                        year: widget.year,
                        onDaySelect: widget.onDaySelect,
                    ),
                    const SizedBox(height: 50,)
                ]);
          }
        ),
      )
    );
  }
}

class MonthlyCalView extends StatelessWidget {
  const MonthlyCalView({
    super.key,
    required this.focusedDate,
    required this.month,
    required this.year,
    this.onDaySelect
  });
    
  // final List<int> monthDayCount;
  final DateTime focusedDate;
  final int month;
  final int year;
  final OnDaySelect? onDaySelect;

  @override
  Widget build(BuildContext context) {
    // Total days in a month
    List<int> monthDayCount; 
    if(year%400==0){
        monthDayCount = [31,29,31,30,31,30,31,31,30,31,30,31];
    }else if(year%4==0 && year%100!=0){
        monthDayCount = [31,29,31,30,31,30,31,31,30,31,30,31];
    }else{
        monthDayCount = [31,28,31,30,31,30,31,31,30,31,30,31];
    }

    // WeekDay Initials
    List<String> dayInitials = ["M", "T", "W", "T", "F", "S", "S"];
    
    // Month Descriptions 
    List<String> monthDesc = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    
    // Weekday for 1st of the month.
    var startDay = DateTime(year, month+1, 1).weekday;
    
    return Container(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(
                monthDesc[month] + " " + year.toString(),
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                )),
      
              Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(top: 20),
                height: 250,
                child: GridView.count(
                  crossAxisCount: 7,
                  childAspectRatio: 3.5/3,
                  children: List.generate(7 + startDay-1 + monthDayCount[month], (ind){
                      if(ind < 7){
                        return Text(dayInitials[ind]);
                      }else if(ind - 6 < startDay){
                        return const Text("");
                      }else{
                        DateTime date = DateTime(year, month + 1, (ind - 5 - startDay));
                        
                        if(date.day.toString() == focusedDate.day.toString() && (month+1) == focusedDate.month && year == focusedDate.year){
                           return GestureDetector(
                             child: Text(
                                  (date.day).toString(),
                                  style: TextStyle(
                                      color: Colors.white,  
                                      background: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..color = Colors.black
                                      ..strokeJoin = StrokeJoin.round
                                      ..strokeWidth = 18
                                  ),
                              ),
                              onTap: (){
                                onDaySelect?.call(date);
                              },
                           );
                        } else {
                          return GestureDetector(
                            onTap: (){
                                onDaySelect?.call(date);
                            },
                            child: Text((date.day).toString())
                          );
                        }
                      }
                  })
                )  
              ),
        ],
      ),
    );
  }
}
