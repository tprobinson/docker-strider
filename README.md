# docker-strider

<!-- MDTOC maxdepth:6 firsth1:0 numbering:0 flatten:1 bullets:1 updateOnSave:1 -->

- [Usage](#usage)   
- [Customization](#customization)   
- [Change the URL env vars](#change-the-url-env-vars)   
- [Raise the `CONCURRENT_JOBS` env var](#raise-the-concurrent_jobs-env-var)   
- [Change the SMTP server env vars](#change-the-smtp-server-env-vars)   
- [Change the initial admin username or password env vars](#change-the-initial-admin-username-or-password-env-vars)   
- [Change the initial plugins env var](#change-the-initial-plugins-env-var)   
- [Serve Strider through HTTPS](#serve-strider-through-https)   

<!-- /MDTOC -->

This repository includes a Dockerfile and Docker Compose file for creating a [Strider CI](https://github.com/Strider-CD/strider) installation.

## Usage

- Compile the image:

```bash
docker build -t strider/strider .
```

The included Docker Compose file is an example and should be customized to fit your needs, but can be used as is for a quick demo by adding `strider.example.com` to your hosts file as an alias for `127.0.0.1`.


- Use Compose:

```bash
docker-compose up -d
```

The initial launch may take a moment as some plugins are installed. Once launched, the container's copy of those plugins will persist, and future launches will be faster.


## Customization

The following is suggested to customize the Docker Compose installation to your needs:

- ###### Change the URL env vars
> Strider requires that the `SERVER_NAME` variable be set to its base, externally reachable URL. If you were to restrict Strider to being reached only over HTTPS, you might change the URL to similarly be HTTPS.

- ###### Raise the `CONCURRENT_JOBS` env var
> This number is 1 by default.

- ###### Change the SMTP server env vars
> As in the Strider documentation, environment variables to configure SMTP are available.

- ###### Change the initial admin username or password env vars
> This feature is specific to this image. When the container comes up for the first time (or if you delete the `.admin_user_created` file in the root of the image), a user with the specified name and password will be created.
>
> However, if the user already exists, it may cause the container to crash when `strider-cli` asks for confirmation to force override. Create a file at `/.admin_user_created`, or blank the `STRIDER_ADMIN_EMAIL` variable to stop the auto-creation.

- ###### Change the initial plugins env var
> The `STRIDER_PLUGINS` variable is a space separated list of plugin names to be installed when the container is run for the first time. It must include at least one task runner (`simple-runner` is a good starting point) or the container will crash.

- ###### Serve Strider through HTTPS
> As seen in the [`jwilder/nginx-proxy` image documentation](https://github.com/jwilder/nginx-proxy), put an SSL cert as `<domain name>.crt` and `<domain name>.key` in the `volumes/ssl` directory to serve over HTTPS. You can then remove the port-forwarding of `80:80` in the nginx service.
