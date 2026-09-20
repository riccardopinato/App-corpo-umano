import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const HumanBodyApp());

class HumanBodyApp extends StatelessWidget {
  const HumanBodyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF6755E7));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'edu_01',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: const Color(0xFFF8F8FC),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
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
  int tab = 0, answered = 0, correct = 0;
  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      TodayPage(answered: answered, correct: correct, openStudy: () => setState(() => tab = 3)),
      const LearnPage(),
      const AtlasPage(),
      StudyPage(answered: answered, correct: correct, onAnswer: (ok) => setState(() { answered++; if (ok) correct++; })),
      ProfilePage(answered: answered, correct: correct),
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
          ActionCard(emoji:'🎮',title:'Anatomy Games',subtitle:'Riconoscimento anatomico e sfide',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const GamesPage()))),
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
          FeatureCard(color:const Color(0xFFFFE5E4),emoji:'🎮',title:'Anatomy Games',subtitle:'Impara giocando con il database anatomico',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const GamesPage()))),
          const SizedBox(height:10),
          FeatureCard(color:const Color(0xFFE8F0FF),emoji:'🧬',title:'Anatomia avanzata',subtitle:'Cranio, colonna, mano, piede, legamenti, nervi e vasi',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const AdvancedPage()))),
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
  @override State<AtlasPage> createState()=>_AtlasPageState();
}

class AtlasLayerData {
  final String id, label, emoji, imageUrl, credit;
  final List<AtlasHotspot> hotspots;
  const AtlasLayerData({required this.id,required this.label,required this.emoji,required this.imageUrl,required this.credit,required this.hotspots});
}

class AtlasHotspot {
  final String name, subtitle, emoji;
  final double x, y;
  const AtlasHotspot(this.name,this.subtitle,this.emoji,this.x,this.y);
}

class _AtlasPageState extends State<AtlasPage> {
  int layerIndex = 0;
  bool showLabels = true;
  final TransformationController _transform = TransformationController();

  static const layers = <AtlasLayerData>[
    AtlasLayerData(
      id:'organs',label:'Organi',emoji:'🫀',
      imageUrl:'https://commons.wikimedia.org/w/thumb.php?f=Internal_organs.svg&w=1200',
      credit:'Mikael Häggström · pubblico dominio',
      hotspots:[
        AtlasHotspot('Cervello','Sistema nervoso','🧠',.50,.10),
        AtlasHotspot('Polmoni','Sistema respiratorio','🫁',.50,.30),
        AtlasHotspot('Cuore','Sistema cardiovascolare','❤️',.52,.36),
        AtlasHotspot('Fegato','Sistema digerente','🟤',.43,.48),
        AtlasHotspot('Stomaco','Sistema digerente','🥣',.58,.50),
        AtlasHotspot('Reni','Sistema urinario','🫘',.50,.55),
        AtlasHotspot('Intestino tenue','Sistema digerente','➰',.50,.65),
        AtlasHotspot('Colon','Sistema digerente','🟫',.50,.69),
      ],
    ),
    AtlasLayerData(
      id:'skeleton',label:'Scheletro',emoji:'🦴',
      imageUrl:'https://commons.wikimedia.org/w/thumb.php?f=Human_skeleton_(svg_template).svg&w=1200',
      credit:'Mikael Häggström · CC0 / pubblico dominio',
      hotspots:[
        AtlasHotspot('Cranio','Scheletro assile','💀',.50,.09),
        AtlasHotspot('Clavicola','Cintura scapolare','🦴',.50,.22),
        AtlasHotspot('Sterno','Scheletro assile','🦴',.50,.29),
        AtlasHotspot('Omero','Arto superiore','🦴',.28,.34),
        AtlasHotspot('Radio e ulna','Avambraccio','🦴',.20,.46),
        AtlasHotspot('Carpo','8 ossa per mano','✋',.13,.57),
        AtlasHotspot('Bacino','Cintura pelvica','🦴',.50,.57),
        AtlasHotspot('Femore','Coscia','🦴',.43,.70),
        AtlasHotspot('Rotula','Ginocchio','🦴',.43,.79),
        AtlasHotspot('Tibia e fibula','Gamba','🦴',.43,.87),
        AtlasHotspot('Tarso','7 ossa per piede','🦶',.41,.96),
      ],
    ),
    AtlasLayerData(
      id:'muscles',label:'Muscoli',emoji:'💪',
      imageUrl:'https://commons.wikimedia.org/w/thumb.php?f=Muscles_front_and_back.svg&w=1400',
      credit:'Nefronus · CC BY-SA 4.0',
      hotspots:[
        AtlasHotspot('Deltoide','Spalla','💪',.28,.22),
        AtlasHotspot('Grande pettorale','Torace anteriore','💪',.31,.30),
        AtlasHotspot('Bicipite brachiale','Braccio anteriore','💪',.22,.36),
        AtlasHotspot('Retto dell’addome','Parete addominale','💪',.34,.48),
        AtlasHotspot('Quadricipite','Coscia anteriore','💪',.31,.69),
        AtlasHotspot('Trapezio','Dorso','💪',.72,.25),
        AtlasHotspot('Gran dorsale','Dorso','💪',.72,.40),
        AtlasHotspot('Grande gluteo','Regione glutea','💪',.72,.59),
        AtlasHotspot('Ischiocrurali','Coscia posteriore','💪',.72,.70),
        AtlasHotspot('Gastrocnemio','Polpaccio','💪',.72,.86),
      ],
    ),
    AtlasLayerData(
      id:'nervous',label:'Nervi',emoji:'⚡',
      imageUrl:'https://commons.wikimedia.org/w/thumb.php?f=Nervous_system_diagram_unlabeled.svg&w=1000',
      credit:'Wikimedia Commons',
      hotspots:[
        AtlasHotspot('Cervello','Sistema nervoso centrale','🧠',.50,.10),
        AtlasHotspot('Midollo spinale','Sistema nervoso centrale','⚡',.50,.35),
        AtlasHotspot('Plesso brachiale','C5-T1','⚡',.43,.27),
        AtlasHotspot('Nervo mediano','Arto superiore','⚡',.26,.43),
        AtlasHotspot('Plesso lombosacrale','Arto inferiore','⚡',.50,.58),
        AtlasHotspot('Nervo sciatico','Arto inferiore','⚡',.44,.72),
      ],
    ),
    AtlasLayerData(
      id:'vascular',label:'Vasi',emoji:'🩸',
      imageUrl:'https://commons.wikimedia.org/w/thumb.php?f=Circulatory_System_it.svg&w=1000',
      credit:'LadyofHats / traduzione italiana · pubblico dominio',
      hotspots:[
        AtlasHotspot('Carotidi','Testa e collo','🔴',.49,.17),
        AtlasHotspot('Vene giugulari','Testa e collo','🔵',.53,.17),
        AtlasHotspot('Cuore','Pompa centrale','❤️',.50,.34),
        AtlasHotspot('Aorta','Arteria principale','🔴',.52,.39),
        AtlasHotspot('Vena cava inferiore','Ritorno venoso','🔵',.47,.45),
        AtlasHotspot('Arterie renali','Reni','🔴',.50,.53),
        AtlasHotspot('Arterie iliache','Pelvi','🔴',.50,.61),
        AtlasHotspot('Arteria femorale','Coscia','🔴',.43,.72),
      ],
    ),
  ];

  @override
  void dispose(){_transform.dispose();super.dispose();}

  @override
  Widget build(BuildContext context){
    final layer=layers[layerIndex];
    return Scaffold(
      appBar:AppBar(
        title:const Text('Atlante anatomico'),
        actions:[
          IconButton(tooltip:showLabels?'Nascondi etichette':'Mostra etichette',onPressed:()=>setState(()=>showLabels=!showLabels),icon:Icon(showLabels?Icons.label:Icons.label_off_outlined)),
          IconButton(tooltip:'Reset zoom',onPressed:()=>_transform.value=Matrix4.identity(),icon:const Icon(Icons.center_focus_strong)),
        ],
      ),
      body:Column(children:[
        SizedBox(
          height:54,
          child:ListView.separated(
            padding:const EdgeInsets.symmetric(horizontal:12,vertical:5),
            scrollDirection:Axis.horizontal,
            itemCount:layers.length,
            separatorBuilder:(_,__)=>const SizedBox(width:7),
            itemBuilder:(_,i)=>ChoiceChip(
              selected:layerIndex==i,
              label:Text(layers[i].emoji+' '+layers[i].label),
              onSelected:(_){setState(()=>layerIndex=i);_transform.value=Matrix4.identity();},
            ),
          ),
        ),
        Container(
          margin:const EdgeInsets.fromLTRB(14,4,14,8),
          padding:const EdgeInsets.symmetric(horizontal:12,vertical:9),
          decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(18)),
          child:Row(children:[
            Expanded(child:Text(layer.emoji+' '+layer.label,style:const TextStyle(fontWeight:FontWeight.w900))),
            const Icon(Icons.pinch_outlined,size:18),
            const SizedBox(width:5),
            const Text('Pizzica per zoom',style:TextStyle(fontSize:12)),
          ]),
        ),
        Expanded(
          child:Container(
            margin:const EdgeInsets.symmetric(horizontal:10),
            clipBehavior:Clip.antiAlias,
            decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(24)),
            child:InteractiveViewer(
              transformationController:_transform,
              minScale:.7,maxScale:6,boundaryMargin:const EdgeInsets.all(220),
              child:AspectRatio(
                aspectRatio:.64,
                child:Stack(
                  fit:StackFit.expand,
                  children:[
                    _AtlasImage(url:layer.imageUrl,fallbackLabel:layer.label),
                    ...layer.hotspots.map((h)=>_AtlasHotspotWidget(hotspot:h,showLabel:showLabels)),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:const EdgeInsets.fromLTRB(16,8,16,12),
          child:Row(children:[
            const Icon(Icons.info_outline,size:16),
            const SizedBox(width:6),
            Expanded(child:Text(layer.credit,style:const TextStyle(fontSize:11,color:Colors.black54))),
            Text(layer.hotspots.length.toString()+' hotspot',style:const TextStyle(fontSize:11,fontWeight:FontWeight.w800)),
          ]),
        ),
      ]),
    );
  }
}

class _AtlasImage extends StatelessWidget {
  final String url,fallbackLabel;
  const _AtlasImage({required this.url,required this.fallbackLabel});
  @override
  Widget build(BuildContext context){
    return Image.network(
      url,fit:BoxFit.contain,filterQuality:FilterQuality.high,
      loadingBuilder:(context,child,progress){
        if(progress==null)return child;
        return Center(child:Column(mainAxisSize:MainAxisSize.min,children:[
          const CircularProgressIndicator(),
          const SizedBox(height:12),
          Text('Caricamento atlante '+fallbackLabel+'...'),
        ]));
      },
      errorBuilder:(context,error,stack)=>Center(
        child:Padding(
          padding:const EdgeInsets.all(24),
          child:Column(mainAxisSize:MainAxisSize.min,children:[
            const Icon(Icons.cloud_off,size:52),
            const SizedBox(height:12),
            const Text('Immagine anatomica non disponibile',style:TextStyle(fontWeight:FontWeight.w900)),
            const SizedBox(height:6),
            const Text('Questa build usa tavole anatomiche Wikimedia Commons e richiede una connessione per il caricamento.',textAlign:TextAlign.center),
          ]),
        ),
      ),
    );
  }
}

class _AtlasHotspotWidget extends StatelessWidget {
  final AtlasHotspot hotspot;
  final bool showLabel;
  const _AtlasHotspotWidget({required this.hotspot,required this.showLabel});
  @override
  Widget build(BuildContext context){
    return Align(
      alignment:Alignment(hotspot.x*2-1,hotspot.y*2-1),
      child:GestureDetector(
        onTap:()=>showModalBottomSheet<void>(
          context:context,showDragHandle:true,
          builder:(sheet)=>Padding(
            padding:const EdgeInsets.fromLTRB(22,4,22,28),
            child:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text(hotspot.emoji,style:const TextStyle(fontSize:46)),
              const SizedBox(height:8),
              Text(hotspot.name,style:const TextStyle(fontSize:25,fontWeight:FontWeight.w900)),
              const SizedBox(height:4),
              Text(hotspot.subtitle,style:TextStyle(color:Theme.of(context).colorScheme.primary,fontWeight:FontWeight.w800)),
              const SizedBox(height:16),
              const Text('Struttura selezionata nell’Atlante anatomico. Questa vista serve come punto di ingresso per approfondimenti, quiz e percorso macro→micro.',style:TextStyle(height:1.45)),
            ]),
          ),
        ),
        child:Column(mainAxisSize:MainAxisSize.min,children:[
          Container(
            width:30,height:30,alignment:Alignment.center,
            decoration:BoxDecoration(color:Colors.white,shape:BoxShape.circle,border:Border.all(color:const Color(0xFF6755E7),width:2),boxShadow:const [BoxShadow(color:Color(0x33000000),blurRadius:6)]),
            child:Text(hotspot.emoji,style:const TextStyle(fontSize:14)),
          ),
          if(showLabel)
            Container(
              constraints:const BoxConstraints(maxWidth:110),
              margin:const EdgeInsets.only(top:3),
              padding:const EdgeInsets.symmetric(horizontal:6,vertical:3),
              decoration:BoxDecoration(color:Colors.white.withValues(alpha:.92),borderRadius:BorderRadius.circular(8)),
              child:Text(hotspot.name,textAlign:TextAlign.center,style:const TextStyle(fontSize:9,fontWeight:FontWeight.w900)),
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
  const ProfilePage({super.key,required this.answered,required this.correct});
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
                Text('edu_01 · v0.18.0',style:TextStyle(fontSize:22,fontWeight:FontWeight.w900)),
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
          const Card(child:ListTile(leading:Icon(Icons.info_outline),title:Text('Build consolidata',style:TextStyle(fontWeight:FontWeight.w900)),subtitle:Text('edu_01 0.18.0+18 · Android · offline'))),
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
                const Text('Catalogo avanzato v0.18.0 · collegato a Atlante e Smart Study.',style:TextStyle(fontWeight:FontWeight.w700)),
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
