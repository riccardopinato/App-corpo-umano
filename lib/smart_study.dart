import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudyQuestionV2 {
  final String id,category,prompt,explanation;
  final List<String> answers;
  final int correct;
  const StudyQuestionV2({
    required this.id,required this.category,required this.prompt,required this.answers,required this.correct,required this.explanation,
  });
}

const studyQuestionBank=<StudyQuestionV2>[
  StudyQuestionV2(id:'q01',category:'Scheletrico',prompt:'Quante ossa contiene convenzionalmente lo scheletro adulto?',answers:['106','206','306','406'],correct:1,explanation:'Il conteggio convenzionale dell’adulto è 206.'),
  StudyQuestionV2(id:'q02',category:'Scheletrico',prompt:'Quale vertebra è chiamata Atlante?',answers:['C1','C2','C7','T1'],correct:0,explanation:'C1 è l’Atlante e articola con i condili occipitali.'),
  StudyQuestionV2(id:'q03',category:'Scheletrico',prompt:'Quale vertebra presenta il dente dell’epistrofeo?',answers:['C1','C2','L5','T12'],correct:1,explanation:'Il dente è una caratteristica di C2, l’Epistrofeo.'),
  StudyQuestionV2(id:'q04',category:'Scheletrico',prompt:'Quante ossa contiene ogni mano?',answers:['18','22','27','32'],correct:2,explanation:'Carpo 8 + metacarpo 5 + falangi 14 = 27.'),
  StudyQuestionV2(id:'q05',category:'Muscolare',prompt:'A quale proteina si lega il Ca²⁺ nel muscolo scheletrico?',answers:['Troponina','Cheratina','Albumina','Collagene'],correct:0,explanation:'Il Ca²⁺ si lega alla troponina, favorendo lo spostamento della tropomiosina.'),
  StudyQuestionV2(id:'q06',category:'Muscolare',prompt:'Qual è l’unità contrattile ripetuta del muscolo striato?',answers:['Osteone','Sarcomero','Lobulo','Alveolo'],correct:1,explanation:'Il sarcomero è l’unità contrattile tra due linee Z.'),
  StudyQuestionV2(id:'q07',category:'Cardiovascolare',prompt:'Quale camera genera la pressione della circolazione sistemica?',answers:['Atrio destro','Ventricolo destro','Atrio sinistro','Ventricolo sinistro'],correct:3,explanation:'Il ventricolo sinistro espelle sangue nell’aorta.'),
  StudyQuestionV2(id:'q08',category:'Cardiovascolare',prompt:'Quale valvola si trova tra atrio e ventricolo sinistro?',answers:['Tricuspide','Mitrale','Polmonare','Aortica'],correct:1,explanation:'La valvola mitrale separa atrio e ventricolo sinistro.'),
  StudyQuestionV2(id:'q09',category:'Cardiovascolare',prompt:'Qual è normalmente il pacemaker fisiologico principale?',answers:['Nodo AV','Nodo senoatriale','Fascio di His','Purkinje'],correct:1,explanation:'Il nodo senoatriale avvia normalmente il ritmo cardiaco.'),
  StudyQuestionV2(id:'q10',category:'Respiratorio',prompt:'Dove avviene principalmente lo scambio gassoso?',answers:['Trachea','Bronchi','Alveoli','Pleura'],correct:2,explanation:'La barriera alveolo-capillare è la principale superficie di scambio.'),
  StudyQuestionV2(id:'q11',category:'Respiratorio',prompt:'Quale cellula produce surfattante?',answers:['Pneumocita I','Pneumocita II','Eritrocita','Enterocita'],correct:1,explanation:'I pneumociti di tipo II producono surfattante.'),
  StudyQuestionV2(id:'q12',category:'Digerente',prompt:'Quale cellula è specializzata nell’assorbimento intestinale?',answers:['Podocita','Enterocita','Astrocita','Osteocita'],correct:1,explanation:'Gli enterociti possiedono microvilli che ampliano la superficie assorbente.'),
  StudyQuestionV2(id:'q13',category:'Digerente',prompt:'Quale cellula è la principale cellula funzionale del fegato?',answers:['Epatocita','Condrocita','Neutrofilo','Cardiomiocita'],correct:0,explanation:'L’epatocita svolge numerose funzioni metaboliche e secretorie.'),
  StudyQuestionV2(id:'q14',category:'Urinario',prompt:'Quale cellula contribuisce direttamente alla barriera di filtrazione glomerulare?',answers:['Podocita','Pneumocita','Cheratinocita','Linfocita'],correct:0,explanation:'I pedicelli dei podociti partecipano alle fessure di filtrazione.'),
  StudyQuestionV2(id:'q15',category:'Urinario',prompt:'Quale segmento riassorbe una grande quota del filtrato subito dopo la capsula?',answers:['Tubulo prossimale','Uretere','Vescica','Dotto eiaculatore'],correct:0,explanation:'Il tubulo prossimale svolge un riassorbimento massivo.'),
  StudyQuestionV2(id:'q16',category:'Nervoso',prompt:'Quale nervo cranico è il X?',answers:['Trigemino','Vago','Faciale','Ipoglosso'],correct:1,explanation:'Il nervo vago è il decimo nervo cranico.'),
  StudyQuestionV2(id:'q17',category:'Nervoso',prompt:'Quale ione entra rapidamente durante la depolarizzazione neuronale?',answers:['Na⁺','K⁺','Fe²⁺','I⁻'],correct:0,explanation:'L’apertura dei canali del sodio favorisce l’ingresso di Na⁺.'),
  StudyQuestionV2(id:'q18',category:'Nervoso',prompt:'Quale ingresso ionico presinaptico innesca l’esocitosi delle vescicole?',answers:['Ca²⁺','Na⁺','Cl⁻','Mg²⁺'],correct:0,explanation:'L’ingresso di Ca²⁺ nel terminale presinaptico innesca la fusione vescicolare.'),
  StudyQuestionV2(id:'q19',category:'Nervoso',prompt:'Il plesso brachiale deriva principalmente da quali radici?',answers:['C1-C4','C5-T1','T5-T12','L1-L4'],correct:1,explanation:'Il plesso brachiale deriva principalmente da C5-T1.'),
  StudyQuestionV2(id:'q20',category:'Immunitario',prompt:'Quale leucocita è un granulocita importante nell’infiammazione acuta?',answers:['Neutrofilo','Eritrocita','Piastrina','Osteocita'],correct:0,explanation:'Il neutrofilo è un fagocita granulocita molto abbondante.'),
  StudyQuestionV2(id:'q21',category:'Istologia',prompt:'Quale tessuto è organizzato in osteoni?',answers:['Osso compatto','Cartilagine ialina','Muscolo liscio','Epitelio'],correct:0,explanation:'L’osso compatto è organizzato in osteoni concentrici.'),
  StudyQuestionV2(id:'q22',category:'Istologia',prompt:'Quale cellula matura vive nelle lacune della matrice ossea?',answers:['Osteocita','Condrocita','Epatocita','Astrocita'],correct:0,explanation:'Gli osteociti sono cellule ossee mature contenute nelle lacune.'),
  StudyQuestionV2(id:'q23',category:'Istologia',prompt:'Quale tessuto muscolare è striato ma involontario?',answers:['Cardiaco','Scheletrico','Liscio','Connettivo'],correct:0,explanation:'Il muscolo cardiaco è striato e involontario.'),
  StudyQuestionV2(id:'q24',category:'Cellula',prompt:'Quale organello produce gran parte dell’ATP?',answers:['Mitocondrio','Golgi','Nucleo','Lisosoma'],correct:0,explanation:'I mitocondri producono ATP tramite fosforilazione ossidativa.'),
  StudyQuestionV2(id:'q25',category:'Cellula',prompt:'Quale organello modifica e smista molte proteine?',answers:['Golgi','Mitocondrio','Centriolo','Nucleolo'],correct:0,explanation:'L’apparato di Golgi modifica, ordina e smista proteine e lipidi.'),
  StudyQuestionV2(id:'q26',category:'Vascolare',prompt:'Quale vaso porta sangue dal tratto gastrointestinale al fegato?',answers:['Vena porta epatica','Aorta','Vena cava superiore','Arteria renale'],correct:0,explanation:'La vena porta convoglia sangue ricco di nutrienti al fegato.'),
  StudyQuestionV2(id:'q27',category:'Vascolare',prompt:'Quale arteria continua come femorale dopo il legamento inguinale?',answers:['Iliaca esterna','Iliaca interna','Mesenterica','Succlavia'],correct:0,explanation:'L’iliaca esterna continua come arteria femorale.'),
  StudyQuestionV2(id:'q28',category:'Cranio',prompt:'Quale struttura attraversa il canale ottico?',answers:['Nervo ottico','Nervo vago','Nervo faciale','Nervo accessorio'],correct:0,explanation:'Il nervo ottico II e l’arteria oftalmica attraversano il canale ottico.'),
  StudyQuestionV2(id:'q29',category:'Cranio',prompt:'Quale nervo attraversa principalmente il forame ovale?',answers:['V3 mandibolare','V2 mascellare','II ottico','VII faciale'],correct:0,explanation:'La branca mandibolare V3 passa attraverso il forame ovale.'),
  StudyQuestionV2(id:'q30',category:'Endocrino',prompt:'Quale ghiandola è controllata da TSH?',answers:['Tiroide','Surrene midollare','Parotide','Timo'],correct:0,explanation:'Il TSH ipofisario stimola la tiroide.'),
  StudyQuestionV2(id:'q31',category:'Tegumentario',prompt:'Quale cellula è la principale cellula dell’epidermide?',answers:['Cheratinocita','Epatocita','Podocita','Cardiomiocita'],correct:0,explanation:'Il cheratinocita è la cellula predominante dell’epidermide.'),
  StudyQuestionV2(id:'q32',category:'Cardiovascolare',prompt:'Quale vaso esce dal ventricolo destro?',answers:['Tronco polmonare','Aorta','Vena cava','Vena polmonare'],correct:0,explanation:'Il ventricolo destro espelle sangue nel tronco polmonare.'),
  StudyQuestionV2(id:'q33',category:'Respiratorio',prompt:'Quale struttura manca di cartilagine e regola la resistenza delle piccole vie aeree?',answers:['Bronchiolo','Trachea','Bronco principale','Laringe'],correct:0,explanation:'I bronchioli non hanno cartilagine e contengono muscolatura liscia.'),
  StudyQuestionV2(id:'q34',category:'Scheletrico',prompt:'Qual è il più grande osso del piede?',answers:['Calcagno','Astragalo','Navicolare','Cuboide'],correct:0,explanation:'Il calcagno è il più grande osso del piede.'),
  StudyQuestionV2(id:'q35',category:'Muscolare',prompt:'Quale neurotrasmettitore è rilasciato alla giunzione neuromuscolare scheletrica?',answers:['Acetilcolina','Dopamina','Serotonina','GABA'],correct:0,explanation:'Il motoneurone somatico rilascia acetilcolina.'),
  StudyQuestionV2(id:'q36',category:'Digerente',prompt:'Quale tratto riceve direttamente chimo gastrico, bile e secrezioni pancreatiche?',answers:['Duodeno','Ileo','Colon sigmoideo','Retto'],correct:0,explanation:'Il duodeno è la prima porzione dell’intestino tenue.'),
];

class StudyProgressStore extends ChangeNotifier {
  static const String _key='edu01_smart_study_v2';

  final Map<String,int> attempts={};
  final Map<String,int> correct={};
  final Map<String,int> intervalDays={};
  final Map<String,int> dueMillis={};
  final Map<String,int> dailyCount={};
  final List<int> examScores=[];

  int xp=0;
  int streak=0;
  String lastStudyDay='';
  bool initialized=false;

  Future<void> initialize() async {
    final prefs=await SharedPreferences.getInstance();
    final raw=prefs.getString(_key);
    if(raw!=null){
      try{
        final data=jsonDecode(raw) as Map<String,dynamic>;
        _readMap(data['attempts'],attempts);
        _readMap(data['correct'],correct);
        _readMap(data['intervalDays'],intervalDays);
        _readMap(data['dueMillis'],dueMillis);
        _readMap(data['dailyCount'],dailyCount);
        xp=(data['xp'] as num?)?.toInt()??0;
        streak=(data['streak'] as num?)?.toInt()??0;
        lastStudyDay=data['lastStudyDay']?.toString()??'';
        final exams=data['examScores'];
        if(exams is List){
          examScores
            ..clear()
            ..addAll(exams.whereType<num>().map((e)=>e.toInt()));
        }
      }catch(_){}
    }
    initialized=true;
    notifyListeners();
  }

  void _readMap(dynamic raw,Map<String,int> target){
    if(raw is Map){
      for(final e in raw.entries){
        if(e.value is num)target[e.key.toString()]=(e.value as num).toInt();
      }
    }
  }

  String _dayKey(DateTime d)=>d.year.toString()+'-'+d.month.toString().padLeft(2,'0')+'-'+d.day.toString().padLeft(2,'0');

  void _touchStudyDay(){
    final now=DateTime.now();
    final today=_dayKey(now);
    if(lastStudyDay==today)return;
    final yesterday=_dayKey(now.subtract(const Duration(days:1)));
    streak=lastStudyDay==yesterday?streak+1:1;
    lastStudyDay=today;
  }

  Future<void> recordAnswer(StudyQuestionV2 q,bool ok) async {
    attempts[q.id]=(attempts[q.id]??0)+1;
    if(ok)correct[q.id]=(correct[q.id]??0)+1;
    final old=intervalDays[q.id]??0;
    final next=ok?(old<=0?1:(old==1?3:(old<=3?7:min(60,(old*1.8).round())))):0;
    intervalDays[q.id]=next;
    dueMillis[q.id]=DateTime.now().add(Duration(days:next)).millisecondsSinceEpoch;
    xp+=ok?10:3;
    _touchStudyDay();
    final day=_dayKey(DateTime.now());
    dailyCount[day]=(dailyCount[day]??0)+1;
    await _save();
    notifyListeners();
  }

  Future<void> recordExam(int percent) async {
    examScores.insert(0,percent);
    if(examScores.length>20)examScores.removeRange(20,examScores.length);
    xp+=percent>=80?50:20;
    _touchStudyDay();
    await _save();
    notifyListeners();
  }

  Future<void> reset() async {
    attempts.clear();correct.clear();intervalDays.clear();dueMillis.clear();dailyCount.clear();examScores.clear();
    xp=0;streak=0;lastStudyDay='';
    await _save();
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString(_key,jsonEncode({
      'attempts':attempts,'correct':correct,'intervalDays':intervalDays,'dueMillis':dueMillis,
      'dailyCount':dailyCount,'xp':xp,'streak':streak,'lastStudyDay':lastStudyDay,'examScores':examScores,
    }));
  }

  int get totalAnswers=>attempts.values.fold(0,(a,b)=>a+b);
  int get totalCorrect=>correct.values.fold(0,(a,b)=>a+b);
  int get accuracy=>totalAnswers==0?0:(totalCorrect*100/totalAnswers).round();
  int get level=>1+(xp~/250);
  int get todayCount=>dailyCount[_dayKey(DateTime.now())]??0;
  int get dailyGoal=>10;
  double get dailyProgress=>(todayCount/dailyGoal).clamp(0.0,1.0);

  List<StudyQuestionV2> get dueQuestions {
    final now=DateTime.now().millisecondsSinceEpoch;
    return studyQuestionBank.where((q)=>(attempts[q.id]??0)>0&&(dueMillis[q.id]??0)<=now).toList();
  }

  List<StudyQuestionV2> get wrongQuestions {
    final list=studyQuestionBank.where((q)=>(attempts[q.id]??0)>(correct[q.id]??0)).toList();
    list.sort((a,b)=>errorRate(b).compareTo(errorRate(a)));
    return list;
  }

  double errorRate(StudyQuestionV2 q){
    final a=attempts[q.id]??0;
    if(a==0)return 0;
    return 1-(correct[q.id]??0)/a;
  }

  int masteryFor(String category){
    final qs=studyQuestionBank.where((q)=>q.category==category);
    int a=0,c=0;
    for(final q in qs){a+=attempts[q.id]??0;c+=correct[q.id]??0;}
    return a==0?0:(c*100/a).round();
  }

  List<String> get categories {
    final set=<String>{for(final q in studyQuestionBank)q.category};
    return set.toList()..sort();
  }

  String? get weakestCategory {
    final seen=categories.where((c)=>studyQuestionBank.where((q)=>q.category==c).any((q)=>(attempts[q.id]??0)>0)).toList();
    if(seen.isEmpty)return null;
    seen.sort((a,b)=>masteryFor(a).compareTo(masteryFor(b)));
    return seen.first;
  }
}

class SmartStudyV2Page extends StatelessWidget {
  final StudyProgressStore store;
  const SmartStudyV2Page({super.key,required this.store});

  List<StudyQuestionV2> _randomQuestions(int count,{String? category}){
    final pool=studyQuestionBank.where((q)=>category==null||q.category==category).toList()..shuffle(Random());
    return pool.take(count).toList();
  }

  @override
  Widget build(BuildContext context)=>AnimatedBuilder(
    animation:store,
    builder:(context,_){
      if(!store.initialized)return const Scaffold(body:Center(child:CircularProgressIndicator()));
      final weak=store.weakestCategory;
      return Scaffold(
        appBar:AppBar(title:const Text('Smart Study 2.0')),
        body:ListView(padding:const EdgeInsets.fromLTRB(18,4,18,32),children:[
          Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF6250E6),Color(0xFF8C7CF3)]),borderRadius:BorderRadius.circular(30)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Row(children:[Expanded(child:Text('Livello '+store.level.toString(),style:const TextStyle(color:Colors.white,fontSize:24,fontWeight:FontWeight.w900))),Text('🔥 '+store.streak.toString(),style:const TextStyle(color:Colors.white,fontWeight:FontWeight.w900))]),
            const SizedBox(height:4),
            Text(store.xp.toString()+' XP · '+store.totalAnswers.toString()+' risposte · '+store.accuracy.toString()+'% precisione',style:const TextStyle(color:Colors.white70)),
            const SizedBox(height:14),
            LinearProgressIndicator(value:store.dailyProgress,minHeight:10,backgroundColor:Colors.white24,borderRadius:BorderRadius.circular(20)),
            const SizedBox(height:7),
            Text('Obiettivo oggi: '+store.todayCount.toString()+'/'+store.dailyGoal.toString(),style:const TextStyle(color:Colors.white)),
          ])),
          const SizedBox(height:18),
          if(store.dueQuestions.isNotEmpty)
            ActionCardV2(emoji:'🔁',title:'Ripasso in scadenza',subtitle:store.dueQuestions.length.toString()+' domande dovute oggi',badge:'Priorità',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>StudyQuizSession(store:store,questions:store.dueQuestions.take(20).toList(),title:'Ripasso in scadenza')))),
          if(store.dueQuestions.isNotEmpty)const SizedBox(height:8),
          if(store.wrongQuestions.isNotEmpty)
            ActionCardV2(emoji:'🎯',title:'Correggi gli errori',subtitle:store.wrongQuestions.length.toString()+' domande con errori registrati',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>StudyQuizSession(store:store,questions:store.wrongQuestions.take(20).toList(),title:'Errori da correggere')))),
          if(store.wrongQuestions.isNotEmpty)const SizedBox(height:8),
          ActionCardV2(emoji:'⚡',title:'Quiz rapido',subtitle:'10 domande miste da tutto il database',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>StudyQuizSession(store:store,questions:_randomQuestions(10),title:'Quiz rapido')))),
          const SizedBox(height:8),
          ActionCardV2(emoji:'🧠',title:'Flashcard intelligenti',subtitle:'Prima errori e categorie più deboli',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>SmartFlashcardsPage(store:store)))),
          const SizedBox(height:8),
          ActionCardV2(emoji:'🎓',title:'Esame 20',subtitle:'20 domande · risultati solo alla fine',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>StudyQuizSession(store:store,questions:_randomQuestions(20),title:'Esame 20',examMode:true)))),
          const SizedBox(height:8),
          ActionCardV2(emoji:'📊',title:'Mastery',subtitle:'Preparazione per area anatomica',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>MasteryV2Page(store:store)))),
          if(weak!=null)...[
            const SizedBox(height:20),const Text('Consigliato per te',style:TextStyle(fontSize:21,fontWeight:FontWeight.w900)),const SizedBox(height:8),
            ActionCardV2(emoji:'📌',title:'Rinforza '+weak,subtitle:'Mastery '+store.masteryFor(weak).toString()+'% · sessione mirata',badge:'Debole',onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>StudyQuizSession(store:store,questions:_randomQuestions(10,category:weak),title:weak)))),
          ],
          const SizedBox(height:22),const Text('Categorie',style:TextStyle(fontSize:21,fontWeight:FontWeight.w900)),const SizedBox(height:8),
          ...store.categories.map((c)=>Card(margin:const EdgeInsets.only(bottom:7),child:ListTile(
            title:Text(c,style:const TextStyle(fontWeight:FontWeight.w800)),
            subtitle:LinearProgressIndicator(value:store.masteryFor(c)/100,minHeight:6,borderRadius:BorderRadius.circular(20)),
            trailing:Text(store.masteryFor(c).toString()+'%',style:const TextStyle(fontWeight:FontWeight.w900)),
            onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>StudyQuizSession(store:store,questions:_randomQuestions(10,category:c),title:c))),
          ))),
        ]),
      );
    },
  );
}

class ActionCardV2 extends StatelessWidget {
  final String emoji,title,subtitle;
  final String? badge;
  final VoidCallback onTap;
  const ActionCardV2({super.key,required this.emoji,required this.title,required this.subtitle,required this.onTap,this.badge});
  @override
  Widget build(BuildContext context)=>Card(child:ListTile(
    contentPadding:const EdgeInsets.all(15),
    leading:Text(emoji,style:const TextStyle(fontSize:34)),
    title:Row(children:[
      Expanded(child:Text(title,style:const TextStyle(fontWeight:FontWeight.w900))),
      if(badge!=null)Container(padding:const EdgeInsets.symmetric(horizontal:7,vertical:3),decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(12)),child:Text(badge!,style:const TextStyle(fontSize:10,fontWeight:FontWeight.w900))),
    ]),
    subtitle:Text(subtitle),trailing:const Icon(Icons.chevron_right),onTap:onTap,
  ));
}

class StudyQuizSession extends StatefulWidget {
  final StudyProgressStore store;
  final List<StudyQuestionV2> questions;
  final String title;
  final bool examMode;
  const StudyQuizSession({super.key,required this.store,required this.questions,required this.title,this.examMode=false});
  @override State<StudyQuizSession> createState()=>_StudyQuizSessionState();
}

class _StudyQuizSessionState extends State<StudyQuizSession> {
  int index=0,score=0;
  int? selected;
  bool answered=false,savedExam=false;
  late List<int?> examAnswers;

  @override void initState(){super.initState();examAnswers=List<int?>.filled(widget.questions.length,null);}

  @override
  Widget build(BuildContext context){
    if(widget.questions.isEmpty)return Scaffold(appBar:AppBar(title:Text(widget.title)),body:const Center(child:Text('Nessuna domanda disponibile.')));
    if(index>=widget.questions.length)return _result(context);
    final q=widget.questions[index];
    return Scaffold(
      appBar:AppBar(title:Text(widget.title)),
      body:Padding(padding:const EdgeInsets.all(20),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Row(children:[Text((index+1).toString()+'/'+widget.questions.length.toString(),style:const TextStyle(fontWeight:FontWeight.w900)),const Spacer(),Text(q.category,style:TextStyle(color:Theme.of(context).colorScheme.primary,fontWeight:FontWeight.w700))]),
        const SizedBox(height:8),
        LinearProgressIndicator(value:(index+1)/widget.questions.length,minHeight:7,borderRadius:BorderRadius.circular(20)),
        const SizedBox(height:22),
        Text(q.prompt,style:const TextStyle(fontSize:23,fontWeight:FontWeight.w900)),
        const SizedBox(height:18),
        Expanded(child:ListView.separated(
          itemCount:q.answers.length,separatorBuilder:(_,__)=>const SizedBox(height:8),
          itemBuilder:(_,i){
            final chosen=selected==i;
            final right=i==q.correct;
            Color? bg;
            if(!widget.examMode&&answered&&right)bg=Colors.green.withValues(alpha:.15);
            else if(!widget.examMode&&answered&&chosen&&!right)bg=Colors.red.withValues(alpha:.12);
            else if(widget.examMode&&chosen)bg=Theme.of(context).colorScheme.primaryContainer;
            return Material(color:bg??Theme.of(context).colorScheme.surfaceContainerLow,borderRadius:BorderRadius.circular(18),child:ListTile(title:Text(q.answers[i],style:const TextStyle(fontWeight:FontWeight.w700)),onTap:answered&&!widget.examMode?null:()=>_select(q,i)));
          },
        )),
        if(!widget.examMode&&answered)...[
          Container(width:double.infinity,padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:Theme.of(context).colorScheme.secondaryContainer,borderRadius:BorderRadius.circular(18)),child:Text(q.explanation)),
          const SizedBox(height:10),
        ],
        SizedBox(width:double.infinity,child:FilledButton(
          onPressed:(widget.examMode?selected!=null:answered)?_next:null,
          child:Padding(padding:const EdgeInsets.symmetric(vertical:13),child:Text(index==widget.questions.length-1?'Risultato':'Continua')),
        )),
      ])),
    );
  }

  Future<void> _select(StudyQuestionV2 q,int i) async {
    if(widget.examMode){setState((){selected=i;examAnswers[index]=i;});return;}
    final ok=i==q.correct;
    await widget.store.recordAnswer(q,ok);
    if(!mounted)return;
    setState((){selected=i;answered=true;if(ok)score++;});
  }

  Future<void> _next() async {
    if(widget.examMode){
      final q=widget.questions[index];
      final answer=examAnswers[index];
      if(answer!=null){
        final ok=answer==q.correct;
        await widget.store.recordAnswer(q,ok);
        if(ok)score++;
      }
    }
    if(!mounted)return;
    setState((){index++;selected=null;answered=false;});
  }

  Widget _result(BuildContext context){
    final percent=(score*100/widget.questions.length).round();
    if(widget.examMode&&!savedExam){
      savedExam=true;
      WidgetsBinding.instance.addPostFrameCallback((_)=>widget.store.recordExam(percent));
    }
    return Scaffold(
      appBar:AppBar(title:Text(widget.title)),
      body:Center(child:Padding(padding:const EdgeInsets.all(28),child:Column(mainAxisSize:MainAxisSize.min,children:[
        Text(percent>=80?'🏆':percent>=60?'🎯':'📚',style:const TextStyle(fontSize:78)),const SizedBox(height:12),
        Text(percent.toString()+'%',style:const TextStyle(fontSize:42,fontWeight:FontWeight.w900)),
        Text(score.toString()+'/'+widget.questions.length.toString()+' corrette'),
        const SizedBox(height:18),
        Text(percent>=80?'Ottima preparazione.':percent>=60?'Buona base, continua il ripasso.':'Questa area va rinforzata.',textAlign:TextAlign.center),
        const SizedBox(height:24),
        FilledButton(onPressed:()=>Navigator.pop(context),child:const Text('Termina')),
      ]))),
    );
  }
}

class SmartFlashcardsPage extends StatefulWidget {
  final StudyProgressStore store;
  const SmartFlashcardsPage({super.key,required this.store});
  @override State<SmartFlashcardsPage> createState()=>_SmartFlashcardsPageState();
}

class _SmartFlashcardsPageState extends State<SmartFlashcardsPage> {
  late List<StudyQuestionV2> cards;
  int index=0;
  bool revealed=false;

  @override
  void initState(){
    super.initState();
    final weak=<StudyQuestionV2>[...widget.store.wrongQuestions];
    final unseen=studyQuestionBank.where((q)=>(widget.store.attempts[q.id]??0)==0).toList()..shuffle(Random());
    final combined=<StudyQuestionV2>[...weak,...unseen];
    final seen=<String>{};
    cards=combined.where((q)=>seen.add(q.id)).take(30).toList();
    if(cards.isEmpty){cards=[...studyQuestionBank]..shuffle(Random());}
  }

  @override
  Widget build(BuildContext context){
    final q=cards[index%cards.length];
    return Scaffold(
      appBar:AppBar(title:const Text('Flashcard intelligenti')),
      body:Padding(padding:const EdgeInsets.all(20),child:Column(children:[
        Text((index+1).toString()+'/'+cards.length.toString(),style:const TextStyle(fontWeight:FontWeight.w900)),
        const SizedBox(height:12),
        Expanded(child:Center(child:GestureDetector(
          onTap:()=>setState(()=>revealed=!revealed),
          child:AnimatedContainer(duration:const Duration(milliseconds:200),width:double.infinity,padding:const EdgeInsets.all(24),decoration:BoxDecoration(color:revealed?Theme.of(context).colorScheme.secondaryContainer:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(30)),child:Column(mainAxisSize:MainAxisSize.min,children:[
            Text(revealed?'💡':'🧠',style:const TextStyle(fontSize:50)),const SizedBox(height:16),
            Text(revealed?q.explanation:q.prompt,textAlign:TextAlign.center,style:const TextStyle(fontSize:22,fontWeight:FontWeight.w900,height:1.4)),
            const SizedBox(height:12),Text(revealed?'Tocca per tornare alla domanda':'Tocca per rivelare',style:const TextStyle(fontSize:12)),
          ])),
        ))),
        if(revealed)Row(children:[
          Expanded(child:OutlinedButton(onPressed:()=>_rate(q,false),child:const Padding(padding:EdgeInsets.symmetric(vertical:12),child:Text('Da ripassare')))),
          const SizedBox(width:8),
          Expanded(child:FilledButton(onPressed:()=>_rate(q,true),child:const Padding(padding:EdgeInsets.symmetric(vertical:12),child:Text('Lo so')))),
        ]),
      ])),
    );
  }

  Future<void> _rate(StudyQuestionV2 q,bool known) async {
    await widget.store.recordAnswer(q,known);
    if(!mounted)return;
    if(index>=cards.length-1){Navigator.pop(context);return;}
    setState((){index++;revealed=false;});
  }
}

class MasteryV2Page extends StatelessWidget {
  final StudyProgressStore store;
  const MasteryV2Page({super.key,required this.store});
  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Mastery')),
    body:AnimatedBuilder(animation:store,builder:(context,_)=>ListView(padding:const EdgeInsets.fromLTRB(18,6,18,30),children:[
      Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(28)),child:Row(children:[
        const Text('📊',style:TextStyle(fontSize:48)),const SizedBox(width:14),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Preparazione per area',style:TextStyle(fontSize:20,fontWeight:FontWeight.w900)),Text(store.totalAnswers.toString()+' risposte registrate · '+store.accuracy.toString()+'% precisione')])),
      ])),
      const SizedBox(height:18),
      ...store.categories.map((c)=>Card(margin:const EdgeInsets.only(bottom:8),child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Row(children:[Expanded(child:Text(c,style:const TextStyle(fontWeight:FontWeight.w900))),Text(store.masteryFor(c).toString()+'%',style:const TextStyle(fontWeight:FontWeight.w900))]),
        const SizedBox(height:8),
        LinearProgressIndicator(value:store.masteryFor(c)/100,minHeight:8,borderRadius:BorderRadius.circular(20)),
      ])))),
    ])),
  );
}
