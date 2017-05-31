FROM microsoft/aspnet

# DNN Default Download Link
ARG dnn_install_url=http://bit.ly/dnn910-Install
ENV dnn_url ${dnn_install_url}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Remove-WebSite -Name 'Default Web Site'  

RUN New-Website \
    -Name 'dnn' \
    -Port 80 \  
    -PhysicalPath 'c:\inetpub\wwwroot' \
    -ApplicationPool 'DefaultAppPool'

RUN Invoke-WebRequest -Method Get -Uri $env:dnn_url -OutFile c:\DNN.zip ; \
    Expand-Archive -Path c:\DNN.zip -DestinationPath c:\inetpub\wwwroot ; \
	Remove-Item c:\DNN.zip -Force

# Ensure write permissions over web app project files
RUN icacls C:\inetpub\wwwroot /grant Everyone:F /t /q