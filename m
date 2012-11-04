From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: slow fio random read benchmark, need help
Date: Sun, 04 Nov 2012 15:54:24 +0100 (CET)
Message-ID: <32cb2816-63ad-4741-b9ae-99277d757a51@mailpro>
References: <CAPYLRzhkg=34+JF-+_9TArxgoPAw59J1naAyfoxazpdyy2hE9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:55410 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab2KDOy6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 09:54:58 -0500
In-Reply-To: <CAPYLRzhkg=34+JF-+_9TArxgoPAw59J1naAyfoxazpdyy2hE9g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Marcus Sorensen <shadowsor@gmail.com>, Josh Durgin <josh.durgin@inktank.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Dietmar Maurer <dietmar@proxmox.com>

>>Did your RAID setup improve anything?

I have  tried to launch 2 fio test in parallel, on 2 disks in the same =
guest vm, I get 2500iops for each test ....

Running 2 fio tests, on 2 differents guests, give me 5000iops for each =
test.

I really don't understand...Maybe something don't use parallelim from 1=
 kvm process ? (monitor access, or something else...)

So raid don't help.

>> Have you tried scaling past 4 guests in parallel?

Not Yet,I'll done more tests this week


----- Mail original -----=20

De: "Gregory Farnum" <greg@inktank.com>=20
=C3=80: "Dietmar Maurer" <dietmar@proxmox.com>=20
Cc: "Marcus Sorensen" <shadowsor@gmail.com>, "Josh Durgin" <josh.durgin=
@inktank.com>, "Alexandre DERUMIER" <aderumier@odiso.com>, "Sage Weil" =
<sage@inktank.com>, "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Samedi 3 Novembre 2012 18:09:11=20
Objet: Re: slow fio random read benchmark, need help=20

On Thu, Nov 1, 2012 at 6:00 PM, Dietmar Maurer <dietmar@proxmox.com> wr=
ote:=20
> I always thought a distributed block storage could do such things=20
> faster (or at least as fast) than a single centralized store?=20

That rather depends on what makes up each of them. ;)=20

On Thu, Nov 1, 2012 at 6:11 AM, Alexandre DERUMIER <aderumier@odiso.com=
> wrote:=20
> I have some customers with some huge databases (too big to be handle =
in the bufer), require a lot of ios. (around 10K).=20
>=20
> I have redone tests with 4 guest in parallel, I get 4 x 5000iops, so =
it seem to scale ! (and cpu is very low on the ceph cluster).=20
>=20
>=20
> So I'll try some tricks, like raid over multiple rbd devices, maybe i=
t'll help.=20

Did your RAID setup improve anything? Have you tried scaling past 4=20
guests in parallel?=20
I still haven't come up with a good model for what could be causing=20
these symptoms. :/=20
-Greg=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
