# Kubernetes Manifest Notes

## Deployment

### Readiness Probe

```yaml
readinessProbe:
  httpGet:
    path: /
    port: 80
```

**Meaning**

Kubernetes sends an HTTP request to:

`http://<pod-ip>:80/`

If it receives a successful response (`200–399`), the pod is marked as **READY** and traffic is sent to the pod through the Service.

**If the readiness probe fails:**

- Kubernetes does not kill the container
- The pod is removed from Service endpoints
- Kubernetes stops sending traffic to it

**Common use cases:**

- App is still starting
- Database connection is not ready
- App is warming up

### Liveness Probe

```yaml
livenessProbe:
  httpGet:
    path: /
    port: 80
```

**Meaning**

Kubernetes checks whether the application is still alive by sending a request to:

`http://<pod-ip>:80/`

**If the liveness probe keeps failing:**

- Kubernetes assumes the app is hung or crashed
- Kubernetes automatically restarts the container

---

## Rolling Update Strategy

```yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxUnavailable: 1
```

- **RollingUpdate**: replaces pods gradually without downtime
- **maxUnavailable: 1**: ensures at most one pod is unavailable during rollout

**Result:** Users experience **zero downtime** while updates are deployed.

---

## ConfigMap

**Manifest:** `nginx.yml`

Under the container section, add:

```yaml
volumeMounts:
  - name: nginx-html
    mountPath: /usr/share/nginx/html

volumes:
  - name: nginx-html
    configMap:
      name: nginx-config
```

> This tells Kubernetes to mount the ConfigMap data into the pod.
> 
> Even though default values may already exist in the application, defining them in a ConfigMap makes configuration visible and manageable as code.
