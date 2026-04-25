# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

LinkUp — Flutter mobile app for a Mozambique freelancer/company marketplace. Currently a UI-only prototype: no backend, no networking, no persistence. All data is hardcoded in `lib/data.dart`. Targets iOS and Android.

Stack: Flutter 3.38+ / Dart 3.10+, Material 3, `google_fonts` (Plus Jakarta Sans + JetBrains Mono + Fraunces). No state management library — plain `StatefulWidget` + `setState`.

UI copy is Portuguese (PT). Currency is MZN, names are Mozambican (Maputo, Beira, Nampula, Matola, M-Pesa, NUIT). Keep this when adding screens or sample data.

## Commands

```bash
flutter pub get              # install deps after pubspec changes
flutter run                  # run on selected device (use `-d <id>` to pick)
flutter analyze              # lint — should be 0 errors
flutter test                 # run widget tests
flutter test test/widget_test.dart --plain-name 'LinkUp app boots'   # single test
flutter build ios --no-codesign --simulator   # iOS simulator build
flutter build apk --debug    # Android debug build
```

## Architecture

### Entry & navigation

`lib/main.dart` → `LinkUpApp` (MaterialApp with `buildLinkUpTheme()`) → `RoleSelector` (`lib/shell.dart`).

`RoleSelector` is the top-level shell. It owns two pieces of state: the active `LinkUpRole` (freelancer/company) and a `_showOnboarding` flag. It renders a header with the LinkUp wordmark and a Freelancer/Empresa toggle, then swaps the body between `OnboardingScreen` / `CompanyOnboardingScreen` and the role's shell. The role toggle dismisses onboarding so switching roles after first launch goes straight to the app.

Each role has its own shell:
- `screens/freelancer/freelancer_shell.dart` — 5 tabs (Início, Procurar, Candidatu., Mensagens, Perfil), green accent.
- `screens/company/company_shell.dart` — 5 tabs (Painel, Talento, Vagas, Mensagens, Empresa), navy accent.

Both shells use `IndexedStack` (so tab state is preserved when switching) plus a custom translucent bottom bar painted on top via `Stack`. **Do not** wrap shell pages in `Scaffold` — they render inside the role-shell's stack and would double up app-bar/safe-area chrome. Detail screens pushed via `Navigator.push` (e.g. `JobDetailScreen`, `WalletScreen`) **do** use their own `Scaffold` with `SafeArea`.

Tabs that need cross-tab navigation (e.g. Home → Search) call back to the shell via callbacks rather than pushing routes; the shell flips `_tab`. Detail navigation uses `Navigator.push(MaterialPageRoute(...))` directly from the screen.

### Layers

- `lib/theme.dart` — `LinkUpColors` (palette: green `#0F4F47`, navy `#142F4C`, gold `#C9A24F`, off-white `#F5F2EC`, plus pill/text/status variants), `buildLinkUpTheme()`, font helpers `linkupMono()` / `linkupSerif()`. Always reference colors via `LinkUpColors.*`, never hex literals — the design system is the source of truth.
- `lib/data.dart` — every model class (`FreelancerCardData`, `JobData`, `ChatData`, `CandidateData`, etc.) and every `const` mock list (`freelancers`, `jobs`, `chats`, `candidatesPipeline`, `companyJobs`, `payments`, `notifications`, `reviews`, `portfolio`, `statusLabels`). When adding a feature, add the data here first; screens import directly from `data.dart`.
- `lib/widgets.dart` — design-system primitives: `LuAvatar`, `LuPill` (with `PillColor`/`PillSize` enums), `LuBtn` (`BtnVariant`/`BtnSize`), `LuCard`, `LuStars`, `LuTopBar`, `LuIconBtn`, `LuProgressBar`, `LuDivider`, `LuInputField`, `LuToggleRow`, `LuSectionTitle`, `LuStat`, `LuPlaceholder`, `LuLogoMark`, `LuWordmark`, and `LuReputationRadar` (custom-painted). **Build screens out of these primitives** — don't reach for raw `Container`+`BoxDecoration` when a Lu* widget already encodes the styling.
- `lib/screens/freelancer/` and `lib/screens/company/` — screens. Freelancer chat (`chat_list_screen.dart`, `chat_screen.dart`) and `settings_screen.dart` are reused by the company shell.

### Conventions

- **Two role-coded accent colors** thread through everything. Freelancer = `LinkUpColors.green`. Company = `LinkUpColors.navy`. Use the right one for tab bars, primary CTAs, dashboards, and selected-state highlights for the role you're in. Gold (`LinkUpColors.gold`) is the Ubuntu accent — use sparingly for verification, "Top Rated" pills, match scores.
- **Bottom-action layout pattern** (job detail, apply, freelancer detail, post job, rate freelancer): wrap the screen body in a `Stack`, put the scrollable content behind a fixed-bottom `Container` with a top-to-white `LinearGradient`. Use `padding: EdgeInsets.only(bottom: 110-130)` on the scroll view so the last item isn't hidden.
- **Hero gradient cards** (Home recommended job, Profile header, Wallet, Dashboard KPI): `BorderRadius.circular(22)`, `LinearGradient` from the role's primary to its dark variant, plus a translucent gold radial overlay. See `home_screen.dart` for the canonical pattern.
- **Match scores** are rendered as `LuPill('${n}% match', color: PillColor.green, icon: Icons.auto_awesome)`.
- **Verified marker** is always `Icon(Icons.verified, size: 12-16, color: LinkUpColors.gold)`.
- **Status pills** for applications come from `statusLabels` in `data.dart` (don't hardcode the label/color in screens).
- **Numeric formatting**: MZN amounts are dot-separated (`320.000 MZN`). The screens that format integers (wallet, search, freelancer detail, post job review) each have a private `_format(int)` helper — copy that pattern rather than inventing another.
- **No emoji in code** unless it's intentional UI content (notification icons in `data.dart` use them).
