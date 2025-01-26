# I'm using docker to run terraform in provisioning my compute resources
docker run --entrypoint="" --rm -ti -v $(pwd):/home -w /home hashicorp/terraform:1.10 sh  