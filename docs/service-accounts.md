# Service accounts

By default, the chart creates two service accounts, each with a Role and a RoleBinding in `authgear.appNamespace`:

| Service account | Used by | Permissions in `authgear.appNamespace` |
| --- | --- | --- |
| `<release>-main` | main, admin, resolver | Read configmaps, secrets and ingresses |
| `<release>-portal` | portal | Manage configmaps, secrets, ingresses and cert-manager certificates (custom domains) |

Creating the Role and RoleBinding requires the deployer to hold every permission in the Role, or to have the
`escalate` verb on Roles and the `bind` verb on Roles, in `authgear.appNamespace`. If the deployer (e.g. a CI service account) cannot do that, create the service accounts
and their RBAC resources yourself, and tell the chart to use them:

```yaml
authgear:
  mainServer:
    serviceAccount:
      create: false
      name: authgear-main-sa
  portalServer:
    serviceAccount:
      create: false
      name: authgear-portal-sa
```

`create` can be set independently for main and portal.

## Manifests

Replace the following before applying them:

- `authgear`: the namespace of the release.
- `authgear-apps`: `authgear.appNamespace`.
- `authgear-main-sa` and `authgear-portal-sa`: `serviceAccount.name` of main and portal.

The rules are the same as the ones the chart creates. Keep them in sync when upgrading the chart.

### main, admin and resolver

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: authgear-main-sa
  namespace: authgear
  # Add annotations here if needed, e.g. for IAM roles.
  # authgear.mainServer.serviceAccount.annotations is ignored when create is false.
automountServiceAccountToken: true
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: authgear-main-sa
  namespace: authgear-apps
rules:
- apiGroups: [""]
  resources: ["configmaps", "secrets"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["extensions", "networking.k8s.io"]
  resources: ["ingresses"]
  verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: authgear-main-sa
  namespace: authgear-apps
subjects:
- kind: ServiceAccount
  name: authgear-main-sa
  namespace: authgear
roleRef:
  kind: Role
  name: authgear-main-sa
  apiGroup: rbac.authorization.k8s.io
```

### portal

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: authgear-portal-sa
  namespace: authgear
  # Add annotations here if needed.
  # authgear.portalServer.serviceAccount.annotations is ignored when create is false.
automountServiceAccountToken: true
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: authgear-portal-sa
  namespace: authgear-apps
rules:
- apiGroups: [""]
  resources: ["configmaps", "secrets"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete", "deletecollection"]
- apiGroups: ["extensions", "networking.k8s.io"]
  resources: ["ingresses"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete", "deletecollection"]
# Required only if cert-manager is used for custom domains.
- apiGroups: ["cert-manager.io"]
  resources: ["certificates"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete", "deletecollection"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: authgear-portal-sa
  namespace: authgear-apps
subjects:
- kind: ServiceAccount
  name: authgear-portal-sa
  namespace: authgear
roleRef:
  kind: Role
  name: authgear-portal-sa
  apiGroup: rbac.authorization.k8s.io
```

### Verify

```sh
kubectl auth can-i list secrets -n authgear-apps --as system:serviceaccount:authgear:authgear-main-sa
kubectl auth can-i create ingresses.networking.k8s.io -n authgear-apps --as system:serviceaccount:authgear:authgear-portal-sa
```

Both should print `yes`.
