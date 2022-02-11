SECRET_NAME=$AWS_REGION-ecr-registry
 TOKEN=`aws ecr get-authorization-token --output text --query authorizationData[].authorizationToken | base64 -d | cut -d: -f2`
 echo "ENV variables setup done."
 kubectl create secret docker-registry $SECRET_NAME \
 --docker-server=https://$REPOSITORY_URI \
 --docker-username=AWS \
 --docker-password="${TOKEN}" \
 --docker-email=DUMMY_DOCKER_EMAIL
 kubectl patch serviceaccount default -p '{"imagePullSecrets":[{"name":"'$SECRET_NAME'"}]}'

