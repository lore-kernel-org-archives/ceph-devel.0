From: Loic Dachary <loic@dachary.org>
Subject: Re: aarch64 conditional ansible stanza
Date: Thu, 7 Apr 2016 16:07:32 +0200
Message-ID: <570669A4.2010309@dachary.org>
References: <5706025B.3080205@dachary.org> <5706679B.6030606@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:49226 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192AbcDGOKG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 10:10:06 -0400
In-Reply-To: <5706679B.6030606@laposte.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thierry Delamare <t.delamare@laposte.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 07/04/2016 15:58, Thierry Delamare wrote:
>=20
>=20
> On 04/07/2016 08:46 AM, Loic Dachary wrote:
>> Hi Thierry,
>>
>> In order to only install a template on architectures that are not aa=
rch64, I changed
>>
>> - name: Add sources list
>>    template:
>>      dest: /etc/apt/sources.list
>>      src: "../../templates/apt/sources.list.{{ ansible_distribution_=
release | lower }}"
>>      owner: root
>>      group: root
>>      mode: 0644
>>    register: sources
>>
>> into
>>
>> - name: Add sources list
>>    template:
>>      dest: /etc/apt/sources.list
>>      src: "../../templates/apt/sources.list.{{ ansible_distribution_=
release | lower }}"
>>      owner: root
>>      group: root
>>      mode: 0644
>>    register: sources
>>    when: {{ansible_architecture}} !=3D aarch64
>>
>> Is there a better way to do that ?
> Bonjour Loic,
>=20
> Using when statement is the correct way to add conditions to a task,
> but don't forget that the when clause contains a Jinja2 expression (n=
ot like a module argument),
> Thus the correct expression should rather be =C2=AB when: ansible_arc=
hitecture !=3D 'aarch64' =C2=BB.

Indeed, the previous attempt failed :-) Here is a more elaborate versio=
n that also excludes some packages that are not available in the aarch6=
4 repositories. How does that look ?

https://github.com/ceph/ceph-cm-ansible/pull/224/commits/80e1cb2f368839=
3f4238268a543e6c3ab19bae75

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
