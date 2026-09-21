import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'content_expansion.dart';
import 'histology.dart';
import 'smart_study.dart';

class ExamQuestionFactory {
  ExamQuestionFactory._();

  static List<StudyQuestionV2> buildPool() {
    final result=<StudyQuestionV2>[...studyQuestionBank];

    for(final type in ExpandedContentType.values){
      final entries=expandedContent.where((e)=>e.type==type).toList();
      if(entries.length<4) continue;
      for(final entry in entries){
        final wrong=entries.where((e)=>e.id!=entry.id).toList()..shuffle(Random(entry.id.hashCode));
        final answers=<String>[entry.name,...wrong.take(3).map((e)=>e.name)]..shuffle(Random(entry.id.hashCode+31));
        result.add(StudyQuestionV2(
          id:'auto_content_'+entry.id,
          category:entry.type.label,
          prompt:'Quale struttura corrisponde a questa funzione?\n\n'+entry.function,
          answers:answers,
          correct:answers.indexOf(entry.name),
          explanation:entry.name+' · '+entry.region+'. '+entry.description,
        ));
      }
    }

    for(final level in MicroLevel.values){
      final entries=histologyEntries.where((e)=>e.level==level).toList();
      if(entries.length<4) continue;
      for(final entry in entries){
        final wrong=entries.where((e)=>e.id!=entry.id).toList()..shuffle(Random(entry.id.hashCode));
        final answers=<String>[entry.name,...wrong.take(3).map((e)=>e.name)]..shuffle(Random(entry.id.hashCode+17));
        result.add(StudyQuestionV2(
          id:'auto_histology_'+entry.id,
          category:'Istologia',
          prompt:'Quale struttura o cellula corrisponde a questa descrizione?\n\n'+entry.description,
          answers:answers,
          correct:answers.indexOf(entry.name),
          explanation:entry.name+'. '+entry.function,
        ));
      }
    }

    return result;
  }
}

class ExamProPage extends StatefulWidget {
  final StudyProgressStore store;
  const ExamProPage({super.key,required this.store});
  @override State<ExamProPage> createState()=>_ExamProPageState();
}

class _ExamProPageState extends State<ExamProPage> {
  int size=20;
  String? category;
  bool timed=false;

  late final List<StudyQuestionV2> pool=ExamQuestionFactory.buildPool();

  List<String> get categories {
    final set=<String>{for(final q in pool)q.category};
    return set.toList()..sort();
  }

  List<StudyQuestionV2> _questions(){
    final filtered=pool.where((q)=>category==null||q.category==category).toList()..shuffle(Random());
    if(filtered.length>=size) return filtered.take(size).toList();

    final result=<StudyQuestionV2>[];
    while(result.length<size&&filtered.isNotEmpty){
      final copy=<StudyQuestionV2>[...filtered]..shuffle(Random(result.length+size));
      result.addAll(copy.take(min(copy.length,size-result.length)));
    }
    return result;
  }

  @override
  Widget build(BuildContext context){
    final available=category==null?pool.length:pool.where((q)=>q.category==category).length;
    return Scaffold(
      appBar:AppBar(title:const Text('Exam & Study Pro')),
      body:ListView(
        padding:const EdgeInsets.fromLTRB(18,6,18,32),
        children:[
          Container(
            padding:const EdgeInsets.all(22),
            decoration:BoxDecoration(
              gradient:const LinearGradient(colors:[Color(0xFF2F446F),Color(0xFF5B4BCE)]),
              borderRadius:BorderRadius.circular(30),
            ),
            child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              const Row(children:[
                Text('🎓',style:TextStyle(fontSize:52)),
                SizedBox(width:14),
                Expanded(child:Text('Simulazione esame',style:TextStyle(color:Colors.white,fontSize:24,fontWeight:FontWeight.w900))),
              ]),
              const SizedBox(height:8),
              Text(pool.length.toString()+' domande disponibili nel pool completo',style:const TextStyle(color:Colors.white70)),
            ]),
          ),
          const SizedBox(height:20),
          const Text('Numero di domande',style:TextStyle(fontSize:20,fontWeight:FontWeight.w900)),
          const SizedBox(height:8),
          Wrap(
            spacing:8,
            runSpacing:8,
            children:[10,20,50,100].map((v)=>ChoiceChip(
              selected:size==v,
              label:Text(v.toString()),
              onSelected:(_)=>setState(()=>size=v),
            )).toList(),
          ),
          const SizedBox(height:20),
          const Text('Area',style:TextStyle(fontSize:20,fontWeight:FontWeight.w900)),
          const SizedBox(height:8),
          DropdownButtonFormField<String?>(
            value:category,
            decoration:const InputDecoration(border:OutlineInputBorder(),labelText:'Categoria'),
            items:[
              const DropdownMenuItem<String?>(value:null,child:Text('Mista · tutte le categorie')),
              ...categories.map((c)=>DropdownMenuItem<String?>(value:c,child:Text(c))),
            ],
            onChanged:(v)=>setState(()=>category=v),
          ),
          const SizedBox(height:8),
          Text(available.toString()+' domande uniche disponibili per la selezione',style:const TextStyle(fontSize:12)),
          const SizedBox(height:18),
          SwitchListTile(
            value:timed,
            onChanged:(v)=>setState(()=>timed=v),
            title:const Text('Timer',style:TextStyle(fontWeight:FontWeight.w900)),
            subtitle:Text(timed?'Tempo: '+_timeFor(size).inMinutes.toString()+' minuti':'Nessun limite di tempo'),
            secondary:const Icon(Icons.timer_outlined),
            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
            tileColor:Theme.of(context).colorScheme.surfaceContainerLow,
          ),
          const SizedBox(height:18),
          SizedBox(
            width:double.infinity,
            child:FilledButton.icon(
              onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>ExamProSession(
                store:widget.store,
                questions:_questions(),
                title:category==null?'Esame misto':'Esame · '+category!,
                duration:timed?_timeFor(size):null,
              ))),
              icon:const Icon(Icons.play_arrow),
              label:const Padding(padding:EdgeInsets.symmetric(vertical:14),child:Text('Inizia esame')),
            ),
          ),
          const SizedBox(height:24),
          const Text('Storico risultati',style:TextStyle(fontSize:20,fontWeight:FontWeight.w900)),
          const SizedBox(height:8),
          if(widget.store.examScores.isEmpty)
            const Card(child:ListTile(leading:Icon(Icons.history),title:Text('Nessun esame completato'),subtitle:Text('I risultati compariranno qui.')))
          else ...[
            Card(child:Padding(
              padding:const EdgeInsets.all(16),
              child:Row(children:[
                Expanded(child:_ExamMetric(label:'Ultimo',value:widget.store.examScores.first.toString()+'%')),
                Expanded(child:_ExamMetric(label:'Migliore',value:widget.store.examScores.reduce(max).toString()+'%')),
                Expanded(child:_ExamMetric(label:'Media',value:(widget.store.examScores.reduce((a,b)=>a+b)/widget.store.examScores.length).round().toString()+'%')),
              ]),
            )),
            ...widget.store.examScores.take(10).toList().asMap().entries.map((e)=>Card(
              margin:const EdgeInsets.only(bottom:6),
              child:ListTile(
                leading:CircleAvatar(child:Text((e.key+1).toString())),
                title:Text(e.value.toString()+'%',style:const TextStyle(fontWeight:FontWeight.w900)),
                subtitle:Text(e.value>=80?'Ottima preparazione':e.value>=60?'Buona base':'Da rinforzare'),
              ),
            )),
          ],
          const SizedBox(height:20),
          const Text('Analisi per categoria',style:TextStyle(fontSize:20,fontWeight:FontWeight.w900)),
          const SizedBox(height:8),
          ...widget.store.categories.map((c)=>Card(
            margin:const EdgeInsets.only(bottom:6),
            child:ListTile(
              title:Text(c,style:const TextStyle(fontWeight:FontWeight.w800)),
              subtitle:LinearProgressIndicator(value:widget.store.masteryFor(c)/100,minHeight:6,borderRadius:BorderRadius.circular(20)),
              trailing:Text(widget.store.masteryFor(c).toString()+'%',style:const TextStyle(fontWeight:FontWeight.w900)),
            ),
          )),
          const SizedBox(height:20),
          if(widget.store.wrongQuestions.isNotEmpty)
            ActionCardV2(
              emoji:'📕',
              title:'Error Notebook',
              subtitle:widget.store.wrongQuestions.length.toString()+' errori registrati · sessione automatica',
              onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>StudyQuizSession(
                store:widget.store,
                questions:widget.store.wrongQuestions.take(30).toList(),
                title:'Error Notebook',
              ))),
            ),
        ],
      ),
    );
  }

  Duration _timeFor(int count){
    if(count<=10)return const Duration(minutes:8);
    if(count<=20)return const Duration(minutes:15);
    if(count<=50)return const Duration(minutes:35);
    return const Duration(minutes:70);
  }
}

class ExamProSession extends StatefulWidget {
  final StudyProgressStore store;
  final List<StudyQuestionV2> questions;
  final String title;
  final Duration? duration;
  const ExamProSession({
    super.key,
    required this.store,
    required this.questions,
    required this.title,
    this.duration,
  });
  @override State<ExamProSession> createState()=>_ExamProSessionState();
}

class _ExamProSessionState extends State<ExamProSession> {
  int index=0;
  int score=0;
  int? selected;
  Timer? timer;
  int? remainingSeconds;
  bool finished=false;
  bool persisted=false;

  @override
  void initState(){
    super.initState();
    if(widget.duration!=null){
      remainingSeconds=widget.duration!.inSeconds;
      timer=Timer.periodic(const Duration(seconds:1),(t){
        if(!mounted)return;
        if((remainingSeconds??0)<=1){
          t.cancel();
          setState((){remainingSeconds=0;finished=true;});
        }else{
          setState(()=>remainingSeconds=remainingSeconds!-1);
        }
      });
    }
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    if(finished||index>=widget.questions.length){
      return _result(context);
    }
    final q=widget.questions[index];
    return PopScope(
      canPop:false,
      onPopInvokedWithResult:(didPop,result){
        if(!didPop)_confirmExit();
      },
      child:Scaffold(
        appBar:AppBar(
          title:Text(widget.title),
          leading:IconButton(icon:const Icon(Icons.close),onPressed:_confirmExit),
          actions:[
            if(remainingSeconds!=null)
              Padding(
                padding:const EdgeInsets.only(right:14),
                child:Center(child:Text(_formatTime(remainingSeconds!),style:const TextStyle(fontWeight:FontWeight.w900))),
              ),
          ],
        ),
        body:Padding(
          padding:const EdgeInsets.all(20),
          child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Row(children:[
              Text((index+1).toString()+'/'+widget.questions.length.toString(),style:const TextStyle(fontWeight:FontWeight.w900)),
              const Spacer(),
              Text(q.category,style:TextStyle(color:Theme.of(context).colorScheme.primary,fontWeight:FontWeight.w800)),
            ]),
            const SizedBox(height:8),
            LinearProgressIndicator(value:(index+1)/widget.questions.length,minHeight:7,borderRadius:BorderRadius.circular(20)),
            const SizedBox(height:22),
            Text(q.prompt,style:const TextStyle(fontSize:22,fontWeight:FontWeight.w900)),
            const SizedBox(height:18),
            Expanded(child:ListView.separated(
              itemCount:q.answers.length,
              separatorBuilder:(_,__)=>const SizedBox(height:8),
              itemBuilder:(_,i)=>Material(
                color:selected==i?Theme.of(context).colorScheme.primaryContainer:Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius:BorderRadius.circular(18),
                child:ListTile(
                  title:Text(q.answers[i],style:const TextStyle(fontWeight:FontWeight.w700)),
                  onTap:()=>setState(()=>selected=i),
                ),
              ),
            )),
            SizedBox(
              width:double.infinity,
              child:FilledButton(
                onPressed:selected==null?null:_next,
                child:Padding(
                  padding:const EdgeInsets.symmetric(vertical:13),
                  child:Text(index==widget.questions.length-1?'Consegna esame':'Prossima'),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _next() async {
    final q=widget.questions[index];
    final ok=selected==q.correct;
    await widget.store.recordAnswer(q,ok);
    if(ok)score++;
    if(!mounted)return;
    if(index>=widget.questions.length-1){
      timer?.cancel();
      setState(()=>finished=true);
    }else{
      setState((){index++;selected=null;});
    }
  }

  Widget _result(BuildContext context){
    final answered=min(index+(finished&&selected!=null?1:0),widget.questions.length);
    final denominator=widget.questions.length;
    final percent=denominator==0?0:(score*100/denominator).round();

    if(!persisted){
      persisted=true;
      WidgetsBinding.instance.addPostFrameCallback((_)=>widget.store.recordExam(percent));
    }

    return Scaffold(
      appBar:AppBar(title:const Text('Risultato esame'),automaticallyImplyLeading:false),
      body:ListView(
        padding:const EdgeInsets.all(24),
        children:[
          const SizedBox(height:30),
          Text(percent>=80?'🏆':percent>=60?'🎯':'📚',textAlign:TextAlign.center,style:const TextStyle(fontSize:78)),
          const SizedBox(height:12),
          Text(percent.toString()+'%',textAlign:TextAlign.center,style:const TextStyle(fontSize:46,fontWeight:FontWeight.w900)),
          Text(score.toString()+' corrette su '+denominator.toString(),textAlign:TextAlign.center),
          if(answered<denominator)
            Padding(
              padding:const EdgeInsets.only(top:8),
              child:Text('Esame terminato prima del completamento: '+answered.toString()+' risposte registrate.',textAlign:TextAlign.center),
            ),
          const SizedBox(height:24),
          Container(
            padding:const EdgeInsets.all(18),
            decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(22)),
            child:Text(
              percent>=80
                  ?'Preparazione molto solida.'
                  :percent>=60
                      ?'Buona base: usa Mastery ed Error Notebook per salire.'
                      :'Ripassa le categorie deboli prima di una nuova simulazione.',
              textAlign:TextAlign.center,
              style:const TextStyle(fontWeight:FontWeight.w700),
            ),
          ),
          const SizedBox(height:22),
          FilledButton(onPressed:()=>Navigator.pop(context),child:const Padding(padding:EdgeInsets.symmetric(vertical:13),child:Text('Termina'))),
        ],
      ),
    );
  }

  String _formatTime(int seconds){
    final m=seconds~/60;
    final s=seconds%60;
    return m.toString().padLeft(2,'0')+':'+s.toString().padLeft(2,'0');
  }

  Future<void> _confirmExit() async {
    final exit=await showDialog<bool>(
      context:context,
      builder:(dialog)=>AlertDialog(
        title:const Text('Uscire dall’esame?'),
        content:const Text('Le risposte dell’esame corrente non completato non saranno salvate come risultato finale.'),
        actions:[
          TextButton(onPressed:()=>Navigator.pop(dialog,false),child:const Text('Continua')),
          FilledButton(onPressed:()=>Navigator.pop(dialog,true),child:const Text('Esci')),
        ],
      ),
    );
    if(exit==true&&mounted)Navigator.pop(context);
  }
}

class _ExamMetric extends StatelessWidget {
  final String label,value;
  const _ExamMetric({required this.label,required this.value});
  @override
  Widget build(BuildContext context)=>Column(children:[
    Text(value,style:const TextStyle(fontSize:22,fontWeight:FontWeight.w900)),
    Text(label,style:const TextStyle(fontSize:12)),
  ]);
}
