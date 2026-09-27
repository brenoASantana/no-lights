# 🏛️ Arquitetura do Projeto: No Lights

Este documento descreve a estrutura base e as decisões de engenharia adotadas no desenvolvimento do *No Lights*.

## 1. Padrão de Diretórios (Feature-Based)
O projeto adota uma arquitetura orientada a funcionalidades (Feature-Based). Arquivos intimamente relacionados (Cena e seu Script) residem no mesmo diretório para facilitar a deleção, refatoração e escalabilidade.

```text
/ (Raiz)
├── .gitignore
├── project.godot
├── README.md
├── docs/
│   └── ARCHITECTURE.md
│
├── data/                 # Banco de dados e textos
│   └── story.json        # Árvore narrativa do terminal
│
├── globals/              # O Olimpo (Singletons / Autoloads)
│   ├── system.gd         # Gerenciador de estado
│   ├── audio_global.gd   # Música e crossfade
│   ├── crt_filter.tscn   # Camada visual persistente
│   └── crt_filter.gdshader
│
└── scenes/               # Fases e Interfaces isoladas
	├── intro/            # Introdução e skip
	├── main_menu/        # Porta de entrada do jogo
	├── terminal/         # Fase 1: RPG de Texto (Interface Control)
	├── options/          # Configurações
	├── credits/          # Créditos
	└── dark_neighbourhood/ # Espaço reservado para a próxima fase

```

## 2. Padrões de Design e Singletons (Autoloads)

O jogo utiliza o padrão **Singleton** através dos Autoloads nativos da Godot para gerenciar lógicas globais em duas frentes distintas:

### Lógica Pura: `System.gd` (O Cérebro)

* **Função:** Script sem representação visual instanciado no topo da árvore de execução.
* **Responsabilidades:**
* Armazenar as variáveis globais (`player_name`, `health`, `sanity`).
* Despachar Sinais (Padrão *Observer*) para notificar as cenas ativas sobre dano ou perda de sanidade.
* Carregar e parsear o arquivo `story.json` na memória durante a inicialização (método `_ready()`).



### Renderização Global: `crt_filter.tscn` (A Lente)

* **Função:** Cena global instanciada no topo da árvore de execução.
* **Composição:** Nó raiz `CanvasLayer` (Layer: 100) contendo um `ColorRect` em Full Rect com material de Shader.
* **Regra Crítica:** O nó principal possui a propriedade de mouse `filter` setada como `Ignore` para atuar como um nó fantasma visual, permitindo que cliques atravessem o efeito nas interfaces de baixo.

## 3. Fluxo de Execução do Terminal (Interpretador de Comandos)

A fase inicial (`terminal.tscn`) implementa um interpretador básico inspirado em aventuras de texto (MUDs). A arquitetura separa a intenção da resolução:

1. **Captura:** O jogador digita no `LineEdit` e aciona `gui_input` com `ui_text_submit`.
2. **Sanitização:** O input é convertido para *lowercase* e sofre `strip_edges()`.
3. **Tokenização:** A função `_interpret_command` realiza o `split(" ")` para separar:
* `Índice [0]`: Verbo/Ação (Ex: *olhar*, *pegar*).
* `Índice [1..N]`: Objeto Alvo (Ex: *janela*).


4. **Despacho:** Um bloco `match` mapeia os verbos válidos e invoca `_process_action` ou `_process_interation`.
5. **Consulta de Dados:** O sistema busca no dicionário carregado no `System` os dados de `System.pages["comodos"][System.current_room]`.
6. **Renderização:** O texto resultante é adicionado via `append_text()` e animado frame-a-frame por um `Tween` instanciado localmente, alterando a propriedade `visible_characters`.
