import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'smart_study.dart';

enum PathLevel { base, intermediate, advanced }

extension PathLevelX on PathLevel {
  String get label {
    switch (this) {
      case PathLevel.base: return 'Base';
      case PathLevel.intermediate: return 'Intermedio';
      case PathLevel.advanced: return 'Avanzato';
    }
  }

  String get emoji {
    switch (this) {
      case PathLevel.base: return '🌱';
      case PathLevel.intermediate: return '📘';
      case PathLevel.advanced: return '🎓';
    }
  }
}

class LearningLesson {
  final String id, title, emoji, system, summary;
  final PathLevel level;
  final List<String> keyPoints;
  final List<StudyQuestionV2> checkpoint;

  const LearningLesson({
    required this.id,
    required this.title,
    required this.emoji,
    required this.system,
    required this.summary,
    required this.level,
    required this.keyPoints,
    required this.checkpoint,
  });
}

const learningLessons = <LearningLesson>[
  LearningLesson(
    id:'base_01', title:'Orientarsi nel corpo umano', emoji:'🧍', system:'Generale', level:PathLevel.base,
    summary:'Piani anatomici, regioni corporee e linguaggio di base.',
    keyPoints:['Posizione anatomica standard','Piano sagittale, frontale e trasversale','Termini superiore/inferiore, mediale/laterale, prossimale/distale'],
    checkpoint:[
      StudyQuestionV2(id:'lp0101',category:'Generale',prompt:'Quale piano divide il corpo in destra e sinistra?',answers:['Sagittale','Frontale','Trasversale','Obliquo'],correct:0,explanation:'Il piano sagittale divide il corpo in porzioni destra e sinistra.'),
      StudyQuestionV2(id:'lp0102',category:'Generale',prompt:'Prossimale significa più vicino a cosa?',answers:['Al punto di origine o al tronco','Alla cute','Al piede','Alla linea mediana sempre'],correct:0,explanation:'Prossimale indica vicinanza all’origine di una struttura o al tronco.'),
      StudyQuestionV2(id:'lp0103',category:'Generale',prompt:'Mediale indica una posizione più vicina a...',answers:['Linea mediana','Superficie cutanea','Estremità distale','Piano posteriore'],correct:0,explanation:'Mediale significa più vicino alla linea mediana.'),
    ],
  ),
  LearningLesson(
    id:'base_02', title:'Scheletro essenziale', emoji:'🦴', system:'Scheletrico', level:PathLevel.base,
    summary:'Scheletro assile e appendicolare, principali ossa.',
    keyPoints:['206 ossa nell’adulto come conteggio convenzionale','Scheletro assile: cranio, colonna, gabbia toracica','Scheletro appendicolare: cinture e arti'],
    checkpoint:[
      StudyQuestionV2(id:'lp0201',category:'Scheletrico',prompt:'Quante ossa contiene convenzionalmente lo scheletro adulto?',answers:['206','126','80','306'],correct:0,explanation:'Il conteggio convenzionale è 206.'),
      StudyQuestionV2(id:'lp0202',category:'Scheletrico',prompt:'Il femore appartiene allo scheletro...',answers:['Appendicolare','Assile','Craniale','Viscerale'],correct:0,explanation:'Il femore appartiene all’arto inferiore e quindi allo scheletro appendicolare.'),
      StudyQuestionV2(id:'lp0203',category:'Scheletrico',prompt:'Quale struttura appartiene allo scheletro assile?',answers:['Sterno','Omero','Femore','Scapola'],correct:0,explanation:'Lo sterno appartiene alla gabbia toracica dello scheletro assile.'),
    ],
  ),
  LearningLesson(
    id:'base_03', title:'Muscoli e movimento', emoji:'💪', system:'Muscolare', level:PathLevel.base,
    summary:'Come i muscoli scheletrici producono movimento.',
    keyPoints:['Muscolo, tendine e inserzioni','Agonista e antagonista','Contrazione tramite actina e miosina'],
    checkpoint:[
      StudyQuestionV2(id:'lp0301',category:'Muscolare',prompt:'Quale struttura collega tipicamente muscolo e osso?',answers:['Tendine','Menisco','Nervo','Cartilagine ialina'],correct:0,explanation:'Il tendine trasmette la forza muscolare all’osso.'),
      StudyQuestionV2(id:'lp0302',category:'Muscolare',prompt:'Qual è l’unità contrattile del muscolo striato?',answers:['Sarcomero','Osteone','Lobulo','Nefrone'],correct:0,explanation:'Il sarcomero è l’unità contrattile.'),
      StudyQuestionV2(id:'lp0303',category:'Muscolare',prompt:'Il bicipite brachiale contribuisce soprattutto a...',answers:['Flessione del gomito','Estensione del ginocchio','Dorsiflessione','Inspirazione'],correct:0,explanation:'Il bicipite è un importante flessore del gomito.'),
    ],
  ),
  LearningLesson(
    id:'base_04', title:'Cuore e circolazione', emoji:'❤️', system:'Cardiovascolare', level:PathLevel.base,
    summary:'Le quattro camere e il circuito del sangue.',
    keyPoints:['Cuore destro → polmoni','Cuore sinistro → circolazione sistemica','Arterie portano sangue dal cuore, vene verso il cuore'],
    checkpoint:[
      StudyQuestionV2(id:'lp0401',category:'Cardiovascolare',prompt:'Quale camera pompa il sangue nell’aorta?',answers:['Ventricolo sinistro','Ventricolo destro','Atrio destro','Atrio sinistro'],correct:0,explanation:'Il ventricolo sinistro pompa nell’aorta.'),
      StudyQuestionV2(id:'lp0402',category:'Cardiovascolare',prompt:'Le vene polmonari arrivano a...',answers:['Atrio sinistro','Atrio destro','Ventricolo destro','Aorta'],correct:0,explanation:'Le vene polmonari riportano sangue ossigenato all’atrio sinistro.'),
      StudyQuestionV2(id:'lp0403',category:'Cardiovascolare',prompt:'Il ventricolo destro invia sangue verso...',answers:['Polmoni','Aorta','Reni direttamente','Carotidi'],correct:0,explanation:'Il ventricolo destro pompa nel tronco polmonare.'),
    ],
  ),
  LearningLesson(
    id:'base_05', title:'Respirazione', emoji:'🫁', system:'Respiratorio', level:PathLevel.base,
    summary:'Dall’ingresso dell’aria allo scambio alveolare.',
    keyPoints:['Naso → faringe → laringe → trachea','Bronchi e bronchioli distribuiscono l’aria','Alveoli: principale sede di scambio gassoso'],
    checkpoint:[
      StudyQuestionV2(id:'lp0501',category:'Respiratorio',prompt:'Dove avviene principalmente lo scambio gassoso?',answers:['Alveoli','Trachea','Laringe','Pleura'],correct:0,explanation:'Lo scambio avviene soprattutto negli alveoli.'),
      StudyQuestionV2(id:'lp0502',category:'Respiratorio',prompt:'Cosa viene prima dei bronchi?',answers:['Trachea','Alveoli','Pleura','Diaframma'],correct:0,explanation:'La trachea si divide nei bronchi principali.'),
      StudyQuestionV2(id:'lp0503',category:'Respiratorio',prompt:'Quale muscolo è fondamentale nell’inspirazione?',answers:['Diaframma','Bicipite','Masseterre','Tricipite'],correct:0,explanation:'Il diaframma è il principale muscolo inspiratorio.'),
    ],
  ),
  LearningLesson(
    id:'base_06', title:'Digestione e assorbimento', emoji:'🍎', system:'Digerente', level:PathLevel.base,
    summary:'Il viaggio del cibo e il ruolo degli organi digestivi.',
    keyPoints:['Stomaco: digestione meccanica e chimica','Intestino tenue: assorbimento principale','Fegato e pancreas supportano la digestione'],
    checkpoint:[
      StudyQuestionV2(id:'lp0601',category:'Digerente',prompt:'Quale tratto assorbe gran parte dei nutrienti?',answers:['Intestino tenue','Esofago','Retto','Appendice'],correct:0,explanation:'L’intestino tenue è la principale sede di assorbimento.'),
      StudyQuestionV2(id:'lp0602',category:'Digerente',prompt:'Quale organo produce la bile?',answers:['Fegato','Pancreas','Milza','Stomaco'],correct:0,explanation:'La bile è prodotta dal fegato.'),
      StudyQuestionV2(id:'lp0603',category:'Digerente',prompt:'Il duodeno riceve secrezioni da...',answers:['Pancreas e vie biliari','Tiroide','Rene','Timo'],correct:0,explanation:'Nel duodeno arrivano bile e secrezioni pancreatiche.'),
    ],
  ),
  LearningLesson(
    id:'int_01', title:'Sistema nervoso', emoji:'🧠', system:'Nervoso', level:PathLevel.intermediate,
    summary:'SNC, SNP, neuroni e trasmissione dei segnali.',
    keyPoints:['Cervello e midollo formano il SNC','Nervi periferici collegano il SNC al corpo','Sinapsi e potenziali d’azione permettono comunicazione'],
    checkpoint:[
      StudyQuestionV2(id:'lp0701',category:'Nervoso',prompt:'Cervello e midollo spinale formano...',answers:['SNC','SNP','Sistema endocrino','Sistema linfatico'],correct:0,explanation:'Sono le componenti principali del sistema nervoso centrale.'),
      StudyQuestionV2(id:'lp0702',category:'Nervoso',prompt:'Quale struttura porta il segnale lontano dal corpo cellulare del neurone?',answers:['Assone','Dendrite','Nucleo','Golgi'],correct:0,explanation:'L’assone conduce il segnale verso altre cellule.'),
      StudyQuestionV2(id:'lp0703',category:'Nervoso',prompt:'Quale ione entra nel terminale presinaptico per favorire il rilascio vescicolare?',answers:['Ca²⁺','Fe²⁺','I⁻','Cl⁻ soltanto'],correct:0,explanation:'Il calcio innesca la fusione delle vescicole.'),
    ],
  ),
  LearningLesson(
    id:'int_02', title:'Rene e omeostasi', emoji:'💧', system:'Urinario', level:PathLevel.intermediate,
    summary:'Nefrone, filtrazione e regolazione dei fluidi.',
    keyPoints:['Glomerulo: filtrazione','Tubuli: riassorbimento e secrezione','Rene: equilibrio idro-elettrolitico e acido-base'],
    checkpoint:[
      StudyQuestionV2(id:'lp0801',category:'Urinario',prompt:'Qual è l’unità funzionale del rene?',answers:['Nefrone','Alveolo','Sarcomero','Osteone'],correct:0,explanation:'Il nefrone è l’unità funzionale renale.'),
      StudyQuestionV2(id:'lp0802',category:'Urinario',prompt:'Dove inizia la filtrazione?',answers:['Glomerulo','Uretere','Vescica','Uretra'],correct:0,explanation:'La filtrazione inizia nel corpuscolo renale a livello glomerulare.'),
      StudyQuestionV2(id:'lp0803',category:'Urinario',prompt:'Quale cellula contribuisce alla barriera glomerulare?',answers:['Podocita','Pneumocita','Epatocita','Cheratinocita'],correct:0,explanation:'Il podocita contribuisce alla barriera di filtrazione.'),
    ],
  ),
  LearningLesson(
    id:'int_03', title:'Endocrino', emoji:'⚗️', system:'Endocrino', level:PathLevel.intermediate,
    summary:'Ormoni, ghiandole e feedback.',
    keyPoints:['Ipotalamo e ipofisi coordinano molti assi','Ormoni viaggiano nel sangue','Feedback negativo stabilizza molte variabili'],
    checkpoint:[
      StudyQuestionV2(id:'lp0901',category:'Endocrino',prompt:'Quale ormone ipofisario stimola la tiroide?',answers:['TSH','Insulina','Aldosterone','Melatonina'],correct:0,explanation:'Il TSH stimola la tiroide.'),
      StudyQuestionV2(id:'lp0902',category:'Endocrino',prompt:'L’insulina è prodotta principalmente da...',answers:['Cellule beta pancreatiche','Epatociti','Pneumociti','Podociti'],correct:0,explanation:'Le cellule beta delle isole pancreatiche producono insulina.'),
      StudyQuestionV2(id:'lp0903',category:'Endocrino',prompt:'Il feedback negativo tende a...',answers:['Stabilizzare una variabile','Amplificare indefinitamente una risposta','Bloccare ogni ormone','Eliminare i recettori'],correct:0,explanation:'Il feedback negativo contrasta deviazioni dalla regolazione.'),
    ],
  ),
  LearningLesson(
    id:'int_04', title:'Immunità e linfa', emoji:'🛡️', system:'Immunitario', level:PathLevel.intermediate,
    summary:'Organi linfoidi, cellule immunitarie e drenaggio linfatico.',
    keyPoints:['Midollo osseo e timo sono centrali nella maturazione immunitaria','Linfonodi filtrano la linfa','Milza filtra il sangue'],
    checkpoint:[
      StudyQuestionV2(id:'lp1001',category:'Immunitario',prompt:'Dove maturano principalmente i linfociti T?',answers:['Timo','Milza','Stomaco','Rene'],correct:0,explanation:'I linfociti T maturano nel timo.'),
      StudyQuestionV2(id:'lp1002',category:'Immunitario',prompt:'Quale organo filtra il sangue?',answers:['Milza','Linfonodo cervicale','Tiroide','Pancreas'],correct:0,explanation:'La milza filtra il sangue.'),
      StudyQuestionV2(id:'lp1003',category:'Immunitario',prompt:'Quale leucocita è importante nella risposta acuta?',answers:['Neutrofilo','Eritrocita','Piastrina','Osteocita'],correct:0,explanation:'Il neutrofilo è un fagocita della risposta acuta.'),
    ],
  ),
  LearningLesson(
    id:'int_05', title:'Istologia essenziale', emoji:'🔬', system:'Istologia', level:PathLevel.intermediate,
    summary:'I quattro grandi tessuti e cellule specializzate.',
    keyPoints:['Epiteliale','Connettivo','Muscolare','Nervoso'],
    checkpoint:[
      StudyQuestionV2(id:'lp1101',category:'Istologia',prompt:'Quale tessuto è ricco di matrice extracellulare?',answers:['Connettivo','Epiteliale sempre','Nervoso','Muscolare soltanto'],correct:0,explanation:'Il connettivo è caratterizzato da matrice extracellulare.'),
      StudyQuestionV2(id:'lp1102',category:'Istologia',prompt:'Quale tessuto forma rivestimenti?',answers:['Epiteliale','Osso compatto','Sangue','Cartilagine soltanto'],correct:0,explanation:'Gli epiteli rivestono superfici e cavità.'),
      StudyQuestionV2(id:'lp1103',category:'Istologia',prompt:'Il cardiomiocita appartiene a quale tessuto?',answers:['Muscolare cardiaco','Epiteliale','Cartilagineo','Nervoso'],correct:0,explanation:'Il cardiomiocita è la cellula contrattile del miocardio.'),
    ],
  ),
  LearningLesson(
    id:'int_06', title:'Articolazioni e stabilità', emoji:'🦿', system:'Scheletrico', level:PathLevel.intermediate,
    summary:'Articolazioni sinoviali, legamenti e controllo della mobilità.',
    keyPoints:['Cartilagine articolare riduce attrito','Capsula e legamenti stabilizzano','Muscoli controllano dinamicamente l’articolazione'],
    checkpoint:[
      StudyQuestionV2(id:'lp1201',category:'Scheletrico',prompt:'Quale legamento limita soprattutto la traslazione anteriore della tibia?',answers:['LCA','LCP','Deltoideo','Coraco-acromiale'],correct:0,explanation:'Il legamento crociato anteriore limita soprattutto la traslazione anteriore.'),
      StudyQuestionV2(id:'lp1202',category:'Scheletrico',prompt:'L’anca è un’articolazione...',answers:['Sferoidale','Trocleare pura','Fibrosa','Sutura'],correct:0,explanation:'La coxo-femorale è sinoviale sferoidale.'),
      StudyQuestionV2(id:'lp1203',category:'Scheletrico',prompt:'La cartilagine articolare serve soprattutto a...',answers:['Ridurre attrito e distribuire carico','Produrre ormoni','Trasportare impulsi','Formare sangue'],correct:0,explanation:'La cartilagine articolare facilita lo scorrimento e distribuisce i carichi.'),
    ],
  ),
  LearningLesson(
    id:'adv_01', title:'Conduzione cardiaca', emoji:'⚡', system:'Cardiovascolare', level:PathLevel.advanced,
    summary:'Nodo SA, nodo AV e propagazione ventricolare.',
    keyPoints:['Nodo SA: pacemaker principale','Nodo AV: rallenta la conduzione','His, branche e Purkinje distribuiscono l’impulso ai ventricoli'],
    checkpoint:[
      StudyQuestionV2(id:'lp1301',category:'Cardiovascolare',prompt:'Quale struttura rallenta fisiologicamente la conduzione dagli atri ai ventricoli?',answers:['Nodo AV','Nodo SA','Aorta','Valvola mitrale'],correct:0,explanation:'Il nodo AV rallenta la conduzione e trasmette l’impulso al sistema ventricolare.'),
      StudyQuestionV2(id:'lp1302',category:'Cardiovascolare',prompt:'Il fascio di His prosegue in...',answers:['Branche destra e sinistra','Vene cave','Arterie polmonari','Valvole semilunari'],correct:0,explanation:'Il fascio si divide nelle branche del sistema di conduzione.'),
      StudyQuestionV2(id:'lp1303',category:'Cardiovascolare',prompt:'Il pacemaker principale è normalmente...',answers:['Nodo senoatriale','Purkinje','Nodo AV','Miocardio ventricolare'],correct:0,explanation:'Il nodo senoatriale avvia normalmente il ritmo.'),
    ],
  ),
  LearningLesson(
    id:'adv_02', title:'Neuroanatomia funzionale', emoji:'🧠', system:'Nervoso', level:PathLevel.advanced,
    summary:'Lobi, tronco, cervelletto e nervi cranici.',
    keyPoints:['Lobo frontale: controllo esecutivo e motorio','Occipitale: elaborazione visiva','Tronco: nuclei cranici e centri vitali'],
    checkpoint:[
      StudyQuestionV2(id:'lp1401',category:'Nervoso',prompt:'Quale lobo è principalmente associato alla visione?',answers:['Occipitale','Frontale','Parietale','Insulare soltanto'],correct:0,explanation:'La corteccia visiva primaria è nel lobo occipitale.'),
      StudyQuestionV2(id:'lp1402',category:'Nervoso',prompt:'Quale nervo cranico è il X?',answers:['Vago','Trigemino','Faciale','Ottico'],correct:0,explanation:'Il X nervo cranico è il vago.'),
      StudyQuestionV2(id:'lp1403',category:'Nervoso',prompt:'Il cervelletto contribuisce soprattutto a...',answers:['Coordinazione e apprendimento motorio','Produzione di bile','Filtrazione renale','Emopoiesi'],correct:0,explanation:'Il cervelletto coordina timing e precisione dei movimenti.'),
    ],
  ),
  LearningLesson(
    id:'adv_03', title:'Microanatomia degli organi', emoji:'🧬', system:'Istologia', level:PathLevel.advanced,
    summary:'Collegare macroanatomia e strutture microscopiche.',
    keyPoints:['Alveolo → pneumocita','Glomerulo → podocita','Fegato → epatocita','Osso compatto → osteone'],
    checkpoint:[
      StudyQuestionV2(id:'lp1501',category:'Istologia',prompt:'Quale cellula forma gran parte della superficie alveolare?',answers:['Pneumocita I','Pneumocita II','Epatocita','Osteocita'],correct:0,explanation:'Il pneumocita I è appiattito e specializzato per lo scambio.'),
      StudyQuestionV2(id:'lp1502',category:'Istologia',prompt:'Quale cellula è tipica del glomerulo?',answers:['Podocita','Astrocita','Cheratinocita','Condrocita'],correct:0,explanation:'I podociti rivestono il foglietto viscerale della capsula glomerulare.'),
      StudyQuestionV2(id:'lp1503',category:'Istologia',prompt:'Qual è l’unità strutturale classica dell’osso compatto?',answers:['Osteone','Lobulo epatico','Alveolo','Nefrone'],correct:0,explanation:'L’osteone è la struttura cilindrica dell’osso compatto.'),
    ],
  ),
  LearningLesson(
    id:'adv_04', title:'Vascolarizzazione maggiore', emoji:'🩸', system:'Vascolare', level:PathLevel.advanced,
    summary:'Aorta, rami principali, sistema venoso e portale.',
    keyPoints:['Aorta distribuisce il flusso sistemico','Carotidi e vertebrali servono testa/encefalo','Sistema portale porta sangue intestinale al fegato'],
    checkpoint:[
      StudyQuestionV2(id:'lp1601',category:'Vascolare',prompt:'Quale vaso porta sangue intestinale al fegato?',answers:['Vena porta epatica','Vena cava superiore','Aorta','Arteria carotidea'],correct:0,explanation:'La vena porta convoglia il sangue dal tratto gastrointestinale al fegato.'),
      StudyQuestionV2(id:'lp1602',category:'Vascolare',prompt:'L’iliaca esterna continua come...',answers:['Femorale','Carotide','Brachiale','Renale'],correct:0,explanation:'Dopo il legamento inguinale continua come arteria femorale.'),
      StudyQuestionV2(id:'lp1603',category:'Vascolare',prompt:'Le arterie vertebrali contribuiscono alla circolazione...',answers:['Posteriore dell’encefalo','Del piede soltanto','Portale epatica','Coronarica'],correct:0,explanation:'Le vertebrali si uniscono nella basilare.'),
    ],
  ),
  LearningLesson(
    id:'adv_05', title:'Integrazione dei sistemi', emoji:'🔄', system:'Generale', level:PathLevel.advanced,
    summary:'Come più sistemi cooperano per mantenere l’omeostasi.',
    keyPoints:['Respiratorio + cardiovascolare per gas','Urinario + endocrino per volume e pressione','Nervoso + endocrino per regolazione'],
    checkpoint:[
      StudyQuestionV2(id:'lp1701',category:'Generale',prompt:'Quali sistemi cooperano direttamente nello scambio e trasporto di O₂?',answers:['Respiratorio e cardiovascolare','Scheletrico e dentale','Tegumentario e dentale','Linfatico e scheletrico soltanto'],correct:0,explanation:'I polmoni scambiano gas e il sangue li trasporta.'),
      StudyQuestionV2(id:'lp1702',category:'Generale',prompt:'Il rene contribuisce all’omeostasi regolando...',answers:['Acqua ed elettroliti','Solo movimento volontario','Solo vista','Solo digestione gastrica'],correct:0,explanation:'Il rene regola volume e composizione dei fluidi.'),
      StudyQuestionV2(id:'lp1703',category:'Generale',prompt:'Il sistema endocrino comunica soprattutto tramite...',answers:['Ormoni','Tendini','Ossa','Suture'],correct:0,explanation:'Gli ormoni sono segnali chimici circolanti.'),
    ],
  ),
  LearningLesson(
    id:'adv_06', title:'Checkpoint finale', emoji:'🏁', system:'Generale', level:PathLevel.advanced,
    summary:'Ripasso trasversale prima degli esami Pro.',
    keyPoints:['Riconosci strutture e sistemi','Collega struttura e funzione','Usa microanatomia e fisiologia insieme'],
    checkpoint:[
      StudyQuestionV2(id:'lp1801',category:'Generale',prompt:'Quale coppia struttura-funzione è corretta?',answers:['Alveolo — scambio gassoso','Osteone — produzione bile','Podocita — contrazione cardiaca','Epatocita — conduzione nervosa'],correct:0,explanation:'L’alveolo è specializzato nello scambio gassoso.'),
      StudyQuestionV2(id:'lp1802',category:'Generale',prompt:'Quale percorso macro→micro è coerente?',answers:['Rene → nefrone → glomerulo → podocita','Cuore → alveolo → osteone','Fegato → neurone → sarcomero','Cervello → villo → enterocita'],correct:0,explanation:'Il podocita appartiene al glomerulo del nefrone renale.'),
      StudyQuestionV2(id:'lp1803',category:'Generale',prompt:'Quale affermazione integra struttura e funzione?',answers:['La parete del ventricolo sinistro è spessa perché genera alta pressione','Il cranio produce bile','La trachea filtra il sangue','Il femore genera impulsi nervosi'],correct:0,explanation:'La struttura del ventricolo sinistro riflette il carico della circolazione sistemica.'),
    ],
  ),
];

class LearningPathStore extends ChangeNotifier {
  static const _key='edu01_learning_path_v1';
  final Set<String> completed={};
  bool initialized=false;

  Future<void> initialize() async {
    final prefs=await SharedPreferences.getInstance();
    final raw=prefs.getString(_key);
    if(raw!=null){
      try{
        final list=jsonDecode(raw);
        if(list is List) completed.addAll(list.map((e)=>e.toString()));
      }catch(_){}
    }
    initialized=true;
    notifyListeners();
  }

  Future<void> complete(String id) async {
    completed.add(id);
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString(_key,jsonEncode(completed.toList()));
    notifyListeners();
  }

  bool isUnlocked(int index)=>index==0||completed.contains(learningLessons[index-1].id);
  double get progress=>learningLessons.isEmpty?0:completed.length/learningLessons.length;
  LearningLesson? get nextLesson {
    for(final l in learningLessons){
      if(!completed.contains(l.id)) return l;
    }
    return null;
  }
}

class LearningPathPage extends StatefulWidget {
  final StudyProgressStore studyStore;
  const LearningPathPage({super.key,required this.studyStore});
  @override State<LearningPathPage> createState()=>_LearningPathPageState();
}

class _LearningPathPageState extends State<LearningPathPage> {
  final LearningPathStore pathStore=LearningPathStore();

  @override
  void initState(){
    super.initState();
    pathStore.addListener(_refresh);
    pathStore.initialize();
  }

  void _refresh(){if(mounted)setState((){});}

  @override
  void dispose(){
    pathStore.removeListener(_refresh);
    pathStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    if(!pathStore.initialized){
      return const Scaffold(body:Center(child:CircularProgressIndicator()));
    }
    final next=pathStore.nextLesson;
    final weak=widget.studyStore.weakestCategory;
    return Scaffold(
      appBar:AppBar(title:const Text('Learning Path')),
      body:ListView(
        padding:const EdgeInsets.fromLTRB(18,6,18,32),
        children:[
          Container(
            padding:const EdgeInsets.all(22),
            decoration:BoxDecoration(
              gradient:const LinearGradient(colors:[Color(0xFF356B8C),Color(0xFF5AA7A7)]),
              borderRadius:BorderRadius.circular(30),
            ),
            child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              const Text('🧭 Percorso guidato',style:TextStyle(color:Colors.white,fontSize:24,fontWeight:FontWeight.w900)),
              const SizedBox(height:6),
              Text((pathStore.progress*100).round().toString()+'% completato',style:const TextStyle(color:Colors.white70)),
              const SizedBox(height:12),
              LinearProgressIndicator(value:pathStore.progress,minHeight:10,backgroundColor:Colors.white24,borderRadius:BorderRadius.circular(20)),
            ]),
          ),
          if(next!=null)...[
            const SizedBox(height:18),
            const Text('Continua da qui',style:TextStyle(fontSize:21,fontWeight:FontWeight.w900)),
            const SizedBox(height:8),
            Card(child:ListTile(
              contentPadding:const EdgeInsets.all(16),
              leading:Text(next.emoji,style:const TextStyle(fontSize:36)),
              title:Text(next.title,style:const TextStyle(fontWeight:FontWeight.w900)),
              subtitle:Text(next.level.label+' · '+next.system),
              trailing:const Icon(Icons.play_circle_outline),
              onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>LearningLessonPage(lesson:next,onPassed:()=>pathStore.complete(next.id)))),
            )),
          ],
          if(weak!=null)...[
            const SizedBox(height:12),
            Container(
              padding:const EdgeInsets.all(14),
              decoration:BoxDecoration(color:Theme.of(context).colorScheme.secondaryContainer,borderRadius:BorderRadius.circular(18)),
              child:Text('📌 Smart Study segnala “'+weak+'” come area da rinforzare: nel percorso troverai lezioni collegate.',style:const TextStyle(fontWeight:FontWeight.w700)),
            ),
          ],
          const SizedBox(height:22),
          for(final level in PathLevel.values)...[
            Text(level.emoji+' '+level.label,style:const TextStyle(fontSize:21,fontWeight:FontWeight.w900)),
            const SizedBox(height:8),
            ...learningLessons.asMap().entries.where((e)=>e.value.level==level).map((entry){
              final index=entry.key;
              final lesson=entry.value;
              final complete=pathStore.completed.contains(lesson.id);
              final unlocked=pathStore.isUnlocked(index);
              return Card(
                margin:const EdgeInsets.only(bottom:8),
                child:ListTile(
                  contentPadding:const EdgeInsets.all(14),
                  leading:CircleAvatar(child:Text(complete?'✓':lesson.emoji)),
                  title:Text(lesson.title,style:const TextStyle(fontWeight:FontWeight.w900)),
                  subtitle:Text(lesson.system+' · '+lesson.summary,maxLines:2,overflow:TextOverflow.ellipsis),
                  trailing:Icon(complete?Icons.check_circle:unlocked?Icons.chevron_right:Icons.lock_outline),
                  enabled:unlocked,
                  onTap:unlocked?()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>LearningLessonPage(lesson:lesson,onPassed:()=>pathStore.complete(lesson.id)))):null,
                ),
              );
            }),
            const SizedBox(height:12),
          ],
        ],
      ),
    );
  }
}

class LearningLessonPage extends StatefulWidget {
  final LearningLesson lesson;
  final Future<void> Function() onPassed;
  const LearningLessonPage({super.key,required this.lesson,required this.onPassed});
  @override State<LearningLessonPage> createState()=>_LearningLessonPageState();
}

class _LearningLessonPageState extends State<LearningLessonPage> {
  int stage=0;
  int qIndex=0;
  int score=0;
  int? selected;
  bool answered=false;

  @override
  Widget build(BuildContext context){
    final l=widget.lesson;
    if(stage==0){
      return Scaffold(
        appBar:AppBar(title:Text(l.emoji+' '+l.title)),
        body:ListView(
          padding:const EdgeInsets.all(20),
          children:[
            Container(
              padding:const EdgeInsets.all(22),
              decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(28)),
              child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                Text(l.emoji,style:const TextStyle(fontSize:56)),
                const SizedBox(height:8),
                Text(l.title,style:const TextStyle(fontSize:27,fontWeight:FontWeight.w900)),
                const SizedBox(height:6),
                Text(l.summary),
              ]),
            ),
            const SizedBox(height:20),
            const Text('Cosa devi sapere',style:TextStyle(fontSize:21,fontWeight:FontWeight.w900)),
            const SizedBox(height:8),
            ...l.keyPoints.asMap().entries.map((e)=>Card(child:ListTile(
              leading:CircleAvatar(child:Text((e.key+1).toString())),
              title:Text(e.value,style:const TextStyle(fontWeight:FontWeight.w700)),
            ))),
            const SizedBox(height:18),
            FilledButton.icon(
              onPressed:()=>setState(()=>stage=1),
              icon:const Icon(Icons.quiz_outlined),
              label:const Padding(padding:EdgeInsets.symmetric(vertical:13),child:Text('Checkpoint')),
            ),
          ],
        ),
      );
    }

    if(qIndex>=l.checkpoint.length){
      final passed=score>=2;
      return Scaffold(
        appBar:AppBar(title:const Text('Checkpoint')),
        body:Center(child:Padding(
          padding:const EdgeInsets.all(28),
          child:Column(mainAxisSize:MainAxisSize.min,children:[
            Text(passed?'✅':'📚',style:const TextStyle(fontSize:78)),
            const SizedBox(height:12),
            Text(score.toString()+'/3',style:const TextStyle(fontSize:40,fontWeight:FontWeight.w900)),
            const SizedBox(height:8),
            Text(passed?'Lezione completata.':'Servono almeno 2 risposte corrette.',textAlign:TextAlign.center),
            const SizedBox(height:22),
            FilledButton(
              onPressed:() async {
                if(passed) await widget.onPassed();
                if(!mounted)return;
                if(passed){
                  Navigator.pop(context);
                }else{
                  setState((){qIndex=0;score=0;selected=null;answered=false;});
                }
              },
              child:Text(passed?'Continua il percorso':'Riprova'),
            ),
          ]),
        )),
      );
    }

    final q=l.checkpoint[qIndex];
    return Scaffold(
      appBar:AppBar(title:const Text('Checkpoint')),
      body:Padding(
        padding:const EdgeInsets.all(20),
        child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          LinearProgressIndicator(value:(qIndex+1)/l.checkpoint.length,minHeight:7,borderRadius:BorderRadius.circular(20)),
          const SizedBox(height:22),
          Text(q.prompt,style:const TextStyle(fontSize:23,fontWeight:FontWeight.w900)),
          const SizedBox(height:18),
          Expanded(child:ListView.separated(
            itemCount:q.answers.length,
            separatorBuilder:(_,__)=>const SizedBox(height:8),
            itemBuilder:(_,i){
              Color? color;
              if(answered&&i==q.correct)color=Colors.green.withValues(alpha:.15);
              else if(answered&&selected==i)color=Colors.red.withValues(alpha:.12);
              return Material(
                color:color??Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius:BorderRadius.circular(18),
                child:ListTile(
                  title:Text(q.answers[i],style:const TextStyle(fontWeight:FontWeight.w700)),
                  onTap:answered?null:()=>setState((){selected=i;answered=true;if(i==q.correct)score++;}),
                ),
              );
            },
          )),
          if(answered)...[
            Text(q.explanation),
            const SizedBox(height:12),
            SizedBox(width:double.infinity,child:FilledButton(
              onPressed:()=>setState((){qIndex++;selected=null;answered=false;}),
              child:const Text('Continua'),
            )),
          ],
        ]),
      ),
    );
  }
}
