import 'package:flutter/material.dart';

class RegrasLayout extends StatefulWidget {
  const RegrasLayout({Key? key}) : super(key: key);

  @override
  State<RegrasLayout> createState() => _RegrasLayoutState();
}

class _RegrasLayoutState extends State<RegrasLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" Calculadora Média Ponderada IMD"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: (){},
            ),
          ],
        ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LayoutBuilder(
          builder: (context, constraint){
            var largura = constraint.maxWidth;
            
            if (largura > 600){ 
              return Text("celular");
            }else if (largura < 960){
              return Text("celulares e tablets");
            }else{
              return Text("telas maiores");
            }


            return Container();
          }
        ),
      )



    );
  }
}
