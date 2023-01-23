# pocVSphere
Create / Destroy resources with terraform for VSphere

## Prerequicites
### Packages Ubuntu

The user needs to install the `sshpass` package for ssh username / keys. Sample:

```bash
sudo apt-get install sshpass -y
```

### Packages Ansible

The user needs to install the python package for encryption / descryption. Sample:

```bash
pip install cryptography
```

If the user observes the error:

```bash
$ ansible-vault encrypt terraform-role/vars/secure-vars.yml
New Vault password: # manual input
Confirm New Vault password: # manual input
ERROR! ansible-vault requires the cryptography library in order to function
```

The user either has not installed the Python package or the package needs to be reinstalled.

Sample of reinstalling the pip package:

```bash
$ pip install --upgrade --force-reinstall cryptography
Defaulting to user installation because normal site-packages is not writeable
Collecting cryptography
  Downloading cryptography-39.0.0-cp36-abi3-manylinux_2_28_x86_64.whl (4.2 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 4.2/4.2 MB 9.8 MB/s eta 0:00:00
Collecting cffi>=1.12
  Downloading cffi-1.15.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (462 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 462.6/462.6 kB 10.4 MB/s eta 0:00:00
Collecting pycparser
  Downloading pycparser-2.21-py2.py3-none-any.whl (118 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 118.7/118.7 kB 7.6 MB/s eta 0:00:00
Installing collected packages: pycparser, cffi, cryptography
Successfully installed cffi-1.15.1 cryptography-39.0.0 pycparser-2.21
```

Then simply encode the file sample:

```bash
$ ansible-vault encrypt terraform-role/vars/secure-vars.yml
New Vault password: # manual input
Confirm New Vault password: # manual input
Encryption successful
$ cat terraform-role/secrets/secure-vars.yml
$ANSIBLE_VAULT;1.1;AES256
37353362306165316664383932326332323332656136306265656661396131333764336166613064
6636376366363264376461376630326361386231653763350a663665356236653336643938646433
61653366383930363238333238623964653936383637633034323936333966306564326330353738
3335313162363863370a396664646230386633396530353865333238346330316131633539643462
66663536373138396538653865613538316437376138353666616531393763623264316436316639
65376235663039396331373832633430626661333735643565316132313362363939303639313034
34363931396139616363363533646531396537643731393334373566346462643834336262656165
37323762633533316333623032666364303933363036653736383664326435356233663937386139
62343832663039613861613534313737333062396334383435656632313632666530
```

