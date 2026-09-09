admin: net start com.docker.service

\& "C:\\Program Files\\Docker\\Docker\\Docker Desktop.exe" --unattended

docker compose -p wolo -f D:\\Wolo\\Web\\project\\compose-dev.yaml up
Attaching to nginx-proxy-1, web-app-1, web-site-1

docker exec -it wolo-nginx-proxy-1 bash

./project/render.sh



