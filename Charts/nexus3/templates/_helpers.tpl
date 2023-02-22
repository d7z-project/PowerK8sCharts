{{/*
Expand the name of the chart.
*/}}
{{- define "nexus3.name" -}}
{{- print .Chart.Name  | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define  "nexus.image.nexus"}}
{{- printf "%s/%s:%s" .Values.image.repository .Values.image.images.nexus .Chart.AppVersion }}
{{- end}}

{{- define  "nexus.image.nginx"}}
{{- printf "%s/%s" .Values.image.repository .Values.image.images.nginx }}
{{- end}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nexus3.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nexus3.labels" -}}
helm.sh/chart: {{ include "nexus3.chart" . }}
{{ include "nexus3.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nexus3.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nexus3.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
