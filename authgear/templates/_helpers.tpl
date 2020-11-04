{{/*
Expand the name of the chart.
*/}}
{{- define "authgear.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "authgear.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "authgear.labels" -}}
helm.sh/chart: {{ include "authgear.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "authgear.nameMain" -}}
{{- printf "%s-%s" .Release.Name "main" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.mainSelectorLabels" -}}
{{ include "authgear.labels" . }}
app.kubernetes.io/name: {{ include "authgear.nameMain" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "authgear.nameAdmin" -}}
{{- printf "%s-%s" .Release.Name "admin" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.adminSelectorLabels" -}}
{{ include "authgear.labels" . }}
app.kubernetes.io/name: {{ include "authgear.nameAdmin" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "authgear.nameResolver" -}}
{{- printf "%s-%s" .Release.Name "resolver" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.resolverSelectorLabels" -}}
{{ include "authgear.labels" . }}
app.kubernetes.io/name: {{ include "authgear.nameResolver" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "authgear.namePortal" -}}
{{- printf "%s-%s" .Release.Name "portal" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.portalSelectorLabels" -}}
{{ include "authgear.labels" . }}
app.kubernetes.io/name: {{ include "authgear.namePortal" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
