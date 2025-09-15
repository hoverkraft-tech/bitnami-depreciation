# bitnami-depreciation

The idea of this repo is to reference all helm charts/tools that need attention to be ready for the changes of the 2025-08-28
more infos: https://news.broadcom.com/app-dev/broadcom-introduces-bitnami-secure-images-for-production-ready-containerized-applications

https://www.tickcounter.com/countdown/7975295/bitnami-depreciation

NOTE: bitnami has postponed a bit the depreciation (to the 2025-09-29):
> After evaluating the impact and community feedback, the Bitnami team has postponed the deletion of the Bitnami public catalog (docker.io/bitnami) until September 29th to give users more time to adapt to the upcoming changes.

But htey will start too remove some images randomly for 24h each.
Check https://github.com/bitnami/charts/issues/35164 for more details


## How to detect if you need it

You can use a command like this that will leverage kubectl plugin [custom-cols](https://github.com/webofmars/kubectl-custom-cols)

```shell
kubectl custom-cols -A -o images pods | grep bitnami | awk '{ print $2 }' | sort | uniq
```

If you are seeing images that start with 'bitnami/', it's time to patch !

## Helm charts

- [bitnami/apisix](./helm/bitnami-apisix)
- [bitnami/etcd](./helm/bitnami-etcd)
- [bitnami/mysql](./helm/bitnami-mysql)
- [bitnami/oauth2-proxy](./helm/bitnami-oauth2-proxy)
- [bitnami/phpmyadmin](./helm/bitnami-phpmyadmin)
- [bitnami/postgresql](./helm/bitnami-postgresql)
- [bitnami/rabbitmq](./helm/bitnami-rabbitmq)
- [bitnami/redis](./helm/bitnami-redis)
- [bitnami/thanos](./helm/bitnami-thanos)
- [bitnami/valkey](./helm/bitnami-valkey)
- [kyverno/kyverno](./helm/kyverno-kyverno)
- [vmware-tanzu/velero](./helm/vmware-tanzu-velero)

## Other ways

Another approach is to use mutating webhook to patch live any containers starting by '(*/)bitnami/'.
This is implemented [here](./workarounds/kyverno/).

## Contributors

- [@rverchere](https://github.com/rverchere)
- [@fredleger](https://github.com/fredleger)
- [@neilime](https://github.com/neilime)

## Contributingv

Please fee free to open PRs to add yours if you find this usefull
