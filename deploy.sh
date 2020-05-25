cd ~/project/
git config --global user.email "alcalan@iarc.fr"
git config --global user.name "Circle CI_$CIRCLE_PROJECT_REPONAME_$CIRCLE_BRANCH"
git pull
git add dag*
git commit -m "Generated DAG [skip ci]"
git push origin $CIRCLE_BRANCH

curl -H "Content-Type: application/json" --data "{\"source_type\": \"Branch\", \"source_name\": \"$CIRCLE_BRANCH\"}" -X POST https://hub.docker.com/api/build/v1/source/a1b036fd-db18-43f4-af57-5ce15c010ada/trigger/f1599b31-9224-45a7-95a4-2a2b84717fab/call/
