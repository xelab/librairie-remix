librairie21
===============

# Application simplifiée de gestion de librairie

Cette application est initialement développée pour une librairie associative possédant un millier d'ouvrages. Son but est de gérer le stock d'ouvrages, les ventes et les commandes.
Elle est actuellement en version beta et dispose d'un nombre de fonctionnalités encore limité.

## Installation

Librairie21 est développé avec le framework Ruby on Rails 4. Cela nécessite donc une installation de Ruby (version 2) sur votre machine. Également la base de donnée actuellement utilisée est PostgreSQL. N'importe quelle autre base peut être utilisée, cela nécessite quelques légères modifications dans le fichier Gemfile(documentation à venir).

Actuellement le logiciel n'a été utilisé et installé que sur des machines Linux (plus précisément sur des distributions de la famille Ubuntu). Voici donc la procédure d'installation dans ce cadre, avec un serveur nginx et son plugin passenger.

Lancez le terminal.
Si vous utilisez le "Gnome Terminal" ou "XFCE Terminal", dans les options de configuration, cochez "Run as login shell" (ou la phrase équivalente en français) et relancez le terminal.

Dans le terminal, entrez ces lignes (note: la version de postgresql peut différer selon la distribution, ici il s'agit de la 9.1 sous Ubuntu 13.04):

```shell
sudo apt-get install curl git nodejs postgresql postgresql-server-dev-9.1
```
[Créez un utilisateur pour PostgreSQL.](http://doc.ubuntu-fr.org/postgresql#creer_un_utilisateur_postgresql)

Ensuite installons Ruby avec RVM (important, n'exécutez pas les commandes qui suivent en root mais bien en tant qu'utilisateur normal):

```shell
curl -L https://get.rvm.io | bash -s stable
```

Une fois installé, exécuter cette commande afin d'installer les librairies nécessaires à la future installation de Ruby:

```shell
rvm requirements --autolibs=enable
```

Puis l'installation de Ruby:

```shell
rvm install 2.0.0
```

```shell
rvm use 2.0.0
```

Et enfin la gem "bundler" afin de packager les différentes librairies:

```shell
gem install bundler
```

Ensuite créez un répertoire dans lequel vous souhaitez placer l'application.
Placez vous à la racine de ce répertoire avec le terminal (ex: `cd /home/user/logiciel` en remplaçant *user* par son nom d'utilisateur).

Récupérez les fichiers:
```shell
git clone https://github.com/xelab/librairie-remix.git
```

Un nouveau répertoire nommé *librairie-remix* contenant les fichiers du logiciel est ajouté dans votre dossier précédemment créé.

Allez dans ce répertoire et dans le répertoire *config* et créez un nouveau fichier nommé *database.yml*.

Copiez-y le contenu suivant en remplaçant les champs *username* et *password* par votre nom d'utilisateur sous PostgreSQL et votre mot de passe correspondant:

```yaml
development:
  adapter: sqlite
  encoding: unicode
  database: db/dev.sqlite3
  pool: 5
  timeout: 5000

test:
  adapter: sqlite3
  database: db/test.sqlite3
  pool: 5
  timeout: 5000

production:
  adapter: postgresql
  encoding: unicode
  database: librairie_prod
  host: localhost
  username: <votre_user>
  password: <votre_mdp>
  pool: 5
  timeout: 5000
```

Revenez à la racine du répertoire librairie-remix dans le terminal et exécutez les commandes suivantes (la première peut prendre un certain temps):

```shell
bundle install
rake db:setup RAILS_ENV="production"
RAILS_ENV=production bundle exec rake assets:precompile
```

Copiez également les fichiers .png et .gif du répertoire *vendor/stylesheets/* dans *public/assets* (note: cette étape devrait être automatisée prochainement).

Installons maintenant le serveur nginx et le module passenger:

```shell
gem install passenger
rvmsudo passenger-install-nginx-module
```

La dernière commande peut vous indiquer des paquets supplémentaires à installer. Faites-le si nécessaire puis relancez la commande.

Ensuite, il est nécessaire de modifier la configuration de nginx:
```shell
sudo nano /opt/nginx/conf/nginx.conf
```

Dans le bloc *location /*, supprimez les lignes existantes pour mettre celles-ci à la place:

```text
location / {
            passenger_enabled on;
            root /home/user/repertoire_logiciel/public;
        }
```

Remplacez *user/repertoire_logiciel* par l'adresse de votre dossier *librairie-remix*.

Ensuite lancez *nginx*:

```shell
sudo service nginx start
```

Note: si vous avez le message d'erreur `nginx: unrecognized service`, exécutez ces commandes et retapez la commande ci-dessous:

```shell
wget -O init-deb.sh http://library.linode.com/assets/660-init-deb.sh
sudo mv init-deb.sh /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo /usr/sbin/update-rc.d -f nginx defaults
```
Ouvrez votre navigateur, tapez *localhost* dans la barre d'adresse.
Voilà, si tout s'est bien passé, librairie21 apparaît devant vos yeux!

## Feuille de route

Les prochaines étapes de développement sont les suivantes:

- gestion complète des auteurs, des catégories, des éditeurs, des collections et des distributeurs
- module ventes
- module commandes
- gestion de stock améliorée (mouvements de stocks: dons, pertes, réassorts, etc.)
- gestion des inventaires
