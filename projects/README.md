# Your custom extensions goes here

Tree structure

- /crm/projects/<project-name>
  - files
    - application/Espo/Modules/<ModuleName>
    - client/modules/<modulename>
    - CommandLineRunners.php
  - scripts
    - BeforeInstall.php
    - AfterInstall.php
    - BeforeUninstall.php
    - AfterUninstall.php
  - manifest.json

In dev.docker-compose.yml, mount to folders

```
- /crm/projects/<project-name>/files/application/Espo/Modules/<ModuleName>:/crm/espocrm/application/Espo/Modules/<ModuleName>
- /crm/projects/<project-name>/files/client/modules/<modulename>:/crm/espocrm/client/modules/<modulename>
- /crm/projects/<project-name>/files/CommandLineRunners.php:/crm/espocrm/CommandLineRunners.php
```

In Dockerfile, use below

```
COPY ./projects/<project-name>/files /crm/espocrm
```
