

# Set Game - CS193p - Assignment 3

Esse jogo foi feito com base no [Assignment 3](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/assignment_3.pdf) do curso de Stanford [CS193p](https://cs193p.sites.stanford.edu/2020) do ano de 2020. O jogo tem como base o jogo de cartas de mesmo nome, e foi construído utilizando o [SwiftUI](https://developer.apple.com/documentation/swiftui/) com base no padrão de design *MVVM (Model - View - View Model)*

# Set

O jogo  [Set](https://drive.google.com/file/d/1_h08Fs2-zyuH3m2cDw_2UsVlWCIDDz41/view) é jogado com um baralho contendo diversas cartas. Cada carta do baralho possui um conjunto de características que são utilizadas para que um grupo seja formado:

- Forma geométrica (ovais, riscos e losangos)
- Quantidade de formas (1, 2 ou 3)
- Cor (a, b ou c)
- Preenchimento (listrado, vazio ou sólido)


Um grupo (chamado de **set**) é formado por 3 (três) cartas que possuem as características todas *iguais* ou *diferentes*, segue exemplo:

![Exemplo Set](https://imgur.com/1TJqJmu.jpg)

As três cartas são parte de um Set, pois possuem:

- Formas geométrica iguais (oval)
- Mesma quantidade de formas (1)
- Cores diferentes (Vermelho / Roxo / Verde)
- Mesmo preenchimento (translúcido)

O aplicativo serve como uma adaptação do jogo para que seja jogado por apenas um jogador.

## Planejamento

Para o planejamento do aplicativo, foi consultado o PDF do [Assignment 3](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/assignment_3.pdf), e utilizada a ferramenta *Trello* para dividir as tarefas. Ao total foram mapeadas 19 tarefas, as quais foram divididas entre 4 tipos:

|TAREFAS|DESCRIÇÂO|
|------------------------|----------------------------
|**Essenciais**|São tarefas de suma importância para o funcionamento do jogo.|
|**Adicionais**|São tarefas que agregam valor ao aplicativo de forma que não impedem o funcionamento integral do mesmo.                        
|**Regras de negócio**|São tarefas que ditam como será o desenvolvimento do aplicativo, antes mesmo de qualquer linha de código.
|**Não será feito**|São tarefas que não serão realizadas durante o prazo da entrega do trabalho.|

Segue abaixo um GIF demonstrando como ficou o *board* do *Trello* após a divisão
![Board Trello](https://i.imgur.com/V7C4X6F.gif)