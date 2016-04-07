From: Thierry Delamare <t.delamare@laposte.net>
Subject: Re: aarch64 conditional ansible stanza
Date: Thu, 7 Apr 2016 18:35:43 +0200
Message-ID: <57068C5F.6080800@laposte.net>
References: <5706025B.3080205@dachary.org> <5706679B.6030606@laposte.net>
 <570669A4.2010309@dachary.org> <57068176.3090706@laposte.net>
 <5706863D.5050500@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpoutz28.laposte.net ([194.117.213.103]:48789 "EHLO
	smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751440AbcDGRAd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 13:00:33 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
	by lpn-prd-vrout016 (Postfix) with ESMTP id 1194B111C13
	for <ceph-devel@vger.kernel.org>; Thu,  7 Apr 2016 18:35:46 +0200 (CEST)
Received: from lpn-prd-vrin001 (lpn-prd-vrin001.laposte [10.128.63.2])
	by lpn-prd-vrout016 (Postfix) with ESMTP id 0529D1113FE
	for <ceph-devel@vger.kernel.org>; Thu,  7 Apr 2016 18:35:46 +0200 (CEST)
Received: from lpn-prd-vrin001 (localhost [127.0.0.1])
	by lpn-prd-vrin001 (Postfix) with ESMTP id E576A365D10
	for <ceph-devel@vger.kernel.org>; Thu,  7 Apr 2016 18:35:45 +0200 (CEST)
In-Reply-To: <5706863D.5050500@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 04/07/2016 06:09 PM, Loic Dachary wrote:
>
> On 07/04/2016 17:49, Thierry Delamare wrote:
>>
>> On 04/07/2016 04:07 PM, Loic Dachary wrote:
>>> On 07/04/2016 15:58, Thierry Delamare wrote:
>>>> On 04/07/2016 08:46 AM, Loic Dachary wrote:
>>>>> Hi Thierry,
>>>>>
>>>>> In order to only install a template on architectures that are not=
 aarch64, I changed
>>>>>
>>>>> - name: Add sources list
>>>>>      template:
>>>>>        dest: /etc/apt/sources.list
>>>>>        src: "../../templates/apt/sources.list.{{ ansible_distribu=
tion_release | lower }}"
>>>>>        owner: root
>>>>>        group: root
>>>>>        mode: 0644
>>>>>      register: sources
>>>>>
>>>>> into
>>>>>
>>>>> - name: Add sources list
>>>>>      template:
>>>>>        dest: /etc/apt/sources.list
>>>>>        src: "../../templates/apt/sources.list.{{ ansible_distribu=
tion_release | lower }}"
>>>>>        owner: root
>>>>>        group: root
>>>>>        mode: 0644
>>>>>      register: sources
>>>>>      when: {{ansible_architecture}} !=3D aarch64
>>>>>
>>>>> Is there a better way to do that ?
>>>> Bonjour Loic,
>>>>
>>>> Using when statement is the correct way to add conditions to a tas=
k,
>>>> but don't forget that the when clause contains a Jinja2 expression=
 (not like a module argument),
>>>> Thus the correct expression should rather be =C2=AB when: ansible_=
architecture !=3D 'aarch64' =C2=BB.
>>> Indeed, the previous attempt failed :-) Here is a more elaborate ve=
rsion that also excludes some packages that are not available in the aa=
rch64 repositories. How does that look ?
>>>
>>> https://github.com/ceph/ceph-cm-ansible/pull/224/commits/80e1cb2f36=
88393f4238268a543e6c3ab19bae75
>>>
>> That looks good to me, but.
>> You could also use the already existing scheme for defining vars or =
even including plays depending on distribution or (if you take care of =
it) architecture.
>> I mean that you could create a roles/testnode/tasks/setup-ubuntu-aar=
ch32.yml with only the needed tasks (instead of conditionally exclude m=
ost of them in roles/testnode/tasks/setup-ubuntu.yml) and change roles/=
testnode/tasks/main.yml to add =C2=AB - { include: setup-ubuntu-aarch32=
=2Eyml, when: ansible_distribution =3D=3D "Ubuntu" and ansible_architec=
ture =3D=3D 'aarch32' } =C2=BB (maybe you also want to rename setup-ubu=
ntu.yml as setup-ubuntu-aarch64.yml and change main.yml accordingly)
>> If the common part between aarch32 and aarch64 duplicate to much, ke=
ep a common setup-ubuntu.
> I did that, it looks better :-)
>
>> Similarly for packages lists (more usual), add roles/testnode/vars/u=
buntu-aarch64.yml and ubuntu-aarch32.yml for respective specific packag=
es and use an include_vars directive using ansible_distribution and ans=
ible_architecture once in roles/testnode/tasks/vars.yml instead of many=
 when clauses.
> I'm not sure I get where the simplification is. When I try this, I en=
d up with more indirection levels and it feels more complicated.
I don't say it's the simplest way to get your changes done, but it look=
=20
like more coherent with existing scheme (itself familiar to ansible=20
users) and probably will be easier to find and evolve for newcomers=20
(main include vars which include version dependent files defining=20
version dependent vars)
>  =20
>
>> PS: Maybe you could teach me how to boostrap a working env next time=
 we cowork.
> You should be able to follow the HOWTO at http://dachary.org/?p=3D393=
9 when you get a chance :-) Or I'll show you.
Thanks for the link. I will try.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
