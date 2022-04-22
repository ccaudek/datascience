# Il modello lineare visto da vicino {#regr-model-lm}



In questo capitolo mi pongo il problema di applicare il modello di regressione bivariata ad un campione di dati. Userò i dati `kidiq`. Riporto qui di seguito la descrizione di questo set di dati.

> Data from a survey of adult American women and their children (a subsample from the National Longitudinal Survey of Youth). 

> Source: Gelman and Hill (2007)

> 434 obs. of 4 variables

> - kid_score Child's IQ score
> - mom_hs Indicator for whether the mother has a high school degree
> - mom_iq Mother's IQ score
> - mom_age Mother's age

Leggo i dati in $\mathsf{R}$.


```r
kidiq <- rio::import(here::here(
  "data", "kidiq.dta"
))
glimpse(kidiq)
#> Rows: 434
#> Columns: 5
#> $ kid_score <dbl> 65, 98, 85, 83, 115, 98, 69, 106, 102, 95, 91, 58, 84, 78, 1…
#> $ mom_hs    <dbl> 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, …
#> $ mom_iq    <dbl> 121.11753, 89.36188, 115.44316, 99.44964, 92.74571, 107.9018…
#> $ mom_work  <dbl> 4, 4, 4, 3, 4, 1, 4, 3, 1, 1, 1, 4, 4, 4, 2, 1, 3, 3, 4, 3, …
#> $ mom_age   <dbl> 27, 25, 27, 25, 27, 18, 20, 23, 24, 19, 23, 24, 27, 26, 24, …
```

In questo esercizio considererò la relazione tra `kid_score` e `mom_iq`.


```r
kidiq %>% 
  ggplot(aes(x = mom_iq, y = kid_score)) +
  geom_point()
```

<img src="052_reglin2_files/figure-html/unnamed-chunk-3-1.png" width="576" style="display: block; margin: auto;" />

I dati rappresentati nel diagramma a dispersione suggeriscono che, in questo campione, sembra esserci un'associazione positiva tra l'intelligenza del bambino (kid_score) e l'intelligenza della madre (mom_iq). Mi pongo il problema di descrivere questa associazione mediante una relazione lineare.


```r
kidiq %>% 
  ggplot(aes(x = mom_iq, y = kid_score)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
```

<img src="052_reglin2_files/figure-html/unnamed-chunk-4-1.png" width="576" style="display: block; margin: auto;" />

Ci sono infinite rette che, in linea di principio, possono essere usate per "approssimare" la nube di punti nel diagramma a dispersione. È dunque necessario introdurre dei vincoli per selezionare una di queste rette.

Un vincolo che viene spesso usato è quello di costringere la retta a passare per il punto $(\bar{x}, \bar{y})$. 


```r
kidiq %>% 
  ggplot(aes(x = mom_iq, y = kid_score)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  geom_point(
    aes(x=mean(mom_iq), y=mean(kid_score)), 
    colour="red", size = 4
  )
```

<img src="052_reglin2_files/figure-html/unnamed-chunk-5-1.png" width="576" style="display: block; margin: auto;" />

Una retta che passa per il punto $(\bar{x}, \bar{y})$ ha la proprietà descritta di seguito.

Iniziamo a descrivere ciascuna osservazione inserita nel diagramma a dispersione con un'equazione:

$$
y_i = a + b x_i + e_i
$$
Le osservazioni $y$ sono `kid_score`. I primi 10 valori sono i seguenti:


```r
kidiq$kid_score[1:10]
#>  [1]  65  98  85  83 115  98  69 106 102  95
```

Per fare riferimento a ciascun valore usiamo l'indice $i$. Quindi, ad esempio, $y_3$ è uguale a


```r
kidiq$kid_score[3]
#> [1] 85
```

La variabile $x$, nel caso presente, è `mom_iq`. I primi 10 valori di $x$ sono


```r
kidiq$mom_iq[1:10]
#>  [1] 121.11753  89.36188 115.44316  99.44964  92.74571 107.90184 138.89311
#>  [8] 125.14512  81.61953  95.07307
```

In maniera corrispondente alla $y$, uso un indice per fare riferimento ai singoli valori della variabile. Ad esempio, $x_3$ è


```r
kidiq$mom_iq[3]
#> [1] 115.4432
```

L'equazione precedente ci dice che ciascun valore $y$ è dato dalla somma di due componenti: una componente deterministica e una componente aleatoria. Consideriamo il primo valore $y$.  Per esso diciamo che

$$
y_1 = a + b x_1 + e_1,
$$

laddove $a + b x_1$ è la componente deterministica, detta $\hat{y}$, e $e_1$ è la componente aleatoria.

La componente deterministica è, appunto, la componente di ciascun valore $y$ che possiamo prevedere conoscendo $x$.  Non possiamo prevedere perfettamente i valori $y$ -- ciò si verificherebbe soltanto se tutti punti del diagramma a dispersione fossero disposti su una retta. Ma non lo sono: la retta è solo un'approssimazione della relazione (lineare) tra $x$ e $y$. Pertanto, conoscendo $x$ possiamo solo prevedere una "componente" di ciascun valore $y$.

Cosa significa che possiamo prevedere una componente di ciascuna osservazione $y$? Significa che il valore $y$ osservato sarà dato dalla somma di due componenti: $y_i = \hat{y}_i + e_i$.

L'affermazione precedente solleva due domande:

- come possiamo trovare la quota della $y$ che può essere predetta conoscendo $x$?
- quant'è grande la porzione della $y$ che può essere predetta conoscendo $x$? In altre parole, conoscendo la $x$ è possibile predire $y$ con accuratezza oppure no?

Rispondere a tali due domanda definisce i primi due obiettivi del modello statistico della regressione lineare. Il terzo obiettivo è quello dell'inferenza, ovvero di capire che relazioni ci sono tra la relazione tra $x$ e $y$ osservata nel campione e la la relazione tra $x$ e $y$ nella popolazione.

## Stima dei coefficienti di regressione

Iniziamo con il primo obiettivo, ovvero quello di predire una frazione di ciascuna osservazione $y$ conoscendo $x$. Quindi, nel caso presente, ci chiediamo quanto segue.  Il primo bambino del campione ha un QI uguale a 65. Sua madre ha un QI di 121.12. Quanto bene riesco a predire il punteggio QI del bambino conoscendo quello di sua madre?

È chiaro, guardando i numeri, che non c'è una corrispondenza perfetta, tutt'altro! Infatti, se guardiamo il diagramma di dispersione ci rendiamo conto che i punti sono piuttosto lontani dalla retta che abbiamo usato per descrivere la relazione tra $x$ e $y$. Tuttavia, il diagramma di dispersione suggerisce che una qualche relazione c'è, seppur debole. Il nostro obiettivo è di descrivere una tale relazione.

Una tale relazione è descritta dalla componente deterministica che costituisce una frazione di ciascuna osservazione $y$. Abbiamo deciso di definire una tale componente "deterministica" $\hat{y}_i$ nei termini della seguente equazione: $\hat{y}_i = a_i + bx_i$.

L'equazione precedente è detta equazione lineare e, dal punto di vista geometrico, corrisponde ad una retta.  Ci sono infinite equazioni che potremmo usare per mettere in relazione $x$ e $y$. Abbiamo scelto questa perché è la più semplice. Se guardiamo il diagramma di dispersione, infatti, non ci sono ragioni per descrivere la relazione tra $x$ e $y$ con qualche curva, anziché con una retta. In altri campioni, una curva può essere più sensata di una retta, quale descrizione della relazione *media* tra $x$ e $y$, ma non nel caso presente. Ricordiamo il principio del rasoio di Occam (ovvero, il principio che sta alla base del pensiero scientifico moderno): se un modello semplice funziona, non c'è ragione di usare un modello più complesso.

Dunque, abbiamo capito che vogliamo descrivere la relazione media* tra $x$ e $y$ con una retta, ovvero, con l'equazione lineare

$$
\hat{y}_i = a + b x_i.
$$

L'equazione precedente indica che il modello lineare $a + b x_i$ *non è in grado di prevedere* il valore di ciascuna osservazione $y_i$. Questo, in generale, non è mai possibile (ovvero, è possibile solo in un caso specifico che, nella realtà empirica, non si verifica mai). 


L'equazione precedente ci dice che possiamo prevedere solo una frazione di ciascuna osservazione $y_i$, ovvero quella frazione che abbiamo denotato con $\hat{y}_i$. La componente che non possiamo prevedere con l'equazione $a + b x_i$ si denota con $e_i$.

In questo senso diciamo che *scomponiamo* il valore di ciascuna osservazione $y_i$ in due componenti: la componente deterministica (prevedibile conoscendo $x$) e la componente aleatoria (non prevedibile conoscendo $x$):

$$
y_i = \hat{y}_i + e_i. 
$$
 
 Il primo obiettivo del modello di regressione è quello di trovare i coefficienti dell'equazione
 
 $$
 a + b x_i
 $$

che consente di predire $\hat{y}_i$. Questi due coefficienti sono detti *coefficienti di regressione*.

Per trovare i coefficienti di regressione dobbiamo introdurre dei vincoli per limitare lo spazio delle possibili soluzioni.

Il primo vincolo lo abbiamo espresso prima: vogliamo che la retta $\hat{y}_i = a + b x_i$ passi per il punto $(\bar{x}, \bar{y})$. Il punto $(\bar{x}, \bar{y})$ corrisponde al *baricentro* del diagramma a dispersione.

Ci sono infinite rette che passano per i punto $(\bar{x}, \bar{y})$. Tutte queste rette soddisfano la seguente proprietà. Nel caso di qualsiasi retta passante per il punto $(\bar{x}, \bar{y})$ è vero che

$$
\sum_{i=1}^n e_i = 0.
$$

Dal punto di vista geometrico, la componente erratica del modello, $e_i$, corrisponde alla distanza verticale tra ciascun punto e la retta di regressione $a + bx$. Tale componente va sotto il nome di *residuo*:

$$
e_i = y_i - \hat{y}_i = y_i - (a + bx_i).
$$

L'affermazione precedente dice che la somma di tutte le distanze verticali (che hanno un segno positivo quando il punto è sopra la retta, e un segno negativo quando il punto è sotto la retta) tra le osservazioni e la retta di regressione (passante per il punto $(\bar{x}, \bar{y})$) è uguale a zero.

Questo significa che non possiamo selezionare una tra le infinite rette che passano per il punto $(\bar{x}, \bar{y})$ usando il criterio che ci porta a scegliere la retta che rende la più piccola possibile (ovvero, minimizza) la somma dei residui. Infatti, tutte le rette passanti per il punto $(\bar{x}, \bar{y})$ rendono uguale a zero la somma dei residui.

Dunque, dobbiamo trovare qualche altri criterio per scegliere tra le infinite rette che passano per il punto $(\bar{x}, \bar{y})$. Il criterio che viene normalmente scelto è quello di minimizzare la somma dei quadrati dei residui $(y_i - \hat{y}_i)^2$. In altri termini, vogliamo trovare i coefficienti $a$ e $b$ tali per cui la quantità

$$
\sum_{i=1}^{n}{(y_i - (a + b x_i))^2}
$$

assume il suo valore minimo. I coefficienti che hanno questa proprietà si chiamano *coefficienti dei minimi quadrati*.

Questo problema ha una soluzione analitica. La soluzione analitica si trova riconoscendo il fatto che l'equazione precedente definisce una superficie e il problema diventa quello di trovare il punto minore di questa superficie. Per trovare la soluzione ci si deve rendere conto che il punto di minimo è il punto della superficie nel quale la tangente alla superficie è piatta (ovvero uguale a zero). Rendere uguale a zero la tangente ad una superficie significa porre le derivate parziali rispetto alla direzione $x$ e alla direzione $y$ uguali a zero. Ponendo tali derivate parziali uguali a zero si definisce un sistema di equazioni lineari con due incognite, $a$ e $b$. La soluzione di tali equazioni, che si chiamano *equazioni normali*, è la seguente:

$$
a = \bar{y} - b \bar{x}
$$

$$
b = \frac{\mbox{Cov}(x, y)}{\mbox{Var}(x)}
$$

Le due precedenti equazioni corrispondono alla stima dei minimi quadrati dei coefficienti di regressione della retta che minimizza la somma dei quadrati dei residui.

Nel caso presente, tali coefficienti sono uguali a:


```r
b <- cov(kidiq$kid_score, kidiq$mom_iq) / var(kidiq$mom_iq)
b
#> [1] 0.6099746
```


```r
a <- mean(kidiq$kid_score) - b * mean(kidiq$mom_iq)
a
#> [1] 25.79978
```

In R li possiamo trovare con la seguente funzione:


```r
fm <- lm(kid_score ~ mom_iq, data = kidiq)
coef(fm)
#> (Intercept)      mom_iq 
#>  25.7997778   0.6099746
```

In precedenza abbiamo soltanto accennato al problema di come si possono trovano i coefficienti dei minimi quadrati; ritorneremo su questo punto in seguito. Per ora, chiediamoci cosa significano i due coefficienti che abbiamo calcolato.

Il coefficiente $a$ si chiama *intercetta*. L'intercetta, all'interno del diagramma a dispersione, specifica il punto in cui la retta di regressione interseca l'asse $y$ del sistema di assi cartesiani. 

Nel caso presente questo valore non è di alcun interesse, perché corrisponde al valore della retta di regressione quando $x = 0$, ovvero quando l'intelligenza della madre è uguale a 0. Vedremo in seguito come, trasformando i dati, è possibile assegnare al coefficiente $a$ un'interpretazione più utile. Per ora mi limito a fornire l'interpretazione del coefficiente.

Passando a $b$, possiamo dire che questo secondo coefficiente va sotto il nome di *pendenza* della retta di regressione. Ovvero ci dice di quanto aumenta (se $b$ è positivo) o diminuisce (se $b$ è negativo) la retta di regressione in corrispondenza di un aumento di 1 punto della variabile $x$.

Nel caso presente, il coefficiente $b$ ci dice che, se il QI delle madri aumenta di 1 punto, il QI dei bambini aumenta **in media** di 0.61 punti.

È importante capire cosa significa che, in base ai risultati della regressione, $y$ aumenta *in media* di $b$ punti per ciascun aumento unitario di $x$.  

Il modello statistico di regressione *ipotizza* che, per ciascun valore osservato $x$ (per esempio, il valore del QI della prima madre del campione, ovvero $x = 121.11753$) ci sia una distribuzione di valori $y$ nella popolazione, di cui solo uno è stato osservato nel campione. Possiamo facilmente capire che, se consideriamo tutte le madri con QI di 121.12, il punteggio del QI dei loro figli non sia costante, ma assuma tanti valori possibili. Questa distribuzione di valori possibili si chiama distribuzione $y$ condizionata a $x$, ovvero $p(y \mid x_i)$. 

Il modello statistico della regressione lineare non può in alcun modo prevedere il valore assunto da ciascuna delle possibili osservazioni che fanno parte della distribuzione $p(y \mid x_i)$. Il modello della regressione lineare ha un obiettivo più limitato, ovvero si propone di prevedere *le medie* delle distribuzioni $p(y \mid x_i)$ conoscendo i valori $x$.

Dunque, quando il coefficiente $b$ è uguale a 0.61, questo significa che il modello di regressione predice che *la medie* della distribuzione condizionata $p(y \mid x_i)$ aumenta di 0.61 punti se la variabile $x$ (QI delle madri) aumenta di un punto. Questo significa che il modello di regressione non fa una predizione sul punteggio di ciascun valore $y_i$ (in funzione di $x$), ma solo della media delle distribuzioni condizionate $p(y \mid x_i)$ di cui il valore osservato $y_i$ è una realizzazione casuale. 

Possiamo dire la stessa cosa con parole diverse dicendo che il modello di regressione fa delle predizioni sulla componente deterministica di ciascuna osservazione. È più semplice capire questo aspetto se rappresentiamo in maniera grafica la componente "deterministica" $\hat{y}_i = a + b x_i$ predetta dal modello di regressione.


```r
kidiq$yhat <- fm$fitted.values
kidiq %>% 
  ggplot(aes(x = mom_iq, y = yhat)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  geom_point(
    aes(x=mean(mom_iq), y=mean(kid_score)), 
    colour="red", size = 4
  )
```

<img src="052_reglin2_files/figure-html/unnamed-chunk-13-1.png" width="576" style="display: block; margin: auto;" />

Il diagramma precedente presenta ciascun valore $\hat{y}_i = a + b x_i$ in funzione di $x_i$. Si vede che i valori predetti dal modello di regressione sono i punti che stanno sulla retta di regressione. Dunque, il residuo, ovvero la componente di ciascuna osservazione $y_i$ che non viene predetta dal modello di regressione corrisponde alla distanza verticale tra i punti del diagramma a dispersione e la retta di regressione

$$
e_i = y_i - (a + b x_i).
$$

Nel caso nella prima osservazione, ad esempio abbiamo:

$$
y_1 = (a + b x_1) + e_1
$$

Abbiamo


```r
kidiq$kid_score[1]
#> [1] 65
```

Dunque

$$
e_1 = (a + b x_1) - y_1
$$

```r
e_1 <- kidiq$kid_score[1] - (a + b * kidiq$mom_iq[1])
e_1
#> [1] -34.67839
```

Ciò significa che il valore osservato $y_1 = 65$ viene scomposto dal modello di regressione in due componenti. La componente deterministica $\hat{y}_1$, predicibile da $x_1$, è


```r
yhat_1 <- a + b * kidiq$mom_iq[1]
yhat_1
#> [1] 99.67839
```

La somma della componente deterministica e della componente erratica, ovviamente, riproduce il valore osservato.


```r
yhat_1 + e_1
#> [1] 65
```

### Trasformazione dei dati

Consideriamo ora i dati $y$ espressi come differenze dalla media:


```r
kidiq$xd <- kidiq$mom_iq - mean(kidiq$mom_iq)
```

Il diagramma a dispersione diventa il seguente.



```r
kidiq %>% 
  ggplot(aes(x = xd, y = kid_score)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  geom_point(
    aes(x=mean(xd), y=mean(kid_score)), 
    colour="red", size = 4
  )
```

<img src="052_reglin2_files/figure-html/unnamed-chunk-19-1.png" width="576" style="display: block; margin: auto;" />

Nel diagramma precedente, la pendenza della retta di regressione è uguale alla precedente, ma in questo grafico all'intercetta può essere assegnata un'interpretazione dotata di senso.


```r
fm1 <- lm(kid_score ~ xd, data = kidiq)
coef(fm1)
#> (Intercept)          xd 
#>  86.7972350   0.6099746
```

Nel caso di dati così trasformati, l'intercetta è sempre il punto sull'asse $y$ dove la retta di regressione interseca l'ordinata. Ma, in questo caso, dato che abbiamo traslato i dati di una quantità pari a $x - \bar{x}$, il valore $x = 0$ corrisponde al valore $\bar{x}$ nel caso dei dati grezzi.  Dunque, l'intercetta avrà la seguente interpretazione:

nel caso di dati nei quali $x$ è espresso come differenze dalla media, l'intercetta corrisponde al valore atteso della $y$ in corrispondenza di $\bar{x}$. 

In altre parole, per i dati così trasformati, l'intercetta corrisponde al QI atteso (ovvero, medio) dei bambini in corrispondenza del QI medio delle madri.

### Il metodo dei minimi quadrati

Ora che abbiamo visto come interpretare il coefficienti di regressione, chiediamoci come vengono calcolati.  

La procedura generale è stata brevemente descritta in precedenza.  Vediamo ora come si giunge alla stessa conclusione usando una simulazione.

Il problema è di trovare i valori $a$ e $b$ tali per cui la quantità $\sum_{i=1}^{n}{(y_i - (a + b x_i))^2}$ assume il valore minore possibile. Questo è un problema di minimizzazione rispetto a due parametri. Per dare un'idea di come si fa, semplifichiamo il problema e supponiamo che uno dei due parametri sia noto, ad esempio $a$, così ci resta una sola incognita.

Credo una griglia di valori `b_grid` possibili, ad esempio:


```r
nrep <- 1e5
b_grid <- seq(0, 1, length.out = nrep)
```

Definisco una funzione che calcola la quantità $\sum_{i=1}^{n}{(y_i - (a + b x_i))^2}$:


```r
sse <- function(a, b, x, y) {
  sum((y - (a + b * x))^2)
}
```

Calcolo la somma degli errori quadratici per ciascun possibile valore `b_grid`, fissando $a = 25.79978$.


```r
sse_res <- rep(NA, nrep)
for (i in 1:nrep) {
  sse_res[i] <- sse(a = 25.79978, b = b_grid[i], x = kidiq$mom_iq, y = kidiq$kid_score)
}
```

Esaminiamo il risultato ottenuto.


```r
plot(
  b_grid, sse_res, type = 'l'
)
```

<img src="052_reglin2_files/figure-html/unnamed-chunk-24-1.png" width="576" style="display: block; margin: auto;" />

Il risultato ottenuto con la simulazione


```r
b_grid[which.min(sse_res)]
#> [1] 0.6099761
```

riproduce quello ottenuto per via analitica:


```r
b
#> [1] 0.6099746
```

Una simulazione simile, ma computazionalmente più complessa, può essere usata per stimare simultaneamente entrambi i parametri. Ci siamo limitati qui ad una *proof of concept* del caso più semplice.


### Il coefficiente di determinazione

Il secondo obiettivo del modello statistico di regressione lineare è quello di stabilire *quanto sia grande, in termini proporzionali, la componente $y$ predicibile da $x$, per  ciascuna osservazione*. 

Un indice assoluto della bontà di adattamento è fornito dalla deviazione standard dei residui, $s_e$, chiamata anche *errore standard della stima*. Uno stimatore non distorto della varianza dei residui nella popolazione è dato da

$$
s^2_e = \frac{\sum e_i^2}{n-2}
$$

e quindi l'errore standard della stima sarà

\begin{equation}
s_e = \sqrt{\frac{\sum e_i^2}{n-2}}.
\end{equation}

Si noti che questa è la stessa formula della varianza (dato che la media dei residui è zero), tranne per il fatto che al denominatore abbiamo $n-2$. Dato che, per calcolare $\hat{y}$ abbiamo usato due coefficienti ($a$ e $b$), si dice che "abbiamo perso due gradi di libertà".

Dato che $s_e$ possiede la stessa unità di misura della variabile $y$, l'errore standard della stima può essere considerato come una sorta di "residuo medio." -- usando la stessa interpretazione che diamo alla deviazione standard in generale. 

Si noti che la formula precedente non fornisce la "deviazione standard dei residui nel campione" (quella formula avrebbe $n$ al denominatore). Invece, fornisce una *stima* della deviazione standard dei residui nella popolazione da cui il campione è stato estratto.

Verifichiamo quanto detto con i dati a disposizione.

I residui possono essere trovati nel modo seguente.


```r
e <- kidiq$kid_score - (a + b * kidiq$mom_iq)
e[1:10]
#>  [1] -34.678390  17.691747 -11.217173  -3.461529  32.627697   6.382845
#>  [7] -41.521041   3.864881  26.414387  11.208068
```

Oppure nel modo seguente.


```r
fm$residuals[1:10]
#>          1          2          3          4          5          6          7 
#> -34.678390  17.691747 -11.217173  -3.461529  32.627697   6.382845 -41.521041 
#>          8          9         10 
#>   3.864881  26.414387  11.208068
```

Calcolo il residuo medio, prendendo il valore assoluto.


```r
mean(abs(e))
#> [1] 14.4686
```

L'errore standard della regressione è


```r
sqrt(sum(e^2) / (length(e) - 2))
#> [1] 18.26612
```

I due numeri non sono uguali, ma possiamo dire che hanno lo stesso ordine di grandezza.

Se usiamo la funzione `lm()` otteniamo lo stesso valore, chiamato `Residual standard error`.


```r
summary(fm)
#> 
#> Call:
#> lm(formula = kid_score ~ mom_iq, data = kidiq)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -56.753 -12.074   2.217  11.710  47.691 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 25.79978    5.91741    4.36 1.63e-05 ***
#> mom_iq       0.60997    0.05852   10.42  < 2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 18.27 on 432 degrees of freedom
#> Multiple R-squared:  0.201,	Adjusted R-squared:  0.1991 
#> F-statistic: 108.6 on 1 and 432 DF,  p-value: < 2.2e-16
```

## Indice di determinazione

Un importante risultato dei minimi quadrati riguarda la cosiddetta *scomposizione della devianza* mediante la quale si definisce l'indice di determinazione, il quale fornisce una misura relativa della bontà di adattamento del modello di regressione ai dati del campione. Per una generica osservazione $x_i, y_i$, la variazione di $y_i$ rispetto alla media $\bar{y}$ può essere descritta come la somma di due componenti: il residuo $e_i=y_i- \hat{y}_i$ e lo scarto di $\hat{y}_i$ rispetto alla media $\bar{y}$:

$$
y_i - \bar{y} = (y_i- \hat{y}_i) + (\hat{y}_i - \bar{y}) = e_i + (\hat{y}_i - \bar{y}).
$$

Se consideriamo tutte le osservazioni, la devianza delle $y$ può essere scomposta nel seguente modo:

\begin{align}
 \sum (y_i - \bar{y})^2 &= \sum \left[ e_i + (\hat{y}_i - \bar{y})
 \right]^2 
 = \sum e_i^2 + \sum (\hat{y}_i - \bar{y})^2 + 2 \sum e_i (\hat{y}_i -
 \bar{y}) \notag
\end{align}

Per i vincoli imposti sul modello statistico di regressione, il doppio prodotto si annulla, infatti

\begin{align}
\sum e_i (\hat{y}_i - \bar{y}) &= \sum e_i \hat{y}_i - \bar{y}\sum e_i = \sum e_i (a + b x_i) \notag \\
&= a \sum e_i + b \sum e_i x_i = 0 \notag
\end{align}

Il termine $b \sum e_i x_i$ è uguale a zero perché, come vedremo in seguito, i coefficienti di regressione vengono calcolati in modo tale da rendere nulla $\mbox{Cov}(e, x)$. Di conseguenza, il termine precedente deve essere nullo.

Possiamo dunque concludere che la devianza totale ($\mbox{dev}_T$) si scompone nella somma di devianza d'errore (o devianza non spiegata) ($\mbox{dev}_E$) e devianza di regressione (o devianza spiegata) ($\mbox{dev}_T$):

\begin{align}
\underbrace{\sum_{i=1}^n (y_i - \bar{y})^2}_{\tiny{\text{Devianza
totale}}} &= \underbrace{\sum_{i=1}^n e_i^2}_{\tiny{\text{Devianza
di dispersione}}} + \underbrace{\sum_{i=1}^n  (\hat{y}_i -
\bar{y})^2}_{\tiny{\text{Devianza di regressione}}} \notag
\end{align}

La devianza di regressione, $\mbox{dev_R} \triangleq \mbox{dev_T} - \mbox{dev_E}$, indica dunque la riduzione degli errori al quadrato che è imputabile alla regressione lineare. Il rapporto $\mbox{dev_R}/\mbox{dev_T}$, detto \emph{indice di determinazione}, esprime tale riduzione degli errori in termini proporzionali e definisce il coefficiente di correlazione al quadrato:

\begin{equation}
R^2 \triangleq \frac{\mbox{dev_R}}{\mbox{dev_T}} = 1 - \frac{\mbox{dev_E}}{\mbox{dev_T}}.
\end{equation}

Quando l'insieme di tutte le deviazioni della $y$ dalla media è spiegato dall'insieme di tutte le deviazioni della variabile teorica $\hat{y}$ dalla media, si ha che l'adattamento (o accostamento) del modello al campione di dati è perfetto, la
devianza residua è nulla ed $r^2 = 1$; nel caso opposto, la variabilità totale coincide con quella residua, per cui $r^2 = 0$. 
Tra questi due estremi, $r$ indica l'intensità della relazione lineare tra le due variabili e $r^2$, con $0 \leq r^2 \leq 1$, esprime la porzione della devianza totale della $y$ che è spiegata dalla regressione lineare sulla $x$.

Per l'esempio in discussione abbiamo quanto segue. La devianza totale è


```r
dev_t <- sum((kidiq$kid_score - mean(kidiq$kid_score))^2)
dev_t
#> [1] 180386.2
```

La devianza spiegata è


```r
dev_r <- sum((fm$fitted.values - mean(kidiq$kid_score))^2)
dev_r
#> [1] 36248.82
```

L'indice di determinazione è


```r
R2 <- dev_r / dev_t
R2
#> [1] 0.2009512
```

Nell'output di `lm()` un tale valore è chiamato `Multiple R-squared`. 


```r
summary(fm)
#> 
#> Call:
#> lm(formula = kid_score ~ mom_iq, data = kidiq)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -56.753 -12.074   2.217  11.710  47.691 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 25.79978    5.91741    4.36 1.63e-05 ***
#> mom_iq       0.60997    0.05852   10.42  < 2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 18.27 on 432 degrees of freedom
#> Multiple R-squared:  0.201,	Adjusted R-squared:  0.1991 
#> F-statistic: 108.6 on 1 and 432 DF,  p-value: < 2.2e-16
```

Il risultato ottenuto si può interpretare dicendo che circa il 20% della variabilità dei punteggi del QI dei bambini può essere predetto conoscendo il QI delle madri.

### Inferenza sul modello di regressione

La discussione precedente era tutta basata sulla trattazione "classica" del modello lineare, ovvero una trattazione basata sulle stime di massima verosimiglianza (se $y \sim \mathcal{N}(\alpha + \beta x, \sigma)$, allora le stime dei minimi quadrati coincidono con le stime di massima verosimiglianza). In altre parole, nella discussione precedente non abbiamo considerato in alcun modo le distribuzioni a priori dei parametri $\alpha$ e $\beta$. In altre parole, i risultati precedenti si confermano, in un contesto bayesiano, se e solo se imponiamo sui parametri delle distribuzioni a priori non informative (cioè, uniformi). In tali circostanze, le stime di massima verosimiglianza sono identiche al massimo a posteriori bayesiano.

Detto questo, il tema dell'inferenza viene trattato dall'approccio frequentista costruendo la "distribuzione campionaria" dei parametri (ovvero la distribuzione dei valori che i parametri otterrebbero in infiniti campioni casuali ($x, y$) di ampiezza $n$ estratti dalla medesima popolazione) e poi calcolando gli errori standard dei parametri e gli intervalli di fiducia dei parametri. Una domanda frequente è, per esempio, se la pendenza della retta di regressione sia maggiore di zero.  Per rispondere a tale domanda l'approccio frequentista calcola l'intervallo di fiducia al 95% per il parametro $\beta$. Se tale intervallo non include lo zero, e se il limite inferiore di tale intervallo è maggiore di zero, allora si conclude, con un grado di confidenza del 95%, che il vero parametro $\beta$ nella popolazione è maggiore di zero. Ovvero, si conclude che vi sono evidenze di un'associazione lineare positiva tra $x$ e $y$.

Alla stessa conclusione si può arrivare calcolando, in un ottica bayesiana, l'intervallo di credibilità al 95% per il parametro $\beta$.  I due intervalli sono identici se usiamo una distribuzione a priori piatta. Sono invece diversi se usiamo una distribuzione a priori debolmente informativa, oppure informativa. 

Solitamente si usa una distribuzione a priori debolmente informativa centrata sullo zero. In tali circostanze, l'uso della distribuzione a priori ha solo un effetto di *regolarizzazione*, ovvero di riduzione del peso delle osservazioni estreme -- un tale risultato statistico è molto desiderabile, ma è difficile da ottenere in un contesto frequentista. Vedremo nel prossimo capitolo come può essere svolta l'inferenza sui coefficienti del modello di regressione lineare in un contesto bayesiano.


## Commenti e considerazioni finali {-}

Il modello lineare semplice viene usato per descrivere la relazione tra due variabili e per determinare il segno e l'intensità di tale relazione. Inoltre, il modello lineare ci consente di prevedere il valore della variabile dipendente in base al valore assunto dalla variabile indipendente. 


