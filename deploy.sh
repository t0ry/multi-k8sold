docker build -t tory00b/multi-client:latest -t tory00b/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tory00b/multi-server:latest -t tory00b/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tory00b/multi-worker:latest -t tory00b/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tory00b/multi-client:latest
docker push tory00b/multi-server:latest
docker push tory00b/multi-worker:latest
docker push tory00b/multi-client:$SHA
docker push tory00b/multi-server:$SHA
docker push tory00b/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tory00b/multi-server:$SHA
kubectl set image deployments/client-deployment client=tory00b/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tory00b/multi-worker:$SHA
