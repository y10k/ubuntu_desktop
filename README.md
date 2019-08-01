ubuntu_desktop
==============

Ubuntuのデスクトップ環境をセットアップする。
自分で使うための個人用設定。

前提条件
--------

あんまりない。

事前作業
--------

### 1. 必要なツールの準備

```
$ su
Password:
# apt-get install git sudo ansible
```

### 2. sudoの許可

```
# vigr
sudo:x:**:toki
:wq
# exit
$ sudo id
[sudo] password for toki:
uid=0(root) gid=0(root) groups=0(root)
```

### 3. プレイブックの準備

```
$ git clone https://github.com/y10k/ubuntu_desktop.git
Cloning into 'ubuntu_desktop'...
remote: Enumerating objects: 365, done.
remote: Counting objects: 100% (365/365), done.
remote: Compressing objects: 100% (148/148), done.
remote: Total 365 (delta 130), reused 364 (delta 129), pack-reused 0
Receiving objects: 100% (365/365), 35.10 KiB | 561.00 KiB/s, done.
Resolving deltas: 100% (130/130), done.
$ cd ubuntu_desktop
```

### 4. Ansible-Galaxyのインストール

```
$ ansible-galaxy install y10k.kelleyk_emacs y10k.ruby_build y10k.rubygems_setup
```

```
$ ansible-galaxy list
- y10k.kelleyk_emacs, master
- y10k.rubygems_environment, master
- y10k.rubygems_setup, master
- y10k.ruby_build, master
```

### 5. 疎通確認

最初はRubyおよびRakeが入ってないので、Rakeタスクを使わずに直接Ansible
を実行する。

```
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

```
$ ansible-playbook -Ki inventory/local site.yml
SUDO password:

PLAY [all] *******************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************
ok: [localhost]

...省略...

PLAY RECAP *******************************************************************************************************************************************
localhost                  : ok=26   changed=4    unreachable=0    failed=0
```
