From: Loic Dachary <loic@dachary.org>
Subject: ansible stalls because the inventory is too big
Date: Mon, 28 Mar 2016 00:29:36 +0200
Message-ID: <56F85ED0.5060605@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37561 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbcC0W3l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Mar 2016 18:29:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thierry Delamare <t.delamare@laposte.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Thierry,

When teuthology runs ansible on a newly created host as:

/home/ubuntu/teuthology/virtualenv/bin/python /home/ubuntu/teuthology/v=
irtualenv/bin/ansible-playbook -v --extra-vars {"ansible_ssh_user": "ub=
untu"} -i /etc/ansible/hosts --limit target010011010028.teuthology /hom=
e/ubuntu/src/ceph-cm-ansible_master/cephlab.yml

it stalls because there are too many hosts in the inventory (65537) and

newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203193.t=
euthology", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (No such f=
ile or directory)
newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203193.t=
euthology.yml", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (No su=
ch file or directory)
newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203193.t=
euthology.yaml", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (No s=
uch file or directory)
newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203193.t=
euthology.json", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (No s=
uch file or directory)
newfstatat(AT_FDCWD, "/etc/ansible/hosts/", {st_mode=3DS_IFDIR|0755, st=
_size=3D4096, ...}, 0) =3D 0
newfstatat(AT_FDCWD, "/etc/ansible/hosts", {st_mode=3DS_IFDIR|0755, st_=
size=3D4096, ...}, 0) =3D 0
newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203194.t=
euthology", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (No such f=
ile or directory)
newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203194.t=
euthology.yml", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (No su=
ch file or directory)
newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203194.t=
euthology.yaml", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (No s=
uch file or directory)
newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203194.t=
euthology.json", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (No s=
uch file or directory)

takes forever. This is running on an ARMv8 virtual machine:


Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
