docker build -t kingofcph/multi-client:latest -t kingofcph/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kingofcph/multi-server:latest -t kingofcph/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kingofcph/multi-worker:latest -t kingofcph/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kingofcph/multi-client:latest
docker push kingofcph/multi-server:latest
docker push kingofcph/multi-worker:latest
docker push kingofcph/multi-client:$SHA
docker push kingofcph/multi-server:$SHA
docker push kingofcph/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kingofcph/multi-server:$SHA
kubectl set image deployments/client-deployment client=kingofcph/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kingofcph/multi-worker:$SHA
