# No Lights

## 1. Visão geral

**No Lights** é um jogo de terror psicológico para um jogador, desenvolvido em Godot 4. A experiência começa como uma aventura de texto inspirada nos terminais e RPGs de computador dos anos 90 e se expande para exploração 2D e cenários 3D.

O jogador acorda em uma casa mergulhada em uma escuridão anormal. Sem poder contar com a luz do dia ou com interfaces gráficas convencionais, precisa interpretar textos, investigar o ambiente e descobrir como sair. Enquanto isso, o jogo reage ao estado mental do personagem: a escuridão, os sons e a própria leitura dos acontecimentos tornam-se cada vez menos confiáveis.

### Frase de venda

> Quando não há luz para revelar a verdade, cada palavra pode ser uma ameaça.

## 2. Pilares da experiência

### Terror psicológico e isolamento

O medo nasce da ausência de informação, do silêncio e da dúvida sobre o que está acontecendo. O jogador deve se sentir preso em um espaço familiar que gradualmente se torna hostil.

### Leitura como exploração

Investigar é a principal forma de avançar. Descrições de ambientes, objetos e documentos substituem marcadores visuais tradicionais e recompensam atenção e interpretação.

### Interface diegética

O terminal não é apenas um menu: é o ponto de contato do personagem com o mundo. O teclado, o monitor CRT e os textos são elementos narrativos e devem transmitir a sensação de uma tecnologia antiga, frágil e limitada.

### Consequências do estado mental

A sanidade funciona como uma camada de tensão persistente. Ações aparentemente simples podem alterar o estado do personagem e influenciar a percepção do ambiente, da narrativa e dos eventos futuros.

### Mistério antes da explicação

O jogo deve apresentar pistas suficientes para despertar hipóteses, mas evitar explicar cedo demais a origem da escuridão, da sombra e dos relatos sobre o “Terror do Norte”.

## 3. Público e plataforma

- **Público:** pessoas interessadas em terror psicológico, aventuras de texto, exploração narrativa e estética retro.
- **Plataforma inicial:** computador.
- **Controles principais:** teclado para digitação e comandos; mouse para interações de interface quando necessário.
- **Modo de jogo:** single-player, offline, com foco em uma campanha narrativa curta e atmosférica.

## 4. Loop principal

1. Ler a descrição do local e observar os detalhes disponíveis.
2. Formular uma hipótese sobre o que pode ser examinado ou utilizado.
3. Digitar um comando e receber uma resposta textual, sonora ou mecânica.
4. Coletar itens e interpretar documentos para descobrir novas possibilidades.
5. Administrar os riscos para a saúde e a sanidade do personagem.
6. Desbloquear o próximo espaço ou evento e continuar investigando.

O loop deve alternar curiosidade e insegurança: o jogador precisa querer descobrir mais, mas nunca deve ter certeza de que investigar é totalmente seguro.

## 5. Estrutura da campanha

O jogo é dividido em fases com linguagens visuais e interativas diferentes:

### Fase 0: Introdução

Apresenta o contexto da escuridão, estabelece o tom e conduz o jogador ao menu principal ou à primeira experiência narrativa. A introdução pode ser ignorada quando já tiver sido assistida.

### Fase 1: Terminal

É a abertura jogável e o núcleo atualmente implementado. O personagem está no escritório e usa comandos de texto para examinar a casa, encontrar itens e compreender a situação.

### Fase 2: Vizinhança escura

Área reservada para a expansão da campanha. Deve levar a investigação para fora da casa e introduzir exploração 2D em visão superior, mantendo a sensação de isolamento e ameaça invisível.

### Fases posteriores: exploração 3D

Espaços 3D devem representar a escalada do terror e a perda de estabilidade da percepção. A mudança de perspectiva precisa ter função narrativa, e não apenas visual.

## 6. Narrativa

### Premissa

O noticiário prometeu que a escuridão causada por um eclipse duraria apenas algumas horas. A promessa era falsa. Às 08:42 da manhã, o céu permanece completamente negro e o protagonista está isolado em casa, diante de um monitor CRT verde.

O silêncio é interrompido pelo zumbido elétrico e por sinais de que há algo além do cômodo: uma sombra se move na parede, embora o personagem permaneça imóvel. A partir desse momento, sair da casa deixa de ser apenas uma tarefa física e passa a ser uma disputa contra o medo e contra a própria interpretação da realidade.

### Temas

- Trauma emocional e seus efeitos sobre a percepção.
- Isolamento e incapacidade de pedir ajuda.
- A busca por controle em uma situação incompreensível.
- A fronteira entre memória, pressentimento e ameaça real.

### Mistérios centrais

- Por que o sol não nasceu?
- O que existe na escuridão além da casa?
- O que é o “Terror do Norte” mencionado no jornal?
- A sombra é uma presença externa, uma manifestação da sanidade ou as duas coisas?

## 7. Mecânicas

### Parser de comandos

O jogador digita comandos em linguagem simples. O sistema normaliza o texto para letras minúsculas, remove espaços nas extremidades e separa verbo, objeto e alvo.

Comandos previstos na primeira fase:

| Comando                | Função                           | Exemplo            |
| ---------------------- | -------------------------------- | ------------------ |
| `olhar` / `investigar` | Examinar o ambiente ou um objeto | `olhar janela`     |
| `pegar` / `coletar`    | Adicionar um item ao inventário  | `pegar chave`      |
| `ler`                  | Ler um documento ou registro     | `ler jornal`       |
| `usar` / `utilizar`    | Usar um item em um alvo          | `usar chave porta` |
| `ajuda` / `help`       | Exibir os comandos disponíveis   | `ajuda`            |

Comandos inválidos devem receber uma resposta clara e diegética, incentivando o jogador a tentar novamente sem quebrar a atmosfera.

### Exploração e resolução de problemas

Cada cômodo oferece uma descrição geral, objetos observáveis, itens, documentos e interações. O jogador precisa relacionar o inventário às interações disponíveis. Na abertura, a chave encontrada na gaveta permite destrancar a porta do escritório.

### Inventário

O inventário é global e persistente entre as cenas. Ele deve conter apenas itens relevantes para a resolução de problemas, evitando transformar a investigação em coleta excessiva.

### Sanidade

A sanidade é um valor global que começa em 100 e pode ser alterado por eventos narrativos. No protótipo atual, observar a janela reduz a sanidade em 10 pontos.

Estados futuros da sanidade podem afetar:

- Descrições exibidas pelo terminal.
- Frequência e intensidade de sons.
- Aparência do filtro CRT.
- Disponibilidade ou confiabilidade de certas informações.
- Eventos e desfechos da campanha.

As alterações devem ser comunicadas principalmente por meio da experiência, e não por mensagens numéricas constantes.

### Vida

A vida é um valor global que começa em 100 e pode ser reduzido por danos. O sistema emite sinais para que as cenas ativas atualizem suas interfaces ou reajam ao dano. A forma final de dano, recuperação e derrota ainda precisa ser definida junto com os encontros da campanha.

### Transição entre espaços

Interações bem-sucedidas devem conduzir o jogador ao próximo estado narrativo ou cômodo. A primeira transição planejada é sair do escritório depois de usar a chave na porta. A implementação atual registra o sucesso textual, mas ainda não realiza a troca de cena.

## 8. Conteúdo inicial

### Escritório

O ponto de partida. É o santuário e a prisão do personagem, iluminado apenas pelo monitor.

- **Janela:** revela o breu exterior, terra úmida e mato amassado; investigar reduz a sanidade.
- **Porta:** está trancada por dentro e exige a chave do escritório.
- **Mesa:** contém café frio, teclado e uma gaveta entreaberta.
- **Chão:** possui papéis e um jornal desconhecido.
- **Chave:** encontrada na gaveta e usada na porta.
- **Lanterna:** encontrada atrás do monitor, mas sem pilhas.
- **Jornal:** apresenta o alerta sobre o “Terror do Norte” e os assobios da madrugada.

### Corredor

Um corredor longo e estreito, com papel de parede descascado. Distribui o jogador entre quarto, banheiro e sala.

### Quarto

Um ambiente gelado, com a cama desarrumada como se algo grande tivesse acabado de se levantar.

### Banheiro

Um espaço tomado por mofo, gotejamento e um espelho estilhaçado.

### Sala

A porta da rua está próxima, mas a mobília foi arrastada para bloqueá-la.

## 9. Direção de arte e áudio

### Visual

- Pixel art com referências de 8-bit.
- Paleta marcada pelo verde do monitor, preto profundo e sinais de cor associados a alertas e deterioração.
- Interface com tipografia monoespaçada e aparência de terminal antigo.
- Filtro CRT global com distorção, scanlines e aberração cromática.
- Mudanças visuais sutis conforme a sanidade diminui.

O filtro CRT deve permanecer sobre todas as cenas sem bloquear cliques ou entradas do jogador.

### Áudio

O áudio deve privilegiar silêncio, ruído elétrico, ecos domésticos e sons pontuais que façam o jogador questionar a origem do que ouviu. Eventos de interação podem trocar ou sobrepor a música ambiente, como ao encontrar a chave, ler o jornal ou destrancar a porta.

O áudio global deve persistir entre cenas e permitir transições suaves entre faixas.

## 10. Interface e experiência do jogador

- O terminal recebe foco automaticamente ao entrar na fase.
- O texto aparece gradualmente, letra a letra, reforçando o ritmo de leitura.
- O histórico de mensagens permanece visível para consulta.
- O jogador pode solicitar ajuda a qualquer momento.
- O menu principal oferece acesso ao início do jogo, opções e créditos.
- As opções devem concentrar configurações audiovisuais e de acessibilidade que forem necessárias.
- A tecla `Esc` libera o mouse quando a interface estiver capturando o cursor.

## 11. Arquitetura de conteúdo

A narrativa e as descrições de objetos ficam separadas da lógica em `data/story.json`. Cada cômodo pode declarar sua descrição, objetos observáveis, itens, documentos e interações. Isso permite expandir a história sem duplicar o código do interpretador.

O estado compartilhado fica no autoload `System`, incluindo nome do jogador, vida, sanidade, inventário e cômodo atual. `AudioGlobal` controla música e crossfade; `CrtFilter` fornece a camada visual persistente.

## 12. Escopo e estado atual

### Implementado

- Projeto configurado em Godot 4.
- Menu principal, introdução, opções e créditos estruturados como cenas independentes.
- Autoloads para estado, áudio e filtro CRT.
- Carregamento de `story.json` durante a inicialização.
- Prólogo textual do terminal.
- Parser para olhar, pegar, ler, usar e ajuda.
- Inventário persistente em memória.
- Sistema inicial de vida e sanidade com sinais globais.
- Conteúdo textual do escritório e dos cômodos seguintes.
- Animação de texto e eventos sonoros associados a interações.

### Próximos marcos

1. Implementar a transição do escritório para o corredor.
2. Permitir navegação entre corredor, quarto, banheiro e sala.
3. Definir e implementar o comportamento de vida, derrota e reinício.
4. Conectar sanidade a variações textuais, visuais e sonoras.
5. Desenvolver a fase 2D da vizinhança escura.
6. Planejar e prototipar a primeira sequência 3D.
7. Criar finais ou estados narrativos condicionados às escolhas do jogador.

## 13. Critérios de sucesso

O jogo cumpre sua proposta quando:

- O jogador entende o funcionamento do terminal sem precisar sair da atmosfera.
- Cada comando útil revela informação, cria risco ou aproxima o jogador de uma solução.
- A progressão parece descoberta, não uma lista de tarefas explícita.
- O estado de sanidade produz consequências perceptíveis e coerentes.
- A mudança entre terminal, 2D e 3D aumenta a tensão e acompanha a narrativa.
- O conteúdo pode ser expandido pelo JSON sem reescrever o interpretador.
