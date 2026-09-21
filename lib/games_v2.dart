import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GameItem {
  final String name, category, emoji;
  const GameItem(this.name, this.category, this.emoji);
}

const gameItems = <GameItem>[
  GameItem('Cranio','Scheletro','💀'), GameItem('Clavicola','Scheletro','🦴'),
  GameItem('Scapola','Scheletro','🦴'), GameItem('Sterno','Scheletro','🦴'),
  GameItem('Omero','Scheletro','🦴'), GameItem('Radio','Scheletro','🦴'),
  GameItem('Ulna','Scheletro','🦴'), GameItem('Femore','Scheletro','🦴'),
  GameItem('Rotula','Scheletro','🦴'), GameItem('Tibia','Scheletro','🦴'),
  GameItem('Fibula','Scheletro','🦴'), GameItem('Deltoide','Muscolare','💪'),
  GameItem('Bicipite brachiale','Muscolare','💪'), GameItem('Tricipite brachiale','Muscolare','💪'),
  GameItem('Grande pettorale','Muscolare','💪'), GameItem('Retto dell’addome','Muscolare','💪'),
  GameItem('Quadricipite','Muscolare','💪'), GameItem('Gastrocnemio','Muscolare','💪'),
  GameItem('Cervello','Nervoso','🧠'), GameItem('Midollo spinale','Nervoso','⚡'),
  GameItem('Nervo sciatico','Nervoso','⚡'), GameItem('Cuore','Cardiovascolare','❤️'),
  GameItem('Aorta','Cardiovascolare','🔴'), GameItem('Carotide comune','Cardiovascolare','🔴'),
  GameItem('Vena cava inferiore','Cardiovascolare','🔵'), GameItem('Polmoni','Respiratorio','🫁'),
  GameItem('Trachea','Respiratorio','🌬️'), GameItem('Bronchi','Respiratorio','🌿'),
  GameItem('Fegato','Digerente','🟤'), GameItem('Stomaco','Digerente','🥣'),
  GameItem('Pancreas','Digerente','🟡'), GameItem('Intestino tenue','Digerente','➰'),
  GameItem('Rene','Urinario','🫘'), GameItem('Vescica','Urinario','💧'),
  GameItem('Tiroide','Endocrino','🦋'), GameItem('Milza','Immunitario','🛡️'),
];

class GamesHubPage extends StatelessWidget {
  const GamesHubPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Anatomy Games 2.0')),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(18, 6, 18, 32),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFEF6A72), Color(0xFFF89A62)]),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Row(children: [
            Text('🎮', style: TextStyle(fontSize: 52)),
            SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Impara giocando', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w900)),
              Text('Quattro modalità, difficoltà crescente.', style: TextStyle(color: Colors.white70)),
            ])),
          ]),
        ),
        const SizedBox(height: 18),
        _GameModeCard(emoji:'🎯', title:'Riconoscimento', subtitle:'Associa la struttura al sistema corretto.', onTap:()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>const RecognitionGamePage()))),
        _GameModeCard(emoji:'⏱️', title:'Time Attack', subtitle:'60 secondi: accumula più punti possibile.', onTap:()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>const TimeAttackGamePage()))),
        _GameModeCard(emoji:'🧠', title:'Memory anatomico', subtitle:'Trova le coppie tra strutture anatomiche.', onTap:()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>const MemoryGamePage()))),
        _GameModeCard(emoji:'🗺️', title:'Region Challenge', subtitle:'Trova la struttura della regione corretta.', onTap:()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>const RegionChallengePage()))),
      ],
    ),
  );
}

class _GameModeCard extends StatelessWidget {
  final String emoji, title, subtitle;
  final VoidCallback onTap;
  const _GameModeCard({required this.emoji, required this.title, required this.subtitle, required this.onTap});
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: Text(emoji, style: const TextStyle(fontSize: 36)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    ),
  );
}

class RecognitionGamePage extends StatefulWidget {
  const RecognitionGamePage({super.key});
  @override State<RecognitionGamePage> createState()=>_RecognitionGamePageState();
}

class _RecognitionGamePageState extends State<RecognitionGamePage> {
  final Random rng = Random();
  int score = 0, round = 0;
  late GameItem current;
  late List<String> options;
  @override void initState(){ super.initState(); _next(); }

  void _next(){
    current = gameItems[rng.nextInt(gameItems.length)];
    final cats = <String>{for(final i in gameItems) i.category}.where((c)=>c!=current.category).toList()..shuffle(rng);
    options = <String>[current.category, ...cats.take(3)]..shuffle(rng);
  }

  void _answer(String answer){
    final ok = answer == current.category;
    final correctCategory = current.category;
    setState(() {
      round++;
      score = max(0, score + (ok ? 100 : -20));
      _next();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(duration: const Duration(milliseconds: 450), content: Text(ok ? 'Corretto ✅' : 'Sistema corretto: ' + correctCategory)),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Riconoscimento')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        _ScoreHeader(score: score, label: 'Round ' + round.toString()),
        const Spacer(),
        Text(current.emoji, style: const TextStyle(fontSize: 76)),
        const SizedBox(height: 12),
        Text(current.name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        const Text('A quale sistema appartiene?'),
        const SizedBox(height: 22),
        ...options.map((o)=>Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SizedBox(width: double.infinity, child: FilledButton.tonal(onPressed:()=>_answer(o), child: Padding(padding: const EdgeInsets.symmetric(vertical: 14), child: Text(o)))),
        )),
        const Spacer(),
      ]),
    ),
  );
}

class TimeAttackGamePage extends StatefulWidget {
  const TimeAttackGamePage({super.key});
  @override State<TimeAttackGamePage> createState()=>_TimeAttackGamePageState();
}

class _TimeAttackGamePageState extends State<TimeAttackGamePage> {
  final Random rng = Random();
  Timer? timer;
  int seconds = 60, score = 0, answers = 0;
  bool started = false, finished = false;
  late GameItem current;
  late List<String> options;

  @override void initState(){ super.initState(); _next(); }

  void _next(){
    current = gameItems[rng.nextInt(gameItems.length)];
    final names = gameItems.where((e)=>e.name!=current.name).map((e)=>e.name).toList()..shuffle(rng);
    options = <String>[current.name, ...names.take(3)]..shuffle(rng);
  }

  void _start(){
    if(started) return;
    setState(()=>started=true);
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if(!mounted) return;
      if(seconds <= 1){
        t.cancel();
        setState(() { seconds = 0; finished = true; });
      } else {
        setState(()=>seconds--);
      }
    });
  }

  void _answer(String answer){
    if(!started) _start();
    if(finished) return;
    final ok = answer == current.name;
    setState(() {
      answers++;
      score = max(0, score + (ok ? 120 : -30));
      _next();
    });
  }

  @override void dispose(){ timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Time Attack')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: finished
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('⏱️', style: TextStyle(fontSize: 72)),
              const SizedBox(height: 12),
              Text(score.toString() + ' pt', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
              Text(answers.toString() + ' risposte in 60 secondi'),
              const SizedBox(height: 22),
              FilledButton(onPressed:()=>Navigator.pop(context), child: const Text('Termina')),
            ]))
          : Column(children: [
              Row(children: [
                Expanded(child: _ScoreHeader(score: score, label: 'Risposte ' + answers.toString())),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.errorContainer, borderRadius: BorderRadius.circular(20)),
                  child: Text(seconds.toString() + 's', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                ),
              ]),
              const Spacer(),
              Text(current.emoji, style: const TextStyle(fontSize: 72)),
              const SizedBox(height: 12),
              Text('Trova: ' + current.name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
              const SizedBox(height: 20),
              ...options.map((o)=>Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SizedBox(width: double.infinity, child: FilledButton.tonal(onPressed:()=>_answer(o), child: Padding(padding: const EdgeInsets.symmetric(vertical: 13), child: Text(o)))),
              )),
              if(!started) const Padding(padding: EdgeInsets.only(top: 8), child: Text('Il timer parte alla prima risposta.')),
              const Spacer(),
            ]),
    ),
  );
}

class MemoryGamePage extends StatefulWidget {
  const MemoryGamePage({super.key});
  @override State<MemoryGamePage> createState()=>_MemoryGamePageState();
}

class _MemoryCardData {
  final String id, label, emoji;
  bool matched = false;
  _MemoryCardData(this.id, this.label, this.emoji);
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  late List<_MemoryCardData> cards;
  int? first;
  bool locked = false;
  int moves = 0, matches = 0;

  @override
  void initState(){
    super.initState();
    final base = <GameItem>[...gameItems]..shuffle(Random());
    final chosen = base.take(6).toList();
    cards = [];
    for(final item in chosen){
      cards.add(_MemoryCardData(item.name, item.name, item.emoji));
      cards.add(_MemoryCardData(item.name, item.name, item.emoji));
    }
    cards.shuffle(Random());
  }

  Future<void> _tap(int index) async {
    if(locked || cards[index].matched || first == index) return;
    if(first == null){
      setState(()=>first=index);
      return;
    }
    final a = first!;
    setState(() { locked = true; moves++; });
    if(cards[a].id == cards[index].id){
      await Future<void>.delayed(const Duration(milliseconds: 250));
      if(!mounted) return;
      setState(() {
        cards[a].matched = true;
        cards[index].matched = true;
        matches++;
        first = null;
        locked = false;
      });
    } else {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      if(!mounted) return;
      setState(() { first = null; locked = false; });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Memory anatomico')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        _ScoreHeader(score: matches * 100, label: 'Mosse ' + moves.toString()),
        const SizedBox(height: 14),
        Expanded(child: GridView.builder(
          itemCount: cards.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: .88),
          itemBuilder: (_, i) {
            final visible = cards[i].matched || first == i;
            return InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap:()=>_tap(i),
              child: Container(
                decoration: BoxDecoration(
                  color: visible ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: visible
                    ? Column(mainAxisSize: MainAxisSize.min, children: [
                        Text(cards[i].emoji, style: const TextStyle(fontSize: 30)),
                        const SizedBox(height: 5),
                        Text(cards[i].label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                      ])
                    : const Text('?', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
              ),
            );
          },
        )),
        if(matches == 6) Padding(padding: const EdgeInsets.only(top: 12), child: FilledButton(onPressed:()=>Navigator.pop(context), child: const Text('Completato'))),
      ]),
    ),
  );
}

class RegionChallengePage extends StatefulWidget {
  const RegionChallengePage({super.key});
  @override State<RegionChallengePage> createState()=>_RegionChallengePageState();
}

class _RegionChallengePageState extends State<RegionChallengePage> {
  static const Map<String,List<String>> regions = {
    'Testa e collo':['Cranio','Cervello','Tiroide','Carotide comune'],
    'Torace':['Cuore','Polmoni','Sterno','Grande pettorale'],
    'Addome':['Fegato','Stomaco','Pancreas','Intestino tenue','Rene'],
    'Arto superiore':['Omero','Radio','Ulna','Bicipite brachiale','Tricipite brachiale'],
    'Arto inferiore':['Femore','Rotula','Tibia','Fibula','Quadricipite','Gastrocnemio'],
  };

  final Random rng = Random();
  int score = 0, round = 0;
  late String region, target;
  late List<String> options;

  @override void initState(){ super.initState(); _next(); }

  void _next(){
    final keys = regions.keys.toList();
    region = keys[rng.nextInt(keys.length)];
    final values = regions[region]!;
    target = values[rng.nextInt(values.length)];
    final wrong = <String>[];
    for(final e in regions.entries){
      if(e.key != region) wrong.addAll(e.value);
    }
    wrong.shuffle(rng);
    options = <String>[target, ...wrong.take(3)]..shuffle(rng);
  }

  void _answer(String value){
    final ok = value == target;
    setState(() {
      round++;
      score = max(0, score + (ok ? 100 : -20));
      _next();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Region Challenge')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        _ScoreHeader(score: score, label: 'Round ' + round.toString()),
        const Spacer(),
        const Text('🗺️', style: TextStyle(fontSize: 72)),
        const SizedBox(height: 14),
        Text(region, textAlign: TextAlign.center, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        const Text('Quale struttura si trova principalmente qui?'),
        const SizedBox(height: 22),
        ...options.map((o)=>Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SizedBox(width: double.infinity, child: FilledButton.tonal(onPressed:()=>_answer(o), child: Padding(padding: const EdgeInsets.symmetric(vertical: 14), child: Text(o)))),
        )),
        const Spacer(),
      ]),
    ),
  );
}

class _ScoreHeader extends StatelessWidget {
  final int score;
  final String label;
  const _ScoreHeader({required this.score, required this.label});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(20)),
    child: Row(children: [
      const Text('🏆', style: TextStyle(fontSize: 24)),
      const SizedBox(width: 8),
      Text(score.toString() + ' pt', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      const Spacer(),
      Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    ]),
  );
}
