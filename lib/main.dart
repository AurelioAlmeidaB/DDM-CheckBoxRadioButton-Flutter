import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const Ddm8App());
}

class Ddm8App extends StatelessWidget {
  const Ddm8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DDM8',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainActivity(),
    );
  }
}

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  final txtProduto = TextEditingController(text: "Produto");

  bool cbBranco = false;
  bool cbPreto = false;
  bool cbVerde = false;

  // null = nenhum tamanho selecionado (no Android é o -1)
  String? rgTamanho;

  String txtResultado = "";
  String txtCores = "";
  String txtTamanho = "";

  void btnEnviar() {
    setState(() {
      txtResultado = txtProduto.text;
      verificaCheckBox();
      verificaRadioButton();
    });
  }

  void verificaCheckBox() {
    final caixa = {"Branco": cbBranco, "Preto": cbPreto, "Verde": cbVerde};

    final elementos = caixa.entries.where((it) => it.value).map((it) => it.key).toList();
    txtCores = elementos.toString();
  }

  void verificaRadioButton() {
    final idSelecionado = rgTamanho;
    if (idSelecionado != null) {
      txtTamanho = idSelecionado;
    } else {
      txtTamanho = "Nenhum tamanho selecionado";
    }
  }

  @override
  void dispose() {
    txtProduto.dispose();
    super.dispose();
  }

  // Texto de resultado: mostra o "hint" em cinza enquanto estiver vazio
  Widget textoResultado(String texto, String hint) {
    final vazio = texto.isEmpty;
    return Text(
      vazio ? hint : texto,
      style: TextStyle(fontSize: 20, color: vazio ? Colors.grey : null),
    );
  }

  Widget checkBox(String texto, bool marcado, ValueChanged<bool?> aoMudar) {
    return CheckboxListTile(
      title: Text(texto),
      value: marcado,
      onChanged: aoMudar,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  Widget radioButton(String texto) {
    return RadioListTile<String>(
      title: Text(texto),
      value: texto,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    const titulo = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: txtProduto,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              const Text("Cores:", style: titulo),
              const SizedBox(height: 8),
              checkBox("Branco", cbBranco, (v) => setState(() => cbBranco = v!)),
              checkBox("Preto", cbPreto, (v) => setState(() => cbPreto = v!)),
              checkBox("Verde", cbVerde, (v) => setState(() => cbVerde = v!)),
              const Text("Tamanho", style: titulo),
              RadioGroup<String>(
                groupValue: rgTamanho,
                onChanged: (v) => setState(() => rgTamanho = v),
                child: Column(
                  children: [
                    radioButton("Grande"),
                    radioButton("Médio"),
                    radioButton("Pequeno"),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: btnEnviar,
                  child: const Text("Enviar", style: TextStyle(fontSize: 25)),
                ),
              ),
              textoResultado(txtResultado, "Resultado"),
              textoResultado(txtCores, "Cores"),
              textoResultado(txtTamanho, "Tamanhos"),
            ],
          ),
        ),
      ),
    );
  }
}
