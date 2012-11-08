From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: less cores more iops / speed
Date: Thu, 08 Nov 2012 16:53:29 +0100 (CET)
Message-ID: <021c4865-424b-41bd-b81d-62b6771dabc3@mailpro>
References: <509BCC58.3070003@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:41465 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab2KHPx7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 10:53:59 -0500
In-Reply-To: <509BCC58.3070003@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

>>So it is a problem of KVM which let's the processes jump between core=
s a=20
>>lot.=20

maybe numad from redhat can help ?
http://fedoraproject.org/wiki/Features/numad

It's try to keep process on same numa node and I think it's also doing =
some dynamic pinning.

----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
Cc: "Joao Eduardo Luis" <joao.luis@inktank.com>, ceph-devel@vger.kernel=
=2Eorg=20
Envoy=C3=A9: Jeudi 8 Novembre 2012 16:14:32=20
Objet: Re: less cores more iops / speed=20

Am 08.11.2012 14:19, schrieb Mark Nelson:=20
> On 11/08/2012 02:45 AM, Stefan Priebe - Profihost AG wrote:=20
>> Am 08.11.2012 01:59, schrieb Mark Nelson:=20
>>> There's also the context switching overhead. It'd be interesting to=
=20
>>> know how much the writer processes were shifting around on cores.=20
>> What do you mean by that? I'm talking about the KVM guest not about =
the=20
>> ceph nodes.=20
>=20
> in this case, is fio bouncing around between cores?=20

Thanks you're correct. If i bind fio to two cores on a 8 core VM it run=
s=20
with 16.000 iops.=20

So it is a problem of KVM which let's the processes jump between cores =
a=20
lot.=20

Greets,=20
Stefan=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
