docker build -t parthanemo/multi-client:latest -t parthanemo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t parthanemo/multi-server:latest -t parthanemo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t parthanemo/multi-worker:latest -t parthanemo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push parthanemo/multi-client:latest
docker push parthanemo/multi-server:latest
docker push parthanemo/multi-worker:latest

docker push parthanemo/multi-client:$SHA
docker push parthanemo/multi-server:$SHA
docker push parthanemo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=parthanemo/multi-server:$SHA
kubectl set image deployments/client-deployment client=parthanemo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=parthanemo/multi-worker:$SHA