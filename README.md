<p align="center"><img src="https://user-images.githubusercontent.com/4303310/46391467-20d2c480-c6ee-11e8-9d0a-7f8bc09bb022.jpg" /></p>

> Ansible Boilerplate Code

<p align="center">
    <a href="LICENSE.md">
      <img src="https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square" alt="Software License">
    </a>
    <a href="https://www.paypal.me/anmolnagpal">
      <img src="https://img.shields.io/badge/PayPal-Buy%20Me%20A%20BEER-blue.svg?style=flat-squares" alt="Donate">
    </a>
  </p>
</p>

#### Read More

- [Boilerplate Code - https://en.wikipedia.org/wiki/Boilerplate_code](https://en.wikipedia.org/wiki/Boilerplate_code)

![playground](https://user-images.githubusercontent.com/4303310/38618767-9b1c3a72-3dab-11e8-9d3e-e1feb8787aca.png)



## Directory structure
```
├── _inventory
│   └── hosts.ini
│
├── _logs
│   └── facts
│   └── retry
│   └── ansible-log.json
│
├── _ssh
│   └── web.ssh.config
│
├── _ssl
│
├── group_vars
│   ├── all
│   └── dev-api-backend
│
├── notes
│   └── tags.md
│
├── roles
│   └── common
│   └── hardening
│   └── docker
│   └── docker-compose    
│
├── ansible.cfg
│
└── dev-bastion.yml
```
---

## ansible.cfg

This is a project specific configuration file to configure Ansible. [View](ansible.cfg)
to see a more detailed explanation of the default settings provided by this
project.

#### Read More

- [Ansible.cfg - http://docs.ansible.com/ansible/intro_configuration.html](http://docs.ansible.com/ansible/intro_configuration.html)

---

### group_vars

This directory contains yaml files which correspond to a group name, and tells
Ansible to load the variables for the hosts in that group.

Example structure:

```
└── group_vars
    ├── all
    │   └── global.yml
    └── dev-bastion
            └── config.yml
```

- `all` - is a Ansible group, where it will be loaded for all hosts.
- `dev-api-backend`-  is a user defined group of hosts, we defined this in our `dev-api-backend` hosts file in the previous example.

#### Read More

- [Variables - http://docs.ansible.com/ansible/playbooks_variables.html](http://docs.ansible.com/ansible/playbooks_variables.html)

---
## inventories

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
10.250.0.0 = Env=dev EcType=dev_api_backend EcName=dev_api_backend-dev-0-a Az=a K=0 Nr=0 PublicIp=54.00.00.00 
IType=t2.medium Region=eu-west-1 PrivateIp=10.00.00.00 PrivateDns=ip-10-00-00-00.eu-west-1.compute.internal

[all:children]
dev-api-backend
```

#### Read More

- [Inventory - http://docs.ansible.com/ansible/intro_inventory.html](http://docs.ansible.com/ansible/intro_inventory.html)

---

## notes

This is where you can add your notes for things like manual configuration.

---

## roles

This is where you can add your custom Ansible [roles](http://docs.ansible.com/ansible/playbooks_roles.html#roles) for usage by your playbooks.

#### Read More

[Roles - http://docs.ansible.com/ansible/playbooks_roles.html#roles](http://docs.ansible.com/ansible/playbooks_roles.html#roles)

---

## logs

By default this is just a symlink to `./_logs/ansible-log.json`

---
## 👬 Contribution

- Open pull request with improvements
- Discuss ideas in issues
- Reach out with any feedback [![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/anmol_nagpal.svg?style=social&label=Follow%20%40anmol_nagpal)](https://twitter.com/anmol_nagpal)
