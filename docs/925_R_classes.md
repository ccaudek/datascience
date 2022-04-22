## Strutture di dati {#chapter-strutture-dati}



Solitamente gli psicologi raccolgono grandi quantità di dati. Tali dati
vengono codificati in `R` all'interno di oggetti aventi proprietà
diverse. Intuitivamente, in `R` un oggetto è qualsiasi cosa a cui è
possibile assegnare un valore. I dati possono essere di tipo numerico o
alfanumerico. Di conseguenza, `R`distingue tra oggetti aventi _modi_
diversi. Inoltre, i dati possono essere organizzati in righe e colonne
in base a diversi tipi di strutture che `R` chiama _classi_.

### Classi e modi degli oggetti

Gli oggetti `R` si distinguono a seconda della loro classe (*class*) e
del loro modo (*mode*). La classe definisce il tipo di oggetto. In `R`,
vengono utilizzate cinque strutture di dati che corrispondono a cinque
classi differenti: `vector`, `matrix`, `array`, `list` e `data.frame`.
Un'altra classe di oggetti `R` è `function` (ad essa appartengono le
funzioni).

La classe di appartenenza di un oggetto si stabilisce usando le funzioni
`class()`, oppure `is.list()`, `is.function()`, `is.logical()`, e così
via. Queste funzioni restituisco `TRUE` e `FALSE` in base
all'appartenenza o meno dell'argomento a quella determinata classe.

Gli oggetti `R` possono anche essere classificati in base al loro 'modo'.
I modi 'atomici' degli oggetti sono: `numeric`, `complex`, `character` e
`logical`. Per esempio,


```r
x <- c(4, 9)
mode(x)
#> [1] "numeric"
cards <- c("9 of clubs", "10 of hearts", "jack of hearts") 
mode(cards)
#> [1] "character"
```

Nel seguito verranno esaminate le cinque strutture di dati utilizzate da
`R`.

### Vettori 

I vettori sono la classe di oggetto più importante in `R`. Un vettore può
essere creato usando la funzione `c()`:


```r
y <- c(2, 1, 6, -3, 9)
y
#> [1]  2  1  6 -3  9
```

Le dimensioni di un vettore presente nella memoria di lavoro possono essere trovare con la funzione `length()`; ad esempio,


```r
length(y)
#> [1] 5
```

ci dice che `y` è un vettore costituito da cinque elementi. La somma, il
minimo e il massimo degli elementi contenuti in un vettore si trovano
con le seguenti istruzioni:


```r
sum(y)
#> [1] 15
min(y)
#> [1] -3
max(y)
#> [1] 9
```

Mentre ci sono sei 'tipi' di vettori 'atomici' in `R`, noi ci
focalizzeremo sui tipi seguenti: 'numeric' ('integer': *e.g.*, 5;
'double': *e.g.*, 5.5), 'character' (*e.g.*, 'pippo') e 'logical'
(*e.g.*, `TRUE`, `FALSE`). Usiamo la funzione `typeof()` per determinare
il 'tipo' di un vettore atomico. Tutti gli elementi di un vettore
atomico devono essere dello stesso tipo. La funzione `str()` rende
visibile in maniera compatta la struttura interna di un oggetto.

### Matrici

Una matrice è una collezione di vettori. Il comando per generare una
matrice è `matrix()`:


```r
X <- matrix(1:20, nrow = 4, byrow = FALSE)
X
#>      [,1] [,2] [,3] [,4] [,5]
#> [1,]    1    5    9   13   17
#> [2,]    2    6   10   14   18
#> [3,]    3    7   11   15   19
#> [4,]    4    8   12   16   20
```

Il primo argomento è il vettore i cui elementi andranno a disporsi
all'interno della matrice. È poi necessario specificare le dimensioni
della matrice e il modo in cui `R` dovrà riempire la matrice. Date le
dimensioni del vettore, la specificazione del numero di righe (secondo
argomento) è sufficiente per determinare le dimensioni della matrice.
L'argomento `byrow = FALSE` è il default. In tal caso, `R` riempie la
matrice per colonne. Se vogliamo che `R` riempia la matrice per righe,
usiamo `byrow = TRUE`:


```r
Y <- matrix(1:20, nrow = 4, byrow = TRUE)
Y
#>      [,1] [,2] [,3] [,4] [,5]
#> [1,]    1    2    3    4    5
#> [2,]    6    7    8    9   10
#> [3,]   11   12   13   14   15
#> [4,]   16   17   18   19   20
```

Le dimensioni di una matrice presente nella memoria di lavoro possono
essere trovare con la funzione `dim()`; ad esempio,


```r
dim(Y)
#> [1] 4 5
```

ci dice che `Y` è una matrice con quattro righe e cinque colonne.

### Array

Un array è una collezione di matrici (si veda la
Figura [1.1](#fig:R_data_structures){reference-type="ref"
reference="fig:R_data_structures"}). Per costruire un array con la
funzione `array()` è necessario specificare un vettore come primo
argomento e un vettore di dimensioni, chiamato `dim`, quale secondo
argomento:


```r
ar <- array(
  c(11:14, 21:24, 31:34), 
  dim = c(2, 2, 3)
)
```

Un sottoinsieme di questi dati può essere selezionato, per esempio, nel
modo seguente:


```r
ar[, , 3]
#>      [,1] [,2]
#> [1,]   31   33
#> [2,]   32   34
```

### Operazioni aritmetiche su vettori, matrici e array

#### Operazioni aritmetiche su vettori

I vettori e le matrici (o gli array) possono essere utilizzati in
espressioni aritmetiche. Il risultato è un vettore o una matrice (o un
array) formato dalle operazioni fatte elemento per elemento sui vettori
o sulle matrici. Ad esempio,


```r
y + 3
#> [1]  5  4  9  0 12
```

restituisce un vettore di dimensioni uguali alle dimensioni di `y`, i
cui elementi sono dati dalla somma tra ciascuno degli elementi originari
di `y` e la costante "3".

Ovviamente, ad un vettore possono essere applicate tutte le altre
operazioni algebriche, sempre elemento per elemento. Ad esempio,


```r
3 * y
#> [1]  6  3 18 -9 27
```

restituisce un vettore i cui elementi sono uguali agli elementi di `y`
moltiplicati per 3.

Se sono costituiti dallo stesso numero di elementi, due vettori possono
essere sommati, sottratti, moltiplicati e divisi, laddove queste
operazioni algebriche vengono eseguite elemento per elemento. Per
esempio,


```r
x <- c(1, 1, 2, 1, 3)
y <- c(2, 1, 6, 3, 9)
x + y
#> [1]  3  2  8  4 12
x - y
#> [1] -1  0 -4 -2 -6
x * y
#> [1]  2  1 12  3 27
x / y
#> [1] 0.5000000 1.0000000 0.3333333 0.3333333 0.3333333
```

#### Operazioni aritmetiche su matrici

Le operazioni algebriche elemento per elemento si possono estendere al
caso delle matrici. Per esempio, se `X`, `Y` sono entrambe matrici di
dimensioni $4 \times 5$, allora la seguente operazione


```r
M <- 2 * (X + Y) - 3 
```

crea una matrice `D` anch'essa di dimensioni $4 \times 5$ i cui elementi
sono ottenuti dalle operazioni fatte elemento per elemento sulle matrici
e sugli scalari:


```r
M
#>      [,1] [,2] [,3] [,4] [,5]
#> [1,]    1   11   21   31   41
#> [2,]   13   23   33   43   53
#> [3,]   25   35   45   55   65
#> [4,]   37   47   57   67   77
```

#### Operazioni aritmetiche su array

Le stesse considerazioni si estendono al caso degli array.

### Liste

Le liste assomigliano ai vettori perché raggruppano i dati in un insieme
unidimensionale. Tuttavia, le liste non raggruppano elementi individuali
ma bensì oggetti di `R`, quali vettori e altre liste. Per esempio,


```r
list1 <- list("R", list(TRUE, FALSE), 20:24)
list1
#> [[1]]
#> [1] "R"
#> 
#> [[2]]
#> [[2]][[1]]
#> [1] TRUE
#> 
#> [[2]][[2]]
#> [1] FALSE
#> 
#> 
#> [[3]]
#> [1] 20 21 22 23 24
```

Le doppie parentesi quadre identificano l'elemento della lista a cui
vogliamo fare riferimento. Per esempio,


```r
list1[[3]]
#> [1] 20 21 22 23 24
list1[[3]][2]
#> [1] 21
```

### Data frame

I data.frame sono strutture tipo matrice, in cui le colonne possono
essere vettori di tipi differenti. La funzione usata per generare un
data frame è `data.frame()`, che permette di unire più vettori di uguale
lunghezza come colonne del data frame, ognuno dei quali si riferisce ad
una diversa variabile. Ad esempio,


```r
df <- data.frame(
  face = c("ace", "two", "six"),
  suit = c("clubs", "clubs", "clubs"), 
  value = c(1, 2, 3)
)
df
#>   face  suit value
#> 1  ace clubs     1
#> 2  two clubs     2
#> 3  six clubs     3
```

L'estrazione di dati da un data.frame può essere effettuata in maniera
simile a quanto avviene per i vettori. Ad esempio, per estrarre la
variabile `value` dal data.frame `df` si può indicare l'indice della
terza colonna:


```r
df[, 3]
#> [1] 1 2 3
```

Dal momento che le colonne sono delle variabili, è possibile estrarle
anche indicando nome della variabile, scrivendo
`nome_data_frame$nome_variabile`:


```r
df$value
#> [1] 1 2 3
```

Per fare un esempio, creiamo un data.frame che contenga tutte le informazioni di un mazzo di carte da poker [@grolemund2014hands]. In tale data.frame, ciascuna riga
corrisponde ad una carta -- in un mazzo da poker ci sono 52 carte,
perciò il data.frame avrà 52 righe. Il vettore `face` indica con una
stringa di caratteri il valore di ciascuna carta, il vettore `suit`
indica il seme e il vettore `value` indica con un numero intero il
valore di ciascuna carta. Quindi, il data.frame avrà 3 colonne.


```r
deck <- data.frame(
  face = c("king", "queen", "jack", "ten", "nine", "eight",
  "seven", "six", "five", "four", "three", "two", "ace", 
  "king", "queen", "jack", "ten", "nine", "eight", "seven", 
  "six", "five", "four", "three", "two", "ace", "king", 
  "queen", "jack", "ten", "nine", "eight", "seven", "six", 
  "five", "four", "three", "two", "ace", "king", "queen", 
  "jack", "ten", "nine", "eight", "seven", "six", "five", 
  "four", "three", "two", "ace"), 
  suit = c("spades", "spades", "spades", "spades", 
  "spades", "spades", "spades", "spades", "spades", 
  "spades", "spades", "spades", "spades", "clubs", "clubs", 
  "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", 
  "clubs", "clubs", "clubs", "clubs", "clubs", "diamonds", 
  "diamonds", "diamonds", "diamonds", "diamonds", 
  "diamonds", "diamonds", "diamonds", "diamonds", 
  "diamonds", "diamonds", "diamonds", "diamonds", "hearts", 
  "hearts", "hearts", "hearts", "hearts", "hearts", 
  "hearts", "hearts", "hearts", "hearts", "hearts", 
  "hearts", "hearts"), 
  value = c(13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
)
```

Avendo salvato tutte queste informazioni nell'oggetto `deck`, possiamo
stamparle sullo schermo semplicemente digitando il nome dell'oggetto che
le contiene:


```r
deck
#>     face     suit value
#> 1   king   spades    13
#> 2  queen   spades    12
#> 3   jack   spades    11
#> 4    ten   spades    10
#> 5   nine   spades     9
#> 6  eight   spades     8
#> 7  seven   spades     7
#> 8    six   spades     6
#> 9   five   spades     5
#> 10  four   spades     4
#> 11 three   spades     3
#> 12   two   spades     2
#> 13   ace   spades     1
#> 14  king    clubs    13
#> 15 queen    clubs    12
#> 16  jack    clubs    11
#> 17   ten    clubs    10
#> 18  nine    clubs     9
#> 19 eight    clubs     8
#> 20 seven    clubs     7
#> 21   six    clubs     6
#> 22  five    clubs     5
#> 23  four    clubs     4
#> 24 three    clubs     3
#> 25   two    clubs     2
#> 26   ace    clubs     1
#> 27  king diamonds    13
#> 28 queen diamonds    12
#> 29  jack diamonds    11
#> 30   ten diamonds    10
#> 31  nine diamonds     9
#> 32 eight diamonds     8
#> 33 seven diamonds     7
#> 34   six diamonds     6
#> 35  five diamonds     5
#> 36  four diamonds     4
#> 37 three diamonds     3
#> 38   two diamonds     2
#> 39   ace diamonds     1
#> 40  king   hearts    13
#> 41 queen   hearts    12
#> 42  jack   hearts    11
#> 43   ten   hearts    10
#> 44  nine   hearts     9
#> 45 eight   hearts     8
#> 46 seven   hearts     7
#> 47   six   hearts     6
#> 48  five   hearts     5
#> 49  four   hearts     4
#> 50 three   hearts     3
#> 51   two   hearts     2
#> 52   ace   hearts     1
```

Si noti che, a schermo, `R` stampa un numero progressivo che corrisponde
al numero della riga.

#### Selezione di elementi

Una volta creato un data.frame, ad esempio quello che contiene un mazzo
virtuale di carte (si veda
l'esempio [\[exmp:deck_of_cards\]](#exmp:deck_of_cards){reference-type="ref"
reference="exmp:deck_of_cards"}), è necessario sapere come manipolarlo.
La funzione `head()` mostra le prime sei righe del data.frame:


```r
head(deck)
#>    face   suit value
#> 1  king spades    13
#> 2 queen spades    12
#> 3  jack spades    11
#> 4   ten spades    10
#> 5  nine spades     9
#> 6 eight spades     8
```

Poniamoci ora il problema di mescolare il mazzo di carte e di estrarre
alcune carte dal mazzo. Queste operazioni possono essere eseguite usando
il sistema notazionale di `R`.

Il sistema di notazione di `R` consente di estrarre singoli elementi
dagli oggetti definiti da `R`. Per estrarre un valore da un data.frame,
per esempio, dobbiamo scrivere il nome del data.frame seguito da una
coppia di parentesi quadre:


```r
deck[, ]
```

All'interno delle parentesi quadre ci sono due indici separati da una
virgola. `R` usa il primo indice per selezionare un sottoinsieme di righe
del data.frame e il secondo indice per selezionare un sottoinsieme di
colonne. L'indice è il numero d’ordine che etichetta progressivamente ognuno dei valori del vettore. Per esempio,


```r
deck[9, 2]
#> [1] "spades"
```

restituisce l'elemento che si trova nella nella nona riga della seconda
colonna di `deck`.

In `R` ci sono sei modi diversi per specificare gli indici di un oggetto:
interi positivi, interi negativi, zero, spazi vuoti, valori logici e
nomi. Esaminiamoli qui di seguito.

#### Interi positivi

Gli indici $i, j$ possono essere degli interi positivi che identificano
l'elemento nella $i$-esima riga e nella $j$-esima colonna del
data.frame. Per l'esempio relativo al mazzo di carte, l'istruzione


```r
deck[1, 1]
#> [1] "king"
```

ritorna il valore nella prima riga e nella prima colonna. Per estrarre
più di un valore, usiamo un vettore di interi positivi. Per esempio, la
prima riga di `deck` si trova con


```r
deck[1, c(1:3)]
#>   face   suit value
#> 1 king spades    13
```

Tale sistema notazionale non si applica solo ai data.frame ma può essere
usato anche per gli altri oggetti di `R`.

L'indice usato da `R` inizia da 1. In altri linguaggi di programmazione,
per esempio `C`, inizia da 0.

#### Interi negativi

Gli interi negativi fanno l'esatto contrario degli interi positivi: R
ritornerà tutti gli elementi tranne quelli specificati dagli interi
negativi. Per esempio, la prima riga del data.frame può essere
specificata nel modo seguente


```r
deck[-(2:52), 1:3]
#>   face   suit value
#> 1 king spades    13
```

ovvero, escludendo tutte le righe seguenti.

#### Zero

Quando lo zero viene usato come indice, `R` non ritorna nulla dalla
dimensione a cui lo zero si riferisce. L'istruzione


```r
deck[0, 0]
#> data frame con 0 colonne e 0 righe
```

ritorna un data.frame vuoto. Non molto utile.

#### Spazio `’ ’`

Uno spazio viene usato quale indice per comunicare a `R` di estrarre
tutti i valori in quella dimensione. Questo è utile per estrarre intere
colonne o intere righe da un data.frame. Per esempio, l'istruzione


```r
deck[3, ]
#>   face   suit value
#> 3 jack spades    11
```

ritorna la terza riga del data.frame `deck`.

#### Valori booleani

Se viene fornito un vettore di stringhe `TRUE`, `FALSE`, `R` selezionerà
gli elementi riga o colonna corrispondenti ai valori booleani `TRUE`
usati quali indici. Per esempio, l'istruzione


```r
deck[3, c(TRUE, TRUE, FALSE)]
#>   face   suit
#> 3 jack spades
```

ritorna i valori delle prime due colonne della terza riga di `deck`.

#### Nomi

È possibile selezionare gli elementi del data.frame usando i loro nomi.
Per esempio,


```r
deck[1, c("face", "suit", "value")]
#>   face   suit value
#> 1 king spades    13
deck[, "value"]
#>  [1] 13 12 11 10  9  8  7  6  5  4  3  2  1 13 12 11 10  9  8  7  6  5  4  3  2
#> [26]  1 13 12 11 10  9  8  7  6  5  4  3  2  1 13 12 11 10  9  8  7  6  5  4  3
#> [51]  2  1
```


### Giochi di carte 

Avendo presentato le nozioni base del sistema di notazione di `R`,
utilizziamo tali conoscenze per manipolare il data.frame. L'istruzione


```r
deck[1:52, ]
```

ritorna tutte le righe e tutte e le colonne del data.frame `deck`. Le
righe sono identificate dal primo indice, che va da 1 a 52. Permutare in
modo casuale l'indice delle righe equivale a mescolare il mazzo di
carte. Per fare questo, utilizziamo la funzione `sample()`  ponendo `replace=FALSE` e `size`
uguale alla dimensione del vettore che contiene gli indici da 1 a 52:


```r
random <- sample(1:52, size = 52, replace = FALSE)
random
#>  [1] 41 35 51 22  3 10  2 15 11 16 46 21  7 19 43 17 27 50 39 44 14 18 40 47 31
#> [26] 30 52 37 20 33  6  9  5 49 13  4  8 28 32 45 42 26 36  1 48 23 24 29 34 25
#> [51] 38 12
```

Utilizzando il vettore `random` di indici permutati otteniamo il
risultato cercato:


```r
deck_shuffled <- deck[random, ]
head(deck_shuffled)
#>     face     suit value
#> 41 queen   hearts    12
#> 35  five diamonds     5
#> 51   two   hearts     2
#> 22  five    clubs     5
#> 3   jack   spades    11
#> 10  four   spades     4
```

Possiamo ora scrivere una funzione che include le precedenti istruzioni:


```r
shuffle <- function(cards) {
  random <- sample(1:52, size = 52, replace = FALSE) 
  return(cards[random, ])
}
```

Invocando la funzione `shuffle()` possiamo generare un data.frame che
rappresenta un mazzo di carte mescolato:


```r
deck_shuffled <- shuffle(deck)
```

Se immaginiamo di distribuire le carte di questo mazzo a due giocatori
di poker, per il primo giocatore avremo:


```r
deck_shuffled[c(1, 3, 5, 7, 9), ]
#>    face     suit value
#> 26  ace    clubs     1
#> 44 nine   hearts     9
#> 29 jack diamonds    11
#> 42 jack   hearts    11
#> 22 five    clubs     5
```

e per il secondo:


```r
deck_shuffled[c(2, 4, 6, 8, 10), ]
#>     face     suit value
#> 24 three    clubs     3
#> 47   six   hearts     6
#> 34   six diamonds     6
#> 51   two   hearts     2
#> 17   ten    clubs    10
```


### Variabili locali

Si noti che, nell'esempio precedente, abbiamo passato l'argomento `deck`
alla funzione `shuffle()`, perché questo è il nome del data.frame che
volevamo manipolare. Nella definizione della funzione `shuffle()`, però,
l'argomento della funzione era chiamato `cards`. Il nome degli argomenti
è diverso nei due casi. Allora perché l'istruzione `shuffle(deck)` non
dà un messaggio d'errore?

La risposta a questa domanda è che nelle funzioni le variabili nascono
quando la funzione entra in esecuzione e muoiono al termine
dell'esecuzione della funzione. Per questa ragione, sono dette 'locali'.
La variabile `cards`, in questo esempio, esiste soltanto all'interno
della funzione. Dunque non deve (necessariamente) avere lo stesso nome
di un altro oggetto che esiste al di fuori della funzione, nello spazio
di lavoro di R (anzi, è meglio se il nome degli oggetti usati
all'interno delle funzioni è diverso da quello degli oggetti che
esistono fuori dalle funzioni). R sa che l'oggetto `deck` passato a
`shuffle()` corrisponde a `cards` all'interno della funzione perché
assegna il nome `cards` a qualunque oggetto venga passato alla funzione
`shuffle()` come primo (e, in questo caso, unico) argomento.


