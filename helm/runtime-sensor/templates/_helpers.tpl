{{/*
Expand the name of the chart.
*/}}
{{- define "runtime-sensor.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "runtime-sensor.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "runtime-sensor.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "runtime-sensor.labels" -}}
{{ include "runtime-sensor.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "runtime-sensor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "runtime-sensor.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "runtime-sensor.serviceAccountName" -}}
{{- if .Values.sensor.serviceAccount.create }}
{{- default (include "runtime-sensor.name" .) .Values.sensor.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.sensor.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "runtime-sensor.podAnnotations" -}}
{{- if .Values.sensor.podAnnotations }}
{{- .Values.sensor.podAnnotations | toYaml }}
{{- end }}
{{- end }}

{{- define "runtime-sensor.podLabels" -}}
{{- if .Values.sensor.podLabels }}
{{- .Values.sensor.podLabels | toYaml }}
{{- end }}
{{- end }}

{{- define "runtime-sensor.additionalVolumes" -}}
{{- if .Values.secretProvider }}
{{- if eq .Values.secretProvider "aws" }}
- name: secrets-store-inline
  csi:
    driver: secrets-store.csi.k8s.io
    readOnly: true
    volumeAttributes:
      secretProviderClass: {{ include "runtime-sensor.name" . }}-aws-secrets
{{- end }}
{{- end }}
{{- end }}

{{- define "runtime-sensor.additionalVolumeMounts" -}}
{{- if .Values.secretProvider }}
{{- if eq .Values.secretProvider "aws" }}
- name: secrets-store-inline
  mountPath: "/mnt/secrets-store"
  readOnly: true
{{- end }}
{{- end }}
{{- end }}
