# Ansible Boilerplate Code

What is boolerplate?
In computer programming, boilerplate code or boilerplate refers to sections of code that have to be included in many places with little or no alteration. It is often used when referring to languages that are considered verbose, i.e. the programmer must write a lot of code to do minimal jobs
Ref: 
##### Read more

- [Boilerplate Code - https://en.wikipedia.org/wiki/Boilerplate_code](https://en.wikipedia.org/wiki/Boilerplate_code)


### Directory structure

```
├── block
│
├── files
│
├── group_vars
│   ├── all
│   └── dev-api-backend
├── Inventory
│   └── hosts.ini
├── notes
│   └── tags.txt
├── roles
│   └── docker
│   └── docker-compose    
├── ssh
│   └── facts
│   └── logs
│       └── ansible.log
│   └── retry
├── ansible.cfg
│
└── dev-api-backend.yml

```

#### ansible.cfg

This is a project specific configuration file to configure Ansible. [View](ansible.cfg)
to see a more detailed explanation of the default settings provided by this
project.

##### Read more

- [Ansible.cfg - http://docs.ansible.com/ansible/intro_configuration.html](http://docs.ansible.com/ansible/intro_configuration.html)


#### inventories

This is where you should put the list of hosts for Ansible to connect to. It
also contains directories for [group_vars](http://docs.ansible.com/ansible/intro_inventory.html#group-variables) and [host_vars](http://docs.ansible.com/ansible/intro_inventory.html#host-variables).

Example:

```
.
├── group_vars
├── host_vars
└── production
```

We have a file called `production`, but if you have a lot of environments,
instead of `production`, you might call it `production_app_name` or
`app_name_production`, etc.

In it you might define it like so:

```yml
# inventories/production
[application]
app01.server.com
app02.server.com
app03.server.com

[database]
db01.server.com

[production:children]
application
database
```

`production:children`, indicates to Ansible this is a group of made of all the
things in the groups listed below.

So its equivalent to manually writing:

```
# inventories/production
[production]
app01.server.com
app02.server.com
app03.server.com
db01.server.com
```

##### group_vars

This directory contains yaml files which correspond to a group name, and tells
Ansible to load the variables for the hosts in that group.

Example structure:

```
.
└── group_vars
    ├── all
    │   └── ubuntu.yml
    ├── application
    │   ├── rails.yml
    │   └── secret
    │       └── rails.yml
    └── database
        ├── mysql.yml
        ├── postgresql.yml
        └── secret
            ├── mysql.yml
            └── postgresql.yml
```

- `all` - is a Ansible group, where it will be loaded for all hosts.
- `application`-  is a user defined group of hosts, we defined this in our `production` hosts file in the previous example.
- `database` - is a user defined group of hosts, we defined this in our `production` hosts file in the previous example.

A group variable file looks like this:

```yml
# inventories/group_vars/application/rails.yml
---
rails_version: 5.0.0
```

So the `rails_version` variable will be available for all hosts listed under `application` (app[0-3].server.com).

**NOTE:** You might have noticed the `secret` directory, this is where you can
take advantage of [ansible-vault](http://docs.ansible.com/ansible/playbooks_vault.html). For secret specific variables such as api keys and etc,
I like to put them inside a `secret` folder, and encrypt the folder with `ansible-vault`.

Secrets are prefixed with the key `secret_`.

Example:

```yml
# Encrypted secrets for rails
# inventories/group_vars/application/secret/rails.yml
---
secret_rails_secret_token: 1db372dbc0a8200da1d7f9c51384fe0094c940628c497e7e519eb4977aba244cdad0ab9c4965383d2dc9244296ea6b889fe711d40dc590a4455d17e1a012db58
```

```yml
# Unencrypted secrets for rails
# inventories/group_vars/application/rails.yml
---
rails_version: 5.0.0
rails_secret_token: "{{ secret_rails_secret_token }}"
```

You can see our unencrypted variable file reference the encrypted variable file's variable in `secret`.

##### host_vars

`host_vars` work just like `group_vars`, but instead of naming it after a
group name, you use the `hostname`. The variables only be loaded for that specific host.

Example:

```
.
└── host_vars
    └── app01.server.com
        └── rails.yml
```

##### Read More

- [Inventory - http://docs.ansible.com/ansible/intro_inventory.html](http://docs.ansible.com/ansible/intro_inventory.html)
- [Variables - http://docs.ansible.com/ansible/playbooks_variables.html](http://docs.ansible.com/ansible/playbooks_variables.html)

---

#### log

By default this is just a symlink to `ssh/logs/ansible.log`.

---

#### notes

This is where you can add your notes for things like manual configuration.

---

#### playbooks

##### Read More

- [Playbooks - http://docs.ansible.com/ansible/playbooks.html](http://docs.ansible.com/ansible/playbooks.html)

---
#### roles

This is where you can add your custom Ansible [roles](http://docs.ansible.com/ansible/playbooks_roles.html#roles) for usage by your playbooks.

##### Read more

[Roles - http://docs.ansible.com/ansible/playbooks_roles.html#roles](http://docs.ansible.com/ansible/playbooks_roles.html#roles)

---

#### tmp

A tmp directory for convenience. For example, you may prefer to write logs
here.

---
