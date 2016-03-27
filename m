From: Loic Dachary <loic@dachary.org>
Subject: configuring ansible apt-repository for i386
Date: Sun, 27 Mar 2016 01:28:22 +0100
Message-ID: <56F72926.8000402@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43894 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbcC0A22 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Mar 2016 20:28:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thierry Delamare <t.delamare@laposte.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Thierry,

Running on an i386 host, ansible does the following:

TASK: [testnode | Add local apt repos.] *******************************=
******** ^M

2016-03-27 00:16:20,737.737 INFO:teuthology.task.ansible.out:^[[0;33mch=
anged: [target167114241144.teuthology] =3D> (item=3Ddeb http://gitbuild=
er.ceph.com/libapache-mod-fastcgi-deb-trusty-x86_64-basic/ref/master/ t=
rusty main) =3D> {"changed": true, "item": "deb http://gitbuilder.ceph.=
com/libapache-mod-fastcgi-deb-trusty-x86_64-basic/ref/master/ trusty ma=
in", "repo": "deb http://gitbuilder.ceph.com/libapache-mod-fastcgi-deb-=
trusty-x86_64-basic/ref/master/ trusty main", "state": "present"}^[[0m

where x86_64 should be i386. I traced that back to

https://github.com/ceph/ceph-cm-ansible/blob/master/roles/testnode/task=
s/apt/repos.yml#L52

- name: Add local apt repos.
  apt_repository:
    repo: "{{ item }}"
    state: present
    update_cache: no=20
    mode: 0644
  with_items: apt_repos|list + common_apt_repos|list
  register: local_apt_repos

Do you know how I canfigure out where "item" (which is presumably the i=
ncorrect http://gitbuilder.ceph.com/libapache-mod-fastcgi-deb-trusty-x8=
6_64-basic/ref/master/ here) is set ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
