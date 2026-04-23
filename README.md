```yml
# Lab simulatorr: FailverLab RH134
# Author: Alexander Aguilar
# Email: alexolomeo@gmail.com
```

This lab is a test simulator, allow to repeat any time and improve your skills on  RHEL 9, to used Supported:

* Ansible
* Red Hat Enterprise Linux 9.x 

### Requirement package and basic Installed.
-  lvbirt
-  kvm
-  net-tools
-  ansible-core
-  setup ssh-key sshd

###  Lab initial setup suppoted

To init and configure lab, you need apply  `la configure initl`.

# Command to init the lab, once apply
```yml
lab configure init
```

##  Process action supported for simulate test

#start topic lab
Generate a default state.
```yml
lab start <evalutor-topic>
```

#Init evaluator simulator
This apply all validator test and generate a output score of yours setup.
```yml
lab simulate <evalutor-topic>
```

#finish topic lab
Close all dependences and default started.
```yml
lab finish <evalutor-topic>
```


##  Process action supported for grade test

#start topic lab
Generate a default state.
```yml
lab start <evalutor-topic>
```

#Init evaluator simulator
This apply all validator test and generate a output score of yours setup.
```yml
lab grade <evalutor-topic>
```

#finish topic lab
Close all dependences and default started.
```yml
lab finish <evalutor-topic>
```

##  Process action supported  adictional

#Get list <evalutor-topic>

Generate a list
```yml
lab list
```

#Process  info  simulator
This apply all validator.
```yml
lab info <evalutor-topic>
```




###  Playbook setup suppoted

## SELinux example playbook suppoted
This example is basic definition to playbook launch.

```yml
---

- name: selinux opsmode
  hosts: workstation
  gather_facts: no
  become: true
  vars: 
    failover_mode: "start"
  roles:
    - role: selinux-opsmode
      failover_project: selinux-opsmode               # lab <failover_mode> <failover_project>
      failover_environment: "workstation"               # workstation, servera serverb 
      failover_user: root 
      failover_group: root


- name: selinux opsmode
  hosts: servera
  gather_facts: no
  become: true
  vars: 
    failover_mode: "start"
  roles:
    - role: selinux-opsmode
      failover_remote_project: selinux-opsmode
      failover_remote_environment: "servera"              # workstation, servera serverb 
      failover_remote_user: root
      failover_remote_group: root
```

