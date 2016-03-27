From: Loic Dachary <loic@dachary.org>
Subject: Re: ansible stalls because the inventory is too big
Date: Mon, 28 Mar 2016 00:33:27 +0200
Message-ID: <56F85FB7.8050004@dachary.org>
References: <56F85ED0.5060605@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40642 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbcC0Wdd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Mar 2016 18:33:33 -0400
In-Reply-To: <56F85ED0.5060605@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thierry Delamare <t.delamare@laposte.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


[resuming the previous mail, sent too early by mistake :-]

On 28/03/2016 00:29, Loic Dachary wrote:
> Hi Thierry,
>=20
> When teuthology runs ansible on a newly created host as:
>=20
> /home/ubuntu/teuthology/virtualenv/bin/python /home/ubuntu/teuthology=
/virtualenv/bin/ansible-playbook -v --extra-vars {"ansible_ssh_user": "=
ubuntu"} -i /etc/ansible/hosts --limit target010011010028.teuthology /h=
ome/ubuntu/src/ceph-cm-ansible_master/cephlab.yml
>=20
> it stalls because there are too many hosts in the inventory (65537) a=
nd
>=20
> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203193=
=2Eteuthology", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (No su=
ch file or directory)
> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203193=
=2Eteuthology.yml", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (N=
o such file or directory)
> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203193=
=2Eteuthology.yaml", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (=
No such file or directory)
> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203193=
=2Eteuthology.json", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (=
No such file or directory)
> newfstatat(AT_FDCWD, "/etc/ansible/hosts/", {st_mode=3DS_IFDIR|0755, =
st_size=3D4096, ...}, 0) =3D 0
> newfstatat(AT_FDCWD, "/etc/ansible/hosts", {st_mode=3DS_IFDIR|0755, s=
t_size=3D4096, ...}, 0) =3D 0
> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203194=
=2Eteuthology", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (No su=
ch file or directory)
> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203194=
=2Eteuthology.yml", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (N=
o such file or directory)
> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203194=
=2Eteuthology.yaml", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (=
No such file or directory)
> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203194=
=2Eteuthology.json", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (=
No such file or directory)
>=20
> takes forever. This is running on an ARMv8 virtual machine:
>=20

(virtualenv)ubuntu@teuthology:~/teuthology$ cat /proc/cpuinfo=20
Processor	: AArch64 Processor rev 1 (aarch64)
processor	: 0
=46eatures	: fp asimd evtstrm=20
CPU implementer	: 0x50
CPU architecture: AArch64
CPU variant	: 0x0
CPU part	: 0x000
CPU revision	: 1

Hardware	: linux,dummy-virt

which also explains why it's not very fast. Do you know of a way to ask=
 ansible to only consider one host instead of what appears to be a syst=
ematic exploration of all possible hosts in the inventory, only to fina=
lly select the one from the --limit argument ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
