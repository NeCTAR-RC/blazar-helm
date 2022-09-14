{{- define "blazar-conf" }}
[DEFAULT]
auth_strategy=keystone
os_admin_username={{ .Values.conf.keystone.username }}
os_admin_project_name={{ .Values.conf.keystone.project_name }}
os_auth_protocol=https
os_auth_host={{ .Values.conf.keystone.host }}
port=8010
#log_file=/dev/null
#log_dir=/var/log/blazar
#use_syslog=True

[manager]
plugins=physical.host.plugin,virtual.instance.plugin
event_max_retries=3

[nova]
nova_client_version=2.60

[database]
connection_recycle_time=600

[oslo_messaging_notifications]
driver=messagingv2

[oslo_messaging_rabbit]
amqp_durable_queues=True
ssl=True
rabbit_ha_queues=True

[oslo_policy]
policy_file=/etc/blazar/policy.yaml

[keystone_authtoken]
auth_url={{ .Values.conf.keystone.auth_url }}
www_authenticate_uri={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
project_name={{ .Values.conf.keystone.project_name }}
user_domain_name=Default
project_domain_name=Default
auth_type=password
{{- if .Values.conf.keystone.memcached_servers }}
memcached_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}
service_type=reservation

{{- end }}
