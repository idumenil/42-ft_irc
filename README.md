# 42-ft_irc

Remarque : ce projet sera supprimé le 31 mai 2024 car je n'en suis pas l'auteure. 

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
#USER irene 0 0 IreneDumenil
#NICK reni
```
