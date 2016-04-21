# Riemann Ansible role

Ansible role for configuring the [Riemann] stream processor, for alerting
on Logstash events sent from an ELK logserver.
Intended for use with the [freedomofpress.elk] role.

Requirements
------------
* an ELK logserver to receive events from (see the [freedomofpress.elk] role)

Role Variables
--------------
```yaml
```

Example Playbook
----------------

```
- name: Install Riemann server.
  hosts: logserver
  become: yes
  vars_files:
    - vars/slack_api.yml
  roles:
    - role: freedomofpress.riemann
  tags: riemann
```

Running the tests
-----------------

This role uses [Molecule] and [ServerSpec] for testing. To use it:

```
pip install molecule
gem install serverspec
molecule test
```

You can also run selective commands:

```
molecule idempotence
molecule verify
```

See the [Molecule] docs for more info.

Contributions
-------------
The following resources were invaluable in creating this role.

* [Riemann official guide](http://riemann.io/howto.html#putting-riemann-into-production)

License
-------

MIT

[Molecule]: http://molecule.readthedocs.org/en/master/
[ServerSpec]: http://serverspec.org/
[freedomofpress.elk]: https://github.com/freedomofpress/ansible-role-elk
[Riemann]: http://riemann.io
