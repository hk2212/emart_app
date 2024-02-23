import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
//import 'package:emart_app/views/orders_secreen/components/orders_status.dart';

import 'package:emart_app/widgets_common/loading_indicator.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(), 
        builder: (BuildContext conext, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIncicatior(),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return "No Orders Yet !".text.color(darkFontGrey).makeCentered();
          }else{
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  leading : "${index + 1}".text.fontFamily(semibold).color(darkFontGrey).make(),
                  title: data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                  subtitle: data[index]['total_amount'].toString().numCurrency.text.color(redColor).fontFamily(bold).make(),
                  );//IconButton(onPressed: (){}     
              }
              );
          }//=> const  OrdersDetails(), icon: const Icon(Icons.arrow_forward_ios_rounded, color: darkFontGrey,)
        },
        ),
    );
  }
}