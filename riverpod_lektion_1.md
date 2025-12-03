# Riverpod Lektion 1

## Lernziele

Nach dieser Lektion wirst du:
- Verstehen, was Riverpod ist und warum es verwendet wird
- Riverpod in einem Flutter-Projekt einrichten können
- Die wichtigsten Provider-Typen kennen
- Einen bestehenden `ChangeNotifier`-Service zu Riverpod migrieren können

---

## 1. Was ist Riverpod?

Riverpod ist ein State-Management-Paket für Flutter, das vom selben Autor wie Provider entwickelt wurde. Es löst viele Probleme von Provider und bietet:

| Provider (alt) | Riverpod (neu) |
|----------------|----------------|
| Abhängig vom Widget-Tree | Unabhängig vom Widget-Tree |
| Fehler erst zur Laufzeit | Compile-time Sicherheit |
| Schwer zu testen | Einfach zu testen |
| `context` überall nötig | Kein `context` nötig |

### Warum Riverpod statt Provider?

1. **Keine `ProviderNotFoundException`** - Riverpod-Provider sind global definiert
2. **Bessere Testbarkeit** - Provider können einfach überschrieben werden
3. **Kein BuildContext nötig** - State kann überall gelesen werden
4. **Automatische Entsorgung** - Nicht mehr benötigte Provider werden automatisch disposed

---

## 2. Wie funktioniert Riverpod intern?

### Das Konzept: Provider als globale Container

Riverpod basiert auf einem einfachen Konzept:

```
┌─────────────────────────────────────────────────────────────┐
│                     ProviderScope                            │
│  ┌─────────────────────────────────────────────────────┐    │
│  │              Provider Container                      │    │
│  │                                                      │    │
│  │   counterProvider ──────► state: 5                   │    │
│  │   userProvider ─────────► state: User(...)           │    │
│  │   themeProvider ────────► state: ThemeMode.dark      │    │
│  │                                                      │    │
│  └─────────────────────────────────────────────────────┘    │
│                            │                                 │
│                            ▼                                 │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐      │
│  │   Widget A  │    │   Widget B  │    │   Widget C  │      │
│  │ ref.watch() │    │ ref.watch() │    │ ref.read()  │      │
│  └─────────────┘    └─────────────┘    └─────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

### Die drei Säulen von Riverpod

#### 1. Provider (Deklaration)

Ein Provider ist eine **Deklaration** von State. Er beschreibt:
- **Was** der State ist (Typ)
- **Wie** er initialisiert wird
- **Wann** er sich ändert

```dart
// Provider wird EINMAL global deklariert
final NotifierProvider counterProvider = NotifierProvider<CounterNotifier, int>(
  CounterNotifier.new,
);
```

> **Wichtig:** Der Provider selbst hält KEINEN State! Er ist nur eine "Adresse" im Container.

#### 2. ProviderScope (Container)

Der `ProviderScope` ist der **Container**, der den tatsächlichen State speichert:

```dart
ProviderScope(
  child: MyApp(),  // Alle Widgets darunter haben Zugriff
)
```

- Jeder `ProviderScope` hat seinen eigenen State-Container
- State wird **lazy** erstellt (erst beim ersten Zugriff)
- State kann **überschrieben** werden (für Tests!)

#### 3. Ref (Zugriff)

`ref` ist das **Tor zum State**. Es gibt zwei Arten:

| Ref-Typ | Wo verfügbar | Verwendung |
|---------|--------------|------------|
| `WidgetRef` | In `ConsumerWidget` | UI-Zugriff auf State |
| `Ref` | In anderen Providern | Provider-zu-Provider Abhängigkeiten |

### Der Lebenszyklus eines Providers

```
1. Provider wird deklariert (global)
        │
        ▼
2. Erster ref.watch() Aufruf
        │
        ▼
3. build() wird aufgerufen → State wird erstellt
        │
        ▼
4. Widgets lauschen auf Änderungen
        │
        ▼
5. state = newValue → Alle Listener werden benachrichtigt
        │
        ▼
6. Kein Widget lauscht mehr → dispose() wird aufgerufen
```

### Automatische Abhängigkeiten

Riverpod trackt automatisch, welche Provider voneinander abhängen:

```dart
// Provider 1: Zählt die Mahlzeiten
final mealCountProvider = StateProvider<int>((ref) => 0);

// Provider 2: Hängt von mealCountProvider ab
final mealStatusProvider = Provider<String>((ref) {
  // Riverpod weiß jetzt: mealStatusProvider hängt von mealCountProvider ab!
  final count = ref.watch(mealCountProvider);
  
  if (count == 0) return 'Keine Mahlzeiten heute';
  if (count < 3) return '$count Mahlzeiten - weiter so!';
  return '$count Mahlzeiten - gut gegessen!';
});
```

Wenn sich `mealCountProvider` ändert, wird `mealStatusProvider` automatisch neu berechnet!

---

## 3. Riverpod vs. BLoC: Kurzer Vergleich

### Architektur auf einen Blick

| | BLoC | Riverpod |
|--|------|----------|
| **Pattern** | Event → Bloc → State | Methodenaufruf → Notifier → State |
| **Boilerplate** | Hoch (Events, States, Bloc) | Niedrig (Notifier + Provider) |
| **Lernkurve** | Steiler | Flacher |
| **Event-Tracking** | Ja (explizite Events) | Nein (direkte Methoden) |

### Wann welches?

**BLoC wählen, wenn:**
- Du Event-Tracking brauchst
- Große Teams mit strikten Patterns
- Bereits BLoC-Erfahrung vorhanden

**Riverpod wählen, wenn:**
- Weniger Boilerplate gewünscht
- Viele abhängige States
- Einfacheres Testing wichtig ist

> **Fazit:** Für die meisten Flutter-Apps ist Riverpod die einfachere Wahl. BLoC lohnt sich bei komplexen Event-Flows.



---

## 4. Setup: Riverpod zum Projekt hinzufügen

### Schritt 1: Dependency hinzufügen

Füge `flutter_riverpod` zur `pubspec.yaml` hinzu:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.6.1  # Aktuelle Version prüfen!
```

Dann ausführen:

```bash
flutter pub get
```

### Schritt 2: App mit ProviderScope wrappen

In der `main.dart` muss die gesamte App mit einem `ProviderScope` umschlossen werden:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```

> **Wichtig:** Der `ProviderScope` muss das oberste Widget sein (noch vor `MaterialApp`).

---

## 5. Die wichtigsten Provider-Typen

Riverpod bietet verschiedene Provider für unterschiedliche Anwendungsfälle:

### StateProvider (für einfache Werte)

Perfekt für primitive Werte wie `int`, `String`, `bool`:

```dart
//Riverpod 2.0
final counterProvider = StateProvider<int>((ref) => 0);
```

### NotifierProvider (für komplexe Logik)

Wenn du Methoden und komplexere Logik brauchst:

```dart
// 1. Notifier-Klasse definieren
class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0;  // Initialer State

  void increment() {
    state++;  // Automatisches Rebuild!
  }
}

// 2. Provider erstellen
final counterNotifierProvider = NotifierProvider<CounterNotifier, int>(
  CounterNotifier.new,
);
```

### Übersicht der Provider-Typen

1. [Provider](https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/Provider-class.html)
2. [NotifierProvider](https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/NotifierProvider-class.html)
3. [FutureProvider](https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/FutureProvider-class.html)
4. [AsyncNotifierProvider](https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/AsyncNotifierProvider-class.html)
5. [StreamProvider](https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/StreamProvider-class.html)
6. [StreamNotifierProvider](https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/StreamNotifierProvider-class.html)

---

## 6. Praktisches Beispiel: CounterService migrieren

### Vorher: ChangeNotifier (Provider-Paket)

So sieht unser aktueller `CounterService` aus:

```dart
import 'package:flutter/foundation.dart';

class CounterService extends ChangeNotifier {
  CounterService();
  
  int _tappedCount = 0;

  int get tappedCount => _tappedCount;

  void incrementTappedCount() {
    _tappedCount++;
    notifyListeners();  // Manuelles Benachrichtigen!
  }
}
```

**Probleme mit diesem Ansatz:**
- Manuelles `notifyListeners()` vergessen = Bug
- Benötigt `context` zum Zugriff
- Muss im Widget-Tree registriert werden

---


### Die drei wichtigsten ref-Methoden

| Methode | Verwendung | Wann benutzen? |
|---------|------------|----------------|
| `ref.watch(provider)` | Liest State & rebuildet bei Änderungen | Im `build()`-Method |
| `ref.read(provider)` | Liest State einmalig (kein Rebuild) | In Callbacks/Events |
| `ref.read(provider.notifier)` | Zugriff auf Notifier-Methoden | Für Aktionen |

> **Goldene Regel:** 
> - `ref.watch` im `build()` 
> - `ref.read` in `onPressed`, `onTap`, etc.

---


## Nächste Lektion

In der nächsten Lektion lernen wir:
- `AsyncNotifier` für asynchrone Operationen
- `FutureProvider` für API-Calls
- Migration des `AddMealService` zu Riverpod

### Quellen & Weiterführende Links

- [Riverpod Dokumentation](https://riverpod.dev/) - Offizielle Docs
- [Flutter State Management Übersicht](https://docs.flutter.dev/data-and-backend/state-mgmt/options) - Flutter.dev
- [Riverpod GitHub](https://github.com/rrousselGit/riverpod) - Quellcode & Issues