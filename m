From: Thierry Delamare <t.delamare@laposte.net>
Subject: Re: aarch64 conditional ansible stanza
Date: Thu, 7 Apr 2016 17:49:10 +0200
Message-ID: <57068176.3090706@laposte.net>
References: <5706025B.3080205@dachary.org> <5706679B.6030606@laposte.net>
 <570669A4.2010309@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpoutz298.laposte.net ([178.22.154.198]:40538 "EHLO
	smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756508AbcDGPtQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 11:49:16 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
	by lpn-prd-vrout010 (Postfix) with ESMTP id 30F2E459F6D
	for <ceph-devel@vger.kernel.org>; Thu,  7 Apr 2016 17:49:13 +0200 (CEST)
Received: from lpn-prd-vrin003 (lpn-prd-vrin003.laposte [10.128.63.4])
	by lpn-prd-vrout010 (Postfix) with ESMTP id 2ABAC459A73
	for <ceph-devel@vger.kernel.org>; Thu,  7 Apr 2016 17:49:13 +0200 (CEST)
Received: from lpn-prd-vrin003 (localhost [127.0.0.1])
	by lpn-prd-vrin003 (Postfix) with ESMTP id 1998548CD48
	for <ceph-devel@vger.kernel.org>; Thu,  7 Apr 2016 17:49:13 +0200 (CEST)
In-Reply-To: <570669A4.2010309@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 04/07/2016 04:07 PM, Loic Dachary wrote:
>
> On 07/04/2016 15:58, Thierry Delamare wrote:
>>
>> On 04/07/2016 08:46 AM, Loic Dachary wrote:
>>> Hi Thierry,
>>>
>>> In order to only install a template on architectures that are not a=
arch64, I changed
>>>
>>> - name: Add sources list
>>>     template:
>>>       dest: /etc/apt/sources.list
>>>       src: "../../templates/apt/sources.list.{{ ansible_distributio=
n_release | lower }}"
>>>       owner: root
>>>       group: root
>>>       mode: 0644
>>>     register: sources
>>>
>>> into
>>>
>>> - name: Add sources list
>>>     template:
>>>       dest: /etc/apt/sources.list
>>>       src: "../../templates/apt/sources.list.{{ ansible_distributio=
n_release | lower }}"
>>>       owner: root
>>>       group: root
>>>       mode: 0644
>>>     register: sources
>>>     when: {{ansible_architecture}} !=3D aarch64
>>>
>>> Is there a better way to do that ?
>> Bonjour Loic,
>>
>> Using when statement is the correct way to add conditions to a task,
>> but don't forget that the when clause contains a Jinja2 expression (=
not like a module argument),
>> Thus the correct expression should rather be =C2=AB when: ansible_ar=
chitecture !=3D 'aarch64' =C2=BB.
> Indeed, the previous attempt failed :-) Here is a more elaborate vers=
ion that also excludes some packages that are not available in the aarc=
h64 repositories. How does that look ?
>
> https://github.com/ceph/ceph-cm-ansible/pull/224/commits/80e1cb2f3688=
393f4238268a543e6c3ab19bae75
>
That looks good to me, but.
You could also use the already existing scheme for defining vars or eve=
n=20
including plays depending on distribution or (if you take care of it)=20
architecture.
I mean that you could create a=20
roles/testnode/tasks/setup-ubuntu-aarch32.yml with only the needed task=
s=20
(instead of conditionally exclude most of them in=20
roles/testnode/tasks/setup-ubuntu.yml) and change=20
roles/testnode/tasks/main.yml to add =C2=AB - { include:=20
setup-ubuntu-aarch32.yml, when: ansible_distribution =3D=3D "Ubuntu" an=
d=20
ansible_architecture =3D=3D 'aarch32' } =C2=BB (maybe you also want to =
rename=20
setup-ubuntu.yml as setup-ubuntu-aarch64.yml and change main.yml=20
accordingly)
If the common part between aarch32 and aarch64 duplicate to much, keep =
a=20
common setup-ubuntu.
Similarly for packages lists (more usual), add=20
roles/testnode/vars/ubuntu-aarch64.yml and ubuntu-aarch32.yml for=20
respective specific packages and use an include_vars directive using=20
ansible_distribution and ansible_architecture once in=20
roles/testnode/tasks/vars.yml instead of many when clauses.

PS: Maybe you could teach me how to boostrap a working env next time we=
=20
cowork.


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
