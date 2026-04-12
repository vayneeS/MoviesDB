# Guide de contribution — MoviesDB

Merci de contribuer à ce projet ! Ce document décrit les règles à suivre pour
maintenir une collaboration claire et cohérente.

---

## Table des matières

1. [Prérequis](#prérequis)
2. [Workflow Git](#workflow-git)
3. [Convention de commits](#convention-de-commits)
4. [Ouvrir une issue](#ouvrir-une-issue)
5. [Soumettre une Pull Request](#soumettre-une-pull-request)
6. [Style de code](#style-de-code)

---

## Prérequis

- Python 3.13+
- Docker (pour les conteneurs MySQL/Neo4j)
- Un fichier `.env` à la racine de `Streamlit-App/` avec les variables Neo4j

Installer les dépendances :

```bash
pip install -r requirements.txt
pip install -r requirements-lint.txt
```

---

## Workflow Git

Ce projet suit le modèle **GitHub Flow** :

```
main  ←  feature/ma-fonctionnalite
      ←  fix/correction-bug
      ←  docs/mise-a-jour-readme
```

1. Créer une branche depuis `main` avec un nom explicite (voir ci-dessous)
2. Effectuer les modifications en respectant la convention de commits
3. Ouvrir une Pull Request vers `main`
4. Attendre la revue avant de merger

### Nommage des branches

| Type | Exemple |
|---|---|
| Nouvelle fonctionnalité | `feature/ajout-filtre-genre` |
| Correction de bug | `fix/countdown-affichage` |
| Documentation | `docs/mise-a-jour-readme` |
| Refactoring | `refactor/graph-builder` |
| Données / pipeline | `data/import-neo4j` |

---

## Convention de commits

Voir [COMMIT_CONVENTION.md](COMMIT_CONVENTION.md) pour le détail complet.

En résumé : format **Conventional Commits** :

```
<type>(<scope>): <description courte>
```

Exemples :

```
feat(streamlit): ajouter le filtre par film
fix(neo4j): corriger la connexion bolt après timeout
docs(readme): mettre à jour les jalons du projet
```

---

## Ouvrir une issue

Avant d'ouvrir une issue :

- Vérifier qu'elle n'existe pas déjà
- Utiliser le bon template (Bug ou Feature Request)
- Fournir un titre clair et une description détaillée

---

## Soumettre une Pull Request

- Une PR = un objectif précis
- Le titre doit suivre la convention de commits
- Remplir entièrement le template de PR
- Les tests PEP8 doivent passer (`pycodestyle`)

```bash
python -m pycodestyle Streamlit-App/
```

---

## Style de code

- **PEP8** strict, longueur de ligne max **79 caractères**
- Nommage en `snake_case` pour les variables et fonctions
- Commentaires en **français**
- Pas de secrets ou credentials dans le code (utiliser `.env`)
