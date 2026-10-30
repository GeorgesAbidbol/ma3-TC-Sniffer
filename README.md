# ma3-tc-sniffer

Plugin Lua grandMA3 : coupe (`Off`) tous les shows Timecode du pool sauf celui choisi, et peut lancer (`Go`) ce dernier. Pensé pour être déclenché depuis une macro.

## Installation

1. Copier `tc_sniffer.xml` et `tc_sniffer.lua` sur une clé USB dans
   `grandMA3_library/datapools/plugins/` (onPC : `.../MALightingTechnology/gma3_library/datapools/plugins/`).
2. Sur la console : **Menu > Plugins**, cliquer sur un emplacement vide, **Import**, choisir `TC Sniffer`.
3. Noter le numéro du plugin dans le pool (ex. 1).

## Utilisation dans une macro

| Ligne de macro | Effet |
|---|---|
| `Plugin "TC Sniffer" "3"` | garde le Timecode 3, coupe les autres |
| `Plugin "TC Sniffer" "MonShow"` | garde le Timecode nommé « MonShow » |
| `Plugin "TC Sniffer"` | garde le Timecode sélectionné, coupe les autres |

Le plus simple : une seule macro `Plugin "TC Sniffer"`. Sélectionne le Timecode voulu (clic dans le pool Timecode), puis lance la macro.

## Réglages

En haut de `tc_sniffer.lua` :
- `START_SELECTED` (true) : lance aussi le show gardé avec `Go Timecode`.
- `CONFIRM` (false) : demande une confirmation avant d'agir.

Écrit pour : grandMA3 v2.3.2.0.
