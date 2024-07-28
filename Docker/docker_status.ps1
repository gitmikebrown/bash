

################################################################################################
####   Report on all that is going on
################################################################################################



function docker_status {
    Clear-Host;
    Write-Host "`n`n";
    Write-Host "`n-Networks-----------------------------------------------------`n" -ForegroundColor Green;
    docker network ls; 
    Write-Host "`n`n-Volumes-----------------------------------------------------`n" -ForegroundColor Green;
    docker volume ls; 
    Write-Host "`n`n-Images--------------------------------------------------------`n" -ForegroundColor Green;
    docker images; 
    Write-Host "`n`n-Containers - All------------------------------------------------`n" -ForegroundColor Green;
    docker ps -a;
    Write-Host "`n`n-Containers - Currently Running-----------------------------------`n" -ForegroundColor Green;
    docker ps;
    Write-Host "`n`n";
}
docker_status;
