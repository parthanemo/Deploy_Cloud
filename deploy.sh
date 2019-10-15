docker build -t pribhask/multi-client:latest -t pribhask/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pribhask/multi-server:latest -t pribhask/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pribhask/multi-worker:latest -t pribhask/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pribhask/multi-client:latest
docker push pribhask/multi-server:latest
docker push pribhask/multi-worker:latest

docker push pribhask/multi-client:$SHA
docker push pribhask/multi-server:$SHA
docker push pribhask/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pribhask/multi-server:$SHA
kubectl set image deployments/client-deployment client=pribhask/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pribhask/multi-worker:$SHA