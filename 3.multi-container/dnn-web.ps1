# This helper script simplifies starting and running
# a multi-container DNN development site

param(
[Parameter(Mandatory=$true)]
[ValidateSet('Start', 'Stop')]
[string]$command,

[Parameter(Mandatory=$false)]
[string]$sa_password,

[Parameter(Mandatory=$false)]
[string]$dnn_url,

[Parameter(Mandatory=$false)]
[string]$dnn_hash
)

$dir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

switch ($command.ToLower()) {
    'start' {
        docker-compose --file "$dir\docker-compose.yml" --project-name dnnplatform up -d 

        $container = docker ps -q --filter ancestor=jbrinkman/dnn-web --filter name=dnnplatform_web | select-object -first 1

        $ip = docker inspect -f "{{.NetworkSettings.Networks.nat.IPAddress}}" $container

        start-process "http://$ip"
    }
    'stop' {
        docker-compose --file "$dir\docker-compose.yml" --project-name dnnplatform down
    }
}