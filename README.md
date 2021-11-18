# DataPipe_perios_isoles

Ce répertoire contient les éléments Python (fonctions et notebook) et xsl/xml (feuille de style et processeur Saxon) nécessaire à l'exécution d'un pipeline de données visant à récupérer un set de ppn Sudoc (via l'application Périscope) puis à le filtrer et l'enrichir d'identifiants système locaux, afin le redistribuer dans un format tabulaire réutilisable comme fichier de travail pour les collègues.
Le notebook est servi comme une page web grâce à la librairie [Voila](https://github.com/voila-dashboards/voila).

L'architecture du dispositif a pour but d'automatiser et rendre facilement reproductible ce pipe de données, et répond également à un objectif d'ouverture et de "démocratisation" de l'accès à l'application, autant du point de vue de son exécutions que de son développement. Pour ce faire, le code est structuré  de manière à pouvoir permettre des installations et des accès multiples (expert ou non) :
- installation du code source en local [expert]
  - accès et exécution via un Jupyter notebook
  - accès et exécution via une UI basique générée avec la librairie Voila qui convertit le notebook en app web interactive
- installation du conteneur Docker en local [expert]
  - accès et exécution via l'UI Voila servie dans le container
- accès distant partagé au conteneur Docker installé sur dev-scd [accès pour tous]
  - accès et exécution via l'UI Voila 

## Code source : installation locale (Windows)

### Pré-requis

Python v3 et environnement Anaconda pour ouvrir le notebook

### Download

- Télécharger l'archive zippée ou cloner le dépôt depuis Github.

- Installer le dossier dans un emplacement du serveur ou du PC accessible en écriture

### Environnement virtuel

- Si besoin, installer le package virtualenv (pip install virtualenv)

- Se placer à la racine du dossier et lancer la commande de création d'un environnement virtuel :

```
virtualenv NOM_DE_VOTRE_ENV
```
- Activer l'environnement virtuel

```
cd NOM_DE_VOTRE_ENV/Scripts & activate
pip install -r ../../win_requirements.txt # installe toutes les dépendances
```
- Rendre accessible l'environnement virtuel dans le kernel des notebooks
  
 ```
 ipython kernel install --user --name=NOM_DE_VOTRE_ENV
 ```
- Lancer le notebook
  - en ligne de commande : jupyter notebook workflow_ui.ipynb
  - ou avec Anaconda Navigator

- Lancer l'app web Voila
  - en ligne de commande : voila workflow_ui.ipynb -> la page web est accessible sur http://localhost:8866
  - depuis le notebook : cliquer sur le bouton Voila dans le menu supérieur du Notebook


## Conteneur Docker : installation en local (Windows)

### Pré-requis

Docker Desktop pour Windows installé

### Download et utilisation

L'image du conteneur est accessible depuis le Docker registry à cette adresse : [https://hub.docker.com/repository/docker/azurscd/datapipe-perios-isoles](https://hub.docker.com/repository/docker/azurscd/datapipe-perios-isoles)

Une seule commande suffit à récupérer l'image et lancer le conteneur, en précisant en argument le mapping du port 8866 écouté à l'intérieur du conteneur ainsi que l'emplacement des répertoires du PC local à binder sur ceux du conteneur

```
docker run --name datapipe-perios-isoles -d -p VOTRE_PORT_DE_SORTIE:8866 -v VOTRE_LOCAL_PATH/temporary_files:/home/scd/temporary_files -v VOTRE_LOCAL_PATH/result_files:/home/scd/result_files datapipe-perios-isoles:latest
```
Exemple 
```
docker run --name datapipe-perios-isoles -d -p 8866:8866 -v C:/Users/geoffroy/Documents/GitHub/DataPipe_perios_isoles/temporary_files:/home/scd/temporary_files -v C:/Users/geoffroy/Documents/GitHub/DataPipe_perios_isoles/result_files:/home/scd/result_files datapipe-perios-isoles:latest
```

L'application est accessible en local sur http://localhost:VOTRE_PORT_DE_SORTIE/datapipe-perios-isoles
