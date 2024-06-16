# Runtime Sensor

The Runtime Sensor watches your deployments on a Kubernetes cluster
and will send collected data to Snyk.

## Usage

### Installation

There is a [Helm chart](https://helm.sh) within this repo in [helm/runtime-sensor](https://github.com/snyk/runtime-sensor), that is hosted through Github pages in `https://snyk.github.io/runtime-sensor`.

Initially you need to create a Kubernetes secret that contains the API token for the
[service account](https://docs.snyk.io/snyk-admin/service-accounts)

The service account must have one of the following roles:

- Group Admin
- Custom Role with "AppRisk edit" permission

To install Snyk's runtime sensor using Helm Charts follow these steps:

1. Make sure Helm is installed
2. Create the namespace you would like to install the sensor in, for example `snyk-runtime-sensor`:

   ```
   kubectl create namespace <<YOUR_NAMESPACE>>
   ```

3. Create a secret with your service account token which has the appropriate permissions under the created namespace:

   ```
   kubectl create secret generic <<YOUR_SECRET_NAME>> --from-literal=snykToken=<<YOUR_TOKEN>> -n <<YOUR_NAMESPACE>>
   ```

4. Add the Helm repo

   ```
   helm repo add runtime-sensor https://snyk.github.io/runtime-sensor
   ```

5. Install the Helm chart:

   ```
   helm install my-runtime-sensor \
   --set secretName=<<YOUR_SECRET_NAME>> \
   --set clusterName=<<CLUSTER_NAME>> \
   --set snykGroupId=<<YOUR_GROUP_ID>> \
   -n <<YOUR_NAMESPACE>> \
   runtime-sensor/runtime-sensor
   ```

Release versions can be found [in GitHub](https://github.com/snyk/runtime-sensor/releases).

#### upgrading to latest version

1. Check the name that was given to the sensor

```
helm repo list
```

2. Update the repo (with the name from (1))

```
helm repo update <SENSOR REPO NAME>
```

3. Upgrade installation

```
helm upgrade --install <<SENSOR_REPO_NAME>> \
   --set secretName=<<YOUR_SECRET_NAME>>  \
   --set clusterName=<<CLUSTER_NAME>> \
   --set snykGroupId=<<YOUR_GROUP_ID>>  \
   -n <<YOUR_NAMESPACE>> \
   runtime-sensor/runtime-sensor
```
