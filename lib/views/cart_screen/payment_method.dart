import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/home_screen/home_screen.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Obx( () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.palcingOrder.value ? 
          Center(
            child: loadingIncicatior(),
          )
          : ourButton(
            onPress: () async{
            await controller.placeMyOrder(orderPaymentMethod: paymentMethods[controller.paymentIndex.value],
             totalAmount: controller.totalP.value);

             await controller.clearCart();
            // VxToast.show(context, msg:"Oder Placed Sucessfully");
              Get.offAll(const HomeScreen());

            },
            color: redColor,
            textColor: whiteColor,
            title: "Place my Order",
          ),
        ),
        appBar: AppBar(
          title: "Choose Payment Method".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx( () =>  Column(
              children: List.generate(paymentMethodsImgs.length,(index){
                return GestureDetector(
                  onTap: (){
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: controller.paymentIndex.value == index ? redColor : Colors.transparent,
                        width: 4,
                      )
                    ),
                    margin:const EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                      Image.asset(paymentMethodsImgs[index],
                      width: double.infinity,
                      height: 120,
                      colorBlendMode: controller.paymentIndex.value == index ?  BlendMode.darken : BlendMode.color,
                      color: controller.paymentIndex.value == index ? Colors.black.withOpacity(0.4) : Colors.transparent,
                      fit: BoxFit.cover,
                      ),
                     controller.paymentIndex.value == index ? Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                        activeColor: Colors.green,
                        value: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                         onChanged: (value) {}),
                      ) : Container(),
                      
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: paymentMethods[index].text.white.fontFamily(semibold).size(16).make()),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
    
      ),
    );
  }
}