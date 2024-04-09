pour le docker 
aller sur le dossier flutter-firebase_app
faire:
docker build . -t flutter_docker
apres le build du docker 
ensuite :
docker images
enfin: 
docker run -i -p 8080:9000 -td flutter_docker

