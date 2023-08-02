import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity),
  ));
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _disciplinaController = TextEditingController();
  TextEditingController _NotaAPController = TextEditingController();
  TextEditingController _NotaPVController = TextEditingController();
  TextEditingController _NotaEVController = TextEditingController();
  TextEditingController _NotaPPController = TextEditingController();

  void calcular() {
    setState(() {
      const pesoAP = 25;
      const pesoPV = 10;
      const pesoEV = 15;
      const pesoPP = 50;
      const totalPesos = pesoAP + pesoPV + pesoEV + pesoPP;

      dynamic disciplina = _disciplinaController.text;
      dynamic notaAP = double.parse(_NotaAPController.text);
      dynamic notaPV = double.parse(_NotaPVController.text);
      dynamic notaEV = double.parse(_NotaEVController.text);
      dynamic notaPP = double.parse(_NotaPPController.text);

      double totalAP = notaAP * pesoAP;
      double totalPV = notaPV * pesoPV;
      double totalEV = notaEV * pesoEV;
      double totalPP = notaPP * pesoPP;
      double notafinal = (totalAP + totalPV + totalEV + totalPP) / totalPesos;

      if (notafinal >= 5.0) {
        alunoStatus = "Aprovado";
      } else if (notafinal <= 4.9 && notafinal > 3.0) {
        alunoStatus = "Em Recuperação";
      } else {
        alunoStatus = "Reprovado";
      }


      notasAluno = notasAluno + ("\nDisciplina: ${disciplina.toString().toUpperCase()}\nNotas: AP ${notaAP}, PV ${notaPV}, EV ${notaEV}, PP ${notaPP} Média Ponderada ${notafinal}\nSituação: ${alunoStatus}\n");


      mediaT.add(notafinal);
      counter++;
      somamedias = mediaT.reduce((value, element) => value + element) / counter;

      _disciplinaController.clear();
      _NotaAPController.clear();
      _NotaPVController.clear();
      _NotaEVController.clear();
      _NotaPPController.clear();
    });
  }

  void _refresh() {
    setState(() {
      _disciplinaController.clear();
      _NotaAPController.clear();
      _NotaPVController.clear();
      _NotaEVController.clear();
      _NotaPPController.clear();
    });
  }

  void _refreshAll() {
    setState(() {
      notasAluno = "";
      mediaT.clear();
      somamedias = 0;
      counter--;

      if (counter < 0) {
        counter = 0;
      }
    });
  }


  List<double> mediaT = [];
  var counter = 0;
  dynamic somamedias = 0;
  String notasAluno = "";
  String alunoStatus = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Calculadora Média Ponderada IMD"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refresh,
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "ex: Programação front end",
                        labelText: "Disciplina",
                      ),
                      controller: _disciplinaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "insira alguma nota válida";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      maxLength: 4,
                      decoration: InputDecoration(
                        hintText: 'ex: 7,5',
                        labelText: "Nota Atividade Presencial (AP) (peso 25)",
                      ),
                      controller: _NotaAPController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "insira alguma nota válida";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      maxLength: 4,
                      decoration: InputDecoration(
                          labelText:
                              "Nota Participação Virtual (PV) (peso 10)"),
                      controller: _NotaPVController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "insira nota válida";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      maxLength: 4,
                      decoration: InputDecoration(
                          labelText: "Nota Exercicios Virtuais (EV) (peso 15)"),
                      controller: _NotaEVController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "insira alguma nota válida";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      maxLength: 4,
                      decoration: InputDecoration(
                          labelText: "Nota Prova Presencial (PP) (peso 50)"),
                      controller: _NotaPPController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "insira alguma nota válida";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          ElevatedButton(
                              onPressed: calcular,
                              child: Text("Média\nPonderada")),
                          SizedBox(width: 20, height: 20),
                          ElevatedButton(
                              onPressed: _refreshAll,
                              child: Text("Reset\nHistórico")),
                          SizedBox(width: 20, height: 20),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text("Média das Notas do Semestre" +
                                "    ${somamedias.toStringAsFixed(2)}"),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: GridView.builder(
                            itemCount: 1,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                            ),
                            itemBuilder: (context, index) {
                              return Text("${notasAluno}");
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
