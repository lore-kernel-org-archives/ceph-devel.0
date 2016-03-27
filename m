From: Loic Dachary <loic@dachary.org>
Subject: Re: configuring ansible apt-repository for i686
Date: Sun, 27 Mar 2016 17:36:08 +0200
Message-ID: <56F7FDE8.5010804@dachary.org>
References: <56F72926.8000402@dachary.org> <56F7C50D.7060703@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57752 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbcC0PgQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Mar 2016 11:36:16 -0400
In-Reply-To: <56F7C50D.7060703@laposte.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thierry Delamare <t.delamare@laposte.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Thierry,

Thanks for the detailed explanation of how to figure that out :-) https=
://github.com/ceph/ceph-cm-ansible/pull/220 has the suggested changes f=
or centos 7 and ubuntu.

Cheers

On 27/03/2016 13:33, Thierry Delamare wrote:
> On 03/27/2016 01:28 AM, Loic Dachary wrote:
>> Hi Thierry,
>>
>> Running on an i386 host, ansible does the following:
>>
>> TASK: [testnode | Add local apt repos.] ****************************=
*********** ^M
>>
>> 2016-03-27 00:16:20,737.737 INFO:teuthology.task.ansible.out:^[[0;33=
mchanged: [target167114241144.teuthology] =3D> (item=3Ddeb http://gitbu=
ilder.ceph.com/libapache-mod-fastcgi-deb-trusty-x86_64-basic/ref/master=
/ trusty main) =3D> {"changed": true, "item": "deb http://gitbuilder.ce=
ph.com/libapache-mod-fastcgi-deb-trusty-x86_64-basic/ref/master/ trusty=
 main", "repo": "deb http://gitbuilder.ceph.com/libapache-mod-fastcgi-d=
eb-trusty-x86_64-basic/ref/master/ trusty main", "state": "present"}^[[=
0m
>>
>> where x86_64 should be i386. I traced that back to
>>
>> https://github.com/ceph/ceph-cm-ansible/blob/master/roles/testnode/t=
asks/apt/repos.yml#L52
>>
>> - name: Add local apt repos.
>>    apt_repository:
>>      repo: "{{ item }}"
>>      state: present
>>      update_cache: no
>>      mode: 0644
>>    with_items: apt_repos|list + common_apt_repos|list
>>    register: local_apt_repos
>>
>> Do you know how I canfigure out where "item" (which is presumably th=
e incorrect http://gitbuilder.ceph.com/libapache-mod-fastcgi-deb-trusty=
-x86_64-basic/ref/master/ here) is set ?
>>
>> Cheers
>>
> Salut Loic,
>=20
> - This task iterate over the cat of two vars (apt_repos and common_ap=
t_repos (yaml list, jinja, iterable converted to list))
> - These vars are (as expected) defined in the std role vars dir (test=
node/vars)
>   - ansible auto include vars/main.yml, but in this case, as we mainl=
y have distribution specific vars, the include come from testnode/tasks=
/vars.yml (testnode/tasks/vars.yml being itself the first task of testn=
ode/tasks/main.yml)
>   - testnode/tasks/vars.yml use ansible auto defined variables (like =
ansible_distribution or ansible_distribution_major_version) to include =
the correct files from testnode/tasks (eg. centos_7.yml or ubuntu_14.ym=
l)
> - As a quick an dirty fix or test step you can always redefine a var =
at ansible invocation using --extra-vars (but you will need to use yaml=
 or json instead of key=3Dval because common_apt_repos expect a list)
> - A simple fix could probably be to replace the srt x86_64 by ansible=
_architecture in testnode/vars files where it occurs
>=20
> - In your specific case:
>=20
>   echo -e '/x86_64/s//{{ansible_architecture}}/\nwq' | ed roles/testn=
ode/vars/ubuntu.yml
>=20
> - But maybe also in centos_{6,7} debian7 redhat{6,7}
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
