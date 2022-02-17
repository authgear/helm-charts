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
app.kubernetes.io/name: {{ include "authgear.nameMain" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "authgear.nameAdmin" -}}
{{- printf "%s-%s" .Release.Name "admin" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.adminSelectorLabels" -}}
app.kubernetes.io/name: {{ include "authgear.nameAdmin" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "authgear.nameResolver" -}}
{{- printf "%s-%s" .Release.Name "resolver" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.resolverSelectorLabels" -}}
app.kubernetes.io/name: {{ include "authgear.nameResolver" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "authgear.namePortal" -}}
{{- printf "%s-%s" .Release.Name "portal" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.namePortalAuthgear" -}}
{{- printf "%s-%s" .Release.Name "portal-authgear" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.portalSelectorLabels" -}}
app.kubernetes.io/name: {{ include "authgear.namePortal" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "authgear.nameAuditLogCron" -}}
{{- printf "%s-%s" .Release.Name "audit-log-cron" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.nameAnalyticCronWeekly" -}}
{{- printf "%s-%s" .Release.Name "analytic-cron-weekly" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.nameAnalyticCronMonthly" -}}
{{- printf "%s-%s" .Release.Name "analytic-cron-monthly" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.nameAnalyticCronDaily" -}}
{{- printf "%s-%s" .Release.Name "analytic-cron-daily" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.nameAnalyticCronWeeklyScript" -}}
{{- printf "%s-%s" .Release.Name "analytic-cron-weekly-script" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.nameAnalyticCronMonthlyScript" -}}
{{- printf "%s-%s" .Release.Name "analytic-cron-monthly-script" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.nameAnalyticCronDailyScript" -}}
{{- printf "%s-%s" .Release.Name "analytic-cron-daily-script" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.nameBackground" -}}
{{- printf "%s-%s" .Release.Name "background" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.backgroundSelectorLabels" -}}
app.kubernetes.io/name: {{ include "authgear.nameBackground" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "authgear.nameWildcard" -}}
{{- printf "%s-%s" .Release.Name "wildcard" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.nameIngressTemplate" -}}
{{- printf "%s-%s" .Release.Name "ingress-template" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "authgear.authgearSecretsYAML" -}}
secrets:
- key: db
  data:
    database_schema: {{ .authgear.databaseSchema | quote }}
    database_url: {{ .authgear.databaseURL | quote }}
- key: audit.db
  data:
    database_schema: {{ .authgear.auditLog.databaseSchema | quote }}
    database_url: {{ .authgear.auditLog.databaseURL | quote }}
- key: redis
  data:
    redis_url: {{ .authgear.redisURL | quote }}
- key: analytic.redis
  data:
    redis_url: {{ .authgear.analytic.redisURL | quote }}
- key: mail.smtp
  data:
    host: {{ .authgear.smtp.host | quote }}
    port: {{ .authgear.smtp.port }}
    mode: {{ .authgear.smtp.mode | quote }}
    username: {{ .authgear.smtp.username | quote }}
    password: {{ .authgear.smtp.password | quote }}
{{- if .authgear.twilio.accountSID }}
- key: sms.twilio
  data:
    account_sid: {{ .authgear.twilio.accountSID | quote }}
    auth_token: {{ .authgear.twilio.authToken | quote }}
{{- end }}
{{- if .authgear.elasticsearch.enabled }}
- key: elasticsearch
  data:
    elasticsearch_url: {{ .authgear.elasticsearch.url | quote }}
{{- end }}
{{- end }}
