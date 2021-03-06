### MOZI DOCKER SETUP
1. Clone [mozi_docker](http://github.com/Habush/mozi_docker) , [mozi_backend_flask](https://gitlab.com/icog-labs/mozi_backend_flask), [mozi_frontend](https://gitlab.com/icog-labs/mozi), [ghost](https://gitlab.com/xabush/ghost) and [bio-data](https://gitlab.com/opencog-bio/bio-data) repositories
NOTE: You must be on the **develop** branch for Mozi Backend and Mozi Frontend repos/

2. Define the following environment variables:

    a. `MOZI_BACKEND` -- Points to the Mozi backend dir

    b. `MOZI_FRONTEND` -- Points to the Mozi frontend dir 

    c. `GHOST_DIR` -- Points to the Ghost dir

    d. `BIODATA_DIR` -- Points to the Bio-data dir

    e. `DATASETS_DIR` -- Points to the location where datasets will be stored

3. Goto mozi_docker directory and run the following commands:

    3a. `docker-compose up mozi` which will run mozi

    3b. `docker exec -it mozi_docker_mozi_1 /bin/bash` which will give 
    you interactive shell access to the running docker image

    3c. Once inside run this shell run `celery -A utils.task_runner.celery worker --loglevel=INFO` to start **celery**. 
