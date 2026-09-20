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

class _AtlasPageState extends State<AtlasPage> {
  bool skeleton=false,muscles=false,organs=true,nerves=false,vessels=false,back=false;
  double opacity=.18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:const Text('Atlante umano')),
      body:Column(children:[
        SizedBox(height:46,child:ListView(scrollDirection:Axis.horizontal,padding:const EdgeInsets.symmetric(horizontal:12),children:[
          FilterChip(label:const Text('🫀 Organi'),selected:organs,onSelected:(v)=>setState(()=>organs=v)),
          const SizedBox(width:6),
          FilterChip(label:const Text('🦴 Scheletro'),selected:skeleton,onSelected:(v)=>setState(()=>skeleton=v)),
          const SizedBox(width:6),
          FilterChip(label:const Text('💪 Muscoli'),selected:muscles,onSelected:(v)=>setState(()=>muscles=v)),
          const SizedBox(width:6),
          FilterChip(label:const Text('⚡ Nervi'),selected:nerves,onSelected:(v)=>setState(()=>nerves=v)),
          const SizedBox(width:6),
          FilterChip(label:const Text('🩸 Vasi'),selected:vessels,onSelected:(v)=>setState(()=>vessels=v)),
        ])),
        Row(children:[
          const SizedBox(width:12),
          SegmentedButton<bool>(
            segments:const [ButtonSegment(value:false,label:Text('Fronte')),ButtonSegment(value:true,label:Text('Retro'))],
            selected:{back},
            onSelectionChanged:(s)=>setState(()=>back=s.first),
          ),
          Expanded(child:Slider(min:.04,max:.55,value:opacity,onChanged:(v)=>setState(()=>opacity=v))),
        ]),
        Expanded(child:InteractiveViewer(
          minScale:.7,maxScale:5,
          child:AspectRatio(
            aspectRatio:.52,
            child:CustomPaint(
              painter:BodyPainter(surfaceOpacity:opacity,skeleton:skeleton,muscles:muscles,organs:organs,nerves:nerves,vessels:vessels,back:back),
              child:const SizedBox.expand(),
            ),
          ),
        )),
      ]),
    );
  }
}

class BodyPainter extends CustomPainter {
  final double surfaceOpacity;
  final bool skeleton,muscles,organs,nerves,vessels,back;
  BodyPainter({required this.surfaceOpacity,required this.skeleton,required this.muscles,required this.organs,required this.nerves,required this.vessels,required this.back});
  @override
  void paint(Canvas c,Size s){
    final cx=s.width/2;
    final skin=Paint()..color=const Color(0xFFE9BFA5).withValues(alpha:surfaceOpacity);
    c.drawOval(Rect.fromCenter(center:Offset(cx,s.height*.075),width:s.width*.22,height:s.height*.13),skin);
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center:Offset(cx,s.height*.37),width:s.width*.42,height:s.height*.48),Radius.circular(s.width*.18)),skin);
    final limb=Paint()..color=skin.color..strokeCap=StrokeCap.round..strokeWidth=s.width*.095;
    c.drawLine(Offset(cx-s.width*.18,s.height*.23),Offset(s.width*.10,s.height*.58),limb);
    c.drawLine(Offset(cx+s.width*.18,s.height*.23),Offset(s.width*.90,s.height*.58),limb);
    limb.strokeWidth=s.width*.12;
    c.drawLine(Offset(cx-s.width*.09,s.height*.58),Offset(cx-s.width*.12,s.height*.95),limb);
    c.drawLine(Offset(cx+s.width*.09,s.height*.58),Offset(cx+s.width*.12,s.height*.95),limb);
    if(skeleton){
      final p=Paint()..color=const Color(0xFFF3EED8)..style=PaintingStyle.stroke..strokeWidth=4..strokeCap=StrokeCap.round;
      c.drawOval(Rect.fromCenter(center:Offset(cx,s.height*.075),width:s.width*.16,height:s.height*.11),p);
      c.drawLine(Offset(cx,s.height*.14),Offset(cx,s.height*.60),p);
      for(int i=0;i<9;i++){ final y=s.height*(.23+i*.025),w=s.width*(.18-i*.008); c.drawArc(Rect.fromCenter(center:Offset(cx,y),width:w*2,height:s.height*.07),0,pi,false,p); }
      c.drawLine(Offset(cx-s.width*.17,s.height*.23),Offset(s.width*.20,s.height*.55),p);
      c.drawLine(Offset(cx+s.width*.17,s.height*.23),Offset(s.width*.80,s.height*.55),p);
      c.drawLine(Offset(cx-s.width*.07,s.height*.58),Offset(cx-s.width*.10,s.height*.94),p);
      c.drawLine(Offset(cx+s.width*.07,s.height*.58),Offset(cx+s.width*.10,s.height*.94),p);
    }
    if(muscles){
      final p=Paint()..color=const Color(0xFFD64A4A).withValues(alpha:.75);
      if(!back){
        c.drawOval(Rect.fromCenter(center:Offset(cx-s.width*.09,s.height*.28),width:s.width*.16,height:s.height*.13),p);
        c.drawOval(Rect.fromCenter(center:Offset(cx+s.width*.09,s.height*.28),width:s.width*.16,height:s.height*.13),p);
        for(int i=0;i<3;i++){
          c.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center:Offset(cx-s.width*.045,s.height*(.41+i*.045)),width:s.width*.07,height:s.height*.035),const Radius.circular(8)),p);
          c.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center:Offset(cx+s.width*.045,s.height*(.41+i*.045)),width:s.width*.07,height:s.height*.035),const Radius.circular(8)),p);
        }
      } else {
        final path=Path()..moveTo(cx,s.height*.18)..lineTo(cx-s.width*.18,s.height*.30)..lineTo(cx-s.width*.12,s.height*.50)..lineTo(cx,s.height*.41)..lineTo(cx+s.width*.12,s.height*.50)..lineTo(cx+s.width*.18,s.height*.30)..close();
        c.drawPath(path,p);
      }
      c.drawOval(Rect.fromCenter(center:Offset(cx-s.width*.08,s.height*.72),width:s.width*.10,height:s.height*.22),p);
      c.drawOval(Rect.fromCenter(center:Offset(cx+s.width*.08,s.height*.72),width:s.width*.10,height:s.height*.22),p);
    }
    if(organs){
      if(!back){
        final lung=Paint()..color=const Color(0xFFE99CA7);
        c.drawOval(Rect.fromCenter(center:Offset(cx-s.width*.085,s.height*.29),width:s.width*.14,height:s.height*.18),lung);
        c.drawOval(Rect.fromCenter(center:Offset(cx+s.width*.085,s.height*.29),width:s.width*.14,height:s.height*.18),lung);
        c.drawOval(Rect.fromCenter(center:Offset(cx+s.width*.04,s.height*.315),width:s.width*.10,height:s.height*.10),Paint()..color=const Color(0xFFC44752));
        c.drawOval(Rect.fromCenter(center:Offset(cx-s.width*.04,s.height*.41),width:s.width*.24,height:s.height*.08),Paint()..color=const Color(0xFF85483F));
        c.drawOval(Rect.fromCenter(center:Offset(cx+s.width*.07,s.height*.435),width:s.width*.11,height:s.height*.10),Paint()..color=const Color(0xFFD68D72));
        final gut=Paint()..color=const Color(0xFFD59B75)..style=PaintingStyle.stroke..strokeWidth=8;
        for(int i=0;i<3;i++){c.drawArc(Rect.fromCenter(center:Offset(cx,s.height*(.50+i*.03)),width:s.width*.22,height:s.height*.06),0,5.4,false,gut);}
      } else {
        c.drawOval(Rect.fromCenter(center:Offset(cx-s.width*.07,s.height*.46),width:s.width*.07,height:s.height*.08),Paint()..color=const Color(0xFF965555));
        c.drawOval(Rect.fromCenter(center:Offset(cx+s.width*.07,s.height*.46),width:s.width*.07,height:s.height*.08),Paint()..color=const Color(0xFF965555));
      }
    }
    if(nerves){
      final p=Paint()..color=const Color(0xFFF2C94C)..strokeWidth=3..strokeCap=StrokeCap.round;
      c.drawCircle(Offset(cx,s.height*.075),18,Paint()..color=const Color(0xFFF2C94C).withValues(alpha:.65));
      c.drawLine(Offset(cx,s.height*.11),Offset(cx,s.height*.60),p);
      for(final y in <double>[.20,.28,.36,.44,.52]){
        c.drawLine(Offset(cx,s.height*y),Offset(cx-s.width*.16,s.height*(y+.03)),p);
        c.drawLine(Offset(cx,s.height*y),Offset(cx+s.width*.16,s.height*(y+.03)),p);
      }
    }
    if(vessels){
      final a=Paint()..color=const Color(0xFFD74040)..strokeWidth=4..strokeCap=StrokeCap.round;
      final v=Paint()..color=const Color(0xFF4779D8)..strokeWidth=4..strokeCap=StrokeCap.round;
      c.drawLine(Offset(cx+5,s.height*.16),Offset(cx+5,s.height*.62),a);
      c.drawLine(Offset(cx-5,s.height*.16),Offset(cx-5,s.height*.62),v);
      c.drawLine(Offset(cx,s.height*.29),Offset(s.width*.18,s.height*.54),a);
      c.drawLine(Offset(cx,s.height*.29),Offset(s.width*.82,s.height*.54),a);
      c.drawLine(Offset(cx,s.height*.58),Offset(cx-s.width*.10,s.height*.94),a);
      c.drawLine(Offset(cx,s.height*.58),Offset(cx+s.width*.10,s.height*.94),a);
    }
  }
  @override bool shouldRepaint(covariant BodyPainter oldDelegate)=>true;
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
