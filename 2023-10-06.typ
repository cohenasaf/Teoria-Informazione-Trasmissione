#import "@preview/tablex:0.0.5": tablex

= Introduzione

== Storia

La teoria dell'informazione nasce nel 1948 grazie a *Claude Shannon* (1916-2001), un impiegato alla "Telecom" americana al quale sono stati commissionati due lavori: data una comunicazione su filo di rame, si voleva sfruttare tutta la capacità del canale, ma al tempo stesso coreggere gli errori di trasmissione dovuti al rumore presente.

Nel 1948 infatti viene pubblicato l'articolo "_A Mathematical Theory of Communication_" da parte di Bell Labs, dove Shannon pone le basi della teoria dell'informazione.

Ma non è l'unico personaggio che lavora in questo ambito: infatti, nel 1965, tre matematici russi pubblicano degli articoli che vanno a perfezionare il lavoro fatto anni prima da Shannon.

I tre matematici sono Gregory Chaitin (1947-), Ray Solomonoff (1926-2009) e *Andrey Kolmogorov* (1903-1987), ma si considerano solo gli articoli di quest'ultimo poiché ai tempi era molto più famoso dei primi due.

== Shannon vs Kolmogorov

La situazione generica che troveremo in quasi la totalità dei nostri studi si può ridurre alla comunicazione tra due entità tramite un *canale affetto da rumore*.

#v(12pt)

#figure(
    image("assets/canale.svg", width: 50%)
)

#v(12pt)

Quello che distingue Shannon da Kolmogorov è l'approccio: il primo propone un *approccio ingegneristico*, ovvero tramite un modello formato da una distribuzione di probabilità si va a definire cosa fa _in media_ la sorgente, mentre il secondo propone un *approccio rigoroso e formale*, dove sparisce la nozione di media e si introduce la nozione di sorgente in modo _puntuale_.

In poche parole, dato un messaggio da comprimere:
- Shannon direbbe "lo comprimo _in media_ così, e lo comprimerei così anche se il messaggio fosse totalmente diverso";
- Kolmogorov direbbe "lo comprimo _esattamente_ così, ma lo comprimerei in modo totalmente diverso se il messaggio fosse diverso".

== Obiettivi di Shannon

Gli obiettivi che Shannon vuole perseguire sono due:
- *massimizzare* l'informazione trasmessa _ad ogni utilizzo del canale_;
- *minimizzare* il numero di errori di trasmissione dovuti alla presenza del rumore nel canale.

La parte "_ad ogni utilizzo del canale_" viene inserita per dire che, ogni volta che si accede al canale, deve essere utilizzato tutto, mentre senza questa parte una sorgente potrebbe mandare l'1% del messaggio ad ogni accesso al canale, mandandolo sì tutto ma senza sfruttare a pieno la banda.

Shannon risolverà questi due problemi con due importantissimi teoremi:
- *$I$° teorema di Shannon*, che riguarda la _source coding_, ovvero la ricerca di un codice per rappresentare i messaggi della sorgente che massimizzi l'informazione spedita sul canale, ovvero massimizzi la sua *compressione*;
- *$\I\I$° teorema di Shannon*, che riguarda la _channel coding_, ovvero la ricerca di un codice per rappresentare i messaggi della sorgente che minimizzi gli errori di trasmissione dovuti alla presenza del rumore nel canale.

L'approccio che viene usato è quello _divide-et-impera_, che in questo caso riesce a funzionare bene e riesce ad unire i risultati dei due teoremi di Shannon grazie al *teorema di codifica congiunta sorgente-canale* e ad alcune relazioni che legano i due problemi descritti.

In un caso generale del _divide-et-impera_ si ricade in una soluzione sub-ottimale.

== Primo teorema di Shannon

Il primo problema da risolvere è il seguente: come è distribuita l'informazione all'interno di un documento?

Vediamo due esempi dove un documento viene spedito su un canale e alcune informazioni vengono perse per colpa del rumore presente nel canale.

#v(12pt)

#figure(
    image("assets/poca-informazione.svg", width: 75%)
)

#v(12pt)

In questo primo esempio notiamo che, nonostante l'informazione persa sia sostanziosa, possiamo in qualche modo "risalire" a quello perso per via delle informazioni che troviamo "nelle vicinanze".

#v(12pt)

#figure(
    image("assets/tanta-informazione.svg", width: 75%)
)

#v(12pt)

In questo secondo esempio notiamo invece che, nonostante l'informazione persa sia molto meno rispetto a quella precedente, "risalire" al contenuto perso è molto più difficile.

Questi due esempi dimostrano come l'informazione contenuta in un documento *non* è uniforme, e quindi che una distorsione maggiore non implica una perdita maggiore di informazioni.

L'obiettivo del primo teorema di Shannon è eliminare le informazioni inutili e ridondanti, comprimendo il messaggio per poter utilizzare il canale per inviare altre informazioni.

Quello che facciamo è concentrare l'informazione, rendendola *equamente distribuita*, quindi impossibile da ridurre ancora e contenente solo informazioni importanti.

== Secondo teorema di Shannon

Il secondo teorema di Shannon è quello più rognoso, perchè si occupa della _channel coding_, ovvero di una codifica che permetta di minimizzare l'informazione persa durante la trasmissione.

Vogliamo questo perchè l'informazione che passa sul canale è compressa, quindi qualsiasi bit perso ci fa perdere molte informazioni, non essendoci ridondanza.

Quello che viene fatto quindi è aggiungere *ridondanza*, ovvero più copie delle informazioni da spedire così che, anche perdendo un bit di informazione, lo si possa recuperare usando una delle copie inviate.

La ridondanza che aggiungiamo però è *controllata*, ovvero in base al livello di distorsione del canale utilizzato si inviano un certo numero di copie.

In un *canale ideale* la ridondanza è pari a 0, mentre per canali con rumore viene usata una matrice stocastica, che rappresenta la distribuzione probabilistica degli errori.

#align(center)[
    #table(
        align: center + horizon,
        columns: (7%, 7%, 7%, 7%, 7%, 7%),
        inset: 10pt,

        [], [a], [b], [c], [d], [e],
        [a], [0.7], [0.0], [0.1], [0.1], [0.1],
        [b], [...], [...], [...], [...], [...],
        [c], [...], [...], [...], [...], [...],
        [d], [...], [...], [...], [...], [...],
        [e], [...], [...], [...], [...], [...]
    )
]

Ogni riga $i$ rappresenta una distribuzione di probabilità che definisce la probabilità che, spedito il carattere $i$, si ottenga uno dei valori $j$ presenti nelle colonne.

Se il canale è ideale la matrice risultante è la matrice identità.
