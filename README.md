## Étapes préliminaires

Installer le client IRC irssi ( = client de référence) :

```bash
sudo apt install irssi
```

Installer les fichiers de développement OpenSSL : 

```bash
sudo apt-get install libssl-dev
```

## Correction

Checklist questions :

https://github.com/mharriso/school21-checklists/blob/master/ng_5_ft_irc.pdf

### Basic checks

**Fonction poll()**

La fonction poll() est utilisée une seule fois, dans le fichier Application.cpp

Cette fonction est utilisée pour surveiller plusieurs descripteurs de fichiers afin de déterminer s'ils sont prêts à être lus, écrits ou s'ils ont des exceptions à signaler. Elle sert principalement pour les opérations d'entrée/sortie non bloquantes, lorsqu’on ne souhaite pas que le programme se bloque en attendant que des données soient disponibles.

Fonctionnement : 

- Initialisation de la structure pollfd : pour spécifier les descripteurs de fichiers à surveiller ainsi que les événements pour chaque descripteur.
- Appel de poll() : en passant à la fonction le tableau de structures pollfd ainsi que le nombre total de structures à surveiller.
- Attente de l'événement : poll() examine chaque fd et vérifie s'il y a des données à lire (POLLIN), s'il est prêt à être écrit (POLLOUT), ou s'il y a des exceptions (POLLERR, POLLHUP, etc.).
- Traitement des événements : parcours du tableau de structures pollfd pour voir quels descripteurs de fichiers ont des événements prêts, et actions adaptées, par exemple, lire ou écrire des données.
- Gestion des erreurs : notamment les erreurs systèmes

**Fonction fcntl()**

Permet de rendre les sockets non bloquants (par défaut les fd crée par l’appel système socket() fonctionne en mode bloquant). Cela permet d’empêcher les fonctions bloquantes telles que read/recv, write/send, accept qui par défaut suspendre le programme le temps de leur exécution : si ces fonctions n’ont rien à lire, alors elles renvoient juste un code d’erreur -1 et le programme continue de boucler sur les autres sockets.

### Networking

Compiler le projet avec make dans un terminal. Pour lancer le serveur :

```bash
./ircserv <port> <password>
#./ircserv 6667 mdp
```

Le serveur est alors en mode écoute. 

**Premiers tests avec NetCat :** 

Pour se connecter au serveur avec ‘nc’ (NetCat), ouvrir un 2nd terminal : 

```bash
nc -C localhost <server_port>
#nc -C localhost 6667
```

S’authentifier avec les trois commandes suivantes :

```bash
PASS <server_password>
USER <user> <mode(unused)> <host(unused> <realname>
NICK <nickname>
#PASS mdp
#USER john 0 0 JohnSmith
#NICK johny
```

Tester quelques commandes simples du type : 

`INFO` : affiche les informations du serveur : 

`NAMES` : affiche les utilisateurs

Créer un canal (revient que même que rejoindre un canal qui n’existe pas encore) : `JOIN`

```bash
JOIN <#nom_du_canal>
#JOIN #canal_test
```

Pour vérifier que les messages envoyés par un utilisateurs d’un canal est transmis aux autres utilisateurs, on peut connecter un 2ème client au serveur IRC. 

Pour cela, ouvrir un 3ème terminal et s’authentifier comme précédemment. Exemple : 

```bash
PASS mdp
USER Jane 0 0 JaneWhite
NICK jany
```

Pour que Jane rejoindre le canal_test :

```bash
JOIN #canal_test
```

Ecrire un message dans le terminal de John ou Jane et vérifier qu’il est bien transmis.

**Tests avec IRSSI (client de référence) :**

Ouvrir un nouveau terminal et lancer irssi en tapant `irssi`

Connexion au serveur : 

```bash
/connect localhost <server_port> <server_password>
#/connect localhost 6667 mdp
```

Effectuer les mêmes tests que précédemment, mais ajouter un / avant chaque commande et retirer le # avant chaque canal. Exemple : 

```bash
/JOIN canal_test
```

### Networking specials

Pour tuer un client : Ctrl + C

### Clients commands

Pour vérifier `PRIVMSG` et `NOTICE` , lancer 3 clients via ‘nc’ puis irssi puis taper la commande :

```bash
PRIVMSG JohnDoe "coucou"
```

**Commandes d’operators :** 

Ouvrir 3 clients A B C et tester les commandes suivantes. 

`TOPIC` : change ou affiche le sujet du canal

```bash
TOPIC <channel_name> <message>
```

`KICK` : éjecte un utilisateur

```bash
KICK <nick_name> <channel_name>
```

Vérifier avec `NAMES` si besoin.

`INVITE` : invite un utilisateur

```bash
INVITE <nick_name> <channel_name>
```

Une fois l’utilisateur invité, celui-ci doit utiliser la commande `JOIN` pour rejoindre le canal.

**MODE option i**

`MODE` `<#nom du canal>` `+i` : les utilisateurs peuvent rejoindre le canal sur invitation seulement

→ tester en kickant un client et essayer de rejoindre sans invitation

`MODE` `<#nom du canal>` `-i` :  les utilisateurs peuvent rejoindre le canal sur invitation seulement

→ réessayer de rejoindre : ok 

Essayer cette commande avec un client non operator → génère un message d’erreur

**MODE option k**

`MODE` `<#nom du canal>` `+k` `password`: les utilisateurs doivent entrer un mot de passe pour rejoindre le canal. 

→ tester en faisant un JOIN <nom_du_canal> <password>

`MODE` `<#nom du canal>` `-k` : plus besoin de mot de passe

Essayer cette commande avec un client non operator → génère un message d’erreur

**MODE option l**

`MODE` `<#nom du canal>` `+l 5`: pas plus de 5 utilisateurs sur le canal

`MODE` `<#nom du canal>` `-l` : plus de restrictions sur le nombre d’utilisateurs

**MODE option o**

`MODE` `<#nom du canal>` `+o` `<username>` : donne les privilèges d’operator à username

`MODE` `<#nom du canal>` `-o` `<username>` : retire les privilèges d’operator à username

**MODE option t**

`MODE` `<#nom du canal>` `+t` : les non operators peuvent désormais changer le topic
