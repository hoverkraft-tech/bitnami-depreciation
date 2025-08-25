# bitnami-depreciation

The idea of this repo is to reference all helm charts/tools that need attention to be ready for the changes of the 2025-08-28
more infos: https://news.broadcom.com/app-dev/broadcom-introduces-bitnami-secure-images-for-production-ready-containerized-applications

https://www.tickcounter.com/countdown/7975295/bitnami-depreciation

## How to detect if you need it

You can use a command like this that will leverage kubectl plugin [custom-cols](https://github.com/webofmars/kubectl-custom-cols)

```shell
kubectl custom-cols -A -o images pods | grep bitnami | awk '{ print $2 }' | sort | uniq
```

If you are seeing images that start with 'bitnami/', it's time to patch !

## Helm charts

- [bitnami/oauth2-proxy](./helm/bitnami-oauth2-proxy)
- [bitnami/mysql](./helm/bitnami-mysql)
- [bitnami/phpmyadmin](./helm/bitnami-phpmyadmin)
- [bitnami/postgresql](./helm/bitnami-postgresql)
- [bitnami/rabbitmq](./helm/bitnami-rabbitmq)
- [bitnami/redis](./helm/bitnami-redis)
- [bitnami/thanos](./helm/bitnami-thanos)
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
