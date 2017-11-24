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
│
├── Inventory
│   └── hosts.ini
│
├── notes
│   └── tags.txt
├── roles
│   └── docker
│   └── docker-compose    
│
├── ssh
│   └── facts
│   └── logs
│       └── ansible.log
│   └── retry
│
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


##### group_vars

This directory contains yaml files which correspond to a group name, and tells
Ansible to load the variables for the hosts in that group.

Example structure:

```
.
└── group_vars
    ├── all
    │   └── global.yml
    └── dev-api-backend
            └── config.yml
```

- `all` - is a Ansible group, where it will be loaded for all hosts.
- `dev-api-backend`-  is a user defined group of hosts, we defined this in our `dev-api-backend` hosts file in the previous example.

##### Read More

- [Variables - http://docs.ansible.com/ansible/playbooks_variables.html](http://docs.ansible.com/ansible/playbooks_variables.html)

#### inventories

This is where you should put the list of hosts for Ansible to connect to. It

Example:

```
├── hosts.ini
```

We have a file called `hosts.ini`, but if you have a lot of environments,
instead of `develop`, you might call it `dev-api-backend` or
`dev-db-mongodb`, etc.

In it you might define it like so:

```
[dev-api-backend]
10.250.12.51 = Env=dev EcType=dev_api_backend EcName=dev_api_backend-dev-0-a Az=a K=0 Nr=0 PublicIp=54.00.00.00 IType=t2.medium Region=eu-west-1 PrivateIp=10.00.00.00 PrivateDns=ip-10-00-00-00.eu-west-1.compute.internal

[all:children]
dev-api-backend
```

##### Read More

- [Inventory - http://docs.ansible.com/ansible/intro_inventory.html](http://docs.ansible.com/ansible/intro_inventory.html)


#### notes

This is where you can add your notes for things like manual configuration.

#### roles

This is where you can add your custom Ansible [roles](http://docs.ansible.com/ansible/playbooks_roles.html#roles) for usage by your playbooks.

##### Read more

[Roles - http://docs.ansible.com/ansible/playbooks_roles.html#roles](http://docs.ansible.com/ansible/playbooks_roles.html#roles)

---
---

#### ssh/logs

By default this is just a symlink to `./ssh/logs/ansible.log`.

---
#### playbooks

##### Read More

- [Playbooks - http://docs.ansible.com/ansible/playbooks.html](http://docs.ansible.com/ansible/playbooks.html)

---