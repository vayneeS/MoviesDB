# Convention de commits — Conventional Commits

Ce projet suit le standard **[Conventional Commits 1.0.0](https://www.conventionalcommits.org/fr/)**.

---

## Format

```
<type>(<scope>): <description>

[corps optionnel]

[footer optionnel]
```

- **type** : obligatoire — catégorie de la modification
- **scope** : optionnel — composant concerné entre parenthèses
- **description** : obligatoire — résumé en minuscules, sans point final, max 72 caractères
- **corps** : optionnel — contexte supplémentaire (séparé par une ligne vide)
- **footer** : optionnel — références à des issues (`Closes #12`, `Fixes #8`)

---

## Types autorisés

| Type | Usage |
|---|---|
| `feat` | Nouvelle fonctionnalité visible par l'utilisateur |
| `fix` | Correction d'un bug |
| `docs` | Modification de la documentation uniquement |
| `style` | Formatage, espaces, virgules — sans changement logique |
| `refactor` | Restructuration du code sans ajout de fonctionnalité ni correction de bug |
| `perf` | Amélioration des performances |
| `test` | Ajout ou correction de tests |
| `chore` | Maintenance : dépendances, configuration, scripts |
| `data` | Modification des données, pipelines, fichiers CSV/SQL |
| `ci` | Configuration des workflows CI/CD |
| `revert` | Annulation d'un commit précédent |

---

## Scopes suggérés

| Scope | Composant |
|---|---|
| `streamlit` | Application Streamlit (`Streamlit-App/`) |
| `neo4j` | Connecteur ou requêtes Neo4j |
| `graph` | Construction ou analyse du graphe |
| `pipeline` | Scripts d'import/export de données |
| `mysql` | Scripts SQL MySQL |
| `docker` | Configuration Docker |
| `notebook` | Jupyter Notebooks |
| `deps` | Dépendances (`requirements.txt`) |
| `readme` | Fichier README |

---

## Exemples

```
feat(streamlit): ajouter le compte à rebours Avengers: Doomsday

fix(neo4j): corriger le timeout de connexion bolt

docs(readme): ajouter la description des jalons du projet

refactor(graph): extraire l'analyse BC dans graph_analyzer.py

perf(streamlit): ajouter st.cache_data sur les appels Neo4j

chore(deps): mettre à jour cdlib vers 0.4.0

data(pipeline): ajouter le chargement des films Marvel dans AuraDB

feat(graph)!: changer le format de retour de build_pyvis_graph

BREAKING CHANGE: build_pyvis_graph retourne maintenant une chaîne HTML
directement au lieu d'un dictionnaire.
```

---

## Commits avec breaking change

Ajouter un `!` après le type/scope et un footer `BREAKING CHANGE:` :

```
feat(graph)!: modifier l'API de build_pyvis_graph

BREAKING CHANGE: le paramètre `debug` est supprimé, le comportement
est maintenant toujours équivalent à debug=False.
```

---

## Référencer des issues

```
fix(streamlit): corriger l'affichage du countdown sur Safari

Closes #14
```

---

## Règles à respecter

- Toujours en **minuscules**
- Pas de point `.` en fin de description
- Description en **français**
- Un commit = une modification logique (ne pas mélanger fix et feat)
- Eviter les commits vagues : ~~`fix stuff`~~, ~~`wip`~~, ~~`update`~~
