import 'package:app_emprendimiento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatelessWidget {
  OrderWidget({super.key,
  required this.order,
  required this.orderDateTime});

  List colors = [primaryClr,pinkClr,yellowClr];

  final order;
  final orderDateTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colors[order.color??0],
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.name??"",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${DateFormat.yMd('es_ES').format(orderDateTime).toString()} - ${DateFormat("hh:mm a").format(orderDateTime).toString()}",
                      style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  "\$${order.toPay}",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 20, 
                      color: Colors.grey[100],
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              order.isCompleted == true ? "COMPLETADA" : "EN ESPERA",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}