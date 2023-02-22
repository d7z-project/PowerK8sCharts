{{- define "gitlab.name" -}}
{{- print .Release.Name  | trunc 63 | trimSuffix "-" }}
{{- end }}
