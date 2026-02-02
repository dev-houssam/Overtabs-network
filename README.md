# Overtabs-network
Overtabs network is an overred network allowing to make communications between severals tabs across/from differents origins in all browsers. 

Un onglet doit implementer et instancier un Overtabs puis doit se connecter à d'autres onglet en indiquant des informations de configurations qui permettront d'identifier de maniere unique un onglet.
On pourra créer un système d'adressage pour les onglets qui permettront de reconnaitre la localisation des cluster ou de ses onglets. La possibilité d'indiquer un ou plusieur certificats est envisageable, et dans ce cas-ci, le serveur du site web sera l'acteur de confiance et sera utilisé pour initier le protocole Overtabs.

# Le protocole Overtabs

Un ou plusieurs onglets doivent suivre une politique et un mécanisme pour établir une communication sécurisé entre eux.

Overtabs est un tunnel-labyrinthe par conception pour lutter contre la divulgation des données donc par défaut aucun acteur ne peut intercepter ce qui s'y passe, sinon le labyrinthe se résout.
Overtabs utilise un mutex distribué.

# Packet mutéxé distribué
Les Packets mutéxés distribués sont stupéfiant. En effet, un packet est chiffré, dans son contenu, mais il existe un ordre pour recevoir, un mecanisme de demutexation, et un mecanisme de dépacketage permettant enfin de déchiffrer les données au niveau Overtabs puis le navigateur va enfin déchiffrer au niveau https et le navigateur pourra enfin lire la donnée.

# Tunnel-labyrinthe

un tunnel-labyrinthe permet à tout attaquant de voir la présence de circulation mais pousse la machine à trouver toutes les solutions de manière exponentielles. La détection d'un traitement à forte complexité permet de detecter les attaques.
Une bonne connexion via Overtabs utilise le tunnel-labyrinthe avec un gradient dirigée, ce qui permet d'atteindre plus facilement son destinataire. Mais le destinataire n'est pas connu au début, le gradient est un chemin permettant de calculer
de manière vectoriel le chemin vers le destinataire et le chemin le plus court vers ce destinataire. L'inclusion du gradient permet d'ajouter un flou dans le tunnel-labyrinthe. Utile uniquement pour certification et assurer la confiance.

# Avantages

Overtabs peut être utiliser avec n'importe quels utilisateurs, clients, sites. Cela permet un maximum de partage pour interfacer les onglets de manière efficace. 

# Un scénario ? simple ?

```js
class Overtabs{}

const ov = new Overtabs();
ov.setSource(ov.sameDomain());
ov.setDestinataire("https://stack-antislash.net", ov.localBrowser());
ov.acceptCert(ov.sameServer());
ov.executionMode(ov.realtimeMode());

ov.oncalled = function(ev){
  console.log(`I am here ${ev}`);
}
ov.onreceive = function(tabs){
  tabs.foreach((e)=>{
    console.log(`I am here ${e}`);
  });
  console.log(`I am here ${ev}`);
}

ov.onconnected = function(ev){
  console.log(`I am connected here ${ev}`);
}

ov.ondestroyed = function(ev){
  console.log(`Destroying... now ${ev}`);
}

ov.sendMessage = function(callback, data){
  console.log(`I am here ${ev}`);
  callback(data);
}

```
