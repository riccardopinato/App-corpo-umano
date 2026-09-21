import 'package:flutter/material.dart';
import 'histology.dart';

class DeepDiveNode {
  final String id,name,emoji,summary,details;
  final String? microPathId;
  final List<DeepDiveNode> children;
  const DeepDiveNode({
    required this.id,required this.name,required this.emoji,required this.summary,required this.details,
    this.microPathId,this.children=const[],
  });
}

class DeepDiveRegistry {
  DeepDiveRegistry._();

  static const roots=<DeepDiveNode>[
    DeepDiveNode(
      id:'heart',name:'Cuore',emoji:'❤️',
      summary:'Pompa muscolare della circolazione polmonare e sistemica.',
      details:'Organo cavo a quattro camere, con valvole che mantengono il flusso prevalentemente unidirezionale e un sistema di conduzione intrinseco.',
      microPathId:'heart_micro',
      children:[
        DeepDiveNode(id:'ra',name:'Atrio destro',emoji:'🔵',summary:'Riceve gran parte del ritorno venoso sistemico.',details:'Comunica con il ventricolo destro attraverso la valvola tricuspide.'),
        DeepDiveNode(id:'rv',name:'Ventricolo destro',emoji:'🔵',summary:'Pompa sangue nel tronco polmonare.',details:'Ha parete meno spessa del ventricolo sinistro perché lavora contro resistenze inferiori.'),
        DeepDiveNode(id:'la',name:'Atrio sinistro',emoji:'🔴',summary:'Riceve sangue dalle vene polmonari.',details:'Comunica con il ventricolo sinistro attraverso la valvola mitrale.'),
        DeepDiveNode(id:'lv',name:'Ventricolo sinistro',emoji:'🔴',summary:'Genera la pressione della circolazione sistemica.',details:'Presenta una parete miocardica particolarmente spessa.',microPathId:'heart_micro'),
        DeepDiveNode(
          id:'valves',name:'Valvole cardiache',emoji:'🚪',summary:'Tricuspide, polmonare, mitrale e aortica.',details:'Si aprono e chiudono passivamente in risposta ai gradienti di pressione.',
          children:[
            DeepDiveNode(id:'tricuspid',name:'Tricuspide',emoji:'🚪',summary:'Valvola atrioventricolare destra.',details:'Tra atrio e ventricolo destro.'),
            DeepDiveNode(id:'mitral',name:'Mitrale',emoji:'🚪',summary:'Valvola atrioventricolare sinistra.',details:'Tra atrio e ventricolo sinistro.'),
            DeepDiveNode(id:'aortic_valve',name:'Aortica',emoji:'🚪',summary:'Valvola semilunare.',details:'Tra ventricolo sinistro e aorta.'),
            DeepDiveNode(id:'pulmonary_valve',name:'Polmonare',emoji:'🚪',summary:'Valvola semilunare.',details:'Tra ventricolo destro e tronco polmonare.'),
          ],
        ),
        DeepDiveNode(
          id:'conduction',name:'Sistema di conduzione',emoji:'⚡',summary:'Coordina l’attivazione elettrica del cuore.',details:'Il nodo senoatriale avvia normalmente il ritmo, seguito da nodo AV, fascio di His, branche e rete di Purkinje.',
          children:[
            DeepDiveNode(id:'sa',name:'Nodo senoatriale',emoji:'⚡',summary:'Pacemaker fisiologico principale.',details:'Localizzato nell’atrio destro vicino allo sbocco della vena cava superiore.'),
            DeepDiveNode(id:'av',name:'Nodo atrioventricolare',emoji:'⚡',summary:'Rallenta e trasmette l’impulso dagli atri al sistema ventricolare.',details:'Introduce un ritardo utile al riempimento ventricolare.'),
            DeepDiveNode(id:'his',name:'Fascio di His',emoji:'⚡',summary:'Connessione elettrica verso i ventricoli.',details:'Prosegue nelle branche destra e sinistra.'),
          ],
        ),
      ],
    ),
    DeepDiveNode(
      id:'brain',name:'Cervello',emoji:'🧠',summary:'Centro superiore di integrazione del sistema nervoso.',details:'Comprende emisferi, corteccia, nuclei profondi e connessioni con diencefalo, tronco e cervelletto.',microPathId:'brain_micro',
      children:[
        DeepDiveNode(id:'frontal',name:'Lobo frontale',emoji:'🧠',summary:'Funzioni esecutive e controllo motorio.',details:'Comprende corteccia prefrontale e corteccia motoria primaria.'),
        DeepDiveNode(id:'parietal',name:'Lobo parietale',emoji:'🧠',summary:'Integrazione somatosensoriale e spaziale.',details:'Comprende corteccia somatosensoriale primaria.'),
        DeepDiveNode(id:'temporal',name:'Lobo temporale',emoji:'🧠',summary:'Udito, memoria e riconoscimento.',details:'Interagisce con strutture limbiche e corteccia uditiva.'),
        DeepDiveNode(id:'occipital',name:'Lobo occipitale',emoji:'👁️',summary:'Elaborazione visiva.',details:'Contiene la corteccia visiva primaria.'),
        DeepDiveNode(id:'cerebellum',name:'Cervelletto',emoji:'🧠',summary:'Coordinazione, equilibrio e apprendimento motorio.',details:'Modula precisione e timing dei movimenti.'),
        DeepDiveNode(id:'brainstem',name:'Tronco encefalico',emoji:'🧠',summary:'Mesencefalo, ponte e bulbo.',details:'Ospita numerosi nuclei dei nervi cranici e centri vitali.'),
      ],
    ),
    DeepDiveNode(
      id:'lungs',name:'Polmoni',emoji:'🫁',summary:'Organi dello scambio gassoso.',details:'L’albero bronchiale conduce l’aria alla zona respiratoria, dove alveoli e capillari formano la barriera di scambio.',microPathId:'lung_micro',
      children:[
        DeepDiveNode(id:'bronchi',name:'Bronchi',emoji:'🌿',summary:'Vie aeree di conduzione.',details:'I bronchi principali si ramificano in bronchi lobari e segmentari.'),
        DeepDiveNode(id:'bronchioles',name:'Bronchioli',emoji:'🌱',summary:'Piccole vie aeree senza cartilagine.',details:'Regolano la resistenza al flusso grazie alla muscolatura liscia.'),
        DeepDiveNode(id:'alveoli',name:'Alveoli',emoji:'🫧',summary:'Unità terminali dello scambio gassoso.',details:'Presentano pneumociti di tipo I e II e stretto rapporto con i capillari.',microPathId:'lung_micro'),
        DeepDiveNode(id:'pleura',name:'Pleura',emoji:'🫁',summary:'Sierosa viscerale e parietale.',details:'Riduce l’attrito e contribuisce alla meccanica toracica.'),
      ],
    ),
    DeepDiveNode(
      id:'kidney',name:'Rene',emoji:'🫘',summary:'Regola volume, elettroliti e composizione del sangue.',details:'Produce urina tramite filtrazione glomerulare e modificazioni tubulari.',microPathId:'kidney_micro',
      children:[
        DeepDiveNode(id:'renal_cortex',name:'Corteccia renale',emoji:'🫘',summary:'Regione esterna del rene.',details:'Contiene corpuscoli renali e porzioni tubulari.',microPathId:'kidney_micro'),
        DeepDiveNode(id:'renal_medulla',name:'Midollare renale',emoji:'🫘',summary:'Regione organizzata in piramidi.',details:'Contiene anse di Henle e dotti collettori.'),
        DeepDiveNode(
          id:'nephron',name:'Nefrone',emoji:'💧',summary:'Unità funzionale del rene.',details:'Comprende corpuscolo renale, tubulo prossimale, ansa di Henle e tubulo distale.',microPathId:'kidney_micro',
          children:[
            DeepDiveNode(id:'glomerulus',name:'Glomerulo',emoji:'🩸',summary:'Gomitolo capillare filtrante.',details:'La pressione idrostatica favorisce la formazione del filtrato.'),
            DeepDiveNode(id:'prox_tubule',name:'Tubulo prossimale',emoji:'〰️',summary:'Sede di intenso riassorbimento.',details:'Recupera gran parte di acqua, sodio, glucosio e altri soluti.'),
            DeepDiveNode(id:'henle',name:'Ansa di Henle',emoji:'↪️',summary:'Contribuisce al gradiente midollare.',details:'Ha segmenti con proprietà di permeabilità differenti.'),
          ],
        ),
      ],
    ),
    DeepDiveNode(
      id:'liver',name:'Fegato',emoji:'🟤',summary:'Grande organo metabolico e secretorio.',details:'Integra metabolismo, sintesi, detossificazione e produzione della bile.',microPathId:'liver_micro',
      children:[
        DeepDiveNode(id:'right_lobe',name:'Lobo destro',emoji:'🟤',summary:'Porzione più voluminosa.',details:'Occupa gran parte dell’ipocondrio destro.'),
        DeepDiveNode(id:'left_lobe',name:'Lobo sinistro',emoji:'🟤',summary:'Porzione più piccola verso sinistra.',details:'Si estende verso l’epigastrio.'),
        DeepDiveNode(id:'lobule',name:'Lobulo epatico',emoji:'🔬',summary:'Unità istologica classica.',details:'Epatociti disposti in cordoni intorno a una vena centrale.',microPathId:'liver_micro'),
        DeepDiveNode(id:'portal_triad',name:'Triade portale',emoji:'🩸',summary:'Ramo portale, arterioso e biliare.',details:'Si trova alla periferia dei lobuli classici.'),
      ],
    ),
    DeepDiveNode(
      id:'stomach',name:'Stomaco',emoji:'🥣',summary:'Organo muscolare della digestione gastrica.',details:'Mescola il bolo con secrezioni acide ed enzimatiche formando il chimo.',
      children:[
        DeepDiveNode(id:'fundus',name:'Fondo',emoji:'🥣',summary:'Regione superiore a cupola.',details:'Può contenere gas e partecipa alla funzione di serbatoio.'),
        DeepDiveNode(id:'body_stomach',name:'Corpo',emoji:'🥣',summary:'Porzione principale.',details:'Ricco di ghiandole gastriche.'),
        DeepDiveNode(id:'pylorus',name:'Piloro',emoji:'🚪',summary:'Regione distale verso il duodeno.',details:'Regola lo svuotamento gastrico.'),
      ],
    ),
    DeepDiveNode(
      id:'intestine',name:'Intestino tenue',emoji:'➰',summary:'Principale sede di digestione terminale e assorbimento.',details:'Comprende duodeno, digiuno e ileo; villi e microvilli amplificano la superficie.',microPathId:'intestine_micro',
      children:[
        DeepDiveNode(id:'duodenum',name:'Duodeno',emoji:'1️⃣',summary:'Prima porzione.',details:'Riceve chimo, bile e secrezioni pancreatiche.'),
        DeepDiveNode(id:'jejunum',name:'Digiuno',emoji:'➰',summary:'Porzione intermedia.',details:'Importante per l’assorbimento di numerosi nutrienti.'),
        DeepDiveNode(id:'ileum',name:'Ileo',emoji:'➰',summary:'Porzione terminale.',details:'Termina nella valvola ileocecale.'),
        DeepDiveNode(id:'villus',name:'Villo intestinale',emoji:'🔬',summary:'Proiezione della mucosa.',details:'Contiene capillari e un vaso chilifero centrale.',microPathId:'intestine_micro'),
      ],
    ),
    DeepDiveNode(
      id:'pancreas',name:'Pancreas',emoji:'🟡',summary:'Ghiandola sia esocrina sia endocrina.',details:'Gli acini producono secrezioni digestive; le isole pancreatiche producono ormoni.',
      children:[
        DeepDiveNode(id:'acini',name:'Acini pancreatici',emoji:'🔬',summary:'Componente esocrina.',details:'Secernono enzimi digestivi nei dotti.'),
        DeepDiveNode(id:'islets',name:'Isole pancreatiche',emoji:'⚗️',summary:'Componente endocrina.',details:'Contengono cellule beta, alfa e altre popolazioni endocrine.'),
      ],
    ),
    DeepDiveNode(
      id:'thyroid',name:'Tiroide',emoji:'🦋',summary:'Ghiandola endocrina cervicale.',details:'I follicoli tiroidei producono ormoni tiroidei; le cellule C producono calcitonina.',
      children:[
        DeepDiveNode(id:'follicle',name:'Follicolo tiroideo',emoji:'🔬',summary:'Unità sferica piena di colloide.',details:'Le cellule follicolari circondano il colloide.'),
        DeepDiveNode(id:'c_cell',name:'Cellule C',emoji:'🧫',summary:'Cellule parafollicolari.',details:'Producono calcitonina.'),
      ],
    ),
  ];

  static String _normalize(String value)=>value.toLowerCase().replaceAll('destro','').replaceAll('sinistro','').replaceAll('polmone','polmoni').replaceAll('reni','rene').trim();

  static DeepDiveNode? find(String name){
    final q=_normalize(name);
    for(final root in roots){if(_normalize(root.name)==q)return root;}
    if(q.contains('cuore'))return roots.firstWhere((e)=>e.id=='heart');
    if(q.contains('cervello'))return roots.firstWhere((e)=>e.id=='brain');
    if(q.contains('polmon'))return roots.firstWhere((e)=>e.id=='lungs');
    if(q.contains('rene'))return roots.firstWhere((e)=>e.id=='kidney');
    if(q.contains('fegato'))return roots.firstWhere((e)=>e.id=='liver');
    if(q.contains('stomaco'))return roots.firstWhere((e)=>e.id=='stomach');
    if(q.contains('intestino'))return roots.firstWhere((e)=>e.id=='intestine');
    if(q.contains('pancreas'))return roots.firstWhere((e)=>e.id=='pancreas');
    if(q.contains('tiroide'))return roots.firstWhere((e)=>e.id=='thyroid');
    return null;
  }

  static HistologyPath? microPathFor(DeepDiveNode node){
    if(node.microPathId==null)return null;
    for(final p in histologyPaths){if(p.id==node.microPathId)return p;}
    return null;
  }
}

class DeepDiveHubPage extends StatelessWidget {
  const DeepDiveHubPage({super.key});
  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Deep Dive anatomico')),
    body:ListView(padding:const EdgeInsets.fromLTRB(18,6,18,32),children:[
      Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF6546A8),Color(0xFF9B6DD0)]),borderRadius:BorderRadius.circular(30)),child:const Row(children:[
        Text('🔎',style:TextStyle(fontSize:52)),SizedBox(width:14),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Dentro gli organi',style:TextStyle(color:Colors.white,fontSize:23,fontWeight:FontWeight.w900)),Text('Macroanatomia → parti → microanatomia.',style:TextStyle(color:Colors.white70))])),
      ])),
      const SizedBox(height:18),
      ...DeepDiveRegistry.roots.map((node)=>Card(margin:const EdgeInsets.only(bottom:8),child:ListTile(contentPadding:const EdgeInsets.all(15),leading:Text(node.emoji,style:const TextStyle(fontSize:34)),title:Text(node.name,style:const TextStyle(fontWeight:FontWeight.w900)),subtitle:Text(node.children.length.toString()+' sezioni · '+node.summary),trailing:const Icon(Icons.chevron_right),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>DeepDiveDetailPage(root:node)))))),
    ]),
  );
}

class DeepDiveDetailPage extends StatefulWidget {
  final DeepDiveNode root;
  const DeepDiveDetailPage({super.key,required this.root});
  @override State<DeepDiveDetailPage> createState()=>_DeepDiveDetailPageState();
}

class _DeepDiveDetailPageState extends State<DeepDiveDetailPage> {
  late List<DeepDiveNode> stack;
  @override void initState(){super.initState();stack=[widget.root];}
  DeepDiveNode get current=>stack.last;

  @override
  Widget build(BuildContext context){
    final micro=DeepDiveRegistry.microPathFor(current);
    return Scaffold(
      appBar:AppBar(title:Text(current.emoji+' '+widget.root.name),leading:stack.length>1?IconButton(icon:const Icon(Icons.arrow_back),onPressed:()=>setState(()=>stack.removeLast())):null),
      body:ListView(padding:const EdgeInsets.fromLTRB(18,4,18,32),children:[
        SingleChildScrollView(scrollDirection:Axis.horizontal,child:Row(children:[
          for(int i=0;i<stack.length;i++)...[
            ActionChip(label:Text(stack[i].name),onPressed:i==stack.length-1?null:()=>setState(()=>stack=stack.sublist(0,i+1))),
            if(i<stack.length-1)const Padding(padding:EdgeInsets.symmetric(horizontal:4),child:Icon(Icons.chevron_right,size:17)),
          ],
        ])),
        const SizedBox(height:14),
        Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(28)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text(current.emoji,style:const TextStyle(fontSize:56)),const SizedBox(height:8),Text(current.name,style:const TextStyle(fontSize:27,fontWeight:FontWeight.w900)),const SizedBox(height:6),Text(current.summary,style:const TextStyle(fontWeight:FontWeight.w700)),
        ])),
        const SizedBox(height:16),
        InfoPanel(title:'Approfondimento',text:current.details,icon:Icons.menu_book_outlined),
        if(micro!=null)...[
          const SizedBox(height:12),
          FilledButton.icon(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>HistologyPathPage(path:micro))),icon:const Icon(Icons.biotech_outlined),label:const Padding(padding:EdgeInsets.symmetric(vertical:12),child:Text('Scendi fino al livello microscopico'))),
        ],
        if(current.children.isNotEmpty)...[
          const SizedBox(height:22),const Text('Esplora',style:TextStyle(fontSize:21,fontWeight:FontWeight.w900)),const SizedBox(height:8),
          ...current.children.map((child)=>Card(margin:const EdgeInsets.only(bottom:8),child:ListTile(leading:Text(child.emoji,style:const TextStyle(fontSize:30)),title:Text(child.name,style:const TextStyle(fontWeight:FontWeight.w900)),subtitle:Text(child.summary),trailing:const Icon(Icons.chevron_right),onTap:()=>setState(()=>stack.add(child))))),
        ],
      ]),
    );
  }
}
