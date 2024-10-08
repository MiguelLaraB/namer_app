import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xf6f4fe)),
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class ModelPage extends StatefulWidget {
  @override
  State<ModelPage> createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  final ageController = TextEditingController();
  final sexController = TextEditingController();
  final cpController = TextEditingController();
  final trestbpsController = TextEditingController();
  final cholController = TextEditingController();
  final fbsController = TextEditingController();
  final restecgController = TextEditingController();
  final thalachController = TextEditingController();
  final exangController = TextEditingController();
  final oldpeakController = TextEditingController();
  final slopeController = TextEditingController();
  final caController = TextEditingController();
  final thalController = TextEditingController();

  @override
  void dispose() {
    ageController.dispose();
    sexController.dispose();
    cpController.dispose();
    trestbpsController.dispose();
    cholController.dispose();
    fbsController.dispose();
    restecgController.dispose();
    thalachController.dispose();
    exangController.dispose();
    oldpeakController.dispose();
    slopeController.dispose();
    caController.dispose();
    thalController.dispose();
    super.dispose();
  }

void showResultDialog(BuildContext context, String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Prediction Result'),
          content: Text(result),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Age',
                ),
              ),
            ),
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: sexController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Sex (1 = Male, 0 = Female)',
                ),
              ),
            ),
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: cpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Chest Pain Type (cp)',
                ),
              ),
            ),
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: trestbpsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Resting Blood Pressure (trestbps)',
                ),
              ),
            ),
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: cholController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Cholesterol (chol)',
                ),
              ),
            ),
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: fbsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Fasting Blood Sugar (fbs)',
                ),
              ),
            ),
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: restecgController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Resting ECG Results (restecg)',
                ),
              ),
            ),
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: thalachController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Max Heart Rate Achieved (thalach)',
                ),
              ),
            ),
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: exangController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Exercise Induced Angina (exang)',
                ),
              ),
            ),
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: oldpeakController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'ST Depression (oldpeak)',
                ),
              ),
            ),
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: slopeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Slope of Peak Exercise ST Segment (slope)',
                ),
              ),
            ),
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: caController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Number of Major Vessels (ca)',
                ),
              ),
            ),
            Container(
              width: 300, // Establecer un ancho específico
              child: TextField(
                controller: thalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Thalassemia (thal)',
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
  onPressed: () async {
    String result = await appState.callModel(
      ageController.text,
      sexController.text,
      cpController.text,
      trestbpsController.text,
      cholController.text,
      fbsController.text,
      restecgController.text,
      thalachController.text,
      exangController.text,
      oldpeakController.text,
      slopeController.text,
      caController.text,
      thalController.text,
    );
    showResultDialog(context, result); // Usa el resultado capturado
  },
  child: Text('Predict'),
),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[];

  GlobalKey? historyListKey;

Future<String> callModel(
    String age,
    String sex,
    String cp,
    String trestbps,
    String chol,
    String fbs,
    String restecg,
    String thalach,
    String exang,
    String oldpeak,
    String slope,
    String ca,
    String thal) async {
  final url = Uri.parse("https://fastapiml-latest-8e1o.onrender.com/score");
  final headers = {"Content-Type": "application/json;charset=UTF-8"};
  print('hello model...');
  try {
    final prediction_instance = {
      "age": int.parse(age),
      "sex": int.parse(sex),
      "cp": int.parse(cp),
      "trestbps": int.parse(trestbps),
      "chol": int.parse(chol),
      "fbs": int.parse(fbs),
      "restecg": int.parse(restecg),
      "thalach": int.parse(thalach),
      "exang": int.parse(exang),
      "oldpeak": double.parse(oldpeak),
      "slope": int.parse(slope),
      "ca": int.parse(ca),
      "thal": int.parse(thal)
    };
    final res = await http.post(url,
        headers: headers, body: jsonEncode(prediction_instance));
    if (res.statusCode == 200) {
      final json_prediction = res.body; // Puedes convertir esto a un objeto si es necesario
      return json_prediction.toString(); // Devuelve el resultado
    } else {
      print('Error: ${res.statusCode}');
      return 'Error: ${res.statusCode}'; // Devuelve un mensaje de error
    }
  } catch (e) {
    print('Error: ${e.toString()}');
    return 'Error: ${e.toString()}'; // Devuelve un mensaje de error
  }
}

  void getNext() {
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }

  Future<String> triggerGitHubWorkflow(String sha, String datasetUrl) async {
    final workflowUrl = "https://api.github.com/repos/MiguelLaraB/heart-model/dispatches";
    final headers = {
      "Authorization": "Bearer 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", // Reemplaza con tu token de acceso
      "Accept": "application/vnd.github.v3+json",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "event_type": "flutter_deploy",
      "client_payload": {
        "sha": sha, // El sha que desees enviar
        "dataseturl": datasetUrl, // La URL del dataset
      },
    });

    try {
      final res = await http.post(Uri.parse(workflowUrl), headers: headers, body: body);
      if (res.statusCode == 204) {
        return "Workflow iniciado exitosamente.";
      } else {
        return "Error al iniciar el workflow: ${res.body}";
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = ModelPage();
        break;
      case 3:
        page = RetrainPage(appState: MyAppState());
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            // Use a more mobile-friendly layout with BottomNavigationBar
            // on narrow screens.
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .surface, // Asegura el color de fondo
                    type: BottomNavigationBarType.fixed,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: 'Favorites',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.rocket),
                        label: 'Model',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.rocket_launch),
                        label: 'Retrain',
                      )
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite),
                        label: Text('Favorites'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.rocket),
                        label: Text('Model'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.rocket_launch),
                        label: Text('Retrain'),
                      )
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: HistoryListView(),
          ),
          SizedBox(height: 10),
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: Duration(milliseconds: 200),
          // Make sure that the compound word wraps correctly when the window
          // is too narrow.
          child: MergeSemantics(
            child: Wrap(
              children: [
                Text(
                  pair.first,
                  style: style.copyWith(fontWeight: FontWeight.w200),
                ),
                Text(
                  pair.second,
                  style: style.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        Expanded(
          // Make better use of wide windows with a grid.
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 400 / 80,
            ),
            children: [
              for (var pair in appState.favorites)
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.delete_outline, semanticLabel: 'Delete'),
                    color: theme.colorScheme.primary,
                    onPressed: () {
                      appState.removeFavorite(pair);
                    },
                  ),
                  title: Text(
                    pair.asLowerCase,
                    semanticsLabel: pair.asPascalCase,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class HistoryListView extends StatefulWidget {
  const HistoryListView({Key? key}) : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  /// Needed so that [MyAppState] can tell [AnimatedList] below to animate
  /// new items.
  final _key = GlobalKey();

  /// Used to "fade out" the history items at the top, to suggest continuation.
  static const Gradient _maskingGradient = LinearGradient(
    // This gradient goes from fully transparent to fully opaque black...
    colors: [Colors.transparent, Colors.black],
    // ... from the top (transparent) to half (0.5) of the way to the bottom.
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      // This blend mode takes the opacity of the shader (i.e. our gradient)
      // and applies it to the destination (i.e. our animated list).
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        itemBuilder: (context, index, animation) {
          final pair = appState.history[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  appState.toggleFavorite(pair);
                },
                icon: appState.favorites.contains(pair)
                    ? Icon(Icons.favorite, size: 12)
                    : SizedBox(),
                label: Text(
                  pair.asLowerCase,
                  semanticsLabel: pair.asPascalCase,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RetrainPage extends StatefulWidget {
 final MyAppState appState; // Agregar un campo para MyAppState

  // Constructor que acepta appState
  RetrainPage({required this.appState});

  @override
  State<RetrainPage> createState() => _RetrainPageState();
}

class _RetrainPageState extends State<RetrainPage> {
  final shaController = TextEditingController();
  final urlController = TextEditingController();

  @override
  void dispose() {
    shaController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: TextField(
                controller: shaController,
                decoration: InputDecoration(
                  hintText: 'sha(etiqueta de versión)', // Placeholder
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              child: TextField(
                controller: urlController,
                decoration: InputDecoration(
                  hintText: 'url', // Placeholder
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String sha = shaController.text; // Captura el sha
                String datasetUrl = urlController.text; // Captura la url

                // Usar appState desde widget
                String workflowResult = await widget.appState.triggerGitHubWorkflow(sha, datasetUrl);
                
                // Muestra el resultado del workflow
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Resultado del Workflow'),
                      content: Text(workflowResult),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Cierra el diálogo
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}


  