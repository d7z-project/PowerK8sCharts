{{/*
Expand the name of the chart.
*/}}
{{- define "woodpecker-server.name" -}}
{{- default .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "woodpecker-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "woodpecker-server.labels" -}}
helm.sh/chart: {{ include "woodpecker-server.chart" . }}
{{ include "woodpecker-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "woodpecker-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "woodpecker-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
