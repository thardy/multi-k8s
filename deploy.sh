docker build -t timhardy/multi-client:latest -t timhardy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t timhardy/multi-server:latest -t timhardy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t timhardy/multi-worker:latest -t timhardy/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push timhardy/multi-client:latest
docker push timhardy/multi-server:latest
docker push timhardy/multi-worker:latest

docker push timhardy/multi-client:$SHA
docker push timhardy/multi-server:$SHA
docker push timhardy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=timhardy/multi-server:$SHA
kubectl set image deployments/client-deployment client=timhardy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=timhardy/multi-worker:$SHA