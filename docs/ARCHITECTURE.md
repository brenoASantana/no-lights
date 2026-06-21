# 🏛️ Arquitetura do Projeto: No Lights

Este documento descreve a estrutura base e as decisões de engenharia adotadas no desenvolvimento do *No Lights*.

## 1. Padrão de Diretórios (Feature-Based)
O projeto adota uma arquitetura orientada a funcionalidades (Feature-Based). Arquivos intimamente relacionados (Cena e seu Script) residem no mesmo diretório para facilitar a deleção, refatoração e escalabilidade.

```text
/ (Raiz)
├── .gitignore
├── project.godot
├── README.md
├── architecture.md
│
├── data/                 # Banco de Dados e Textos
│   └── historia.json     # Árvore narrativa do terminal
│
├── globals/              # O Olimpo (Singletons / Autoloads)
│   ├── system.gd         # Gerenciador de Estado (Memória)
│   └── filtro_crt.tscn   # Camada visual persistente
│
├── entities/             # Atores que trafegam entre as fases
│   └── player/           # Lógica física do jogador (2D/3D)
│
└── scenes/               # Fases e Interfaces isoladas
    ├── main_menu/        # Porta de entrada do jogo
    ├── terminal/         # Fase 1: RPG de Texto (Interface Control)
    ├── level_02_street/  # Fase 2: Exploração 2D
    └── level_03_maze/    # Fase 3: Labirinto Procedural 3D

```

## 2. Padrões de Design e Singletons (Autoloads)

O jogo utiliza o padrão **Singleton** através dos Autoloads nativos da Godot para gerenciar lógicas globais em duas frentes distintas:

### Lógica Pura: `System.gd` (O Cérebro)

* **Função:** Script sem representação visual instanciado no topo da árvore de execução.
* **Responsabilidades:**
* Armazenar as variáveis globais (`player_name`, `health`, `sanity`).
* Despachar Sinais (Padrão *Observer*) para notificar as cenas ativas sobre dano ou perda de sanidade.
* Carregar e parsear o arquivo `historia.json` na memória durante a inicialização (método `_ready()`).



### Renderização Global: `FiltroCRT.tscn` (A Lente)

* **Função:** Cena global instanciada no topo da árvore de execução.
* **Composição:** Nó raiz `CanvasLayer` (Layer: 100) contendo um `ColorRect` em Full Rect com material de Shader.
* **Regra Crítica:** O nó principal possui a propriedade de mouse `filter` setada como `Ignore` para atuar como um nó fantasma visual, permitindo que cliques atravessem o efeito nas interfaces de baixo.

## 3. Fluxo de Execução do Terminal (Interpretador de Comandos)

A fase inicial (`terminal.tscn`) implementa um interpretador básico inspirado em aventuras de texto (MUDs). A arquitetura separa a intenção da resolução:

1. **Captura:** O jogador digita no `LineEdit` e aciona `text_submitted`.
2. **Sanitização:** O input é convertido para *lowercase* e sofre *strip_edges()*.
3. **Tokenização:** A função `_interpretar_comando` realiza o `split(" ")` para separar:
* `Índice [0]`: Verbo/Ação (Ex: *olhar*, *pegar*).
* `Índice [1..N]`: Objeto Alvo (Ex: *janela*).


4. **Despacho Dinâmico:** Um bloco `match` mapeia os verbos válidos e invoca `_processar_acao`.
5. **Consulta de Dados:** O sistema busca no dicionário carregado no `System` a validação das chaves `System.paginas[verbo][objeto]`.
6. **Renderização:** O texto resultante é adicionado via `append_text()` e animado frame-a-frame por um `Tween` instanciado localmente, alterando a propriedade `visible_characters`.
