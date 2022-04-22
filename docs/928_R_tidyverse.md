## Manipolazione dei dati 



### Motivazione 

Si chiamano "dati grezzi" quelli che provengono dal mondo circostanze, i
dati raccolti per mezzo degli strumenti usati negli esperimenti, per
mezzo di interviste, di questionari, ecc. Questi dati (chiamati
*dataset*) raramente vengono forniti con una struttura logica precisa.
Per potere elaborarli mediante dei software dobbiamo prima trasformarli
in maniera tale che abbiano una struttura logica organizzata. La
struttura che solitamente si utilizza è quella tabellare (matrice dei
dati), ovvero si dispongono i dati in una tabella nella quale a ciascuna
riga corrisponde ad un'osservazione e ciascuna colonna corrisponde ad
una variabile rilevata. In `R` una tale struttura è chiamata *data frame*.

Utilizzando i pacchetti del `tidyverse` (`tidyverse` è un insieme, o _bundle_, di pacchetti `R`), le operazioni di trasformazione dei dati risultano molto semplificate. Nel `tidyverse` i data frame vengono leggermente modificati e si chiamano `tibble`. Per la manipolazione dei dati vengono usati i seguenti pacchetti del `tidyverse`:

- `dplyr`
- `tidyr` (tibbles, dataframe e tabelle)
- `stringr` (stringhe)

Il pacchetto `dplyr` (al momento uno dei pacchetti più famosi e utilizzati per la gestione dei dati) offre una serie di funzionalità che consentono di eseguire le operazioni più comuni di manipolazione dei dati in maniera più semplice rispetto a quanto succeda quando usiamo le funzioni base di `R`.

### Trattamento dei dati con `dplyr`

Il pacchetto `dplyr` include sei funzioni base: `filter()`, `select()`, `mutate()`, `arrange()`, `group_by()` e `summarise()`. Queste sei funzioni costituiscono i _verbi_ del linguaggio di manipolazione dei dati. A questi sei verbi si aggiunge il pipe `%>%` che serve a concatenare più operazioni. In particolare, considerando una matrice osservazioni per variabili, `select()` e `mutate()` si occupano di organizzare le variabili, `filter()` e `arrange()` i casi, e `group_by()` e `summarise()` i gruppi. 

Per introdurre le funzionalità di `dplyr`, utilizzeremo i dati `msleep` forniti dal pacchetto `ggplot2`. Tali dati descrivono le ore di sonno medie di 83 specie di mammiferi [@savage2007scaling]. Carichiamo il _boundle_  `tidyverse` (che contiene `ggplot2`) e leggiamo nella memoria di lavoro l'oggetto `msleep`:


```r
library("tidyverse")
data(msleep)
dim(msleep)
#> [1] 83 11
```

#### Operatore pipe

Prima di presentare le funzionalità di `dplyr`, introduciamo l'operatore pipe `%>%`  del pacchetto `magrittr` -- ma ora presente anche in base `R` nella versione `|>`. L'operatore pipe, `%>%` o `|>`, serve a concatenare varie funzioni insieme, in modo da inserire un'operazione dietro l'altra. Una spiegazione intuitiva dell'operatore pipe è stata fornita in un tweet di `@andrewheiss`. Consideriamo la seguente istruzione in pseudo-codice `R`:


```r
leave_house(
  get_dressed(
    get_out_of_bed(
      wake_up(me, time = "8:00"), 
      side = "correct"), 
    pants = TRUE, 
    shirt = TRUE), 
  car = TRUE, 
  bike = FALSE
)
```

Il listato precedente descrive una serie di (pseudo) funzioni concatenate, le quali costituiscono gli argomenti di altre funzioni. Scritto così, il codice è molto difficile da capire. Possiamo però ottenere lo stesso risultato utilizzando l'operatore pipe che facilita enormememnte la leggibilità del codice:


```r
me %>% 
  wake_up(time = "8:00") %>% 
  get_out_of_bed(side = "correct") %>% 
  get_dressed(pants = TRUE, shirt = TRUE) %>% 
  leave_house(car = TRUE, bike = FALSE)
```

In questa seconda versione del (pseudo) codice `R` si capisce molto meglio ciò che vogliamo fare. Il `tibble` `me` viene passato alla funzione `wake_up()`. La funzione `wake_up()` ha come argomento l'ora del giorno: `time = "8:00"`. Una volta "svegliati" (wake up) dobbiamo scendere dal letto. Quindi l'output di `wake_up()` viene passato alla funzione `get_out_of_bed()` la quale ha come argomento `side = "correct"` perché vogliamo scendere dal letto dalla parte giusta. E così via. 

Questo pseudo-codice chiarisce il significato dell'operatore pipe. L'operatore `%>%` è "syntactic sugar" per una serie di chiamate di funzioni concatenate, ovvero, detto in altre parole, consente di definire la relazione tra una serie di funzioni nelle quali il risultato (output) di una funzione viene utilizzato come l'input di una funzione successiva.

#### Estrarre una singola colonna con `pull()`

Ritorniamo ora all'esempio precedente. Iniziamo a trasformare il data frame `msleep` in un `tibble` (che è identico ad un data frame ma viene stampato sulla console in un modo diverso):


```r
msleep <- tibble(msleep)
```

\noindent 
Estraiamo da `msleep` la variabile `sleep_total` usando il verbo `pull()`:


```r
msleep %>% 
  pull(sleep_total)
#>  [1] 12.1 17.0 14.4 14.9  4.0 14.4  8.7  7.0 10.1  3.0  5.3  9.4 10.0 12.5 10.3
#> [16]  8.3  9.1 17.4  5.3 18.0  3.9 19.7  2.9  3.1 10.1 10.9 14.9 12.5  9.8  1.9
#> [31]  2.7  6.2  6.3  8.0  9.5  3.3 19.4 10.1 14.2 14.3 12.8 12.5 19.9 14.6 11.0
#> [46]  7.7 14.5  8.4  3.8  9.7 15.8 10.4 13.5  9.4 10.3 11.0 11.5 13.7  3.5  5.6
#> [61] 11.1 18.1  5.4 13.0  8.7  9.6  8.4 11.3 10.6 16.6 13.8 15.9 12.8  9.1  8.6
#> [76] 15.8  4.4 15.6  8.9  5.2  6.3 12.5  9.8
```

#### Selezionare più colonne con `select()`

Se vogliamo selezionare da `msleep` un insieme di variabili, ad esempio `name`, `vore` e `sleep_total`, possiamo usare il verbo `select()`:


```r
dt <- msleep %>%
  dplyr::select(name, vore, sleep_total)
dt
#> # A tibble: 83 × 3
#>   name                       vore  sleep_total
#>   <chr>                      <chr>       <dbl>
#> 1 Cheetah                    carni        12.1
#> 2 Owl monkey                 omni         17  
#> 3 Mountain beaver            herbi        14.4
#> 4 Greater short-tailed shrew omni         14.9
#> 5 Cow                        herbi         4  
#> 6 Three-toed sloth           herbi        14.4
#> 7 Northern fur seal          carni         8.7
#> 8 Vesper mouse               <NA>          7  
#> # … with 75 more rows
```

\noindent
laddove la sequenza di istruzioni precedenti significa che abbiamo passato `msleep` alla funzione `select()` contenuta nel pacchetto `dplyr` e l'output di `select()` è stato salvato (usando l'operatore di assegnazione, `<-`) nell'oggetto `dt`. Alla funzione `select()` abbiamo passato gli argomenti `name`, `vore` e `sleep_total`. 

#### Filtrare le osservazioni (righe) con `filter()`

Il verbo `filter()` consente di selezionare da un `tibble` un sottoinsieme di righe (osservazioni). Per esempio, possiamo selezionare tutte le osservazioni nella variabile `vore` contrassegnate come `carni` (ovvero, tutti i carnivori):


```r
dt %>%
  dplyr::filter(vore == "carni")
#> # A tibble: 19 × 3
#>   name                 vore  sleep_total
#>   <chr>                <chr>       <dbl>
#> 1 Cheetah              carni        12.1
#> 2 Northern fur seal    carni         8.7
#> 3 Dog                  carni        10.1
#> 4 Long-nosed armadillo carni        17.4
#> 5 Domestic cat         carni        12.5
#> 6 Pilot whale          carni         2.7
#> 7 Gray seal            carni         6.2
#> 8 Thick-tailed opposum carni        19.4
#> # … with 11 more rows
```

Per utilizzare il verbo `filter()` in modo efficace è neccessario usare gli operatori relazionali (Tabella \@ref(tab:oprelazionali)) e gli operatori logici  (Tabella \@ref(tab:oplogici)) di `R`. Per un approfondimento, si veda il Capitolo [Comparisons](https://r4ds.had.co.nz/transform.html) di _R for Data Science_.

\begin{table}[h!]
  \begin{center}
    \caption{Operatori relazionali.}
    \label{tab:oprelazionali}
    \begin{tabular}{l c} 
      \toprule
      uguale             &	== \\
      diverso            &  !=  \\
      minore             &	<  \\
      maggiore           &	>  \\
      minore o uguale	   & <=  \\
      maggiore o uguale	 & >=  \\
      \bottomrule
    \end{tabular}
  \end{center}
\end{table}

\begin{table}[h!]
  \begin{center}
    \caption{Operatori logici.}
    \label{tab:oplogici}
    \begin{tabular}{l c} 
      \toprule
      AND 	   &  \&	\\
      OR       &  |	\\
      NOT 	   &  !	  \\
      \bottomrule
    \end{tabular}
  \end{center}
\end{table}

#### Creare una nuova variabile con `mutate()`

Talvolta vogliamo creare una nuova variabile, per esempio, sommando o dividendo due variabili, oppure calcolandone la media. A questo scopo si usa il verbo `mutate()`. Per esempio, se vogliamo esprimere i valori di `sleep_total` in minuti, moltiplichiamo per 60:


```r
dt %>% 
  mutate(
    sleep_minutes = sleep_total * 60
  ) %>%
  dplyr::select(sleep_total, sleep_minutes)
#> # A tibble: 83 × 2
#>   sleep_total sleep_minutes
#>         <dbl>         <dbl>
#> 1        12.1           726
#> 2        17            1020
#> 3        14.4           864
#> 4        14.9           894
#> 5         4             240
#> 6        14.4           864
#> 7         8.7           522
#> 8         7             420
#> # … with 75 more rows
```

#### Ordinare i dati con `arrange()`

Il verbo `arrange()` ordina i dati in base ai valori di una o più variabili. Per esempio, possiamo ordinare la variabile `sleep_total` dal valore più alto al più basso in questo modo:


```r
dt %>% 
  arrange(
    desc(sleep_total)
  )
#> # A tibble: 83 × 3
#>   name                   vore    sleep_total
#>   <chr>                  <chr>         <dbl>
#> 1 Little brown bat       insecti        19.9
#> 2 Big brown bat          insecti        19.7
#> 3 Thick-tailed opposum   carni          19.4
#> 4 Giant armadillo        insecti        18.1
#> 5 North American Opossum omni           18  
#> 6 Long-nosed armadillo   carni          17.4
#> 7 Owl monkey             omni           17  
#> 8 Arctic ground squirrel herbi          16.6
#> # … with 75 more rows
```

#### Raggruppare i dati con `group_by()`

Il verbo `group_by()` raggruppa insieme i valori in base a una o più variabili. Lo vedremo in uso in seguito insieme a `summarise()`. 

Nota: con `dplyr()`, le operazioni raggruppate vengono iniziate con la funzione `group_by()`. È una buona norma utilizzare `ungroup()` alla fine di una serie di operazioni raggruppate, altrimenti i raggruppamenti verranno mantenuti nelle analisi successiva, il che non è sempre auspicabile. 

#### Sommario dei dati con `summarise()`

Il verbo `summarise()` collassa il dataset in una singola riga dove viene riportato il risultato della statistica richiesta. Per esempio, la media del tempo totale del sonno è


```r
dt %>% 
  summarise(
    m_sleep = mean(sleep_total, na.rm = TRUE)
  ) 
#> # A tibble: 1 × 1
#>   m_sleep
#>     <dbl>
#> 1    10.4
```

#### Operazioni raggruppate

Sopra abbiamo visto come i mammiferi considerati dormano, in media, 10.4 ore al giorno. Troviamo ora il sonno medio in funzione di `vore`:


```r
dt %>%
  group_by(vore) %>%
  summarise(
    m_sleep = mean(sleep_total, na.rm = TRUE), 
    n = n()
  )
#> # A tibble: 5 × 3
#>   vore    m_sleep     n
#>   <chr>     <dbl> <int>
#> 1 carni     10.4     19
#> 2 herbi      9.51    32
#> 3 insecti   14.9      5
#> 4 omni      10.9     20
#> 5 <NA>      10.2      7
```

\noindent
Si noti che, nel caso di 7 osservazioni, il valore di `vore` non era
specificato. Per tali osservazioni, dunque, la classe di appartenenza è
`NA`.

#### Applicare una funzione su più colonne: `across()`

È spesso utile eseguire la stessa operazione su più colonne, ma copiare e incollare è sia noioso che soggetto a errori:


```r
df %>%
  group_by(g1, g2) %>%
  summarise(
    a = mean(a),
    b = mean(b),
    c = mean(c),
    d = mean(d)
  )
```

\noindent
In tali circostanze è possibile usare la funzione `across()` che consente di riscrivere il codice precedente in modo più succinto:


```r
df %>% 
  group_by(g1, g2) %>% 
  summarise(across(a:d, mean))
```

\noindent
Per i dati presenti, ad esempio, possiamo avere:


```r
msleep %>%
  group_by(vore) %>%
  summarise(across(starts_with("sleep"), ~ mean(.x, na.rm = TRUE)))
#> # A tibble: 5 × 4
#>   vore    sleep_total sleep_rem sleep_cycle
#>   <chr>         <dbl>     <dbl>       <dbl>
#> 1 carni         10.4       2.29       0.373
#> 2 herbi          9.51      1.37       0.418
#> 3 insecti       14.9       3.52       0.161
#> 4 omni          10.9       1.96       0.592
#> 5 <NA>          10.2       1.88       0.183
```

### Dati categoriali in `R`

Consideriamo una variabile che descrive il genere e include le categorie `male`,  `female` e `non-conforming`. In `R`, ci sono due modi per memorizzare queste informazioni. Uno è usare la classe _character strings_ e l'altro è usare la classe _factor_. Non ci addentrimo qui nelle sottigliezze di questa distinzione, motivata in gran parte per le necessità della programmazione con le funzioni di `tidyverse`. Per gli scopi di questo insegnamento sarà sufficiente codificare le variabili qualitative usando la classe _factor_. Una volta codificati i dati qualitativi utilizzando la classe _factor_, si pongono spesso due problemi:

1. modificare le etichette dei livelli (ovvero, le modalità) di un fattore,
2. riordinare i livelli di un fattore.

#### Modificare le etichette dei livelli di un fattore

Esaminiamo l'esempio seguente.


```r
f_1 <- c("old_3", "old_4", "old_1", "old_1", "old_2")
f_1 <- factor(f_1)
y <- 1:5
df <- tibble(f_1, y)
df
#> # A tibble: 5 × 2
#>   f_1       y
#>   <fct> <int>
#> 1 old_3     1
#> 2 old_4     2
#> 3 old_1     3
#> 4 old_1     4
#> 5 old_2     5
```

\noindent
Supponiamo ora di volere che i livelli del fattore `f_1` abbiano le etichette `new_1`, `new_2`, ecc. Per ottenere questo risultato usiamo la funzione `forcats::fct_recode()`:


```r
df <- df %>%
  mutate(f_1 =
    forcats::fct_recode(
      f_1, 
      "new_poco" = "old_1", 
      "new_medio" = "old_2", 
      "new_tanto" = "old_3", 
      "new_massimo" = "old_4"
      )
   )
df
#> # A tibble: 5 × 2
#>   f_1             y
#>   <fct>       <int>
#> 1 new_tanto       1
#> 2 new_massimo     2
#> 3 new_poco        3
#> 4 new_poco        4
#> 5 new_medio       5
```

#### Riordinare i livelli di un fattore

Spesso i livelli dei fattori hanno un ordinamento naturale. Quindi, gli utenti devono avere un modo per imporre l'ordine desiderato sulla codifica delle loro variabili qualitative. Se per qualche motivo vogliamo ordinare i livelli `f_1` in ordine inverso, ad esempio, possiamo procedere nel modo seguente.


```r
df$f_1 <- factor(df$f_1,
  levels = c(
    "new_massimo", "new_tanto", "new_medio", "new_poco" 
  )
)
summary(df$f_1)
#> new_massimo   new_tanto   new_medio    new_poco 
#>           1           1           1           2
```

\noindent
Per approfondire le problematiche della manipolazione di variabili qualitative in `R`, si veda @mcnamara2018wrangling.

### Creare grafici con `ggplot2()`

Il pacchetto `ggplot2()` è un potente strumento per rappresentare graficamente i dati. Le iniziali del nome, `gg`, si riferiscono alla "Grammar of Graphics", che è un modo di pensare le figure come una serie di layer stratificati. Originariamente descritta da @wilkinson2012grammar, la grammatica dei grafici è stata aggiornata e applicata in `R` da Hadley Wickham, il creatore del pacchetto.

La funzione da cui si parte per inizializzare un grafico è `ggplot()`. La funzione `ggplot()` richiede due argomenti. Il primo è l'oggetto di tipo data.frame che contiene i dati da visualizzare -- in alternativa al primo argomento, un dataframe può essere passato a `ggplot()` mediante l'operatore pipe. Il secondo è una particolare lista che viene generata dalla funzione `aes()`, la quale determina l'aspetto (*aesthetic*) del grafico. La funzione `aes()` richiede necessariamente di specificare "x" e "y", ovvero i nomi delle colonne del data.frame che è stato utilizzato quale primo argomento di `ggplot()` (o che è stato passato da pipe), le quali rappresentano le variabili da porre rispettivamente sugli assi orizzontale e verticale.

La definizione della tipologia di grafico e i vari parametri sono poi definiti successivamente, aggiungendo all'oggetto creato da `ggplot()` tutte le componenti necessarie. Saranno quindi altre funzioni, come `geom_bar()`, `geom_line()` o `geom_point()` a occuparsi di aggiungere al livello di base barre, linee, punti, e così via. Infine, tramite altre funzioni, ad esempio `labs()`, sarà possibile definire i dettagli più fini.

Gli elementi grafici (bare, punti, segmenti, ...) usati da `ggplot2` sono chiamati `geoms`. Mediante queste funzioni è possibile costruire diverse tipologie di grafici:

-   `geom_bar()`: crea un layer con delle barre;

-   `geom_point()`: crea un layer con dei punti (diagramma a dispersione);

-   `geom_line()`: crea un layer con una linea retta;

-   `geom_histogram()`: crea un layer con un istogramma;

-   `geom_boxplot()`: crea un layer con un box-plot;

-   `geom_errorbar()`: crea un layer con barre che rappresentano intervalli di confidenza;

-   `geom_hline()` e `geom_vline()` : crea un layer con una linea orizzontale o verticale definita dall'utente.

Un comando generico ha la seguente forma:


```r
my_graph <- my_data %>% 
  ggplot(aes(x_var, y_var)) +
  geom_...()
```

La prima volta che si usa il pacchetto `ggplot2` è necessario installarlo. Per fare questo possiamo installare `tidyverse` che, oltre a caricare `ggplot2`, carica anche altre utili funzioni per l'analisi dei dati. Ogni volta che si inizia una sessione R è necessario attivare i pacchetti che si vogliono usare, ma non è necessario istallarli una nuova volta. Se è necessario specificare il pacchetto nel quale è contenuta la funzione che vogliamo utilizzare, usiamo la sintassi `package::function()`. Per esempio, l'istruzione `ggplot2::ggplot()` rende esplicito che stiamo usando la funzione `ggplot()` contenuta nel pacchetto `ggplot2`.

### Diagramma a dispersione

Consideriamo nuovamenti i dati contenuti nel `tibble` `msleep` e poniamoci il problema di rappresentare graficamente la relazione tra il numero medio di ore di sonno giornaliero (`sleep_total`) e il peso dell'animale (`bodywt`). Usando le impostazioni di default di `ggplot2`, con le istruzioni seguenti, otteniamo il grafico fornito dalla figura seguente.


```r
data("msleep")
p <- msleep %>% 
  ggplot(
    aes(x = bodywt, y = sleep_total)
  ) +
  geom_point()
print(p)
```

<img src="928_R_tidyverse_files/figure-html/unnamed-chunk-20-1.png" width="576" style="display: block; margin: auto;" />

Coloriamo ora in maniera diversa i punti che rappresentano animali carnivori, erbivori, ecc.


```r
p <- msleep %>% 
  ggplot(
    aes(x = bodywt, y = sleep_total, col = vore)
  ) +
  geom_point()
print(p)
```

<img src="928_R_tidyverse_files/figure-html/unnamed-chunk-21-1.png" width="576" style="display: block; margin: auto;" />

È chiaro, senza fare alcuna analisi statistica, che la relazione tra le due variabili non è lineare. Trasformando in maniera logaritmica i valori dell'asse $x$ la relazione si linearizza.


```r
p <- msleep %>% 
  ggplot(
    aes(x = log(bodywt), y = sleep_total, col = vore)
  ) +
  geom_point()
print(p)
```

<img src="928_R_tidyverse_files/figure-html/unnamed-chunk-22-1.png" width="576" style="display: block; margin: auto;" />

Infine, aggiustiamo il "tema" del grafico (si noti l'utilizzo di una tavolozza di colori adatta ai daltonici mediante il pacchetto `viridis`), aggiungiamo le etichette sugli assi e il titolo.


```r
library("viridis")
msleep %>%
  ggplot(
    aes(x = log(bodywt), y = sleep_total, col = vore)
  ) +
  geom_point(size = 3, alpha = .8) +
  labs(
    x = "Peso corporeo (log)",
    y = "Ore di sonno",
    title = "Il sonno in 83 specie di mammiferi",
    subtitle = "Un esempio di visualizzazione con ggplot()",
    caption = "Fonte: Savage e West (2007)"
  ) +
  scale_fill_viridis(discrete = TRUE, option = "viridis") +
  theme_minimal() +
  theme(legend.title = element_blank()) 
```

<img src="928_R_tidyverse_files/figure-html/unnamed-chunk-23-1.png" width="576" style="display: block; margin: auto;" />

La visualizzazione può essere migliorata cambiando le etichette della legenda del grafico. Per fare questo è necessario intervenire sui dati prima di usare `ggplot()` -- per esempio, come abbiamo fatto in precedenza con la funzione `forcats::fct_recode()`.

#### Istogramma

Creiamo ora un istogramma che rappresenta la distribuzione del (logaritmo del) peso medio del cervello delle 83 specie di mammiferi considerate da @savage2007quantitative. L'argomento `aes(y = ..density..)` in `geom_histogram()` produce le frequenze relative. L'opzione di default (senza questo argomento) porta `ggplot()` a rappresentare le frequenze assolute.


```r
msleep %>% 
  ggplot(
    aes(log(brainwt))
  ) +
  geom_histogram(aes(y = ..density..)) +
  labs(
    x = "Peso del cervello (log)",
    y = "Frequenza relativa"
  ) +
  theme(legend.title = element_blank())
```

<img src="928_R_tidyverse_files/figure-html/unnamed-chunk-24-1.png" width="576" style="display: block; margin: auto;" />

### Scrivere il codice `R` con stile 

Uno stile di programmazione è un insieme di regole per la gestione dell'indentazione dei blocchi di codice, per la creazione dei nomi dei file e delle variabili e per le convenzioni tipografiche che vengono usate. Scrivere il codice in `R` con stile consente di creare listati più leggibili e semplici da modificare, minimizza la possibilità di errore, e consente correzioni e modifiche più rapide. Vi sono molteplici stili di programmazione che possono essere utilizzati dall'utente, anche se è bene attenersi a quelle che sono le convenzioni maggiormente diffuse, allo scopo di favorire la comunicazione. In ogni caso, l'importante è di essere coerenti, ovvero di adottare le stesse convenzioni in tutte le parti del codice che si scrive. Ad esempio, se si sceglie di usare lo stile `snake_case` per il nome composto di una variabile (es., `personality_trait`), non è appropriato usare lo stile *lower Camel case* per un'altra variabile (es., `socialStatus`). Dato che questo argomento è stato trattato ampiamente in varie sedi, mi limito qui a rimandare ad uno [stile di programmazione](http://style.tidyverse.org/) molto popolare, quello proposto da Hadley Wickham, il creatore di `tidyverse`. La soluzione più semplice è quella installare `stiler`, che è uno RStudio Addin, e formattare il codice in maniera automatica utilizzando lo stile proposto da Hadley Wickham.  Si possono ottenere informazioni su `stiler` seguendo questo [link](https://github.com/r-lib/styler). 


