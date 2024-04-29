# 42-ft_irc

## Étapes préliminaires

Installer le client IRC irssi ( = client de référence) :

```bash
sudo apt install irssi
```

Installer les fichiers de développement OpenSSL : 

```bash
sudo apt-get install libssl-dev
```

## Utilisation

Cloner répertoire et y entrer avec `cd` .

Pour compiler, utiliser `make`.

Pour lancer le serveur : 

```bash
./ircserv <port> <password>
#./ircserv 6667 mdp
```

## Connexion au serveur via IRSSI

Dans un autre terminal, lancer IRSSI via la commande `irssi`

Se connecter au serveur : 

```bash
/connect localhost <server_port> <server_password>
#/connect localhost 6667 mdp
```

## Connexion au serveur via NetCat

```bash
nc -C localhost <server_port>
#nc -C localhost 6667
```

S’authentifier avec les trois commandes suivantes (ne pas mettre de / avant contrairement à IRSSI) :

```bash
PASS <server_password>
USER <user> <mode(unused)> <host(unused> <realname>
NICK <nickname>
#PASS mdp
#USER John 0 0 JohnSmith
#NICK johny
```

## Commandes

Une fois que la connexion a été établie avec IRSSI ou NetCat, tester les commandes possibles.

Ne pas oublier d’ajouter un / avant chaque commande pour IRSSI. 

* `INFO` : affiche les informations du serveur : 

```bash
INFO
```

* `ADMIN` : affiche les informations de l’administrateur du serveur : 

```bash
ADMIN
```

* `NAMES` : affiche les noms des utilisateurs : 

```bash
NAMES
```

* `JOIN` : Rejoindre un canal ou en créer un s’il n’existe pas :

```bash
#sur nc :
JOIN <#nom_du_canal>

#sur irssi : 
/JOIN <nom_du_canal>
```
L'utilisateur qui crée le canal a automatiquement le rôle d'operator
