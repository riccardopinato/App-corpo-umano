import 'package:flutter/material.dart';

enum ExpandedContentType { muscle, joint, ligament, lymphatic, reproductive, primaryTooth }

extension ExpandedContentTypeX on ExpandedContentType {
  String get label {
    switch(this) {
      case ExpandedContentType.muscle: return 'Muscoli';
      case ExpandedContentType.joint: return 'Articolazioni';
      case ExpandedContentType.ligament: return 'Legamenti';
      case ExpandedContentType.lymphatic: return 'Linfatico';
      case ExpandedContentType.reproductive: return 'Riproduttivo';
      case ExpandedContentType.primaryTooth: return 'Dentizione decidua';
    }
  }
  String get emoji {
    switch(this) {
      case ExpandedContentType.muscle: return '💪';
      case ExpandedContentType.joint: return '🦿';
      case ExpandedContentType.ligament: return '🧵';
      case ExpandedContentType.lymphatic: return '🛡️';
      case ExpandedContentType.reproductive: return '🧬';
      case ExpandedContentType.primaryTooth: return '🦷';
    }
  }
}

class ExpandedContentEntry {
  final String id,name,region,description,function;
  final ExpandedContentType type;
  const ExpandedContentEntry({
    required this.id,required this.name,required this.region,required this.description,required this.function,required this.type,
  });

  bool matches(String q) {
    final query=q.trim().toLowerCase();
    if(query.isEmpty)return true;
    return (name+' '+region+' '+description+' '+function+' '+type.label).toLowerCase().contains(query);
  }
}

const expandedContent=<ExpandedContentEntry>[
  ExpandedContentEntry(id:'m01',name:'Massetere',region:'Testa',description:'Muscolo masticatorio superficiale.',function:'Eleva la mandibola.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m02',name:'Temporale',region:'Testa',description:'Muscolo masticatorio a ventaglio.',function:'Eleva e retrae la mandibola.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m03',name:'Sternocleidomastoideo',region:'Collo',description:'Muscolo superficiale del collo.',function:'Flette e ruota il capo.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m04',name:'Trapezio',region:'Dorso',description:'Ampio muscolo superficiale cervico-dorsale.',function:'Muove scapola e contribuisce ai movimenti del collo.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m05',name:'Deltoide',region:'Spalla',description:'Muscolo che avvolge l’articolazione gleno-omerale.',function:'Abduce il braccio e partecipa a flessione/estensione.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m06',name:'Sovraspinato',region:'Spalla',description:'Muscolo della cuffia dei rotatori.',function:'Avvia l’abduzione e stabilizza la testa omerale.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m07',name:'Sottospinato',region:'Spalla',description:'Muscolo della cuffia dei rotatori.',function:'Ruota lateralmente l’omero.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m08',name:'Piccolo rotondo',region:'Spalla',description:'Muscolo della cuffia dei rotatori.',function:'Rotazione laterale dell’omero.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m09',name:'Sottoscapolare',region:'Spalla',description:'Muscolo anteriore della scapola.',function:'Ruota medialmente l’omero.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m10',name:'Grande pettorale',region:'Torace',description:'Muscolo superficiale anteriore del torace.',function:'Adduce e ruota medialmente il braccio.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m11',name:'Piccolo pettorale',region:'Torace',description:'Muscolo profondo al grande pettorale.',function:'Stabilizza e abbassa la scapola.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m12',name:'Dentato anteriore',region:'Torace',description:'Muscolo laterale della parete toracica.',function:'Protrae e stabilizza la scapola.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m13',name:'Gran dorsale',region:'Dorso',description:'Ampio muscolo superficiale del dorso.',function:'Estende, adduce e ruota medialmente il braccio.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m14',name:'Bicipite brachiale',region:'Braccio',description:'Muscolo anteriore a due capi.',function:'Flette il gomito e supina l’avambraccio.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m15',name:'Brachiale',region:'Braccio',description:'Muscolo profondo al bicipite.',function:'Potente flessore del gomito.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m16',name:'Coracobrachiale',region:'Braccio',description:'Muscolo mediale del braccio.',function:'Flette e adduce l’omero.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m17',name:'Tricipite brachiale',region:'Braccio',description:'Muscolo posteriore del braccio a tre capi.',function:'Estende il gomito.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m18',name:'Pronatore rotondo',region:'Avambraccio',description:'Muscolo superficiale anteriore.',function:'Prona l’avambraccio.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m19',name:'Flessore radiale del carpo',region:'Avambraccio',description:'Flessore superficiale dell’avambraccio.',function:'Flette e abduce il polso.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m20',name:'Flessore ulnare del carpo',region:'Avambraccio',description:'Flessore mediale del polso.',function:'Flette e adduce il polso.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m21',name:'Flessore superficiale delle dita',region:'Avambraccio',description:'Muscolo flessore estrinseco della mano.',function:'Flette le interfalangee prossimali.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m22',name:'Estensore comune delle dita',region:'Avambraccio',description:'Muscolo posteriore dell’avambraccio.',function:'Estende le dita 2-5.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m23',name:'Retto dell’addome',region:'Addome',description:'Muscolo verticale della parete addominale.',function:'Flette il tronco e comprime i visceri.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m24',name:'Obliquo esterno',region:'Addome',description:'Muscolo superficiale laterale.',function:'Rotazione controlaterale e flessione del tronco.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m25',name:'Obliquo interno',region:'Addome',description:'Muscolo profondo all’obliquo esterno.',function:'Rotazione omolaterale e compressione addominale.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m26',name:'Trasverso dell’addome',region:'Addome',description:'Strato muscolare più profondo della parete laterale.',function:'Comprime i visceri e stabilizza il tronco.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m27',name:'Erettori spinali',region:'Dorso',description:'Gruppo longitudinale paravertebrale.',function:'Estende e inclina la colonna.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m28',name:'Multifido',region:'Dorso',description:'Muscolo profondo segmentale.',function:'Stabilizza le vertebre e contribuisce alla rotazione.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m29',name:'Ileo-psoas',region:'Pelvi/Coscia',description:'Complesso psoas maggiore + iliaco.',function:'Potente flessore dell’anca.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m30',name:'Grande gluteo',region:'Regione glutea',description:'Muscolo superficiale della natica.',function:'Estende e ruota lateralmente l’anca.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m31',name:'Medio gluteo',region:'Regione glutea',description:'Muscolo laterale dell’anca.',function:'Abduce l’anca e stabilizza il bacino.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m32',name:'Tensore della fascia lata',region:'Coscia',description:'Muscolo antero-laterale.',function:'Tende la fascia lata e stabilizza il ginocchio.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m33',name:'Sartorio',region:'Coscia',description:'Lungo muscolo superficiale obliquo.',function:'Flette, abduce e ruota lateralmente l’anca; flette il ginocchio.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m34',name:'Retto femorale',region:'Coscia',description:'Componente del quadricipite.',function:'Estende il ginocchio e flette l’anca.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m35',name:'Vasto laterale',region:'Coscia',description:'Componente del quadricipite.',function:'Estende il ginocchio.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m36',name:'Vasto mediale',region:'Coscia',description:'Componente del quadricipite.',function:'Estende il ginocchio e stabilizza la rotula.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m37',name:'Vasto intermedio',region:'Coscia',description:'Componente profonda del quadricipite.',function:'Estende il ginocchio.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m38',name:'Bicipite femorale',region:'Coscia posteriore',description:'Componente degli ischiocrurali.',function:'Flette il ginocchio ed estende l’anca con il capo lungo.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m39',name:'Semitendinoso',region:'Coscia posteriore',description:'Componente degli ischiocrurali.',function:'Estende l’anca e flette il ginocchio.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m40',name:'Semimembranoso',region:'Coscia posteriore',description:'Componente degli ischiocrurali.',function:'Estende l’anca e flette il ginocchio.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m41',name:'Adduttore lungo',region:'Coscia mediale',description:'Muscolo del compartimento mediale.',function:'Adduce la coscia.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m42',name:'Grande adduttore',region:'Coscia mediale',description:'Ampio muscolo mediale della coscia.',function:'Adduce la coscia e partecipa all’estensione.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m43',name:'Tibiale anteriore',region:'Gamba',description:'Muscolo anteriore della gamba.',function:'Dorsiflette e inverte il piede.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m44',name:'Estensore lungo delle dita',region:'Gamba',description:'Muscolo anteriore.',function:'Estende le dita e dorsiflette la caviglia.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m45',name:'Peroniero lungo',region:'Gamba laterale',description:'Muscolo laterale della gamba.',function:'Everte e flette plantarmente il piede.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m46',name:'Gastrocnemio',region:'Polpaccio',description:'Muscolo superficiale a due capi.',function:'Flessione plantare e flessione del ginocchio.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m47',name:'Soleo',region:'Polpaccio',description:'Muscolo profondo al gastrocnemio.',function:'Potente flessore plantare posturale.',type:ExpandedContentType.muscle),
  ExpandedContentEntry(id:'m48',name:'Tibiale posteriore',region:'Gamba posteriore',description:'Muscolo profondo posteriore.',function:'Inverte e flette plantarmente il piede.',type:ExpandedContentType.muscle),

  ExpandedContentEntry(id:'j01',name:'Articolazione temporo-mandibolare',region:'Testa',description:'Articolazione sinoviale complessa tra mandibola e temporale.',function:'Movimenti di apertura, chiusura, protrusione e lateralità.',type:ExpandedContentType.joint),
  ExpandedContentEntry(id:'j02',name:'Gleno-omerale',region:'Spalla',description:'Articolazione sinoviale sferoidale.',function:'Grande mobilità del braccio.',type:ExpandedContentType.joint),
  ExpandedContentEntry(id:'j03',name:'Gomito',region:'Arto superiore',description:'Complesso omero-ulnare, omero-radiale e radio-ulnare prossimale.',function:'Flessione/estensione e prono-supinazione.',type:ExpandedContentType.joint),
  ExpandedContentEntry(id:'j04',name:'Polso',region:'Mano',description:'Articolazione radio-carpica.',function:'Flessione, estensione e deviazioni radiale/ulnare.',type:ExpandedContentType.joint),
  ExpandedContentEntry(id:'j05',name:'Anca',region:'Pelvi',description:'Articolazione coxo-femorale sferoidale.',function:'Trasmette carico e consente movimenti multiplanari.',type:ExpandedContentType.joint),
  ExpandedContentEntry(id:'j06',name:'Ginocchio',region:'Arto inferiore',description:'Articolazione femoro-tibiale e femoro-rotulea.',function:'Flessione/estensione con rotazione accessoria.',type:ExpandedContentType.joint),
  ExpandedContentEntry(id:'j07',name:'Caviglia',region:'Piede',description:'Articolazione tibio-tarsica.',function:'Dorsiflessione e flessione plantare.',type:ExpandedContentType.joint),

  ExpandedContentEntry(id:'l01',name:'Legamento crociato anteriore',region:'Ginocchio',description:'Legamento intra-articolare del ginocchio.',function:'Limita traslazione anteriore della tibia e contribuisce alla stabilità rotazionale.',type:ExpandedContentType.ligament),
  ExpandedContentEntry(id:'l02',name:'Legamento crociato posteriore',region:'Ginocchio',description:'Legamento intra-articolare robusto.',function:'Limita traslazione posteriore della tibia.',type:ExpandedContentType.ligament),
  ExpandedContentEntry(id:'l03',name:'Collaterale mediale',region:'Ginocchio',description:'Legamento mediale del ginocchio.',function:'Resiste allo stress in valgo.',type:ExpandedContentType.ligament),
  ExpandedContentEntry(id:'l04',name:'Collaterale laterale',region:'Ginocchio',description:'Legamento laterale del ginocchio.',function:'Resiste allo stress in varo.',type:ExpandedContentType.ligament),
  ExpandedContentEntry(id:'l05',name:'Legamento ileofemorale',region:'Anca',description:'Forte legamento anteriore della capsula.',function:'Limita iperestensione dell’anca.',type:ExpandedContentType.ligament),
  ExpandedContentEntry(id:'l06',name:'Legamento coraco-acromiale',region:'Spalla',description:'Forma un arco sopra la testa omerale.',function:'Contribuisce alla protezione superiore della spalla.',type:ExpandedContentType.ligament),
  ExpandedContentEntry(id:'l07',name:'Legamento deltoideo',region:'Caviglia',description:'Complesso legamentoso mediale della caviglia.',function:'Stabilizza il compartimento mediale.',type:ExpandedContentType.ligament),
  ExpandedContentEntry(id:'l08',name:'Legamento talo-fibulare anteriore',region:'Caviglia',description:'Legamento laterale spesso coinvolto nelle distorsioni.',function:'Contrasta traslazione anteriore dell’astragalo e inversione.',type:ExpandedContentType.ligament),

  ExpandedContentEntry(id:'ly01',name:'Linfonodi cervicali',region:'Collo',description:'Gruppi linfonodali superficiali e profondi.',function:'Filtrano linfa proveniente da testa e collo.',type:ExpandedContentType.lymphatic),
  ExpandedContentEntry(id:'ly02',name:'Linfonodi ascellari',region:'Ascella',description:'Importante stazione linfatica dell’arto superiore e mammella.',function:'Filtraggio linfatico e risposta immunitaria.',type:ExpandedContentType.lymphatic),
  ExpandedContentEntry(id:'ly03',name:'Linfonodi inguinali',region:'Inguine',description:'Stazione linfatica superficiale e profonda.',function:'Drenaggio di arto inferiore e regioni pelviche superficiali.',type:ExpandedContentType.lymphatic),
  ExpandedContentEntry(id:'ly04',name:'Dotto toracico',region:'Torace',description:'Principale dotto linfatico del corpo.',function:'Riporta linfa alla circolazione venosa.',type:ExpandedContentType.lymphatic),
  ExpandedContentEntry(id:'ly05',name:'Timo',region:'Mediastino',description:'Organo linfoide primario.',function:'Maturazione dei linfociti T.',type:ExpandedContentType.lymphatic),
  ExpandedContentEntry(id:'ly06',name:'Milza',region:'Addome',description:'Organo linfoide secondario.',function:'Filtra sangue, partecipa alla risposta immunitaria e rimuove cellule ematiche senescenti.',type:ExpandedContentType.lymphatic),
  ExpandedContentEntry(id:'ly07',name:'Midollo osseo',region:'Scheletro',description:'Tessuto emopoietico.',function:'Produce le cellule del sangue.',type:ExpandedContentType.lymphatic),

  ExpandedContentEntry(id:'r01',name:'Ovaio',region:'Pelvi femminile',description:'Gonade femminile pari.',function:'Produce ovociti e ormoni sessuali.',type:ExpandedContentType.reproductive),
  ExpandedContentEntry(id:'r02',name:'Tuba uterina',region:'Pelvi femminile',description:'Condotto tra regione ovarica e utero.',function:'Trasporto dell’ovocita; sede frequente della fecondazione.',type:ExpandedContentType.reproductive),
  ExpandedContentEntry(id:'r03',name:'Utero',region:'Pelvi femminile',description:'Organo muscolare cavo.',function:'Accoglie e sostiene lo sviluppo embrio-fetale.',type:ExpandedContentType.reproductive),
  ExpandedContentEntry(id:'r04',name:'Cervice uterina',region:'Pelvi femminile',description:'Porzione inferiore dell’utero.',function:'Comunica con la vagina tramite il canale cervicale.',type:ExpandedContentType.reproductive),
  ExpandedContentEntry(id:'r05',name:'Testicolo',region:'Scroto',description:'Gonade maschile pari.',function:'Produzione di spermatozoi e testosterone.',type:ExpandedContentType.reproductive),
  ExpandedContentEntry(id:'r06',name:'Epididimo',region:'Scroto',description:'Condotto aderente al testicolo.',function:'Maturazione e deposito degli spermatozoi.',type:ExpandedContentType.reproductive),
  ExpandedContentEntry(id:'r07',name:'Dotto deferente',region:'Pelvi maschile',description:'Condotto muscolare dell’apparato genitale maschile.',function:'Trasporta spermatozoi verso i dotti eiaculatori.',type:ExpandedContentType.reproductive),
  ExpandedContentEntry(id:'r08',name:'Prostata',region:'Pelvi maschile',description:'Ghiandola sotto la vescica.',function:'Contribuisce al liquido seminale.',type:ExpandedContentType.reproductive),

  ExpandedContentEntry(id:'d51',name:'51 · Incisivo centrale superiore destro deciduo',region:'Arcata superiore',description:'Dente deciduo anteriore.',function:'Taglio del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d52',name:'52 · Incisivo laterale superiore destro deciduo',region:'Arcata superiore',description:'Dente deciduo anteriore.',function:'Taglio del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d53',name:'53 · Canino superiore destro deciduo',region:'Arcata superiore',description:'Dente deciduo.',function:'Lacerazione del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d54',name:'54 · Primo molare superiore destro deciduo',region:'Arcata superiore',description:'Molare deciduo.',function:'Triturazione del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d55',name:'55 · Secondo molare superiore destro deciduo',region:'Arcata superiore',description:'Molare deciduo.',function:'Triturazione del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d61',name:'61 · Incisivo centrale superiore sinistro deciduo',region:'Arcata superiore',description:'Dente deciduo anteriore.',function:'Taglio del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d62',name:'62 · Incisivo laterale superiore sinistro deciduo',region:'Arcata superiore',description:'Dente deciduo anteriore.',function:'Taglio del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d63',name:'63 · Canino superiore sinistro deciduo',region:'Arcata superiore',description:'Dente deciduo.',function:'Lacerazione del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d64',name:'64 · Primo molare superiore sinistro deciduo',region:'Arcata superiore',description:'Molare deciduo.',function:'Triturazione del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d65',name:'65 · Secondo molare superiore sinistro deciduo',region:'Arcata superiore',description:'Molare deciduo.',function:'Triturazione del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d71',name:'71 · Incisivo centrale inferiore sinistro deciduo',region:'Arcata inferiore',description:'Dente deciduo anteriore.',function:'Taglio del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d72',name:'72 · Incisivo laterale inferiore sinistro deciduo',region:'Arcata inferiore',description:'Dente deciduo anteriore.',function:'Taglio del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d73',name:'73 · Canino inferiore sinistro deciduo',region:'Arcata inferiore',description:'Dente deciduo.',function:'Lacerazione del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d74',name:'74 · Primo molare inferiore sinistro deciduo',region:'Arcata inferiore',description:'Molare deciduo.',function:'Triturazione del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d75',name:'75 · Secondo molare inferiore sinistro deciduo',region:'Arcata inferiore',description:'Molare deciduo.',function:'Triturazione del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d81',name:'81 · Incisivo centrale inferiore destro deciduo',region:'Arcata inferiore',description:'Dente deciduo anteriore.',function:'Taglio del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d82',name:'82 · Incisivo laterale inferiore destro deciduo',region:'Arcata inferiore',description:'Dente deciduo anteriore.',function:'Taglio del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d83',name:'83 · Canino inferiore destro deciduo',region:'Arcata inferiore',description:'Dente deciduo.',function:'Lacerazione del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d84',name:'84 · Primo molare inferiore destro deciduo',region:'Arcata inferiore',description:'Molare deciduo.',function:'Triturazione del cibo.',type:ExpandedContentType.primaryTooth),
  ExpandedContentEntry(id:'d85',name:'85 · Secondo molare inferiore destro deciduo',region:'Arcata inferiore',description:'Molare deciduo.',function:'Triturazione del cibo.',type:ExpandedContentType.primaryTooth),
];

class ExpandedContentPage extends StatefulWidget {
  const ExpandedContentPage({super.key});
  @override State<ExpandedContentPage> createState()=>_ExpandedContentPageState();
}

class _ExpandedContentPageState extends State<ExpandedContentPage> {
  String query='';
  ExpandedContentType? type;

  @override
  Widget build(BuildContext context) {
    final list=expandedContent.where((e)=>(type==null||e.type==type)&&e.matches(query)).toList();
    return Scaffold(
      appBar:AppBar(title:const Text('Catalogo completo')),
      body:Column(children:[
        Padding(
          padding:const EdgeInsets.fromLTRB(16,4,16,8),
          child:SearchBar(
            hintText:'Cerca muscolo, legamento, dente...',
            leading:const Icon(Icons.search),
            onChanged:(v)=>setState(()=>query=v),
          ),
        ),
        SizedBox(
          height:46,
          child:ListView(
            scrollDirection:Axis.horizontal,
            padding:const EdgeInsets.symmetric(horizontal:16),
            children:[
              ChoiceChip(label:const Text('Tutto'),selected:type==null,onSelected:(_)=>setState(()=>type=null)),
              const SizedBox(width:6),
              ...ExpandedContentType.values.map((v)=>Padding(
                padding:const EdgeInsets.only(right:6),
                child:ChoiceChip(label:Text(v.emoji+' '+v.label),selected:type==v,onSelected:(_)=>setState(()=>type=v)),
              )),
            ],
          ),
        ),
        Expanded(
          child:ListView(
            padding:const EdgeInsets.fromLTRB(16,10,16,28),
            children:[
              Container(
                padding:const EdgeInsets.all(20),
                decoration:BoxDecoration(
                  gradient:const LinearGradient(colors:[Color(0xFF3569A8),Color(0xFF5A9BD5)]),
                  borderRadius:BorderRadius.circular(28),
                ),
                child:Row(children:[
                  const Text('📚',style:TextStyle(fontSize:48)),
                  const SizedBox(width:14),
                  Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                    const Text('Content Expansion',style:TextStyle(color:Colors.white,fontSize:22,fontWeight:FontWeight.w900)),
                    Text(expandedContent.length.toString()+' strutture aggiuntive',style:const TextStyle(color:Colors.white70)),
                  ])),
                ]),
              ),
              const SizedBox(height:16),
              Text(list.length.toString()+' risultati',style:const TextStyle(fontSize:20,fontWeight:FontWeight.w900)),
              const SizedBox(height:8),
              ...list.map((e)=>Card(
                margin:const EdgeInsets.only(bottom:8),
                child:ListTile(
                  contentPadding:const EdgeInsets.all(14),
                  leading:Text(e.type.emoji,style:const TextStyle(fontSize:32)),
                  title:Text(e.name,style:const TextStyle(fontWeight:FontWeight.w900)),
                  subtitle:Text(e.type.label+' · '+e.region+'\n'+e.description,maxLines:3,overflow:TextOverflow.ellipsis),
                  isThreeLine:true,
                  trailing:const Icon(Icons.chevron_right),
                  onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>ExpandedContentDetail(entry:e))),
                ),
              )),
            ],
          ),
        ),
      ]),
    );
  }
}

class ExpandedContentDetail extends StatelessWidget {
  final ExpandedContentEntry entry;
  const ExpandedContentDetail({super.key,required this.entry});
  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:Text(entry.type.emoji+' '+entry.name)),
    body:ListView(
      padding:const EdgeInsets.all(18),
      children:[
        Container(
          padding:const EdgeInsets.all(22),
          decoration:BoxDecoration(color:Theme.of(context).colorScheme.primaryContainer,borderRadius:BorderRadius.circular(28)),
          child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Text(entry.type.emoji,style:const TextStyle(fontSize:54)),
            const SizedBox(height:8),
            Text(entry.name,style:const TextStyle(fontSize:25,fontWeight:FontWeight.w900)),
            const SizedBox(height:4),
            Text(entry.type.label+' · '+entry.region),
          ]),
        ),
        const SizedBox(height:16),
        _ContentPanel(title:'Anatomia',text:entry.description,icon:Icons.accessibility_new_outlined),
        const SizedBox(height:10),
        _ContentPanel(title:'Funzione',text:entry.function,icon:Icons.settings_outlined),
      ],
    ),
  );
}

class _ContentPanel extends StatelessWidget {
  final String title,text;
  final IconData icon;
  const _ContentPanel({required this.title,required this.text,required this.icon});
  @override
  Widget build(BuildContext context)=>Container(
    padding:const EdgeInsets.all(18),
    decoration:BoxDecoration(color:Theme.of(context).colorScheme.surfaceContainerLow,borderRadius:BorderRadius.circular(22)),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Row(children:[Icon(icon),const SizedBox(width:8),Text(title,style:const TextStyle(fontWeight:FontWeight.w900,fontSize:17))]),
      const SizedBox(height:9),
      Text(text,style:const TextStyle(height:1.5)),
    ]),
  );
}
