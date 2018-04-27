cd ~/vt-nf/
git config --global user.email "delhommet@students.iarc.fr"
git config --global user.name "Circle CI_$CIRCLE_PROJECT_REPONAME_$CIRCLE_BRANCH"
git pull

curl -H "Content-Type: application/json" --data "{\"source_type\": \"Branch\", \"source_name\": \"$CIRCLE_BRANCH\"}" -X POST https://registry.hub.docker.com/u/iarcbioinfo/vt-nf/trigger/90ddfa83-2377-4251-ac76-e64a7638deb0/
