import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

List<String> disciplina = [];
List<String> avaliacao = [];
List<String> data = [];
List<String> dificuldade = [];
List<String> observacoes = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List pages = [Dashboard(), Listagem(), Registo()];

  int _selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Listagem de avaliações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Registo de avaliação',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 227, 227, 227),
        body: Text('Dashboard'));
  }
}

class Listagem extends StatefulWidget {
  Listagem({Key? key}) : super(key: key);

  @override
  State<Listagem> createState() => _Listagem();
}

class _Listagem extends State<Listagem> {
  var aval = TextEditingController();
  var discip = TextEditingController();
  var dat = TextEditingController();
  var difi = TextEditingController();
  var obs = TextEditingController();

  String current = '';
  int value = 0;

  ElevatedButton btn (String value){
    return ElevatedButton(
      onPressed: () => {
        current = value,
        aval.text = avaliacao[findValues(current)],
        discip.text = disciplina[findValues(current)],
        dat.text = data[findValues(current)],
        difi.text = dificuldade[findValues(current)],
        obs.text = observacoes[findValues(current)],
      },
      child: Text(value),
    );
  }

  ElevatedButton btnEdit (){
    int currentValue;
    return ElevatedButton(
      onPressed: () => {
        currentValue = findValues(current),
        avaliacao[currentValue] = aval.text,
        disciplina[currentValue] = discip.text,
        data[currentValue] = dat.text,
        dificuldade[currentValue] = difi.text,
        observacoes[currentValue] = obs.text,
        value = 0,
        setState((){}),
      },
      child: Text("Editar"),
    );
  }

  ElevatedButton btnDel (){
    int currentValue;
    return ElevatedButton(
      onPressed: () => {
        currentValue = findValues(current),
        avaliacao.removeAt(currentValue),
        disciplina.removeAt(currentValue),
        data.removeAt(currentValue),
        dificuldade.removeAt(currentValue),
        observacoes.removeAt(currentValue),
        value = 0,
        setState((){
          aval.text = "";
          discip.text = "";
          dat.text = "";
          difi.text = "";
          obs.text = "";
        })
      },
      child: Text("Apagar"),
    );
  }

  int findValues(String discip) {
    print(discip);
    for (int i = 0; i < disciplina.length; ++i) {
      if (disciplina[i] == discip) {
        return i;
      }
    }
    return 0;
  }

  String getText() {
    if (disciplina.isEmpty) {
      return '';
    }
    return disciplina[value++];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: btn(getText()),
                );
              },
              itemCount: avaliacao.length,
            ),
            TextFormField(
              controller: aval,
            ),
            TextFormField(
              controller: dat,
            ),
            TextFormField(
              controller: difi,
            ),
            TextFormField(
              controller: obs,
            ),
            btnEdit(),
            btnDel(),
          ],
        ));
  }
}

class Registo extends StatefulWidget {
  Registo({Key? key}) : super(key: key);

  @override
  State<Registo> createState() => _Registo();
}

class _Registo extends State<Registo> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'disciplina', hintText: 'Nome da disciplina'),
              onSaved: (value) => setState(() => disciplina.add(value!)),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'avaliacao', hintText: 'Tipo de avaliação'),
              onSaved: (value) => setState(() => avaliacao.add(value!)),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'data', hintText: 'Data e hora da realização'),
              onSaved: (value) => setState(() => data.add(value!)),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'dificuldade',
                  hintText: 'Nível de dificuldade esperado pelo aluno'),
              onSaved: (value) => setState(() => dificuldade.add(value!)),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'observacoes', hintText: 'Observações (opcional)'),
              onSaved: (value) => setState(() => observacoes.add(value!)),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text('A avaliação foi registada com sucesso.')),
                  );
                  _formKey.currentState?.save();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
