From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Regarding bluestore release schedule
Date: Thu, 14 Jan 2016 07:49:27 +0100 (CET)
Message-ID: <288469133.31175442.1452754167448.JavaMail.zimbra@oxygem.tv>
References: <4EFB79CD-2601-4ABF-96DB-AAF6A90D0036@ict.ac.cn> <alpine.DEB.2.11.1601130842560.26381@cpach.fuggernut.com> <84CAA53B-B2B6-4F2A-B199-32534733068F@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:39153 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbcANG7L convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jan 2016 01:59:11 -0500
In-Reply-To: <84CAA53B-B2B6-4F2A-B199-32534733068F@ict.ac.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhang Huan <zhanghuan@ict.ac.cn>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

>>I know it is early, but do we have any chance to know your test resul=
t? and
>>how about the result on SSD?

They are some link to spreadshets results on performance weekly etherpa=
d

http://pad.ceph.com/p/performance_weekly

last results are:
https://drive.google.com/open?id=3D0B2gTBZrkrnpZS1VVMTJTNnQta28

----- Mail original -----
De: "Zhang Huan" <zhanghuan@ict.ac.cn>
=C3=80: "Sage Weil" <sweil@redhat.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Jeudi 14 Janvier 2016 07:37:14
Objet: Re: Regarding bluestore release schedule=20

> On Jan 13, 2016, at 9:45 PM, Sage Weil <sweil@redhat.com> wrote:=20
>=20
> On Wed, 13 Jan 2016, Zhang Huan wrote:=20
>> Hello Sage,=20
>>=20
>> I have been watching the development of bluestore for a while. I am=20
>> interested in bluestore because I believe putting object store on to=
p of=20
>> raw device is the right way. I would like to know if you have any=20
>> release schedule, and which version it will be merged into? I also=20
>> notice that there is big locks (Collection->lock and=20
>> StupidAllocator->lock, etc) in the write path, this might be an issu=
e=20
>> for SSD. Do you have any plan to break it into finer locks?=20
>=20
> It's in master now and it will be part of the jewel release. It won't=
=20
> be the default choice yet, since it is still very new and unproven, b=
ut so=20
> far performance is looking better than FileStore on HDDs.=20
I know it is early, but do we have any chance to know your test result?=
 and=20
how about the result on SSD?=20

>=20
> The collection->lock doesn't need to be broken up since it's hidden=20
> beneath the OSD's per-pg lock anyway.=20
Thanks, I found the per-pg lock. If there exist per-pg locks, the=20
per-collection locks are actually not needed?=20

> The allocator lock could be=20
> sharded, though, by creating multiple allocation groups (ala XFS). Th=
is=20
> is partly why the Allocator interface is abstract and the current=20
> implementation is called StupidAllocator :). If you can demonstrate=20
> that the lock is affecting performance we should definitely improve t=
hat!=20
It would be an interesting to look into:-)=20

>=20
> sage=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20


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
