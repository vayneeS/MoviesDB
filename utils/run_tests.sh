#!/usr/bin/env bash

set -e  # stoppe le script au premier échec

# Aller à la racine du projet (dossier parent de utils/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

echo "🧪 Lancement des tests avec couverture de code..."

pytest tests/ \
    --verbose \
    --tb=short \
    --cov=Streamlit-App/modules \
    --cov=pipeline \
    --cov-report=term-missing \
    --cov-report=xml:coverage.xml

echo "✅ Tests terminés. Rapport de couverture : coverage.xml"
