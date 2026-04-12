---
title: Schéma de la base IMDb
layout: default
nav_order: 4
---

# Schéma relationnel de la base IMDb

La base de données IMDb utilisée dans ce projet est une adaptation du schéma officiel IMDb, stockée dans MySQL via Docker.

## Diagramme

![Schéma relationnel IMDb](assets/imdb-schema.svg)

> Le diagramme est exporté depuis Drawdb.app. Pour le consulter en pleine résolution, ouvrez-le dans un nouvel onglet.

## Tables

### `titles`

Table principale des œuvres (films, séries, épisodes...).

| Colonne | Type | Description |
|---------|------|-------------|
| `title_id` | VARCHAR(255) | Identifiant unique IMDb (ex: `tt0068646`) |
| `title_type` | VARCHAR(50) | Type : `movie`, `tvSeries`, `short`, etc. |
| `primary_title` | TEXT | Titre principal |
| `original_title` | TEXT | Titre original |
| `is_adult` | BOOLEAN | Contenu adulte |
| `start_year` | INTEGER | Année de sortie |
| `end_year` | INTEGER | Année de fin (séries uniquement) |
| `runtime_minutes` | INTEGER | Durée en minutes |
| `genres` | VARCHAR(255) | Genres séparés par des virgules |

### `ratings`

Notes et votes IMDb par titre.

| Colonne | Type | Description |
|---------|------|-------------|
| `title_id` | VARCHAR(255) | Référence vers `titles.title_id` |
| `rating` | FLOAT | Note moyenne (0.0 → 10.0) |
| `votes` | INTEGER | Nombre de votes |

### `people`

Personnes référencées dans IMDb (acteurs, réalisateurs, producteurs...).

| Colonne | Type | Description |
|---------|------|-------------|
| `person_id` | VARCHAR(255) | Identifiant unique IMDb (ex: `nm0000093`) |
| `person_name` | VARCHAR(255) | Nom complet |
| `born` | SMALLINT | Année de naissance |
| `died` | SMALLINT | Année de décès (NULL si vivant) |

### `crew`

Relation entre une personne et un titre (casting + équipe technique).

| Colonne | Type | Description |
|---------|------|-------------|
| `title_id` | VARCHAR(255) | Référence vers `titles.title_id` |
| `person_id` | VARCHAR(255) | Référence vers `people.person_id` |
| `category` | VARCHAR(255) | Rôle : `actor`, `director`, `producer`, etc. |
| `job` | TEXT | Détail du poste (NULL pour les acteurs) |
| `show_characters` | VARCHAR(255) | Personnage(s) joué(s) |

### `episodes`

Épisodes de séries TV, rattachés à la série parente.

| Colonne | Type | Description |
|---------|------|-------------|
| `episode_title_id` | VARCHAR(255) | Identifiant de l'épisode |
| `show_title_id` | VARCHAR(255) | Référence vers `titles.title_id` (série parente) |
| `season_number` | INTEGER | Numéro de saison |
| `episode_number` | INTEGER | Numéro d'épisode |

### `marvel_films`

Table auxiliaire listant les films Marvel utilisés pour filtrer les données IMDb.

| Colonne | Type | Description |
|---------|------|-------------|
| `film` | VARCHAR(255) | Titre du film |
| `release_year` | INTEGER | Année de sortie |

## Relations

```
titles  ←──────────  ratings         (1 titre → 1 note)
titles  ←──────────  episodes        (1 série → N épisodes)
titles  ←──────────  crew            (1 titre → N membres d'équipe)
people  ←──────────  crew            (1 personne → N contributions)
```

> **Note :** Les contraintes de clés étrangères ne sont pas définies explicitement dans le DDL afin de permettre le chargement massif des fichiers TSV IMDb sans erreur d'intégrité référentielle. Les index sont ajoutés séparément via `imdb-add-index.sql`.
