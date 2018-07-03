// #docregion
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'hero.dart';
import 'hero_detail_component.dart';
import 'hero_service.dart';

@Component(
  selector: 'my-heroes',
  templateUrl: 'heroes_component.html',
  styleUrls: const ['heroes_component.css'],
  directives: const [CORE_DIRECTIVES, HeroDetailComponent],
  pipes: const [COMMON_PIPES],
)
class HeroesComponent implements OnInit {
  final HeroService _heroService;
  final Router _router;
  List<Hero> heroes;
  Hero selectedHero;

  HeroesComponent(this._heroService, this._router);

  Future<Null> getHeroes() async {
    heroes = await _heroService.getHeroes();
  }

  // #docregion add
  Future<Null> add(String name) async {
    name = name.trim();
    if (name.isEmpty) return;
    heroes.add(await _heroService.create(name));
    selectedHero = null;
  }
  // #enddocregion add

  // #docregion delete
  Future<Null> delete(Hero hero) async {
    await _heroService.delete(hero.id);
    heroes.remove(hero);
    if (selectedHero == hero) selectedHero = null;
  }
  // #enddocregion delete

  void ngOnInit() => getHeroes();

  void onSelect(Hero hero) => selectedHero = hero;

  Future<Null> gotoDetail() => _router.navigate([
        'HeroDetail',
        {'id': selectedHero.id.toString()}
      ]);
}