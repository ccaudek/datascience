\mainmatter

# (PART) Nozioni preliminari {-}

# Concetti chiave 

La _data science_ si pone all'intersezione tra statistica e informatica. La statistica è un insieme di metodi ugilizzati per estrarre informazioni dai dati; l'informatica implementa tali procedure in un software. In questo Capitolo vengono introdotti i  concetti fondamentali.

## Popolazioni e campioni

*Popolazione.* L'analisi dei dati inizia con l'individuazione delle unità portatrici di informazioni circa il fenomeno di interesse. Si dice popolazione (o universo) l'insieme $\Omega$ delle entità capaci di fornire informazioni sul fenomeno oggetto dell'indagine statistica. Possiamo scrivere $\Omega = \{\omega_i\}_{i=1, \dots, n}= \{\omega_1, \omega_2, \dots, \omega_n\}$, oppure $\Omega =  \{\omega_1, \omega_2, \dots \}$ nel caso di popolazioni finite o infinite, rispettivamente. 

L'obiettivo principale della ricerca psicologica è conoscere gli esiti psicologici e i loro fattori trainanti nella popolazione. Questo è l'obiettivo delle sperimentazioni psicologiche e della maggior parte degli studi osservazionali in psicologia. È quindi necessario essere molto chiari sulla popolazione a cui si applicano i risultati della ricerca. La popolazione può essere ben definita, ad esempio, tutte le persone che si trovavano nella città di Hiroshima al momento dei bombardamenti atomici e sono sopravvissute al primo anno, o può essere ipotetica, ad esempio, tutte le persone depresse che hanno subito o saranno sottoporsi ad un intervento di psicoterapia. Il ricercatore deve sempre essere in grado di determinare se un soggetto appartiene alla popolazione oggetto di interesse. 

Una _sottopopolazione_ è una popolazione in sé e per sé che soddisfa proprietà ben definite. Negli esempi precedenti, potremmo essere interessati alla sottopopolazione di uomini di età inferiore ai 20 anni o di pazienti depressi sottoposti ad uno specifico intervento psicologico. Molte questioni scientifiche riguardano le differenze tra sottopopolazioni; ad esempio, confrontando i gruppi con o senza psicoterapia per determinare se il trattamento è vantaggioso. I modelli di regressione, introdotti nel Capitolo \@ref(regr-models-intro) riguardano le sottopopolazioni, in quanto stimano il risultato medio per diversi gruppi (sottopopolazioni) definiti dalle covariate.

*Campione.* Gli elementi $\omega_i$ dell'insieme $\Omega$ sono detti *unità statistiche*. Un sottoinsieme della popolazione, ovvero un insieme di elementi $\omega_i$, viene chiamato *campione*. Ciascuna unità statistica $\omega_i$ (abbreviata con u.s.) è portatrice dell'informazione che verrà rilevata mediante un'operazione di misurazione.

Un campione è dunque un sottoinsieme della popolazione utilizzato per conoscere tale popolazione. A differenza di una sottopopolazione definita in base a chiari criteri, un campione viene generalmente selezionato tramite un procedura casuale. Il _campionamento casuale_ consente allo scienziato di trarre conclusioni sulla popolazione e, soprattutto, di quantificare l'incertezza sui risultati. I campioni di un sondaggio sono esempi di campioni casuali, ma molti studi osservazionali non sono campionati casualmente. Possono essere _campioni di convenienza_, come coorti di studenti in un unico istituto, che consistono di tutti gli studenti sottoposti ad un certo intervento psicologico in quell'istituto. Indipendentemente da come vengono ottenuti i campioni, il loro uso al fine di conoscere una popolazione target significa che i problemi di rappresentatività sono inevitabili e devono essere affrontati.


## Variabili e costanti

Una *variabile* è qualsiasi proprietà o descrittore che può assumere più valori (numerici o categoriali). Una variabile può essere pensata come una domanda a cui il valore è la risposta. Ad esempio, "Quanti anni ha questo partecipante?" “38 anni”. Qui, "età" è la variabile e "38" è il suo valore. La probabilità che la variabile $X$ assuma valore $x$ si scrive $P(X = x)$. Questo è spesso abbreviato in $P(x)$. Possiamo anche esaminare la probabilità di più valori contemporaneamente; per esempio, la probabilità che $X = x$ e $Y = y$ è scritta $P(X = x, Y = y)$ o $P(x, y)$. Si noti che $P(X = 38)$ è interpretato come la probabilità che un individuo selezionato casualmente dalla popolazione abbia 38 anni. Il termine "variabile" si contrappone al termine "costante" che descrive una proprietà invariante di tutte le unità statistiche. 

Si dice *modalità* ciascuna delle varianti con cui una variabile statistica può presentarsi. Definiamo *insieme delle modalità* di una variabile statistica l'insieme $M$ di tutte le possibili espressioni con cui la variabile può manifestarsi. Le modalità osservate e facenti parte del campione si chiamano *dati* (si veda la Tabella [1.1](#tab:term_st_desc){reference-type="ref"
reference="tab:term_st_desc"}).

::: {.example}
Supponiamo che il fenomeno studiato sia l'intelligenza. In uno studio, la popolazione potrebbe corrispondere all'insieme di tutti gli italiani adulti. La variabile considerata potrebbe essere il punteggio del test standardizzato WAIS-IV. Le modalità di tale variabile potrebbero essere $112, 92, 121, \dots$. Tale variabile è di tipo quantitativo discreto.
::: 

::: {.example}
Supponiamo che il fenomeno studiato sia il compito Stroop. La popolazione potrebbe corrispondere all'insieme dei bambini dai 6 agli 8 anni. La variabile considerata potrebbe essere il reciproco dei tempi di reazione in secondi. Le modalità di tale variabile potrebbero essere $1 / 2.35, 1/ 1.49, 1/2.93, \dots$. La variabile è di tipo quantitativo continuo. 
::: 

::: {.example}
Supponiamo che il fenomeno studiato sia il disturbo di personalità. La popolazione potrebbe corrispondere all'insieme dei detenuti nelle carceri italiane. La variabile considerata potrebbe essere l'assessment del disturbo di personalità tramite interviste cliniche strutturate. Le modalità di tale variabile potrebbero essere i Cluster A, Cluster B, Cluster C descritti dal DSM-V. Tale variabile è di tipo qualitativo. 
::: 


### Variabili casuali

Il termine _variabile_ usato nella statistica è equivalente al termine  _variabile casuale_ usato nella teoria delle probabilità. Lo studio dei risultati degli interventi psicologici è lo studio delle variabili casuali che misurano questi risultati. Una variabile casuale cattura una caratteristica specifica degli individui nella popolazione e i suoi valori variano tipicamente tra gli individui. Ogni variabile casuale può assumere in teoria una gamma di valori sebbene, in pratica, osserviamo un valore specifico per ogni individuo. Quando faremo riferiremo alle variabili casuali considerate in termini generali useremo lettere maiuscole come $X$ e $Y$; quando faremo riferimento ai valori che una variabile casuale assume in determinate circostanze useremo lettere minuscole come $x$ e $y$.


### Variabili indipendenti e variabili dipendenti

Un primo compito fondamentale in qualsiasi analisi dei dati è l'identificazione delle variabili dipendenti ($Y$) e delle variabili indipendenti ($X$). Le variabili dipendenti sono anche chiamate variabili di esito o di risposta e le variabili indipendenti sono anche chiamate predittori o covariate. Ad esempio, nell'analisi di regressione, che esamineremo in seguito, la domanda centrale è quella di capire come $Y$ cambia al variare di $X$. Più precisamente, la domanda che viene posta è: se il valore della variabile indipendente $X$ cambia, qual è la conseguenza per la variabile dipendente $Y$? In parole povere, le variabili indipendenti e dipendenti sono analoghe a "cause" ed "effetti", laddove le virgolette usate qui sottolineano che questa è solo un'analogia e che la determinazione delle cause può avvenire soltanto mediante l'utilizzo di un appropriato disegno sperimentale e di un'adeguata analisi statistica.

Se una variabile è una variabile indipendente o dipendente dipende dalla domanda di ricerca. A volte può essere difficile decidere quale variabile è dipendente e quale è indipendente, in particolare quando siamo specificamente interessati ai rapporti di causa/effetto. Ad esempio, supponiamo di indagare l'associazione tra esercizio fisico e insonnia. Vi sono evidenze che l'esercizio fisico (fatto al momento giusto della giornata) può ridurre l'insonnia. Ma l'insonnia può anche ridurre la capacità di una persona di fare esercizio fisico. In questo caso, dunque, non è facile capire quale sia la causa e quale l'effetto, quale sia la variabile dipendente e quale la variabile indipendente. La possibilità di identificare il ruolo delle variabili (dipendente/indipendente) dipende dalla nostra comprensione del fenomeno in esame. 

::: {.example}
Uno psicologo convoca 120 studenti universitari per un test di memoria.
Prima di iniziare l'esperimento, a metà dei soggetti viene detto che si
tratta di un compito particolarmente difficile; agli altri soggetti non
viene data alcuna indicazione. Lo psicologo misura il punteggio nella
prova di memoria di ciascun soggetto. 

In questo esperimento, la variabile indipendente è l'informazione sulla difficoltà della prova. La variabile indipendente viene manipolata dallo sperimentatore assegnando i soggetti (di solito in maniera causale) o alla condizione (modalità) "informazione assegnata" o "informazione non data". La
variabile dipendente è ciò che viene misurato nell'esperimento, ovvero
il punteggio nella prova di memoria di ciascun soggetto.
::: 


### La matrice dei dati

Le realizzazioni delle variabili esaminate in una rilevazione statistica
vengono organizzate in una *matrice dei dati*. Le colonne della matrice
dei dati contengono gli insiemi dei dati individuali di ciascuna
variabile statistica considerata. Ogni riga della matrice contiene tutte
le informazioni relative alla stessa unità statistica. Una generica
matrice dei dati ha l'aspetto seguente: 

$$
D_{m,n} = 
 \begin{pmatrix}
  \omega_1 & a_{1}   & b_{1}   & \cdots & x_{1} & y_{1}\\
  \omega_2 & a_{2}   & b_{2}   & \cdots & x_{2} & y_{2}\\
  \vdots   & \vdots  & \vdots  & \ddots & \vdots & \vdots  \\
 \omega_n  & a_{n}   & b_{n}   & \cdots & x_{n} & y_{n}
 \end{pmatrix}
 $$ 
 
dove, nel caso presente, la prima colonna contiene il
nome delle unità statistiche, la seconda e la terza colonna si
riferiscono a due mutabili statistiche (variabili categoriali; $A$ e
$B$) e ne presentano le modalità osservate nel campione mentre le ultime
due colonne si riferiscono a due variabili statistiche ($X$ e $Y$) e ne
presentano le modalità osservate nel campione. Generalmente, tra le
unità statistiche $\omega_i$ non esiste un ordine progressivo; l'indice
attribuito alle unità statistiche nella matrice dei dati si riferisce
semplicemente alla riga che esse occupano.


## Parametri e modelli

Ogni variabile casuale ha una _distribuzione_ che descrive la probabilità che la variabile assuma qualsiasi valore in un dato intervallo.^[In questo e nei successivi Paragrafi di questo Capitolo introduco gli obiettivi della _data science_ utilizzando una serie di concetti che saranno chiariti solo in seguito. Questa breve panoramica risulterà dunque solo in parte comprensibile ad una prima lettura e serve solo per definire la _big picture_ dei temi trattati in questo insegnamento. Il significato dei termini qui utilizzati sarà chiarito nei Capitoli successivi.] Senza ulteriori specificazioni, una distribuzione può fare riferimento a un'intera famiglia di distribuzioni. I parametri, tipicamente indicati con lettere greche come $\mu$ e $\alpha$, ci permettono di specificare di quale membro della famiglia stiamo parlando. Quindi, si può parlare di una variabile casuale con una distribuzione Normale, ma se viene specificata la media $\mu$ = 100 e la varianza $\sigma^2$ = 15, viene individuata una specifica distribuzione Normale -- nell'esempio, la distribuzione del quoziente di intelligenza.

I metodi statistici parametrici specificano la famiglia delle distribuzioni e quindi utilizzano i dati per individuare, stimando i parametri, una specifica distribuzione all'interno della famiglia di distribuzioni ipotizzata. Se $f$ è la PDF di una variabile casuale $Y$, l'interesse può concentrarsi sulla sua media e varianza. Nell'analisi di regressione, ad esempio, cerchiamo di spiegare come i parametri di $f$ dipendano dalle covariate $X$. Nella regressione lineare classica, assumiamo che $Y$ abbia una distribuzione normale con media $\mu = \E(Y)$, e stimiamo come $\E(Y)$ dipenda da $X$. Poiché molti esiti psicologici non seguono una distribuzione normale, verranno introdotte distribuzioni più appropriate per questi risultati. I metodi non parametrici, invece, non specificano una famiglia di distribuzioni per $f$. In queste dispense faremo riferimento a metodi non parametrici quando discuteremo della statistica descrittiva.

Il termine _modello_ è onnipresente in statistica e nella _data science_. Il modello statistico include le ipotesi e le specifiche matematiche relative alla distribuzione della variabile casuale di interesse. Il modello dipende dai dati e dalla domanda di ricerca, ma raramente è unico; nella maggior parte dei casi, esiste più di un modello che potrebbe ragionevolmente usato per affrontare la stessa domanda di ricerca e avendo a disposizione i dati osservati. Nella previsione delle aspettative future dei pazienti depressi che discuteremo in seguito [@zetschefuture2019], ad esempio, la specifica del modello include l'insieme delle covariate candidate, l'espressione matematica che collega i predittori con le aspettative future e qualsiasi ipotesi sulla distribuzione della variabile dipendente. La domanda di cosa costituisca un buon modello è una domanda su cui torneremo ripetutamente in questo insegnamento.


## Effetto

L'_effetto_ è una qualche misura dei dati. Dipende dal tipo di dati e dal tipo di test statistico che si vuole utilizzare. Ad esempio, se viene lanciata una moneta 100 volte e esce testa 66 volte, l'effetto sarà 66/100. Diventa poi possibile confrontare l'effetto ottenuto con l'effetto nullo che ci si aspetterebbe da una moneta bilanciata (50/100), o con qualsiasi altro effetto che può essere scelto. La _dimensione dell'effetto_ si riferisce alla differenza tra l'effetto misurato nei dati e l'effetto nullo (di solito un valore che ci si aspetta di ottenere in base al caso soltanto).


## Stima e inferenza

La stima è il processo mediante il quale il campione viene utilizzato per conoscere le proprietà di interesse della popolazione. La media campionaria è una stima naturale della media della popolazione e la mediana campionaria è una stima naturale della mediana della popolazione. Quando parliamo di stimare una proprietà della popolazione (a volte indicata come parametro della popolazione) o di stimare la distribuzione di una variabile casuale, stiamo parlando dell'utilizzo dei dati osservati per conoscere le proprietà di interesse della popolazione. L'inferenza statistica è il processo mediante il quale le stime campionarie vengono utilizzate per rispondere a domande di ricerca e per valutare specifiche ipotesi relative alla popolazione. Discuteremo le procedure bayesiane dell'inferenza nell'ultima parte di queste dispense.


## Metodi e procedure della psicologia

Un modello psicologico di un qualche aspetto del comportamento umano o della mente ha le seguenti proprietà:

1.  descrive le caratteristiche del comportamento in questione,
2.  formula predizioni sulle caratteristiche future del comportamento,
3.  è sostenuto da evidenze empiriche,
4.  deve essere falsificabile (ovvero, in linea di principio, deve
    potere fare delle predizioni su aspetti del fenomeno considerato che
    non sono ancora noti e che, se venissero indagati, potrebbero
    portare a rigettare il modello, se si dimostrassero incompatibili con
    esso).

L'analisi dei dati valuta un modello psicologico utilizzando strumenti statistici.

Questa dispensa è strutturata in maniera tale da rispecchiare la suddivisione tra i temi della misurazione, dell'analisi descrittiva e dell'inferenza. Nel prossimo Capitolo sarà affrontato il tema della misurazione e, nell'ultima parte della dispensa verrà discusso l'argomento più difficile, quello dell'inferenza. Prima di affrontare il secondo tema, l'analisi descrittiva dei dati, sarà necessario introdurre il linguaggio di programmazione statistica R (un'introduzione a R è fornita in Appendice). Inoltre, prima di potere discutere l'inferenza, dovranno essere introdotti i concetti di base della teoria delle probabilità, in quanto l'inferenza non è che l'applicazione della teoria delle probabilità all'analisi dei dati.
