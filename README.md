### MOZI DOCKER SETUP
0. Define the `$MOZI_BACKEND`,`$MOZI_FRONTEND` and `GHOST_DIR` variables to point to the Mozi Backend, Mozi Frontend and Ghost directories respectively

1. Clone [mozi_docker](http://github.com/Habush/mozi_docker) , [mozi_backend_flask](https://gitlab.com/icog-labs/mozi_backend_flask.git) and [mozi](https://gitlab.com/icog-labs/mozi.git) to your **home** directory
2. Goto mozi front-end directory and open `src/app/app.config.ts` and replace with the following code
 ``` javascript 
 export const configs = {
    'url' : 'http://localhost:5000/api/v1.1/',
    'socket_url': 'http://localhost:5000',
    'opencog_url_timeout': '10000',
    'sample_data_file': 'atoms.oovc_ensemble_sti.json'
};
``` 
3. Goto mozi_docker directory and run the following commands:

    3a. `docker-compose build mozi` which will build mozi

    3b. `docker-compose up mozi` which will run mozi

    3c. `docker exec -it mozi_docker_mozi_1 /bin/bash` which will give 
    you interactive shell access to the running docker image

    3d. Once inside run this shell run `celery -A utils.task_runner.celery worker --loglevel=INFO` to start **celery**. 
