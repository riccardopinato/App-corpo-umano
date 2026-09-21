import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'histology.dart';
import 'deep_dive.dart';
import 'smart_study.dart';
import 'games_v2.dart';
import 'content_expansion.dart';
import 'release_center.dart';

void main() => runApp(const HumanBodyApp());

class HumanBodyApp extends StatelessWidget {
  const HumanBodyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF5B4BCE), brightness: Brightness.light);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'edu_01',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: const Color(0xFFF7F7FC),
        cardTheme: CardThemeData(
          elevation: 0,
          color: const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(color: Color(0xFF191923), fontSize: 24, fontWeight: FontWeight.w900),
        ),
        navigationBarTheme: const NavigationBarThemeData(height: 72, elevation: 0, backgroundColor: Colors.white),
      ),
      home: const MainShell(),
    );
  }
}

class BodySystem {
  final String name, emoji, subtitle;
  final List<String> parts;
  const BodySystem(this.name, this.emoji, this.subtitle, this.parts);
}

const systems = <BodySystem>[
  BodySystem('Scheletrico','🦴','206 ossa · articolazioni · legamenti',['Cranio','Colonna vertebrale','Gabbia toracica','Bacino','Arti superiori','Arti inferiori']),
  BodySystem('Muscolare','💪','120+ muscoli e gruppi',['Deltoide','Bicipite','Tricipite','Pettorale','Retto addominale','Quadricipite','Ischiocrurali','Gastrocnemio']),
  BodySystem('Nervoso','🧠','SNC · SNP · nervi cranici e spinali',['Cervello','Cervelletto','Tronco encefalico','Midollo spinale','Nervi periferici']),
  BodySystem('Cardiovascolare','❤️','Cuore · arterie · vene · capillari',['Cuore','Aorta','Carotidi','Vene cave','Coronarie']),
  BodySystem('Respiratorio','🫁','Vie aeree · polmoni · alveoli',['Naso','Faringe','Laringe','Trachea','Bronchi','Polmoni','Alveoli']),
  BodySystem('Digerente','🍎','Digestione e assorbimento',['Bocca','Esofago','Stomaco','Fegato','Pancreas','Intestino tenue','Colon']),
  BodySystem('Urinario','💧','Reni · nefroni · vie urinarie',['Reni','Ureteri','Vescica','Uretra','Nefrone']),
  BodySystem('Immunitario','🛡️','Linfa · difesa · ematopoiesi',['Timo','Milza','Linfonodi','Midollo osseo']),
  BodySystem('Endocrino','⚗️','Ormoni e omeostasi',['Ipofisi','Tiroide','Paratiroidi','Surreni','Pancreas endocrino']),
  BodySystem('Tegumentario','🖐️','Cute e annessi',['Epidermide','Derma','Ipoderma','Peli','Unghie','Ghiandole']),
  BodySystem('Riproduttivo','🧬','Anatomia riproduttiva',['Utero','Ovaie','Tube uterine','Testicoli','Prostata']),
];

const advanced = <Map<String,String>>[
  {'e':'💀','t':'Suture craniche','s':'Coronale · sagittale · lambdoidea · squamosa'},
  {'e':'⭕','t':'Forami cranici','s':'Forame magno · canale ottico · ovale · rotondo · giugulare'},
  {'e':'🦴','t':'Colonna vertebrale','s':'C1 Atlante · C2 Epistrofeo · C3-C7 · T1-T12 · L1-L5 · sacro · coccige'},
  {'e':'✋','t':'Mano','s':'8 carpali · 5 metacarpali · 14 falangi · tunnel carpale'},
  {'e':'🦶','t':'Piede','s':'7 tarsali · 5 metatarsali · 14 falangi · fascia plantare'},
  {'e':'🧵','t':'Legamenti e fasce','s':'LCA · LCP · collaterali · ileofemorale · deltoideo · fascia toracolombare'},
  {'e':'🧠','t':'12 nervi cranici','s':'I olfattivo · II ottico · III oculomotore · IV trocleare · V trigemino · VI abducente · VII faciale · VIII vestibolococleare · IX glossofaringeo · X vago · XI accessorio · XII ipoglosso'},
  {'e':'⚡','t':'Plessi nervosi','s':'Cervicale · brachiale · lombare · sacrale'},
  {'e':'🔴','t':'Albero arterioso','s':'Aorta · carotidi · succlavie · viscerali · iliache · femorali'},
  {'e':'🔵','t':'Sistema venoso','s':'Cave · giugulari · succlavie · porta · femorali · safene'},
];

const physiology = <Map<String,String>>[
  {'e':'🩸','t':'Il viaggio del sangue','s':'Tessuti|Cuore destro|Polmoni|Cuore sinistro|Aorta'},
  {'e':'🌬️','t':'Il percorso dell’aria','s':'Naso|Faringe|Laringe|Trachea|Bronchi|Alveoli'},
  {'e':'🍎','t':'Il viaggio del cibo','s':'Bocca|Esofago|Stomaco|Duodeno|Intestino tenue|Colon'},
  {'e':'💧','t':'Come lavora il nefrone','s':'Glomerulo|Capsula di Bowman|Tubulo prossimale|Ansa di Henle|Tubulo distale|Dotto collettore'},
  {'e':'⚡','t':'Impulso nervoso','s':'Riposo|Soglia|Depolarizzazione|Ripolarizzazione|Iperpolarizzazione'},
  {'e':'🔗','t':'Trasmissione sinaptica','s':'Potenziale d’azione|Ingresso Ca²⁺|Vescicole|Fessura sinaptica|Recettori'},
  {'e':'💪','t':'Contrazione muscolare','s':'Motoneurone|ACh|Ca²⁺|Troponina|Actina e miosina|Accorciamento'},
  {'e':'❤️','t':'Ciclo cardiaco','s':'Riempimento|Sistole atriale|Contrazione isovolumetrica|Eiezione|Rilasciamento'},
  {'e':'⚗️','t':'Asse endocrino','s':'Ipotalamo|Ipofisi|Ormone trofico|Ghiandola bersaglio|Feedback negativo'},
];

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int tab = 0;
  final StudyProgressStore studyStore = StudyProgressStore();

  @override
  void initState() {
    super.initState();
    studyStore.addListener(_onStudyChange);
    studyStore.initialize();
  }

  void _onStudyChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    studyStore.removeListener(_onStudyChange);
    studyStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      TodayPage(answered: studyStore.totalAnswers, correct: studyStore.totalCorrect, openStudy: () => setState(() => tab = 3)),
      const LearnPage(),
      const AtlasPage(),
      SmartStudyV2Page(store: studyStore),
      ProfilePage(answered: studyStore.totalAnswers, correct: studyStore.totalCorrect, studyStore: studyStore),
    ];
    return Scaffold(
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.today_outlined), selectedIcon: Icon(Icons.today), label: 'Oggi'),
          NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'Impara'),
          NavigationDestination(icon: Icon(Icons.accessibility_new_outlined), selectedIcon: Icon(Icons.accessibility_new), label: 'Atlante'),
          NavigationDestination(icon: Icon(Icons.psychology_outlined), selectedIcon: Icon(Icons.psychology), label: 'Studio'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profilo'),
        ],
      ),
    );
  }
}

class TodayPage extends StatelessWidget {
  final int answered, correct;
  final VoidCallback openStudy;
  const TodayPage({super.key, required this.answered, required this.correct, required this.openStudy});
  @override
  Widget build(BuildContext context) {
    final acc = answered == 0 ? '—' : (correct * 100 ~/ answered).toString() + '%';
    return Scaffold(
      appBar: AppBar(title: const Text('Oggi')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18,4,18,32),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors:[Color(0xFF6250E6),Color(0xFF8C7CF3)]),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
              Text('Continua a conoscere il corpo umano',style:TextStyle(color:Colors.white,fontSize:23,fontWeight:FontWeight.w900)),
              SizedBox(height:14),
              LinearProgressIndicator(value:.35,minHeight:11,backgroundColor:Colors.white24),
              SizedBox(height:10),
              Text('Obiettivo di oggi · anatomia + fisiologia + ripasso',style:TextStyle(color:Colors.white70)),
            ]),
          ),
          const SizedBox(height:18),
          ActionCard(emoji:'⚡',title:'Quiz rapido',subtitle:'Domande miste da tutto il corpo umano',onTap:openStudy),
          const SizedBox(height:10),
          ActionCard(emoji:'🫀',title:'Fisiologia interattiva',subtitle:'9 processi spiegati passo-passo',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const PhysiologyPage()))),
          const SizedBox(height:10),
          ActionCard(emoji:'🎮',title:'Anatomy Games',subtitle:'Riconoscimento anatomico e sfide',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const GamesHubPage()))),
          const SizedBox(height:24),
          const Text('In numeri',style:TextStyle(fontSize:22,fontWeight:FontWeight.w900)),
          const SizedBox(height:10),
          Row(children:[
            Expanded(child:Metric(value:answered.toString(),label:'Risposte',emoji:'🧠')),
            const SizedBox(width:8),
            Expanded(child:Metric(value:acc,label:'Precisione',emoji:'🎯')),
            const SizedBox(width:8),
            const Expanded(child:Metric(value:'206',label:'Ossa',emoji:'🦴')),
          ]),
        ],
      ),
    );
  }
}

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Impara')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18,4,18,32),
        children: [
          FeatureCard(color:const Color(0xFFDDF3FF),emoji:'🫀',title:'Fisiologia interattiva',subtitle:'Cuore, respirazione, digestione, rene, neuroni e muscoli',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const PhysiologyPage()))),
          const SizedBox(height:10),
          FeatureCard(color:const Color(0xFFFFE5E4),emoji:'🎮',title:'Anatomy Games',subtitle:'Impara giocando con il database anatomico',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const GamesHubPage()))),
          const SizedBox(height:10),
          FeatureCard(color:const Color(0xFFE8F0FF),emoji:'🧬',title:'Anatomia avanzata',subtitle:'Cranio, colonna, mano, piede, legamenti, nervi e vasi',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const AdvancedPage()))),
          const SizedBox(height:10),
          FeatureCard(color:const Color(0xFFE5F7F2),emoji:'🔬',title:'Istologia & cellule',subtitle:'Tessuti, cellule, organelli e percorsi corpo → organo → cellula',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const HistologyHubPage()))),
          const SizedBox(height:10),
          FeatureCard(color:const Color(0xFFF0E8FF),emoji:'🔎',title:'Deep Dive anatomico',subtitle:'Entra dentro cuore, cervello, polmoni, reni, fegato e altri organi',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const DeepDiveHubPage()))),
          const SizedBox(height:10),
          FeatureCard(color:const Color(0xFFFFF0DD),emoji:'📚',title:'Catalogo completo',subtitle:'Muscoli, articolazioni, legamenti, linfatico, riproduttivo e dentizione decidua',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const ExpandedContentPage()))),
          const SizedBox(height:24),
          const Text('11 sistemi del corpo',style:TextStyle(fontSize:22,fontWeight:FontWeight.w900)),
          const SizedBox(height:10),
          ...systems.map((s)=>Padding(
            padding: const EdgeInsets.only(bottom:8),
            child: Card(child:ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: Text(s.emoji,style:const TextStyle(fontSize:34)),
              title: Text(s.name,style:const TextStyle(fontWeight:FontWeight.w900)),
              subtitle: Text(s.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>SystemDetail(system:s))),
            )),
          )),
          const SizedBox(height:8),
          Card(child:ListTile(
            contentPadding:const EdgeInsets.all(16),
            leading:const Text('🦷',style:TextStyle(fontSize:34)),
            title:const Text('I 32 denti permanenti',style:TextStyle(fontWeight:FontWeight.w900)),
            subtitle:const Text('Numerazione FDI · anatomia interna'),
            trailing:const Icon(Icons.chevron_right),
            onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const TeethPage())),
          )),
        ],
      ),
    );
  }
}

class SystemDetail extends StatelessWidget {
  final BodySystem system;
  const SystemDetail({super.key, required this.system});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text(system.emoji + ' ' + system.name)),
      body:ListView(
        padding:const EdgeInsets.all(18),
        children:[
          Container(
            padding:const EdgeInsets.all(22),
            decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(28)),
            child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text(system.emoji,style:const TextStyle(fontSize:54)),
              const SizedBox(height:8),
              Text(system.name,style:const TextStyle(fontSize:27,fontWeight:FontWeight.w900)),
              const SizedBox(height:6),
              Text(system.subtitle),
            ]),
          ),
          const SizedBox(height:22),
          const Text('Strutture principali',style:TextStyle(fontSize:21,fontWeight:FontWeight.w900)),
          const SizedBox(height:8),
          ...system.parts.map((o)=>Card(child:ListTile(
            leading:Text(system.emoji),
            title:Text(o,style:const TextStyle(fontWeight:FontWeight.w800)),
            subtitle:const Text('Struttura inclusa nel catalogo anatomico edu_01.'),
          ))),
        ],
      ),
    );
  }
}

class AtlasPage extends StatefulWidget {
  const AtlasPage({super.key});
  @override
  State<AtlasPage> createState() => _AtlasPageState();
}

class AtlasLayerData {
  final String id, label, emoji, assetPath, credit;
  final double aspectRatio;
  final List<AtlasHotspot> hotspots;
  const AtlasLayerData({
    required this.id,
    required this.label,
    required this.emoji,
    required this.assetPath,
    required this.credit,
    required this.aspectRatio,
    required this.hotspots,
  });
}

class AtlasHotspot {
  final String name, subtitle, emoji;
  final double x, y;
  const AtlasHotspot(this.name, this.subtitle, this.emoji, this.x, this.y);
}

class _AtlasPageState extends State<AtlasPage> {
  int layerIndex = 0;
  bool showLabels = true;
  String query = '';
  final TransformationController _transform = TransformationController();
  Size _canvasSize = const Size(360, 600);

  static const layers = <AtlasLayerData>[
    AtlasLayerData(
      id:'organs', label:'Organi', emoji:'🫀',
      assetPath:'assets/anatomy/organs.svg',
      credit:'Mikael Häggström · pubblico dominio',
      aspectRatio:1.124,
      hotspots:[
        AtlasHotspot('Cervello','Sistema nervoso','🧠',.50,.105),
        AtlasHotspot('Tiroide','Sistema endocrino','🦋',.50,.235),
        AtlasHotspot('Polmone destro','Sistema respiratorio','🫁',.43,.345),
        AtlasHotspot('Polmone sinistro','Sistema respiratorio','🫁',.57,.345),
        AtlasHotspot('Cuore','Sistema cardiovascolare','❤️',.52,.405),
        AtlasHotspot('Fegato','Sistema digerente','🟤',.42,.515),
        AtlasHotspot('Stomaco','Sistema digerente','🥣',.58,.535),
        AtlasHotspot('Milza','Sistema immunitario','🛡️',.64,.525),
        AtlasHotspot('Pancreas','Sistema digerente/endocrino','🟡',.53,.575),
        AtlasHotspot('Rene destro','Sistema urinario','🫘',.43,.59),
        AtlasHotspot('Rene sinistro','Sistema urinario','🫘',.57,.59),
        AtlasHotspot('Intestino tenue','Sistema digerente','➰',.50,.70),
        AtlasHotspot('Colon','Sistema digerente','🟫',.50,.745),
        AtlasHotspot('Vescica','Sistema urinario','💧',.50,.87),
      ],
    ),
    AtlasLayerData(
      id:'skeleton', label:'Scheletro', emoji:'🦴',
      assetPath:'assets/anatomy/skeleton.svg',
      credit:'Human body diagrams · Wikimedia Commons',
      aspectRatio:.720,
      hotspots:[
        AtlasHotspot('Cranio','Scheletro assile','💀',.50,.085),
        AtlasHotspot('Mandibola','Cranio viscerale','🦴',.50,.135),
        AtlasHotspot('Clavicola','Cintura scapolare','🦴',.50,.205),
        AtlasHotspot('Scapola','Cintura scapolare','🦴',.36,.235),
        AtlasHotspot('Sterno','Scheletro assile','🦴',.50,.285),
        AtlasHotspot('Coste','Gabbia toracica','🦴',.50,.315),
        AtlasHotspot('Colonna cervicale','C1-C7','🦴',.50,.18),
        AtlasHotspot('Colonna toracica','T1-T12','🦴',.50,.34),
        AtlasHotspot('Colonna lombare','L1-L5','🦴',.50,.49),
        AtlasHotspot('Omero','Arto superiore','🦴',.28,.34),
        AtlasHotspot('Radio','Avambraccio','🦴',.19,.46),
        AtlasHotspot('Ulna','Avambraccio','🦴',.22,.46),
        AtlasHotspot('Carpo','8 ossa per mano','✋',.13,.56),
        AtlasHotspot('Metacarpo','5 ossa per mano','✋',.12,.59),
        AtlasHotspot('Falangi mano','14 per mano','✋',.11,.63),
        AtlasHotspot('Bacino','Cintura pelvica','🦴',.50,.57),
        AtlasHotspot('Sacro','Colonna sacrale','🦴',.50,.59),
        AtlasHotspot('Femore','Coscia','🦴',.43,.70),
        AtlasHotspot('Rotula','Ginocchio','🦴',.43,.79),
        AtlasHotspot('Tibia','Gamba','🦴',.43,.865),
        AtlasHotspot('Fibula','Gamba','🦴',.39,.865),
        AtlasHotspot('Tarso','7 ossa per piede','🦶',.41,.955),
        AtlasHotspot('Metatarso','5 ossa per piede','🦶',.40,.975),
      ],
    ),
    AtlasLayerData(
      id:'muscles', label:'Muscoli', emoji:'💪',
      assetPath:'assets/anatomy/muscles.svg',
      credit:'OpenStax + Tomáš Kebert / umimeto.org · CC BY-SA 4.0',
      aspectRatio:1.148,
      hotspots:[
        AtlasHotspot('Sternocleidomastoideo','Collo anteriore','💪',.245,.18),
        AtlasHotspot('Deltoide','Spalla','💪',.175,.245),
        AtlasHotspot('Grande pettorale','Torace anteriore','💪',.25,.31),
        AtlasHotspot('Bicipite brachiale','Braccio anteriore','💪',.15,.37),
        AtlasHotspot('Retto dell’addome','Addome','💪',.25,.46),
        AtlasHotspot('Obliquo esterno','Addome laterale','💪',.18,.47),
        AtlasHotspot('Quadricipite','Coscia anteriore','💪',.22,.69),
        AtlasHotspot('Tibiale anteriore','Gamba anteriore','💪',.22,.86),
        AtlasHotspot('Trapezio','Dorso','💪',.74,.235),
        AtlasHotspot('Deltoide posteriore','Spalla','💪',.83,.25),
        AtlasHotspot('Tricipite brachiale','Braccio posteriore','💪',.85,.37),
        AtlasHotspot('Gran dorsale','Dorso','💪',.74,.40),
        AtlasHotspot('Erettori spinali','Dorso profondo','💪',.75,.46),
        AtlasHotspot('Grande gluteo','Regione glutea','💪',.74,.59),
        AtlasHotspot('Ischiocrurali','Coscia posteriore','💪',.76,.70),
        AtlasHotspot('Gastrocnemio','Polpaccio','💪',.76,.86),
      ],
    ),
    AtlasLayerData(
      id:'nervous', label:'Nervi', emoji:'⚡',
      assetPath:'assets/anatomy/nervous.svg',
      credit:'Medium69 / Jmarchn · Wikimedia Commons',
      aspectRatio:.456,
      hotspots:[
        AtlasHotspot('Cervello','Sistema nervoso centrale','🧠',.50,.08),
        AtlasHotspot('Cervelletto','Sistema nervoso centrale','🧠',.50,.12),
        AtlasHotspot('Midollo spinale','Sistema nervoso centrale','⚡',.50,.34),
        AtlasHotspot('Plesso cervicale','C1-C4','⚡',.50,.20),
        AtlasHotspot('Plesso brachiale','C5-T1','⚡',.40,.28),
        AtlasHotspot('Nervo radiale','Arto superiore','⚡',.25,.40),
        AtlasHotspot('Nervo mediano','Arto superiore','⚡',.31,.43),
        AtlasHotspot('Nervo ulnare','Arto superiore','⚡',.34,.46),
        AtlasHotspot('Plesso lombare','L1-L4','⚡',.48,.54),
        AtlasHotspot('Plesso sacrale','L4-S4','⚡',.50,.60),
        AtlasHotspot('Nervo sciatico','Arto inferiore','⚡',.43,.73),
        AtlasHotspot('Nervo tibiale','Gamba','⚡',.43,.86),
      ],
    ),
    AtlasLayerData(
      id:'vascular', label:'Vasi', emoji:'🩸',
      assetPath:'assets/anatomy/vascular.svg',
      credit:'LadyofHats / P.gibellini · pubblico dominio',
      aspectRatio:.663,
      hotspots:[
        AtlasHotspot('Carotide comune','Testa e collo','🔴',.47,.17),
        AtlasHotspot('Giugulare interna','Testa e collo','🔵',.53,.17),
        AtlasHotspot('Succlavia','Arto superiore','🔴',.40,.24),
        AtlasHotspot('Cuore','Pompa centrale','❤️',.50,.34),
        AtlasHotspot('Aorta ascendente','Torace','🔴',.52,.345),
        AtlasHotspot('Arco aortico','Torace','🔴',.52,.31),
        AtlasHotspot('Aorta toracica','Torace','🔴',.52,.41),
        AtlasHotspot('Vena cava superiore','Torace','🔵',.47,.31),
        AtlasHotspot('Aorta addominale','Addome','🔴',.52,.50),
        AtlasHotspot('Vena cava inferiore','Addome','🔵',.47,.50),
        AtlasHotspot('Arteria renale','Reni','🔴',.50,.54),
        AtlasHotspot('Iliaca comune','Pelvi','🔴',.50,.61),
        AtlasHotspot('Arteria femorale','Coscia','🔴',.43,.72),
        AtlasHotspot('Grande safena','Arto inferiore','🔵',.57,.77),
        AtlasHotspot('Arteria tibiale','Gamba','🔴',.43,.87),
      ],
    ),
  ];

  @override
  void dispose() {
    _transform.dispose();
    super.dispose();
  }

  List<(int, AtlasHotspot)> get _searchResults {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    final result = <(int, AtlasHotspot)>[];
    for (var i=0; i<layers.length; i++) {
      for (final h in layers[i].hotspots) {
        if ((h.name+' '+h.subtitle).toLowerCase().contains(q)) {
          result.add((i,h));
        }
      }
    }
    return result.take(8).toList();
  }

  void _focusHotspot(int newLayer, AtlasHotspot h) {
    setState(() {
      layerIndex = newLayer;
      query = '';
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      const scale = 2.7;
      final dx = _canvasSize.width/2 - h.x*_canvasSize.width*scale;
      final dy = _canvasSize.height/2 - h.y*_canvasSize.height*scale;
      _transform.value = Matrix4.identity()
        ..translate(dx,dy)
        ..scale(scale);
    });
  }

  void _quickZoom(double x,double y,double scale) {
    final dx = _canvasSize.width/2 - x*_canvasSize.width*scale;
    final dy = _canvasSize.height/2 - y*_canvasSize.height*scale;
    _transform.value = Matrix4.identity()
      ..translate(dx,dy)
      ..scale(scale);
  }

  @override
  Widget build(BuildContext context) {
    final layer = layers[layerIndex];
    final results = _searchResults;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atlante anatomico'),
        actions: [
          IconButton(
            tooltip: showLabels ? 'Nascondi etichette' : 'Mostra etichette',
            onPressed: ()=>setState(()=>showLabels=!showLabels),
            icon: Icon(showLabels?Icons.label:Icons.label_off_outlined),
          ),
          IconButton(
            tooltip:'Reset zoom',
            onPressed:()=>_transform.value=Matrix4.identity(),
            icon:const Icon(Icons.center_focus_strong),
          ),
        ],
      ),
      body: Column(children:[
        Padding(
          padding: const EdgeInsets.fromLTRB(12,2,12,6),
          child: SearchBar(
            hintText:'Cerca femore, cuore, sciatico...',
            leading:const Icon(Icons.search),
            trailing: query.isEmpty ? null : [
              IconButton(icon:const Icon(Icons.close),onPressed:()=>setState(()=>query=''))
            ],
            onChanged:(v)=>setState(()=>query=v),
          ),
        ),
        if(results.isNotEmpty)
          Container(
            constraints:const BoxConstraints(maxHeight:190),
            margin:const EdgeInsets.symmetric(horizontal:12),
            decoration:BoxDecoration(
              color:Colors.white,
              borderRadius:BorderRadius.circular(18),
              boxShadow:const [BoxShadow(color:Color(0x22000000),blurRadius:10)],
            ),
            child:ListView(
              shrinkWrap:true,
              children:results.map((r)=>ListTile(
                dense:true,
                leading:Text(r.$2.emoji),
                title:Text(r.$2.name,style:const TextStyle(fontWeight:FontWeight.w800)),
                subtitle:Text(layers[r.$1].label+' · '+r.$2.subtitle),
                onTap:()=>_focusHotspot(r.$1,r.$2),
              )).toList(),
            ),
          ),
        SizedBox(
          height:50,
          child:ListView.separated(
            padding:const EdgeInsets.symmetric(horizontal:12,vertical:4),
            scrollDirection:Axis.horizontal,
            itemCount:layers.length,
            separatorBuilder:(_,__)=>const SizedBox(width:6),
            itemBuilder:(_,i)=>ChoiceChip(
              selected:layerIndex==i,
              label:Text(layers[i].emoji+' '+layers[i].label),
              onSelected:(_){
                setState(()=>layerIndex=i);
                _transform.value=Matrix4.identity();
              },
            ),
          ),
        ),
        SizedBox(
          height:42,
          child:ListView(
            scrollDirection:Axis.horizontal,
            padding:const EdgeInsets.symmetric(horizontal:12),
            children:[
              _ZoomChip('Intero',Icons.accessibility_new,()=>_transform.value=Matrix4.identity()),
              _ZoomChip('Testa',Icons.face,()=>_quickZoom(.50,.12,3.2)),
              _ZoomChip('Torace',Icons.favorite_outline,()=>_quickZoom(.50,.33,2.7)),
              _ZoomChip('Addome',Icons.circle_outlined,()=>_quickZoom(.50,.53,2.8)),
              _ZoomChip('Pelvi',Icons.change_history,()=>_quickZoom(.50,.62,3.0)),
              _ZoomChip('Arto sup.',Icons.pan_tool_alt_outlined,()=>_quickZoom(.24,.42,2.8)),
              _ZoomChip('Arto inf.',Icons.directions_walk,()=>_quickZoom(.44,.78,2.8)),
            ],
          ),
        ),
        Expanded(
          child:LayoutBuilder(
            builder:(context,constraints){
              final width=constraints.maxWidth-20;
              final height=width/layer.aspectRatio;
              _canvasSize=Size(width,height);
              return Container(
                margin:const EdgeInsets.symmetric(horizontal:10,vertical:6),
                clipBehavior:Clip.antiAlias,
                decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(24)),
                child:InteractiveViewer(
                  transformationController:_transform,
                  minScale:.65,
                  maxScale:7,
                  boundaryMargin:const EdgeInsets.all(260),
                  child:SizedBox(
                    width:width,
                    height:height,
                    child:Stack(
                      fit:StackFit.expand,
                      children:[
                        SvgPicture.asset(
                          layer.assetPath,
                          fit:BoxFit.contain,
                          semanticsLabel:layer.label,
                          placeholderBuilder:(_)=>const Center(child:CircularProgressIndicator()),
                        ),
                        ...layer.hotspots.map((h)=>_AtlasHotspotWidget(
                          hotspot:h,
                          showLabel:showLabels,
                          onTap:()=>_showHotspot(h,layer),
                        )),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding:const EdgeInsets.fromLTRB(16,4,16,10),
          child:Row(children:[
            const Icon(Icons.offline_bolt_outlined,size:16),
            const SizedBox(width:6),
            const Text('Offline',style:TextStyle(fontSize:11,fontWeight:FontWeight.w900)),
            const SizedBox(width:10),
            Expanded(child:Text(layer.credit,style:const TextStyle(fontSize:10,color:Colors.black54))),
            Text(layer.hotspots.length.toString()+' hotspot',style:const TextStyle(fontSize:10,fontWeight:FontWeight.w800)),
          ]),
        ),
      ]),
    );
  }

  Future<void> _showHotspot(AtlasHotspot h, AtlasLayerData layer) {
    return showModalBottomSheet<void>(
      context:context,
      showDragHandle:true,
      builder:(sheet)=>SafeArea(
        child:Padding(
          padding:const EdgeInsets.fromLTRB(22,4,22,28),
          child:Column(
            mainAxisSize:MainAxisSize.min,
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Row(children:[
                Text(h.emoji,style:const TextStyle(fontSize:46)),
                const SizedBox(width:14),
                Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                  Text(h.name,style:const TextStyle(fontSize:24,fontWeight:FontWeight.w900)),
                  Text(h.subtitle,style:TextStyle(color:Theme.of(context).colorScheme.primary,fontWeight:FontWeight.w800)),
                ])),
              ]),
              const SizedBox(height:18),
              Text('Layer: '+layer.label,style:const TextStyle(fontWeight:FontWeight.w800)),
              const SizedBox(height:8),
              const Text('Questa struttura è collegata all’Atlante e può essere usata come punto di partenza per ricerca, quiz e approfondimenti anatomici.',style:TextStyle(height:1.45)),
              const SizedBox(height:16),
              Row(children:[
                Expanded(child:OutlinedButton.icon(
                  onPressed:(){
                    Navigator.pop(sheet);
                    final deep=DeepDiveRegistry.find(h.name);
                    if(deep!=null){
                      Navigator.push(context,MaterialPageRoute(builder:(_)=>DeepDiveDetailPage(root:deep)));
                    }else{
                      Navigator.push(context,MaterialPageRoute(builder:(_)=>const AdvancedPage()));
                    }
                  },
                  icon:const Icon(Icons.menu_book_outlined),
                  label:const Text('Approfondisci'),
                )),
                const SizedBox(width:8),
                Expanded(child:FilledButton.icon(
                  onPressed:(){
                    Navigator.pop(sheet);
                    Navigator.push(context,MaterialPageRoute(builder:(_)=>const GamesHubPage()));
                  },
                  icon:const Icon(Icons.quiz_outlined),
                  label:const Text('Allenati'),
                )),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class _ZoomChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _ZoomChip(this.label,this.icon,this.onTap);
  @override
  Widget build(BuildContext context) => Padding(
    padding:const EdgeInsets.only(right:6),
    child:ActionChip(
      avatar:Icon(icon,size:16),
      label:Text(label),
      onPressed:onTap,
    ),
  );
}

class _AtlasHotspotWidget extends StatelessWidget {
  final AtlasHotspot hotspot;
  final bool showLabel;
  final VoidCallback onTap;
  const _AtlasHotspotWidget({required this.hotspot,required this.showLabel,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:Alignment(hotspot.x*2-1,hotspot.y*2-1),
      child:GestureDetector(
        onTap:onTap,
        child:Column(mainAxisSize:MainAxisSize.min,children:[
          Container(
            width:28,height:28,alignment:Alignment.center,
            decoration:BoxDecoration(
              color:Colors.white,
              shape:BoxShape.circle,
              border:Border.all(color:const Color(0xFF6755E7),width:2),
              boxShadow:const [BoxShadow(color:Color(0x33000000),blurRadius:6)],
            ),
            child:Text(hotspot.emoji,style:const TextStyle(fontSize:13)),
          ),
          if(showLabel)
            Container(
              constraints:const BoxConstraints(maxWidth:105),
              margin:const EdgeInsets.only(top:2),
              padding:const EdgeInsets.symmetric(horizontal:5,vertical:2),
              decoration:BoxDecoration(
                color:Colors.white.withValues(alpha:.93),
                borderRadius:BorderRadius.circular(7),
              ),
              child:Text(
                hotspot.name,
                textAlign:TextAlign.center,
                style:const TextStyle(fontSize:8.5,fontWeight:FontWeight.w900),
              ),
            ),
        ]),
      ),
    );
  }
}

class StudyPage extends StatefulWidget {
  final int answered,correct;
  final ValueChanged<bool> onAnswer;
  const StudyPage({super.key,required this.answered,required this.correct,required this.onAnswer});
  @override State<StudyPage> createState()=>_StudyPageState();
}

class _StudyPageState extends State<StudyPage>{
  int index=0;
  int? selected;
  bool locked=false;
  final questions = const <QuizItem>[
    QuizItem('Quante ossa contiene convenzionalmente lo scheletro adulto?',['106','206','306','406'],1,'Il conteggio convenzionale dell’adulto è 206.'),
    QuizItem('Quale camera pompa il sangue nella circolazione sistemica?',['Atrio destro','Ventricolo destro','Atrio sinistro','Ventricolo sinistro'],3,'Il ventricolo sinistro espelle sangue nell’aorta.'),
    QuizItem('Dove avviene principalmente lo scambio gassoso?',['Trachea','Bronchi','Alveoli','Pleura'],2,'Gli alveoli sono la principale superficie di scambio.'),
    QuizItem('Quale nervo cranico è il X?',['Trigemino','Vago','Faciale','Ipoglosso'],1,'Il X nervo cranico è il nervo vago.'),
    QuizItem('Quale struttura appartiene al nefrone?',['Glomerulo','Alveolo','Sarcomero','Sinusoide splenico'],0,'Il glomerulo è la rete capillare del corpuscolo renale.'),
    QuizItem('Quale osso è C1?',['Epistrofeo','Atlante','Sacro','Coccige'],1,'C1 è l’Atlante.'),
    QuizItem('Quale struttura attraversa il canale ottico?',['Nervo ottico','Nervo vago','Nervo faciale','Nervo accessorio'],0,'Il nervo ottico II attraversa il canale ottico.'),
    QuizItem('Quale proteina lega Ca²⁺ nella contrazione muscolare?',['Cheratina','Troponina','Collagene','Albumina'],1,'Il calcio si lega alla troponina.'),
    QuizItem('Quale vaso porta sangue dal tratto gastrointestinale al fegato?',['Vena porta','Aorta','Vena cava superiore','Arteria renale'],0,'La vena porta epatica trasporta sangue al fegato.'),
    QuizItem('Quale osso è il più grande del piede?',['Astragalo','Calcagno','Navicolare','Cuboide'],1,'Il calcagno è il più grande osso del piede.'),
  ];
  @override
  Widget build(BuildContext context){
    final q=questions[index%questions.length];
    final acc=widget.answered==0?'—':(widget.correct*100~/widget.answered).toString()+'%';
    return Scaffold(
      appBar:AppBar(title:const Text('Smart Study')),
      body:ListView(
        padding:const EdgeInsets.fromLTRB(18,4,18,32),
        children:[
          Container(
            padding:const EdgeInsets.all(20),
            decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(28)),
            child:Row(children:[
              const Text('🧠',style:TextStyle(fontSize:48)),
              const SizedBox(width:14),
              Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                const Text('La tua preparazione',style:TextStyle(fontSize:20,fontWeight:FontWeight.w900)),
                Text(widget.answered.toString()+' risposte · precisione '+acc),
              ])),
            ]),
          ),
          const SizedBox(height:20),
          const Text('Quiz rapido',style:TextStyle(fontSize:22,fontWeight:FontWeight.w900)),
          const SizedBox(height:10),
          Card(child:Padding(
            padding:const EdgeInsets.all(18),
            child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text(q.question,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w900)),
              const SizedBox(height:14),
              ...List.generate(q.answers.length,(i){
                Color? bg;
                if(locked && i==q.correct) bg=Colors.green.withValues(alpha:.15);
                else if(locked && selected==i) bg=Colors.red.withValues(alpha:.12);
                return Padding(
                  padding:const EdgeInsets.only(bottom:8),
                  child:Material(
                    color:bg??Theme.of(context).colorScheme.surfaceContainerLow,
                    borderRadius:BorderRadius.circular(16),
                    child:ListTile(
                      title:Text(q.answers[i],style:const TextStyle(fontWeight:FontWeight.w700)),
                      onTap:locked?null:(){
                        final ok=i==q.correct;
                        widget.onAnswer(ok);
                        setState((){selected=i;locked=true;});
                      },
                    ),
                  ),
                );
              }),
              if(locked)...[
                const SizedBox(height:6),
                Text(q.explanation,style:const TextStyle(height:1.4)),
                const SizedBox(height:12),
                SizedBox(width:double.infinity,child:FilledButton(onPressed:()=>setState((){index++;selected=null;locked=false;}),child:const Text('Prossima domanda'))),
              ],
            ]),
          )),
          const SizedBox(height:20),
          ActionCard(emoji:'🦴',title:'Osteologia',subtitle:'206 ossa · colonna · cranio · mano · piede',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const AdvancedPage()))),
          const SizedBox(height:8),
          ActionCard(emoji:'⚡',title:'Neurologia',subtitle:'12 nervi cranici · 31 paia spinali · plessi',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const AdvancedPage()))),
          const SizedBox(height:8),
          ActionCard(emoji:'🩸',title:'Vasi',subtitle:'Arterie e vene principali',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const AdvancedPage()))),
        ],
      ),
    );
  }
}

class QuizItem {
  final String question, explanation;
  final List<String> answers;
  final int correct;
  const QuizItem(this.question,this.answers,this.correct,this.explanation);
}

class ProfilePage extends StatelessWidget {
  final int answered,correct;
  final StudyProgressStore studyStore;
  const ProfilePage({super.key,required this.answered,required this.correct,required this.studyStore});
  @override
  Widget build(BuildContext context){
    final acc=answered==0?'—':(correct*100~/answered).toString()+'%';
    return Scaffold(
      appBar:AppBar(title:const Text('Profilo')),
      body:ListView(
        padding:const EdgeInsets.fromLTRB(18,4,18,32),
        children:[
          Container(
            padding:const EdgeInsets.all(22),
            decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(30)),
            child:const Row(children:[
              CircleAvatar(radius:34,child:Text('18',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900))),
              SizedBox(width:16),
              Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                Text('edu_01 · v0.25.0',style:TextStyle(fontSize:22,fontWeight:FontWeight.w900)),
                Text('Atlante umano interattivo'),
              ])),
            ]),
          ),
          const SizedBox(height:24),
          const Text('Statistiche',style:TextStyle(fontSize:22,fontWeight:FontWeight.w900)),
          const SizedBox(height:10),
          GridView.count(
            crossAxisCount:2,shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),childAspectRatio:1.7,crossAxisSpacing:8,mainAxisSpacing:8,
            children:[
              Stat(value:answered.toString(),label:'Risposte'),
              Stat(value:acc,label:'Precisione'),
              const Stat(value:'206',label:'Ossa'),
              const Stat(value:'11',label:'Sistemi'),
              const Stat(value:'32',label:'Denti'),
              const Stat(value:'12',label:'Nervi cranici'),
            ],
          ),
          const SizedBox(height:20),
          Card(child:ListTile(
            leading:const Icon(Icons.verified_outlined),
            title:const Text('Release Center',style:TextStyle(fontWeight:FontWeight.w900)),
            subtitle:const Text('Versione, qualità, licenze e gestione progressi'),
            trailing:const Icon(Icons.chevron_right),
            onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>ReleaseCenterPage(studyStore:studyStore))),
          )),
          const SizedBox(height:8),
          const Card(child:ListTile(leading:Icon(Icons.info_outline),title:Text('Build consolidata',style:TextStyle(fontWeight:FontWeight.w900)),subtitle:Text('edu_01 0.25.0+25 · Android · Release Candidate'))),
        ],
      ),
    );
  }
}

class PhysiologyPage extends StatelessWidget {
  const PhysiologyPage({super.key});
  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Fisiologia interattiva')),
    body:ListView(
      padding:const EdgeInsets.all(18),
      children:[
        Container(
          padding:const EdgeInsets.all(22),
          decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF287EAE),Color(0xFF54A6C9)]),borderRadius:BorderRadius.circular(30)),
          child:const Row(children:[Text('🫀',style:TextStyle(fontSize:52)),SizedBox(width:14),Expanded(child:Text('Guarda il corpo funzionare',style:TextStyle(color:Colors.white,fontSize:22,fontWeight:FontWeight.w900)))]),
        ),
        const SizedBox(height:18),
        ...physiology.map((p)=>Padding(padding:const EdgeInsets.only(bottom:8),child:Card(child:ListTile(
          contentPadding:const EdgeInsets.all(14),
          leading:Text(p['e']!,style:const TextStyle(fontSize:34)),
          title:Text(p['t']!,style:const TextStyle(fontWeight:FontWeight.w900)),
          subtitle:Text(p['s']!.replaceAll('|',' → ')),
          trailing:const Icon(Icons.play_circle_outline),
          onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>PhysiologyDetail(data:p))),
        )))),
      ],
    ),
  );
}

class PhysiologyDetail extends StatefulWidget {
  final Map<String,String> data;
  const PhysiologyDetail({super.key,required this.data});
  @override State<PhysiologyDetail> createState()=>_PhysiologyDetailState();
}

class _PhysiologyDetailState extends State<PhysiologyDetail> {
  int step=0;
  late final List<String> parts=widget.data['s']!.split('|');
  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:Text(widget.data['e']!+' '+widget.data['t']!)),
    body:Padding(
      padding:const EdgeInsets.all(20),
      child:Column(children:[
        LinearProgressIndicator(value:(step+1)/parts.length,minHeight:8,borderRadius:BorderRadius.circular(20)),
        const SizedBox(height:28),
        Expanded(child:Center(child:Column(mainAxisSize:MainAxisSize.min,children:[
          Text(widget.data['e']!,style:const TextStyle(fontSize:78)),
          const SizedBox(height:20),
          Text(parts[step],textAlign:TextAlign.center,style:const TextStyle(fontSize:28,fontWeight:FontWeight.w900)),
          const SizedBox(height:14),
          Text('Step '+(step+1).toString()+' di '+parts.length.toString(),style:TextStyle(color:Theme.of(context).colorScheme.primary,fontWeight:FontWeight.w800)),
          const SizedBox(height:20),
          Container(
            padding:const EdgeInsets.all(16),
            decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(20)),
            child:const Text('Osserva come questa fase si collega alla precedente e alla successiva: struttura anatomica e funzione lavorano insieme per mantenere l’omeostasi.',textAlign:TextAlign.center,style:TextStyle(height:1.5)),
          ),
        ]))),
        Row(children:[
          Expanded(child:OutlinedButton(onPressed:step>0?()=>setState(()=>step--):null,child:const Text('Indietro'))),
          const SizedBox(width:10),
          Expanded(child:FilledButton(onPressed:step<parts.length-1?()=>setState(()=>step++):()=>Navigator.pop(context),child:Text(step<parts.length-1?'Continua':'Completa'))),
        ]),
      ]),
    ),
  );
}

class AdvancedPage extends StatefulWidget {
  const AdvancedPage({super.key});
  @override State<AdvancedPage> createState()=>_AdvancedPageState();
}

class _AdvancedPageState extends State<AdvancedPage> {
  String query='';
  @override
  Widget build(BuildContext context){
    final list=advanced.where((e)=>(e['t']!+' '+e['s']!).toLowerCase().contains(query.toLowerCase())).toList();
    return Scaffold(
      appBar:AppBar(title:const Text('Anatomia avanzata')),
      body:Column(children:[
        Padding(padding:const EdgeInsets.all(18),child:SearchBar(hintText:'Cerca struttura...',leading:const Icon(Icons.search),onChanged:(v)=>setState(()=>query=v))),
        Expanded(child:ListView(
          padding:const EdgeInsets.fromLTRB(18,0,18,32),
          children:list.map((e)=>Card(child:ListTile(
            contentPadding:const EdgeInsets.all(14),
            leading:Text(e['e']!,style:const TextStyle(fontSize:32)),
            title:Text(e['t']!,style:const TextStyle(fontWeight:FontWeight.w900)),
            subtitle:Text(e['s']!),
            trailing:const Icon(Icons.chevron_right),
            onTap:()=>showModalBottomSheet(context:context,showDragHandle:true,builder:(_)=>Padding(
              padding:const EdgeInsets.fromLTRB(22,4,22,28),
              child:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[
                Text(e['e']!,style:const TextStyle(fontSize:48)),
                const SizedBox(height:8),
                Text(e['t']!,style:const TextStyle(fontSize:24,fontWeight:FontWeight.w900)),
                const SizedBox(height:10),
                Text(e['s']!,style:const TextStyle(height:1.5)),
                const SizedBox(height:12),
                const Text('Catalogo avanzato v0.22 · collegato ad Atlante, Deep Dive e Smart Study 2.0.',style:TextStyle(fontWeight:FontWeight.w700)),
              ]),
            )),
          ))).toList(),
        )),
      ]),
    );
  }
}

class TeethPage extends StatelessWidget {
  const TeethPage({super.key});
  @override
  Widget build(BuildContext context){
    final names=<String>[];
    const types=['Incisivo centrale','Incisivo laterale','Canino','Primo premolare','Secondo premolare','Primo molare','Secondo molare','Terzo molare'];
    for(final q in <int>[1,2,3,4]){ for(int p=1;p<=8;p++){names.add('FDI '+q.toString()+p.toString()+' · '+types[p-1]);}}
    return Scaffold(
      appBar:AppBar(title:const Text('🦷 I 32 denti permanenti')),
      body:GridView.builder(
        padding:const EdgeInsets.all(16),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.3,crossAxisSpacing:8,mainAxisSpacing:8),
        itemCount:names.length,
        itemBuilder:(_,i)=>Card(child:Center(child:Padding(padding:const EdgeInsets.all(10),child:Column(mainAxisSize:MainAxisSize.min,children:[
          const Text('🦷',style:TextStyle(fontSize:32)),
          Text(names[i],textAlign:TextAlign.center,style:const TextStyle(fontWeight:FontWeight.w800)),
        ])))),
      ),
    );
  }
}

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});
  @override State<GamesPage> createState()=>_GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  int score=0,round=0;
  late List<String> options;
  late BodySystem system;
  late String target;
  final rng=Random();
  @override void initState(){super.initState();_next();}
  void _next(){
    system=systems[rng.nextInt(systems.length)];
    target=system.parts[rng.nextInt(system.parts.length)];
    final pool=systems.expand((s)=>s.parts).where((x)=>x!=target).toList()..shuffle(rng);
    options=<String>[target,...pool.take(3)]..shuffle(rng);
  }
  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Anatomy Games')),
    body:Padding(
      padding:const EdgeInsets.all(20),
      child:Column(children:[
        Container(
          padding:const EdgeInsets.all(20),
          decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFFEF6A72),Color(0xFFF89A62)]),borderRadius:BorderRadius.circular(28)),
          child:Row(children:[
            const Text('🎮',style:TextStyle(fontSize:52)),
            const SizedBox(width:12),
            Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              const Text('Trova la struttura',style:TextStyle(color:Colors.white,fontSize:22,fontWeight:FontWeight.w900)),
              Text('Punti '+score.toString()+' · Round '+round.toString(),style:const TextStyle(color:Colors.white70)),
            ])),
          ]),
        ),
        const SizedBox(height:24),
        Text(system.emoji,style:const TextStyle(fontSize:58)),
        const SizedBox(height:10),
        Text('Quale struttura appartiene al sistema '+system.name+'?',textAlign:TextAlign.center,style:const TextStyle(fontSize:21,fontWeight:FontWeight.w900)),
        const SizedBox(height:20),
        Expanded(child:ListView.separated(
          itemCount:options.length,
          separatorBuilder:(_,__)=>const SizedBox(height:8),
          itemBuilder:(_,i)=>FilledButton.tonal(
            onPressed:(){
              final ok=options[i]==target;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration:const Duration(milliseconds:500),content:Text(ok?'Corretto ✅':'Risposta: '+target)));
              setState((){round++;if(ok){score+=100;}else{score=max(0,score-20);}_next();});
            },
            child:Padding(padding:const EdgeInsets.symmetric(vertical:16),child:Text(options[i])),
          ),
        )),
        const SizedBox(height:10),
        const Text('Nel progetto sono previste anche memory anatomico, sfida a tempo e ricostruzione dello scheletro.',textAlign:TextAlign.center),
      ]),
    ),
  );
}

class ActionCard extends StatelessWidget {
  final String emoji,title,subtitle;
  final VoidCallback onTap;
  const ActionCard({super.key,required this.emoji,required this.title,required this.subtitle,required this.onTap});
  @override Widget build(BuildContext context)=>Card(child:ListTile(contentPadding:const EdgeInsets.all(16),leading:Text(emoji,style:const TextStyle(fontSize:34)),title:Text(title,style:const TextStyle(fontWeight:FontWeight.w900)),subtitle:Text(subtitle),trailing:const Icon(Icons.chevron_right),onTap:onTap));
}

class FeatureCard extends StatelessWidget {
  final Color color;
  final String emoji,title,subtitle;
  final VoidCallback onTap;
  const FeatureCard({super.key,required this.color,required this.emoji,required this.title,required this.subtitle,required this.onTap});
  @override Widget build(BuildContext context)=>Material(color:color,borderRadius:BorderRadius.circular(28),child:InkWell(borderRadius:BorderRadius.circular(28),onTap:onTap,child:Padding(padding:const EdgeInsets.all(20),child:Row(children:[
    Text(emoji,style:const TextStyle(fontSize:46)),
    const SizedBox(width:14),
    Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w900)),const SizedBox(height:4),Text(subtitle)])),
    const Icon(Icons.chevron_right),
  ]))));
}

class Metric extends StatelessWidget {
  final String value,label,emoji;
  const Metric({super.key,required this.value,required this.label,required this.emoji});
  @override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.symmetric(vertical:16,horizontal:8),decoration:BoxDecoration(color:Theme.of(context).colorScheme.surfaceContainerLow,borderRadius:BorderRadius.circular(20)),child:Column(children:[Text(emoji,style:const TextStyle(fontSize:24)),Text(value,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w900)),Text(label,style:const TextStyle(fontSize:11))]));
}

class Stat extends StatelessWidget {
  final String value,label;
  const Stat({super.key,required this.value,required this.label});
  @override Widget build(BuildContext context)=>Container(decoration:BoxDecoration(color:Theme.of(context).colorScheme.surfaceContainerLow,borderRadius:BorderRadius.circular(20)),alignment:Alignment.center,child:Column(mainAxisSize:MainAxisSize.min,children:[Text(value,style:const TextStyle(fontSize:24,fontWeight:FontWeight.w900)),Text(label)]));
}
