


################################################################################################
####   Report on all that is going on
################################################################################################


function docker_status(){
    wsl
    text_Green='\033[0;32m';
    text_reset='\033[0m';
    clear;
    printf "\n\n${text_Green}-Networks-----------------------------------------------------${text_reset}\n\n";
    sudo docker network ls; 
    printf "\n\n${text_Green}-Volumes-----------------------------------------------------${text_reset}\n\n";
    sudo docker volume ls; 
    printf "\n${text_Green}-Images--------------------------------------------------------${text_reset}\n\n";
    sudo docker images; 
    printf "\n${text_Green}-Containers - All------------------------------------------------${text_reset}\n\n";
    sudo docker ps -a;
    printf "\n${text_Green}-Containers - Currently Running-----------------------------------${text_reset}\n\n";
    sudo docker ps;
    printf "\n\n";

}

docker_status;



################################################################################################
####   Old PowerShell
#   I could never get PS to work well with the docker command. Switched over to WSL and it works
################################################################################################
#function docker_status {

# Check if Docker service is running
#    $dockerService = Get-Service -Name "docker" -ErrorAction SilentlyContinue

 #   if ($dockerService -and $dockerService.Status -eq 'Running') {
#        Clear-Host;
#        Write-Host "`n`n";
#        Write-Host "`n-Networks-----------------------------------------------------`n" -ForegroundColor Green;
#        docker network ls; 
#        Write-Host "`n`n-Volumes-----------------------------------------------------`n" -ForegroundColor Green;
#        docker volume ls; 
#        Write-Host "`n`n-Images--------------------------------------------------------`n" -ForegroundColor Green;
#        docker images; 
#        Write-Host "`n`n-Containers - All------------------------------------------------`n" -ForegroundColor Green;
#        docker ps -a;
#        Write-Host "`n`n-Containers - Currently Running-----------------------------------`n" -ForegroundColor Green;
#        docker ps;
#        Write-Host "`n`n";
#    } else {
#        Write-Output "Docker is not running. Please start Docker"
#        #Start-Service -Name "docker"
#        # Verify if Docker started successfully
#        #$dockerService = Get-Service -Name "Docker"
        #if ($dockerService.Status -eq 'Running') {
        #    Write-Output "Docker started successfully."
        #} else {
        #    Write-Output "Failed to start Docker."
#    }
#}

#docker_status;
