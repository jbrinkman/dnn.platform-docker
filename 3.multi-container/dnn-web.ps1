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

switch ($command.ToLower()) {
    'start' {
        $dir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
        docker-compose up -d 

        $container = docker ps -q --filter ancestor=jbrinkman/dnn-web --filter name=web | select-object -first 1
    }
    'stop' {
        docker-compose down
    }
}