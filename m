From: Loic Dachary <loic@dachary.org>
Subject: Re: aarch64 conditional ansible stanza
Date: Thu, 7 Apr 2016 18:09:33 +0200
Message-ID: <5706863D.5050500@dachary.org>
References: <5706025B.3080205@dachary.org> <5706679B.6030606@laposte.net>
 <570669A4.2010309@dachary.org> <57068176.3090706@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:36534 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbcDGQJ7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 12:09:59 -0400
In-Reply-To: <57068176.3090706@laposte.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thierry Delamare <t.delamare@laposte.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 07/04/2016 17:49, Thierry Delamare wrote:
>=20
>=20
> On 04/07/2016 04:07 PM, Loic Dachary wrote:
>>
>> On 07/04/2016 15:58, Thierry Delamare wrote:
>>>
>>> On 04/07/2016 08:46 AM, Loic Dachary wrote:
>>>> Hi Thierry,
>>>>
>>>> In order to only install a template on architectures that are not =
aarch64, I changed
>>>>
>>>> - name: Add sources list
>>>>     template:
>>>>       dest: /etc/apt/sources.list
>>>>       src: "../../templates/apt/sources.list.{{ ansible_distributi=
on_release | lower }}"
>>>>       owner: root
>>>>       group: root
>>>>       mode: 0644
>>>>     register: sources
>>>>
>>>> into
>>>>
>>>> - name: Add sources list
>>>>     template:
>>>>       dest: /etc/apt/sources.list
>>>>       src: "../../templates/apt/sources.list.{{ ansible_distributi=
on_release | lower }}"
>>>>       owner: root
>>>>       group: root
>>>>       mode: 0644
>>>>     register: sources
>>>>     when: {{ansible_architecture}} !=3D aarch64
>>>>
>>>> Is there a better way to do that ?
>>> Bonjour Loic,
>>>
>>> Using when statement is the correct way to add conditions to a task=
,
>>> but don't forget that the when clause contains a Jinja2 expression =
(not like a module argument),
>>> Thus the correct expression should rather be =C2=AB when: ansible_a=
rchitecture !=3D 'aarch64' =C2=BB.
>> Indeed, the previous attempt failed :-) Here is a more elaborate ver=
sion that also excludes some packages that are not available in the aar=
ch64 repositories. How does that look ?
>>
>> https://github.com/ceph/ceph-cm-ansible/pull/224/commits/80e1cb2f368=
8393f4238268a543e6c3ab19bae75
>>
> That looks good to me, but.
> You could also use the already existing scheme for defining vars or e=
ven including plays depending on distribution or (if you take care of i=
t) architecture.
> I mean that you could create a roles/testnode/tasks/setup-ubuntu-aarc=
h32.yml with only the needed tasks (instead of conditionally exclude mo=
st of them in roles/testnode/tasks/setup-ubuntu.yml) and change roles/t=
estnode/tasks/main.yml to add =C2=AB - { include: setup-ubuntu-aarch32.=
yml, when: ansible_distribution =3D=3D "Ubuntu" and ansible_architectur=
e =3D=3D 'aarch32' } =C2=BB (maybe you also want to rename setup-ubuntu=
=2Eyml as setup-ubuntu-aarch64.yml and change main.yml accordingly)
> If the common part between aarch32 and aarch64 duplicate to much, kee=
p a common setup-ubuntu.

I did that, it looks better :-)

> Similarly for packages lists (more usual), add roles/testnode/vars/ub=
untu-aarch64.yml and ubuntu-aarch32.yml for respective specific package=
s and use an include_vars directive using ansible_distribution and ansi=
ble_architecture once in roles/testnode/tasks/vars.yml instead of many =
when clauses.

I'm not sure I get where the simplification is. When I try this, I end =
up with more indirection levels and it feels more complicated.

> PS: Maybe you could teach me how to boostrap a working env next time =
we cowork.

You should be able to follow the HOWTO at http://dachary.org/?p=3D3939 =
when you get a chance :-) Or I'll show you.

Cheers

>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
