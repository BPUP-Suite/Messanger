# Messanger (TBC)

App di messagistica in tempo reale sviluppato con tools come Flutter e Android Studio.

Supporta Android, iOS, Windows, MacOS, Linux ed è utilizzabile anche sul web. (IN TEORIA, stiamo ancora lavorando a quella per android, QUINDI CALMA)

Server hostato su docker in questa REPO (Metti il link alla repo che io non ho voglia :D)

Timeline:

25/09/2024

- Creazione della repository
- Creazione progetto su Android Studio e aggiunta del plugin di Flutter (dopo 15 crash da parte dell'IDE e 3 errori da parte mia {SOD} )
- Creazione repo dell`API utilizzata come server database e accesso dei dati
- Capito (in parte, piccolissima parte) come funziona postgresql (anche se non so quanto sia performante un relazionare in un`applicazione del genere, ma va bene lo stesso per sto progettino stupido) e implementato (almeno l'init del database) all'interno di una classe python
- Utilizzo di uno strumento semplice per hostare le API (FastAPI su python), per ora c'é solo il main con le due righe default ma va bene lo stesso
- {MM} che si guarda 3^4535 tutorial diversi perchè non capisce come *acciderbolina* si fa la qualsiasi cosa su Flutter
- Sistemazione del progetto in diverse folder all`interno della cartella lib/ per iniziare a capirci qualcosa e renderlo quanto più possibile comprensibile e scalabile, riducendo anche la possibile necessità di fare un refactor dell'intera pagine che mi farebbe diventare estremamente triste

26/09/2024

- Continui lavori di sviluppo al database che è *quasi* completamente sviluppato, e intanto mi meraviglio alla complessità del database di telegram, mentre piango :D
- {MM} continua a guardare altri 23^54 tutorial
- {MM} riesce a fare qualcosa di funzionante che ti porta dalla pagina principale a una dove ti chiede il numero di telefono (peccato che abbia messo un text field e niente form quindi non va niente)
- Mi ha dato il rimborso di star citizen, posso comprare la Mustang
- Fanculo sto progetto (per ora) si deve conquistare lo spazio
- {MM} scopre la possibilità di poter debuggare il progetto da un suo *PERSONAL* device, ed è estremamente contento 

27/09/2024 - 29/09/2024

- Tryhard su Star Citizen con rari casi di modifica al progetto

30/09/2024

- Me so rotto il cazo di SC, refund e continuo progetto
- Database migliorato, aggiunta la possibilità di far partire il progetto tramite Docker (necessario per hostare database, proxy, dbadmin, api facilmente)
- {MM} Migliora la grafica tantizzimo aggiungendo chat, bottoncini maaaagici, lista di chat figa, un menu ad hambuger (o 3 linee in alto a sinistra)
- {MM} ha iniziato a fare troppi bambini e non si capisc nu caz, quindi si sistema l`intero tree delle directory dandogli un po' di senso (sia per l'API, che per il client)
- Primi test di build android + windows + web (e funzionano abbastanza bene) {MM} contento (MacOS e iOS no perchè {EB} è strunz :D)
- TODO: usare telegram come storage dei file più grossi (da pensare un file system per collegare ad ogni file un file_id di telegram, tramite un bot + una local api)

01/10/2024

- Nuovo mese, inizia l'università e piango
- Ho finalmente {SOD} finito l'API per la sezione login,signup e access con hash della password, generazione di un API key utilizzata per l'accesso alle proprie risorse e tante belle cosine
- Ho configurato anche Nginx Proxy Manager e Cloudflare DNS insieme ad un serverino di Oracle Cloud (sia lodato il cielo e il tuo indirizzo IPv4 statico che io banana gigantesca son sotto CG-NAT, grazie Virgin Fibra(e no, non me lo danno l'IPv6 e col caxo che pago 4 euro al mese per avere un indirizzo inutile))
- L'API (dopo tanti fix perchè non so scrivere Dockerfile in modo consistente :( ) funziona ed è operativa :D
- {MM} e io {SOD} abbiamo finalmente iniziato a collaborare (urlando uno addosso all'altro :D) ma abbiamo collegato il client al server permettendo l'access (in pratica il processo che indentifica se un determinato utente è già registrato o meno portandoti alla specifica pagina), il signup e il login (che da come errore UNPROCESSABLE ENTITY dal server nei log, AIUTO COSA VUOL DIRE, però almeno sappiamo che errore è solo che ormai sono le 00:48 del 02/10/2024 e non ho voglia, sia lodato io che ho pensato di fare un logger di tutte le query e richieste API :D)
- Buonanotte 😴
