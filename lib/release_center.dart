import 'package:flutter/material.dart';

import 'content_expansion.dart';
import 'deep_dive.dart';
import 'games_v2.dart';
import 'histology.dart';
import 'smart_study.dart';
import 'learning_path.dart';
import 'exam_pro.dart';

class ReleaseCenterPage extends StatelessWidget {
  final StudyProgressStore studyStore;
  const ReleaseCenterPage({super.key,required this.studyStore});

  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Release Center')),
    body:ListView(
      padding:const EdgeInsets.fromLTRB(18,6,18,32),
      children:[
        Container(
          padding:const EdgeInsets.all(22),
          decoration:BoxDecoration(
            gradient:const LinearGradient(colors:[Color(0xFF2C3E73),Color(0xFF6755E7)]),
            borderRadius:BorderRadius.circular(30),
          ),
          child:const Row(children:[
            Text('✅',style:TextStyle(fontSize:52)),
            SizedBox(width:14),
            Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text('edu_01 v0.32.0',style:TextStyle(color:Colors.white,fontSize:24,fontWeight:FontWeight.w900)),
              Text('Atlas Accuracy · Anatomy Lab · Atlas Study',style:TextStyle(color:Colors.white70)),
            ])),
          ]),
        ),
        const SizedBox(height:20),
        const Text('Stato progetto',style:TextStyle(fontSize:21,fontWeight:FontWeight.w900)),
        const SizedBox(height:8),
        _ReleaseMetric(icon:'🫀',label:'Atlante',value:'5 layer offline · regioni Pro'),
        _ReleaseMetric(icon:'🔬',label:'Istologia',value:'30+ strutture'),
        _ReleaseMetric(icon:'🔎',label:'Deep Dive',value:'10 organi principali'),
        _ReleaseMetric(icon:'📚',label:'Catalogo espanso',value:expandedContent.length.toString()+' voci'),
        _ReleaseMetric(icon:'🧠',label:'Smart Study',value:studyQuestionBank.length.toString()+' domande'),
        _ReleaseMetric(icon:'🎮',label:'Anatomy Games',value:'4 modalità'),
        _ReleaseMetric(icon:'🧭',label:'Learning Path',value:learningLessons.length.toString()+' lezioni'),
        _ReleaseMetric(icon:'🎓',label:'Exam Pro',value:ExamQuestionFactory.buildPool().length.toString()+' domande'),
        const SizedBox(height:20),
        const Text('Qualità e accessibilità',style:TextStyle(fontSize:21,fontWeight:FontWeight.w900)),
        const SizedBox(height:8),
        const _CheckTile(title:'Funzionamento offline dell’Atlante',subtitle:'Le tavole anatomiche sono incluse nell’APK.'),
        const _CheckTile(title:'Navigazione Material 3',subtitle:'Cinque sezioni principali con layout coerente.'),
        const _CheckTile(title:'Testo scalabile',subtitle:'La UI usa componenti Flutter che rispettano le impostazioni di scala testo del sistema.'),
        const _CheckTile(title:'Persistenza studio',subtitle:'XP, streak, errori e ripasso vengono conservati localmente.'),
        const _CheckTile(title:'Learning Path persistente',subtitle:'Le lezioni completate e i prerequisiti restano memorizzati sul dispositivo.'),
        const _CheckTile(title:'Exam Pro 100',subtitle:'Il pool dinamico genera oltre 100 quesiti da Smart Study, istologia e catalogo anatomico.'),
        const _CheckTile(title:'Contenuti separati dal core UI',subtitle:'Moduli indipendenti per istologia, deep dive, studio, giochi e cataloghi.'),
        const _CheckTile(title:'Release ottimizzata',subtitle:'Stessa pipeline leggera con tree-shaking, stripping e pacchetti per ABI.'),
        const _CheckTile(title:'Anatomy Lab',subtitle:'Layer combinabili, opacità indipendente, selezione multipla e isolamento strutture.'),
        const _CheckTile(title:'Atlas Study',subtitle:'Quiz con tap sugli hotspot, mastery regionale ed Error Notebook collegato a Smart Study.'),
        const SizedBox(height:20),
        const Text('Dati di studio',style:TextStyle(fontSize:21,fontWeight:FontWeight.w900)),
        const SizedBox(height:8),
        Card(
          child:Padding(
            padding:const EdgeInsets.all(16),
            child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Row(children:[
                Expanded(child:_SmallStat(value:studyStore.xp.toString(),label:'XP')),
                Expanded(child:_SmallStat(value:studyStore.level.toString(),label:'Livello')),
                Expanded(child:_SmallStat(value:studyStore.streak.toString(),label:'Streak')),
              ]),
              const SizedBox(height:14),
              SizedBox(
                width:double.infinity,
                child:OutlinedButton.icon(
                  onPressed:()=>_confirmReset(context),
                  icon:const Icon(Icons.restart_alt),
                  label:const Text('Azzera progressi Smart Study'),
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(height:20),
        const Text('Licenze tavole anatomiche',style:TextStyle(fontSize:21,fontWeight:FontWeight.w900)),
        const SizedBox(height:8),
        const Card(
          child:Padding(
            padding:EdgeInsets.all(16),
            child:Text(
              'Le tavole anatomiche offline mantengono le attribuzioni mostrate direttamente nell’Atlante. '
              'Gli asset provengono da Wikimedia Commons e includono contenuti in pubblico dominio e CC BY-SA.',
              style:TextStyle(height:1.5),
            ),
          ),
        ),
      ],
    ),
  );

  Future<void> _confirmReset(BuildContext context) async {
    final confirmed=await showDialog<bool>(
      context:context,
      builder:(dialog)=>AlertDialog(
        title:const Text('Azzerare i progressi?'),
        content:const Text('Verranno cancellati XP, streak, cronologia delle risposte, mastery e programmazione del ripasso.'),
        actions:[
          TextButton(onPressed:()=>Navigator.pop(dialog,false),child:const Text('Annulla')),
          FilledButton(onPressed:()=>Navigator.pop(dialog,true),child:const Text('Azzera')),
        ],
      ),
    );
    if(confirmed==true){
      await studyStore.reset();
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Progressi Smart Study azzerati.')));
      }
    }
  }
}

class _ReleaseMetric extends StatelessWidget {
  final String icon,label,value;
  const _ReleaseMetric({required this.icon,required this.label,required this.value});
  @override
  Widget build(BuildContext context)=>Card(
    margin:const EdgeInsets.only(bottom:7),
    child:ListTile(
      leading:Text(icon,style:const TextStyle(fontSize:29)),
      title:Text(label,style:const TextStyle(fontWeight:FontWeight.w900)),
      trailing:Text(value,style:TextStyle(color:Theme.of(context).colorScheme.primary,fontWeight:FontWeight.w800)),
    ),
  );
}

class _CheckTile extends StatelessWidget {
  final String title,subtitle;
  const _CheckTile({required this.title,required this.subtitle});
  @override
  Widget build(BuildContext context)=>Card(
    margin:const EdgeInsets.only(bottom:7),
    child:ListTile(
      leading:const CircleAvatar(child:Icon(Icons.check,size:18)),
      title:Text(title,style:const TextStyle(fontWeight:FontWeight.w800)),
      subtitle:Text(subtitle),
    ),
  );
}

class _SmallStat extends StatelessWidget {
  final String value,label;
  const _SmallStat({required this.value,required this.label});
  @override
  Widget build(BuildContext context)=>Column(children:[
    Text(value,style:const TextStyle(fontSize:22,fontWeight:FontWeight.w900)),
    Text(label,style:const TextStyle(fontSize:12)),
  ]);
}
