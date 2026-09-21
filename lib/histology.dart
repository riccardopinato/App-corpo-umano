import 'package:flutter/material.dart';

enum MicroLevel { tissue, cell, organelle }

extension MicroLevelX on MicroLevel {
  String get label {
    switch (this) {
      case MicroLevel.tissue: return 'Tessuto';
      case MicroLevel.cell: return 'Cellula';
      case MicroLevel.organelle: return 'Organello / struttura';
    }
  }
  String get emoji {
    switch (this) {
      case MicroLevel.tissue: return '🔬';
      case MicroLevel.cell: return '🧫';
      case MicroLevel.organelle: return '🧬';
    }
  }
}

class HistologyEntry {
  final String id,name,emoji,system,description,function;
  final MicroLevel level;
  final List<String> tags;
  const HistologyEntry({
    required this.id,required this.name,required this.emoji,required this.level,
    required this.system,required this.description,required this.function,this.tags=const[],
  });
  bool matches(String query){
    final q=query.trim().toLowerCase();
    if(q.isEmpty)return true;
    return [name,system,description,function,...tags].join(' ').toLowerCase().contains(q);
  }
}

class HistologyPath {
  final String id,title,emoji,summary;
  final List<String> steps;
  const HistologyPath({required this.id,required this.title,required this.emoji,required this.steps,required this.summary});
}

const histologyEntries=<HistologyEntry>[
  HistologyEntry(id:'epithelium',name:'Tessuto epiteliale',emoji:'🧱',level:MicroLevel.tissue,system:'Generale',description:'Cellule strettamente accostate organizzate in rivestimenti e ghiandole.',function:'Protezione, assorbimento, secrezione e scambio.',tags:['epitelio','ghiandolare']),
  HistologyEntry(id:'connective',name:'Tessuto connettivo',emoji:'🕸️',level:MicroLevel.tissue,system:'Generale',description:'Famiglia di tessuti ricchi di matrice extracellulare.',function:'Sostegno, connessione, nutrizione, difesa e deposito.',tags:['collagene','elastina']),
  HistologyEntry(id:'skeletal_muscle',name:'Muscolo scheletrico',emoji:'💪',level:MicroLevel.tissue,system:'Muscolare',description:'Tessuto striato volontario formato da fibre multinucleate.',function:'Movimento, postura e produzione di calore.',tags:['sarcomero','actina','miosina']),
  HistologyEntry(id:'cardiac_muscle',name:'Muscolo cardiaco',emoji:'❤️',level:MicroLevel.tissue,system:'Cardiovascolare',description:'Tessuto striato involontario di cardiomiociti ramificati.',function:'Contrazione ritmica del cuore.',tags:['miocardio','dischi intercalari']),
  HistologyEntry(id:'smooth_muscle',name:'Muscolo liscio',emoji:'〰️',level:MicroLevel.tissue,system:'Viscerale',description:'Muscolo non striato presente in pareti di organi e vasi.',function:'Regola tono, calibro e propulsione dei contenuti.',tags:['peristalsi','vasi']),
  HistologyEntry(id:'nervous_tissue',name:'Tessuto nervoso',emoji:'⚡',level:MicroLevel.tissue,system:'Nervoso',description:'Tessuto composto da neuroni e cellule gliali.',function:'Riceve, integra e trasmette informazioni.',tags:['neurone','glia','sinapsi']),
  HistologyEntry(id:'compact_bone',name:'Osso compatto',emoji:'🦴',level:MicroLevel.tissue,system:'Scheletrico',description:'Tessuto osseo organizzato in osteoni concentrici.',function:'Elevata resistenza meccanica.',tags:['osteone','Havers']),
  HistologyEntry(id:'spongy_bone',name:'Osso spugnoso',emoji:'🦴',level:MicroLevel.tissue,system:'Scheletrico',description:'Rete tridimensionale di trabecole ossee.',function:'Riduce il peso e ospita spazi midollari.',tags:['trabecole','midollo']),
  HistologyEntry(id:'hyaline_cartilage',name:'Cartilagine ialina',emoji:'🔵',level:MicroLevel.tissue,system:'Scheletrico',description:'Cartilagine con matrice ricca di collagene II e condrociti.',function:'Sostegno elastico e riduzione dell’attrito articolare.',tags:['condrocita','articolazione']),
  HistologyEntry(id:'blood',name:'Sangue',emoji:'🩸',level:MicroLevel.tissue,system:'Cardiovascolare',description:'Connettivo liquido formato da plasma ed elementi figurati.',function:'Trasporto, difesa, emostasi e omeostasi.',tags:['eritrociti','leucociti','piastrine']),
  HistologyEntry(id:'erythrocyte',name:'Eritrocita',emoji:'🔴',level:MicroLevel.cell,system:'Cardiovascolare',description:'Cellula anucleata biconcava ricca di emoglobina.',function:'Trasporta soprattutto ossigeno e parte della CO₂.',tags:['globulo rosso','emoglobina']),
  HistologyEntry(id:'neutrophil',name:'Neutrofilo',emoji:'⚪',level:MicroLevel.cell,system:'Immunitario',description:'Leucocita granulocita molto abbondante nel sangue.',function:'Fagocitosi e risposta infiammatoria acuta.',tags:['granulocita','fagocitosi']),
  HistologyEntry(id:'lymphocyte',name:'Linfocita',emoji:'🛡️',level:MicroLevel.cell,system:'Immunitario',description:'Leucocita centrale nell’immunità adattativa e innata.',function:'Comprende popolazioni B, T e NK.',tags:['B','T','NK']),
  HistologyEntry(id:'platelet',name:'Piastrina',emoji:'🟣',level:MicroLevel.cell,system:'Cardiovascolare',description:'Frammento cellulare derivato dai megacariociti.',function:'Emostasi primaria e tappo piastrinico.',tags:['coagulazione','emostasi']),
  HistologyEntry(id:'neuron',name:'Neurone',emoji:'🧠',level:MicroLevel.cell,system:'Nervoso',description:'Cellula eccitabile specializzata nella comunicazione.',function:'Integra e trasmette segnali elettrici e sinaptici.',tags:['assone','dendrite','sinapsi']),
  HistologyEntry(id:'astrocyte',name:'Astrocita',emoji:'⭐',level:MicroLevel.cell,system:'Nervoso',description:'Cellula gliale del sistema nervoso centrale.',function:'Supporto metabolico e regolazione dell’ambiente extracellulare.',tags:['glia','SNC']),
  HistologyEntry(id:'cardiomyocyte',name:'Cardiomiocita',emoji:'❤️',level:MicroLevel.cell,system:'Cardiovascolare',description:'Cellula muscolare striata del miocardio.',function:'Genera forza contrattile ritmica.',tags:['miocardio','sarcomero']),
  HistologyEntry(id:'hepatocyte',name:'Epatocita',emoji:'🟤',level:MicroLevel.cell,system:'Digerente',description:'Principale cellula funzionale del fegato.',function:'Metabolismo, detossificazione, sintesi e produzione di bile.',tags:['fegato','lobulo']),
  HistologyEntry(id:'pneumocyte1',name:'Pneumocita di tipo I',emoji:'🫧',level:MicroLevel.cell,system:'Respiratorio',description:'Cellula alveolare appiattita e molto sottile.',function:'Forma gran parte della superficie di scambio gassoso.',tags:['alveolo']),
  HistologyEntry(id:'pneumocyte2',name:'Pneumocita di tipo II',emoji:'🫧',level:MicroLevel.cell,system:'Respiratorio',description:'Cellula alveolare cuboidale.',function:'Produce surfattante e rigenera l’epitelio alveolare.',tags:['surfattante']),
  HistologyEntry(id:'enterocyte',name:'Enterocita',emoji:'🍎',level:MicroLevel.cell,system:'Digerente',description:'Cellula assorbente dell’epitelio intestinale.',function:'Assorbe nutrienti grazie anche ai microvilli.',tags:['villo','microvillo']),
  HistologyEntry(id:'podocyte',name:'Podocita',emoji:'💧',level:MicroLevel.cell,system:'Urinario',description:'Cellula specializzata della capsula glomerulare.',function:'Contribuisce alla barriera di filtrazione glomerulare.',tags:['glomerulo','nefrone']),
  HistologyEntry(id:'osteocyte',name:'Osteocita',emoji:'🦴',level:MicroLevel.cell,system:'Scheletrico',description:'Cellula ossea matura contenuta nelle lacune.',function:'Mantiene la matrice e percepisce i carichi meccanici.',tags:['lacuna','canalicoli']),
  HistologyEntry(id:'chondrocyte',name:'Condrocita',emoji:'🔵',level:MicroLevel.cell,system:'Scheletrico',description:'Cellula matura della cartilagine.',function:'Mantiene la matrice cartilaginea.',tags:['cartilagine']),
  HistologyEntry(id:'keratinocyte',name:'Cheratinocita',emoji:'🖐️',level:MicroLevel.cell,system:'Tegumentario',description:'Cellula principale dell’epidermide.',function:'Produce cheratine e contribuisce alla barriera cutanea.',tags:['epidermide','cheratina']),
  HistologyEntry(id:'mitochondrion',name:'Mitocondrio',emoji:'⚡',level:MicroLevel.organelle,system:'Cellulare',description:'Organello delimitato da doppia membrana.',function:'Produce gran parte dell’ATP mediante fosforilazione ossidativa.',tags:['ATP','energia']),
  HistologyEntry(id:'nucleus',name:'Nucleo',emoji:'🧬',level:MicroLevel.organelle,system:'Cellulare',description:'Compartimento che contiene la maggior parte del DNA.',function:'Coordina espressione genica e replicazione.',tags:['DNA','cromatina']),
  HistologyEntry(id:'rough_er',name:'Reticolo endoplasmatico rugoso',emoji:'🧬',level:MicroLevel.organelle,system:'Cellulare',description:'Sistema membranoso associato a ribosomi.',function:'Sintesi e prima maturazione di molte proteine.',tags:['RER','ribosomi']),
  HistologyEntry(id:'golgi',name:'Apparato di Golgi',emoji:'📦',level:MicroLevel.organelle,system:'Cellulare',description:'Pile di cisterne membranose.',function:'Modifica, ordina e smista proteine e lipidi.',tags:['vescicole','secrezione']),
  HistologyEntry(id:'sarcomere',name:'Sarcomero',emoji:'💪',level:MicroLevel.organelle,system:'Muscolare',description:'Unità contrattile ripetuta delle miofibrille striate.',function:'Converte il ciclo actina-miosina in forza.',tags:['actina','miosina']),
];

const histologyPaths=<HistologyPath>[
  HistologyPath(id:'heart_micro',title:'Cuore → cardiomiocita',emoji:'❤️',steps:['Cuore','Miocardio','Cardiomiocita','Miofibrilla','Sarcomero','Actina + miosina'],summary:'Dal cuore alla macchina molecolare della contrazione.'),
  HistologyPath(id:'lung_micro',title:'Polmone → barriera alveolare',emoji:'🫁',steps:['Polmone','Lobulo','Alveolo','Pneumocita I','Membrana basale','Capillare'],summary:'Dall’organo alla sottilissima interfaccia aria-sangue.'),
  HistologyPath(id:'kidney_micro',title:'Rene → filtro glomerulare',emoji:'💧',steps:['Rene','Corteccia','Nefrone','Glomerulo','Podocita','Fessura di filtrazione'],summary:'Dal rene alla barriera che produce il filtrato.'),
  HistologyPath(id:'liver_micro',title:'Fegato → epatocita',emoji:'🟤',steps:['Fegato','Lobulo epatico','Sinusoide','Epatocita','Canalicolo biliare'],summary:'Architettura microscopica del fegato.'),
  HistologyPath(id:'brain_micro',title:'Cervello → sinapsi',emoji:'🧠',steps:['Cervello','Corteccia','Neurone','Assone','Terminale presinaptico','Sinapsi'],summary:'Dalla macroanatomia al punto di comunicazione neuronale.'),
  HistologyPath(id:'bone_micro',title:'Osso → osteone',emoji:'🦴',steps:['Osso','Corticale','Osteone','Lamelle','Osteocita','Canalicoli'],summary:'La struttura gerarchica dell’osso compatto.'),
  HistologyPath(id:'intestine_micro',title:'Intestino → microvillo',emoji:'🍎',steps:['Intestino tenue','Mucosa','Villo','Enterocita','Microvillo'],summary:'Come l’intestino moltiplica la superficie assorbente.'),
];

class HistologyHubPage extends StatefulWidget {
  const HistologyHubPage({super.key});
  @override State<HistologyHubPage> createState()=>_HistologyHubPageState();
}

class _HistologyHubPageState extends State<HistologyHubPage> {
  String query='';
  MicroLevel? level;
  @override
  Widget build(BuildContext context){
    final filtered=histologyEntries.where((e)=>(level==null||e.level==level)&&e.matches(query)).toList();
    return Scaffold(
      appBar:AppBar(title:const Text('Istologia & cellule')),
      body:Column(children:[
        Padding(padding:const EdgeInsets.fromLTRB(16,4,16,8),child:SearchBar(hintText:'Cerca neurone, epitelio, mitocondrio...',leading:const Icon(Icons.search),onChanged:(v)=>setState(()=>query=v))),
        SizedBox(height:44,child:ListView(scrollDirection:Axis.horizontal,padding:const EdgeInsets.symmetric(horizontal:16),children:[
          ChoiceChip(label:const Text('Tutto'),selected:level==null,onSelected:(_)=>setState(()=>level=null)),
          const SizedBox(width:6),
          ...MicroLevel.values.map((v)=>Padding(padding:const EdgeInsets.only(right:6),child:ChoiceChip(label:Text(v.emoji+' '+v.label),selected:level==v,onSelected:(_)=>setState(()=>level=v)))),
        ])),
        Expanded(child:ListView(padding:const EdgeInsets.fromLTRB(16,10,16,28),children:[
          Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF3D8B8B),Color(0xFF66B7A8)]),borderRadius:BorderRadius.circular(28)),child:const Row(children:[
            Text('🔬',style:TextStyle(fontSize:50)),SizedBox(width:14),
            Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Macro → Micro',style:TextStyle(color:Colors.white,fontSize:22,fontWeight:FontWeight.w900)),Text('Organo, tessuto, cellula e struttura subcellulare.',style:TextStyle(color:Colors.white70))])),
          ])),
          const SizedBox(height:18),
          const Text('Percorsi gerarchici',style:TextStyle(fontSize:20,fontWeight:FontWeight.w900)),
          const SizedBox(height:8),
          SizedBox(height:126,child:ListView.separated(scrollDirection:Axis.horizontal,itemCount:histologyPaths.length,separatorBuilder:(_,__)=>const SizedBox(width:8),itemBuilder:(_,i){
            final p=histologyPaths[i];
            return SizedBox(width:220,child:Card(child:InkWell(borderRadius:BorderRadius.circular(24),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>HistologyPathPage(path:p))),child:Padding(padding:const EdgeInsets.all(14),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text(p.emoji,style:const TextStyle(fontSize:28)),const SizedBox(height:5),Text(p.title,style:const TextStyle(fontWeight:FontWeight.w900)),const Spacer(),Text(p.steps.length.toString()+' livelli',style:const TextStyle(fontSize:11)),
            ])))));
          })),
          const SizedBox(height:18),
          Text(filtered.length.toString()+' strutture',style:const TextStyle(fontSize:20,fontWeight:FontWeight.w900)),
          const SizedBox(height:8),
          ...filtered.map((e)=>Card(margin:const EdgeInsets.only(bottom:8),child:ListTile(contentPadding:const EdgeInsets.all(14),leading:CircleAvatar(child:Text(e.emoji)),title:Text(e.name,style:const TextStyle(fontWeight:FontWeight.w900)),subtitle:Text(e.level.label+' · '+e.system+'\n'+e.description,maxLines:3,overflow:TextOverflow.ellipsis),isThreeLine:true,trailing:const Icon(Icons.chevron_right),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>HistologyDetailPage(entry:e)))))),
        ])),
      ]),
    );
  }
}

class HistologyDetailPage extends StatelessWidget {
  final HistologyEntry entry;
  const HistologyDetailPage({super.key,required this.entry});
  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:Text(entry.emoji+' '+entry.name)),
    body:ListView(padding:const EdgeInsets.all(18),children:[
      Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(28)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(entry.emoji,style:const TextStyle(fontSize:56)),const SizedBox(height:8),Text(entry.name,style:const TextStyle(fontSize:26,fontWeight:FontWeight.w900)),Text(entry.level.label+' · '+entry.system),
      ])),
      const SizedBox(height:18),InfoPanel(title:'Che cos’è',text:entry.description,icon:Icons.biotech_outlined),const SizedBox(height:10),InfoPanel(title:'Funzione',text:entry.function,icon:Icons.settings_outlined),
      if(entry.tags.isNotEmpty)...[const SizedBox(height:18),Wrap(spacing:6,runSpacing:6,children:entry.tags.map((t)=>Chip(label:Text(t))).toList())],
    ]),
  );
}

class HistologyPathPage extends StatefulWidget {
  final HistologyPath path;
  const HistologyPathPage({super.key,required this.path});
  @override State<HistologyPathPage> createState()=>_HistologyPathPageState();
}

class _HistologyPathPageState extends State<HistologyPathPage> {
  int index=0;
  @override
  Widget build(BuildContext context){
    final p=widget.path;
    return Scaffold(
      appBar:AppBar(title:Text(p.emoji+' '+p.title)),
      body:Padding(padding:const EdgeInsets.all(20),child:Column(children:[
        LinearProgressIndicator(value:(index+1)/p.steps.length,minHeight:8,borderRadius:BorderRadius.circular(20)),const SizedBox(height:24),
        Expanded(child:Center(child:Column(mainAxisSize:MainAxisSize.min,children:[
          Text(p.emoji,style:const TextStyle(fontSize:72)),const SizedBox(height:16),Text(p.steps[index],textAlign:TextAlign.center,style:const TextStyle(fontSize:30,fontWeight:FontWeight.w900)),const SizedBox(height:10),
          Text('Livello '+(index+1).toString()+' di '+p.steps.length.toString(),style:TextStyle(color:Theme.of(context).colorScheme.primary,fontWeight:FontWeight.w800)),const SizedBox(height:22),
          Container(padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:Theme.of(context).colorScheme.surfaceContainerLow,borderRadius:BorderRadius.circular(22)),child:Text(index==0?p.summary:'Scendi di scala: ogni livello mostra come il precedente è costruito da strutture sempre più piccole.',textAlign:TextAlign.center,style:const TextStyle(height:1.5))),
        ]))),
        Row(children:[Expanded(child:OutlinedButton(onPressed:index>0?()=>setState(()=>index--):null,child:const Text('Indietro'))),const SizedBox(width:8),Expanded(child:FilledButton(onPressed:index<p.steps.length-1?()=>setState(()=>index++):()=>Navigator.pop(context),child:Text(index<p.steps.length-1?'Più in profondità':'Completa')))]),
      ])),
    );
  }
}

class InfoPanel extends StatelessWidget {
  final String title,text;
  final IconData icon;
  const InfoPanel({super.key,required this.title,required this.text,required this.icon});
  @override
  Widget build(BuildContext context)=>Container(width:double.infinity,padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:Theme.of(context).colorScheme.surfaceContainerLow,borderRadius:BorderRadius.circular(22)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Row(children:[Icon(icon),const SizedBox(width:8),Text(title,style:const TextStyle(fontSize:17,fontWeight:FontWeight.w900))]),const SizedBox(height:9),Text(text,style:const TextStyle(height:1.5)),
  ]));
}
