ubuntu_desktop
==============

Ubuntuのデスクトップ環境をセットアップする。
自分で使うための個人用設定。

前提条件
--------

あんまりない。

事前作業
--------

### 1. Ansibleのインストール

```sh
$ sudo apt-get install ansible
```

### 2. Ansible-Galaxyのインストール

```sh
$ ansible-galaxy install y10k.kelleyk_emacs y10k.ruby_build y10k.rubygems_setup
```

```sh
$ ansible-galaxy list
- y10k.kelleyk_emacs, master
- y10k.rubygems_environment, master
- y10k.rubygems_setup, master
- y10k.ruby_build, master
```

### 3. 疎通確認

最初はRubyおよびRakeが入ってないので、Rakeタスクを使わずに直接Ansible
を実行する。

```sh
$ ansible -i inventory/local all -m ping
localhost | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

構築作業
--------

最初はRubyおよびRakeが入ってないので、Rakeタスクを使わずに直接Ansible
を実行する。

```sh
$ ansible-playbook -Ki inventory/local site.yml
SUDO password:

PLAY [all] *******************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************
ok: [localhost]

...省略...

PLAY RECAP *******************************************************************************************************************************************
localhost                  : ok=26   changed=4    unreachable=0    failed=0
```
