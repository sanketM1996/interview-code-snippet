# 📁 Deployment 
```bash
  readinessProbe:
            httpGet:
              path: /
              port: 80

          livenessProbe:
            httpGet:
              path: /
              port: 80
1. Readiness Probe
readinessProbe:
  httpGet:
    path: /
    port: 80
Meaning

Kubernetes sends an HTTP request to:

http://<pod-ip>:80/

If it gets a successful response (200–399), the pod is marked:

READY

Then traffic is sent to this pod through Service.

If Readiness Probe Fails

Kubernetes:

Does NOT kill the container
Removes pod from Service endpoints
Stops sending traffic to it

This is useful when:

App is still starting
Database connection not ready
App warming up
2. Liveness Probe
livenessProbe:
  httpGet:
    path: /
    port: 80
Meaning

Kubernetes checks whether the application is still alive.

It sends:

http://<pod-ip>:80/

If the probe keeps failing:

Kubernetes assumes app is hung/crashed
Automatically restarts the container
```
---

## Rolling Update Strategy

```yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxUnavailable: 1
```

* **RollingUpdate** → replaces Pods gradually without downtime
* **maxUnavailable: 1** → ensures at most one Pod is down during rollout

**Result:** Users experience **zero downtime** while updates roll out.

---
# 📁 configmap
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

> This tells Kubernetes to load all key-value pairs from the ConfigMap as environment variables inside the container.
> 🔹 Even though the defaults are already set in the app, we explicitly define them in the ConfigMap.
> This demonstrates *Configuration as Code* — making all runtime configuration visible and manageable via Kubernetes manifests.
---