# 🔦 No Lights

Um jogo de terror psicológico desenvolvido em Godot 4 que transita entre a nostalgia dos RPGs de texto em terminais dos anos 90, a exploração 2D e o desespero procedural em 3D.

O foco central da narrativa gira em torno de traumas emocionais, isolamento e a mecânica de "Sanidade", onde o próprio ambiente escuro e a leitura de textos reagem ao estado mental do jogador.

## ⚙️ Funcionalidades Principais
* **Sistema Híbrido de Fases:** Transição contínua entre interfaces de terminal de texto puro, exploração em top-down 2D e cenários 3D.
* **Parser de Comandos Retro:** Motor de aventura em texto customizado, interpretando intenções (verbos e objetos) digitados pelo jogador.
* **Estética CRT Dinâmica:** Shader global simulando distorção, scanlines e aberração cromática de monitores de tubo de forma sobreposta a todas as cenas.
* **Arquitetura Orientada a Dados:** Toda a árvore narrativa e descrições do jogo são consumidas via JSON, separando totalmente a história da lógica de programação.
* **Gerenciamento Global de Estado:** Sistema de Sanidade e Vida que persiste de forma invisível entre as trocas de cena.

## 🛠️ Tecnologias Utilizadas
* **Engine:** Godot Engine 4.x
* **Linguagem:** GDScript
* **Assets Visuais:** Pixel art 8-bit, Shaders GLSL customizados para Godot.

## 🚀 Como Executar o Projeto

1. Clone o repositório:
   ```bash
   git clone [https://github.com/seu-usuario/no-lights.git](https://github.com/seu-usuario/no-lights.git)

2. Abra a Godot Engine 4.
3. Clique em **Importar** e selecione o arquivo `project.godot` na raiz do diretório clonado.
4. Pressione `F5` ou clique no botão de "Play" no editor para iniciar a partir do Menu Principal.

## 👤 Autor

**Breno Santana** - Desenvolvimento, Arquitetura e Game Design.