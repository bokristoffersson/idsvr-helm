{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "curity.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "curity.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "curity.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "curity.labels" -}}
app.kubernetes.io/name: {{ include "curity.name" . }}
helm.sh/chart: {{ include "curity.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "curity.metricsPort" -}}
{{ add .Values.curity.healthCheckPort  1 }}
{{- end -}}

{{- define "curity.scopeTag" -}}
<scope>
  <id>{{- .id -}}</id>
  {{- if .isPrefix }}
  <is-prefix>{{- .isPrefix -}}</is-prefix>
  {{- end -}}
  {{- if .description }}
  <description>{{- .description -}}</description>
  {{- end -}}
  {{- if .timeToLive }}
  <time-to-live>{{- .timeToLive -}}</time-to-live>
  {{- end -}}
  {{- if .required }}
  <required>{{- .required -}}</required>
  {{- end -}}
  {{- if .exposeInMetadata }}
  <expose-in-metadata>{{- .exposeInMetadata -}}</expose-in-metadata>
  {{- end }}
</scope>
{{- end -}}

{{- define "curity.clientTag" -}}
<client>
  <id>{{- .id -}}</id>
  {{- if .clientName }}
  <client-name>{{- .clientName -}}</client-name>
  {{- end -}}
{{/*
TODO add the rest of the parameters, see documentation
https://curity.io/docs/idsvr/latest/configuration-guide/reference/config.html#authorization-server
*/}}
  {{- if .scope }}
  {{- range $i := .scope }}
  <scope>{{- . -}}</scope>
  {{- end -}}
  {{- end -}}
</client>
{{- end -}}

