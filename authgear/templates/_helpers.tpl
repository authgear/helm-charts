{{/*
Expand the name of the chart.
*/}}
{{- define "helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helm.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "helm.labels" -}}
helm.sh/chart: {{ include "helm.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "authgear.nameMain" -}}
{{- printf "%s-%s" .Release.Name "main" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.mainSelectorLabels" -}}
{{ include "helm.labels" . }}
app.kubernetes.io/name: {{ include "authgear.nameMain" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "authgear.nameAdmin" -}}
{{- printf "%s-%s" .Release.Name "admin" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.adminSelectorLabels" -}}
{{ include "helm.labels" . }}
app.kubernetes.io/name: {{ include "authgear.nameAdmin" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "authgear.nameResolver" -}}
{{- printf "%s-%s" .Release.Name "resolver" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.resolverSelectorLabels" -}}
{{ include "helm.labels" . }}
app.kubernetes.io/name: {{ include "authgear.nameResolver" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "authgear.namePortal" -}}
{{- printf "%s-%s" .Release.Name "portal" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.portalSelectorLabels" -}}
{{ include "helm.labels" . }}
app.kubernetes.io/name: {{ include "authgear.namePortal" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
