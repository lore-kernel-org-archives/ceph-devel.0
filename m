From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: OSD Hardware questions
Date: Thu, 28 Jun 2012 17:18:49 +0200 (CEST)
Message-ID: <5d5b400b-c2b4-4bce-9231-b412ce1aff03@mailpro>
References: <4FEC6C68.2030307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:33788 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab2F1PTN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 11:19:13 -0400
In-Reply-To: <4FEC6C68.2030307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>

Hi,
maybe it can help, I'm doing same tests that stefan,=20
random write  with 4K with 3 nodes with 5 osds (with 15K drives)
fio --filename=3D[disk] --direct=3D1 --rw=3Drandwrite --bs=3D4k --size=3D=
100M --numjobs=3D50 --runtime=3D30 --group_reporting --name=3Dfile1=20

I can achieve 5500io/s (disks are not at 100%)

cpu is around 30%idle ( 8 cores E5420  @ 2.50GHz)


----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
Cc: "Gregory Farnum" <greg@inktank.com>, ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Jeudi 28 Juin 2012 16:38:32=20
Objet: Re: OSD Hardware questions=20

On 06/28/2012 08:21 AM, Stefan Priebe - Profihost AG wrote:=20
> Am 27.06.2012 18:00, schrieb Mark Nelson:=20
>> On 06/27/2012 10:28 AM, Stefan Priebe wrote:=20
>>>> Well, as we said, 1GHz/OSD was a WAG (wild-ass guess), but 3.6GHz+=
/OSD=20
>>>> is farther outside of that range than I would have expected. It mi=
ght=20
>>>> just be a consequence of using SSDs, since they can sustain so muc=
h=20
>>>> more=20
>>>> throughput.=20
>>>=20
>>> Sure it was just so much away from 1Ghz that i wanted to ask.=20
>>>=20
>>>> What is the cluster doing when you see those CPU usage numbers?=20
>>> random write I/O from one KVM. 14k I/Ops with random 4k writes.=20
>>>=20
>>> Stefan=20
>>=20
>> I think I was seeing about 80-85% CPU utilization with 5 SSD OSDs on=
 our=20
>> 6-core AMD nodes, but I was just doing sequential writes with rados=20
>> bench.=20
>=20
> While doing sequential writes i see pretty low CPU usage. Random writ=
es=20
> is the problem.=20
>=20
> Stefan=20

It would be interesting to see where all your CPU time is being spent.=20
What benchmark are you using to do the random writes?=20

Mark=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
