# Your custom extensions goes here

## Creating Custom Entity

Creating your own custom entities are very easy in EspoCRM.

[Create Custom Entity](https://www.espocrm.com/blog/how-to-create-custom-entity/)

If you want to modify an existing entity then make sure you override the following files.

I will take Lead for example, and let's say ProjectManager is the Module Name.

- `/crm/projects/files/application/Espo/Modules/ProjectManager/Controllers/Lead.php`

**If you don't inherit this file, then while loading Leads in application you will receive 404 Error**

Ideally, this class should not contain any logic.

Methods in this class should do the following:
1) See if request method is valid
2) See if required data is sent
3) See if user has privilege to make request
4) Call required service using `$this->getRecordService("ServiceClassName")->serviceMethodName();`
5) Return response in the form of array

```php
namespace Espo\Modules\ProjectManager\Controllers;

class Lead extends \Espo\Modules\Crm\Controllers\Lead
{
}
```

- `/crm/projects/files/application/Espo/Modules/ProjectManager/Entities/Lead.php`

**If you don't inherit this file, then while loading Leads in application you will receive Bad Server Response.**

```php
namespace Espo\Modules\ProjectManager\Entities;

class Lead extends \Espo\Modules\Crm\Entities\Lead
{
}
```

- `/crm/projects/files/application/Espo/Modules/ProjectManager/Repositories/Lead.php`

Database level operations are performed here like `afterSave`, `beforeSave`, etc...
**If you don't inherit this file, then functions like afterSave written in Crm Module of Espo's base repository will not run for Lead after creating an entry in database.**

You can also use [Hooks](https://www.espocrm.com/documentation/development/hooks/) to do the same.

```php
namespace Espo\Modules\ProjectManager\Repositories;

class Lead extends \Espo\Modules\Crm\Repositories\Lead
{
}
```

- `/crm/projects/files/application/Espo/Modules/ProjectManager/SelectManagers/Lead.php`

Used to add custom filters in UI's List View.

```php
namespace Espo\Modules\ProjectManager\SelectManagers;

class Lead extends \Espo\Modules\Crm\SelectManagers\Lead
{
}
```

- `/crm/projects/files/application/Espo/Modules/ProjectManager/Services/Lead.php`

Contains Logic to perform operations and is called by Controllers

```php
namespace Espo\Modules\ProjectManager\Services;

class Lead extends \Espo\Modules\Crm\Services\Lead
{
}
```

Make sure you go through all the folders `\Espo\Modules\Crm` to see if there is `Lead.php` and inherit all the files in exact same folder structure.

# The Resources Folder

Path: `/crm/projects/files/application/Espo/Modules/ProjectManager/Resources/`

Contains:
- `i18n/`
  - `en_US/`
    - `Global.json`
      - Contains Scope names and Plural Scope Names
    - `Lead.json`
      - Contains the labels for each fields, buttons, links and drop downs that is display when the UI is loaded in the browser.
- `layouts/`
  - `Lead/`
    - `detail.json`
      - Contains detailed layout structure. On browser which field should show up where is defined by this file.
    - `list.json`
      - When listing all leads, which fields to display is defined by this file.
    - `listSmall.json`
      - When listing leads associated to another entity, which fields to display is defined by this file.
    - `massUpdate.json`
      - In list view, which fields can be mass updated is defined by this file.
    - `filters.json`
      - While filtering out leads in list view, which fields can be used to filter out is defined by this file.
- `metadata/`
  - `clientDefs/`
    - `Lead.json`
      - Specifies where to load the javascript files and css templates from, all detail view, list view, buttons, side-panels, controllers, etc...
  - `entityDefs/`
    - `Lead.json`
      - Specifies which fields are present in database and Lead relates to which other database entities(table relationships)
      - While building/rebuilding database, the `create table` query is constructed using this file.
  - `scopes/`
    - `Lead.json`
      - Make sure this file contains `module` field as `ProjectManager`. otherwise, your layouts will not load.
- `routes.json`
  - All your custom controllers routes goes here if necessary only.
  - Usually, it is not very uncommon to add routes unless you have some special API to access certain entity.
- `module.json`
  - This file specifies order in which Module should be loaded. Lower the order, sooner the files are loaded.
  - Crm module in the base code has 10 as value.
  - Since, you're inheriting Lead, you're module order should be greater than 10. 11 for instance will do fine.

## Creating Installable Extension

For the custom entities you have created, making it installable in the EspoCRM base application is quite simple.

Here's how: [Creating an installable extension package](https://www.espocrm.com/blog/creating-an-installable-extension-package/)

## Tree structure

- `/crm/projects/\<project-name\>/`
  - `files/`
    - `application/Espo/Modules/\<ModuleName\>/`
    - `client/modules/\<modulename\>/`
    - `CommandLineRunners.php`
  - `scripts/`
    - `BeforeInstall.php`
    - `AfterInstall.php`
    - `BeforeUninstall.php`
    - `AfterUninstall.php`
  - `manifest.json`

The `scripts` folder is an optional folder.

In `dev.docker-compose.yml`, mount to folders

```
- /crm/projects/<project-name>/files/application/Espo/Modules/<ModuleName>:/crm/espocrm/application/Espo/Modules/<ModuleName>
- /crm/projects/<project-name>/files/client/modules/<modulename>:/crm/espocrm/client/modules/<modulename>
- /crm/projects/<project-name>/files/CommandLineRunners.php:/crm/espocrm/CommandLineRunners.php
```

In `Dockerfile`, use below

```
COPY ./projects/<project-name>/files /crm/espocrm
```

---
[HOME](../README.md)
