import 'package:flutter/material.dart';
import 'package:prova_dm/controller/dom_controller.dart';
import 'package:prova_dm/provider/dom_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controllerDominio = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late final DominioController ctlDominioController;
  final List<int> colorCodes = <int>[300, 200, 100];

  final DominioProvider provider = DominioProvider();

  @override
  void initState() {
    super.initState();
    ctlDominioController = DominioController(provider: provider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _controllerDominio,
                        decoration: const InputDecoration(
                          hintText: 'agr.br',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o domínio';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              ctlDominioController
                                  .getDominio(_controllerDominio.text);
                            }
                          },
                          child: const Text('Consultar'),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              AnimatedBuilder(
                  animation: ctlDominioController,
                  builder: (context, child) {
                    return Column(
                      children: [
                        buildTitle('Status:'),
                        Text(ctlDominioController.estatus),
                        const SizedBox(height: 20),
                        buildTitle('Hosts:'),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: ctlDominioController.hosts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50,
                              color: Colors.blue[colorCodes[index]],
                              child: Center(
                                child: Text(
                                  ctlDominioController.hosts[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Column buildTitle(String title) {
    return Column(
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromARGB(255, 1, 67, 121),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
