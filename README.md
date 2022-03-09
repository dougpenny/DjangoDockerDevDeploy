# DjangoDockerDevDeploy (4D)
[![MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

Are you fed up with managing virtual environments and looking for a way to cleanly package all of the bits and pieces needed for Django development and deployment? While there are many opinons about which tools to use, DjangoDockerDevDeploy includes the basic items needed to have a fully functional development environment, that with a few changes to environment files, can also be used for deployment. The ultimate goal is to simply commit changes to the repo and easily deploy into production; DjangoDockerDevDeploy allows just that.

***

## Table of Contents
* [Usage](#usage)
* [Certificates](#certificates)
* [Contributing](#contributing)
* [License](#license)

---
### Directory Layout

```
.
├── /django/                     # Top-level Django project
│   ├── /config/                 # Configuration root directory
│   │   ├── /settings/           # Django settings files
│   │   │   ├── base.py          # Shared, base settings
│   │   │   ├── local.py         # Settings used for local development
│   │   │   ├── production.py    # Settings used for production
│   │   ├── asgi.py              # ASGI config file
│   │   ├── urls.py              # Base URLConf file
│   │   ├── wsgi.py              # WSGI config file
│   ├── .env.sample              # Environment variables for the Django project
│   ├── manage.py                # Django management file
├── /nginx-dev/                  # Nginx local development configuration
│   ├── default.conf.template    # Nginx configuration template for local development
├── /nginx-prod/                 # Nginx production configuration
│   ├── default.conf.template    # Nginx configuration template for production
│── .env.sample                  # Environment variables for docker-compose.yml
│── Dockerfile                   # Instructions for building the Docker images
│── docker-compose.yml           # Configuration for the various services
│── nginx.env.sample             # Environment variables for Nginx configuration
└── requirements.txt             # List of Python modules to install
```

## Usage
Fork the repository and check it out locally. A basic Django project is included, so you can change into the directory and then build and start the app by running:

```shell
docker-compose up --build
```

Navigate to `http://localhost:8000` in your browser and you will be presented with the “Congratulations!” Django page. You are now ready to start developing your Django app!

If you do not have Django installed locally, you can run all of the Django management commands in the Django Docker container. For example, to add a new app to your Django project you can run the following command, in a seperate terminal window:

```shell
docker-compose exec django python /code/django/manage.py startapp mynewapp
```

There are many different opinions about project layout; this project follows the [Two Scoops](https://www.feldroy.com/books/two-scoops-of-django-3-x) recommendation of having a top-level `config` directory that contains the settings, base URLConf (_urls.py_), and gateway interface (_wsgi.py/asgi.py_) files.

### Async or Sync
By default, the project is setup to proxy requests from Nginx directly to [Uvicorn](https://www.uvicorn.org). The `docker-compose.yml` file contains commented options for using [Gunicorn](https://gunicorn.org) both directly and as a process manager for Uvicorn. _Please note:_ Gunicorn is not installed by default and will need to be added to the `requirements.txt` file if used.

## Certificates
If you would like to use `https` during development, you will need to generate both a certificate and key and place them in the `certs` directory. The easiest way to do this is to use [mkcert](https://github.com/FiloSottile/mkcert) to create locally-trusted development certificates. Full instructions are provided in the [mkcert README](https://github.com/FiloSottile/mkcert/blob/master/README.md). Place the generated cetificate and key in the `certs` directory and update `nginx.env` file with the names of the certificate and key.

In production, you can use [certbot](https://certbot.eff.org) to generate [Let's Encrypt](https://letsencrypt.org) certificates. Simply update the `LOCAL_CERTS_PATH` in the top-level `.env` file to point to your certificates.

## Contributing
If you have a feature or idea you would like to see added to DjangoDockerDevDeploy, please [create an issue](https://github.com/dougonecent/DjangoDockerDevDeploy/issues/new) explaining your idea. Likewise, if you come across a bug, please [create an issue](https://github.com/dougonecent/DjangoDockerDevDeploy/issues/new) explaining the bug with as much detail as possible.

If you have suggestions to improve the security for deployment, please feel free to open a pull request. I am far from an expert on security issues and would welcome any assistance or suggestions.

## License
DjangoDockerDevDeploy (4D) is released under an MIT license. See [LICENSE](https://opensource.org/licenses/MIT) for more information.
