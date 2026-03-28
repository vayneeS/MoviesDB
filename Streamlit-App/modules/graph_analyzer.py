"""Analyse topologique du graphe : Betweenness Centrality + communautés."""
import networkx as nx


# Palette de couleurs distinctes pour les communautés
_COMMUNITY_COLORS = [
    "#e74c3c",  # rouge
    "#3498db",  # bleu
    "#2ecc71",  # vert
    "#f39c12",  # orange
    "#9b59b6",  # violet
    "#1abc9c",  # turquoise
    "#e67e22",  # orange foncé
    "#e91e63",  # rose
    "#00bcd4",  # cyan
    "#8bc34a",  # vert clair
]

COMMUNITY_METHODS = {
    "Composantes connexes": "components",
    "Louvain": "louvain",
    "Leiden": "leiden",
}


def build_nx_graph(nodes, relationships):
    """Construit un graphe NetworkX à partir des nœuds et relations.

    Args:
        nodes: Liste de dicts nœuds (clé 'id' obligatoire)
        relationships: Liste de dicts relations (clés 'source', 'target')

    Returns:
        networkx.DiGraph
    """
    G = nx.DiGraph()
    for node in nodes:
        G.add_node(node["id"])
    known = {n["id"] for n in nodes}
    for rel in relationships:
        src = rel.get("source")
        tgt = rel.get("target")
        if src in known and tgt in known:
            G.add_edge(src, tgt)
    return G


def compute_betweenness(G, normalized=True):
    """Calcule la Betweenness Centrality pour chaque nœud.

    Le graphe est converti en non-orienté pour le calcul afin
    d'obtenir des scores cohérents sur un graphe de films/acteurs.

    Args:
        G: networkx.DiGraph
        normalized: Normaliser les scores entre 0 et 1 (défaut: True)

    Returns:
        dict {node_id: float}
    """
    G_undirected = G.to_undirected()
    bc = nx.betweenness_centrality(G_undirected, normalized=normalized)
    return bc


def _communities_from_node_clustering(result):
    """Convertit un NodeClustering cdlib en dict {node_id: community_idx}.

    Args:
        result: cdlib NodeClustering object

    Returns:
        dict {node_id: int}
    """
    communities = {}
    for idx, community in enumerate(result.communities):
        for node_id in community:
            communities[node_id] = idx
    return communities


def detect_communities(G, method="components"):
    """Détecte les communautés selon la méthode choisie.

    Args:
        G: networkx.DiGraph
        method: 'components' | 'louvain' | 'leiden'

    Returns:
        dict {node_id: community_index (int)}
    """
    G_undirected = G.to_undirected()

    if method == "louvain":
        from cdlib import algorithms as cdlib_alg
        result = cdlib_alg.louvain(G_undirected)
        return _communities_from_node_clustering(result)

    if method == "leiden":
        from cdlib import algorithms as cdlib_alg
        result = cdlib_alg.leiden(G_undirected)
        return _communities_from_node_clustering(result)

    # Fallback : composantes connexes
    communities = {}
    for idx, component in enumerate(
        nx.connected_components(G_undirected)
    ):
        for node_id in component:
            communities[node_id] = idx
    return communities


def get_community_color(community_idx):
    """Retourne une couleur hex pour un index de communauté donné.

    Args:
        community_idx: Index de la communauté (int)

    Returns:
        str couleur hex
    """
    return _COMMUNITY_COLORS[community_idx % len(_COMMUNITY_COLORS)]


def analyze_graph(nodes, relationships, normalized=True,
                  community_method="components"):
    """Point d'entrée principal : calcule BC et communautés.

    Args:
        nodes: Liste de dicts nœuds
        relationships: Liste de dicts relations
        normalized: Normaliser les scores BC (défaut: True)
        community_method: 'components' | 'louvain' | 'leiden'

    Returns:
        dict avec :
            - 'bc'          : {node_id: float} scores BC
            - 'communities' : {node_id: int} index de communauté
            - 'top_bridges' : liste de (node_id, score) triée desc
    """
    G = build_nx_graph(nodes, relationships)
    bc = compute_betweenness(G, normalized=normalized)
    communities = detect_communities(G, method=community_method)
    top_bridges = sorted(bc.items(), key=lambda x: x[1], reverse=True)
    return {
        "bc": bc,
        "communities": communities,
        "top_bridges": top_bridges,
    }
