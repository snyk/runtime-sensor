# Runtime Sensor

The Runtime Sensor watches your deployments on a Kubernetes cluster
and sends collected data to Snyk.

This is a [Helm chart](https://helm.sh) dedicated repo [helm/runtime-sensor](https://github.com/snyk/runtime-sensor), hosting the Snyk Runtime Sensor using Github pages in `https://snyk.github.io/runtime-sensor`.

## Usage

### Installation

Please find the installation instructions under Snyk's docs - https://docs.snyk.io/manage-risk/snyk-apprisk/integrations-for-snyk-apprisk/snyk-runtime-sensor.

Released versions can be found in the [Releases](https://github.com/snyk/runtime-sensor/releases) page.

In order to examine the full list of configurable values and have more control over the installation of the sensor, download the Helm repository and check out the `values.yaml` file:

1. `helm repo add runtime-sensor https://snyk.github.io/runtime-sensor`
2. `helm pull runtime-sensor/runtime-sensor --untar`
3. See the `values.yaml` file under the `runtime-sensor` directory.
