From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Sat, 2 Apr 2016 16:05:05 +1100
Message-ID: <20160402050505.GA23763@onthe.net.au>
References: <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
 <CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160401035610.GA5671@onthe.net.au>
 <alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
 <20160401052838.GA8044@onthe.net.au>
 <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
 <20160401194912.GA18636@onthe.net.au>
 <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <3E46E6C9-EFD2-49BD-9862-4C46D053A8D6@sandisk.com>
 <CAJ4mKGaNPfpPbbNY+YVu1NDuVQ-gaS5fi2Pww7DSjsbGt-sbXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:37477 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbcDBFFJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Apr 2016 01:05:09 -0400
Content-Disposition: inline
In-Reply-To: <CAJ4mKGaNPfpPbbNY+YVu1NDuVQ-gaS5fi2Pww7DSjsbGt-sbXg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Apr 01, 2016 at 07:51:07PM -0700, Gregory Farnum wrote:
> On Fri, Apr 1, 2016 at 7:23 PM, Allen Samuels <Allen.Samuels@sandisk.=
com> wrote:
>> Talk about mental failures. The first statement is correct. It's abo=
ut the ratio of checksum to data bits. After that please ignore. If you=
 double the data you need to double the checksum bit to maintain the be=
r.
>=20
> Forgive me if I'm wrong here =E2=80=94 I haven't done anything with
> checksumming since I graduated college =E2=80=94 but good checksummin=
g is
> about probabilities and people suck at evaluating probability: I'm
> really not sure any of the explanations given in this thread are
> right. Bit errors aren't random and in general it requires a lot more
> than one bit flip to collide a checksum, so I don't think it's a
> linear relationship between block size and chance of error. Finding

A single bit flip can certainly result in a checksum collision, with th=
e
same chance as any other error, i.e. 1 in 2^number_of_checksum_bits.

Just to clarify: the chance of encountering an error is linear with the
block size. I'm contending the chance of encountering a checksum collis=
ion
as a result of encountering one or more errors is independent of the bl=
ock
size.

> collisions with cryptographic hashes is hard! Granted a CRC is a lot
> simpler than SHA1 or whatever, but we also aren't facing adversaries
> with it, just random corruption. So yes, as your data block increases
> then naturally the number of possible bit patterns which match the
> same CRC have to increase =E2=80=94 but that doesn't mean your odds o=
f
> actually *getting* that bit pattern by mistake increase linearly.

A (good) checksum is like rolling a 2^"number of bits in the checksum"-=
sided
dice across an rough table, in an ideal world where every single parame=
ter
is known. If you launch your dice in precisely the same way, the dice w=
ill
behave exactly the same way, hitting the same hills and valleys in the
table, and end up in precisely the same spot with precisely the same fa=
ce on
top - your checksum. The number of data bits is how hard you roll the d=
ice:
how far it goes and many hills and valleys it hits along the way.

One or more data errors (bit flips or whatever) is then equivalent to
changing one or more of the hills or valleys: a very small difference, =
but
encountering the difference puts the dice on a completely different pat=
h,
thereafter hitting completely different hills and valleys to the origin=
al
path. And which face is on top when your dice stops is a matter of chan=
ce
(well... not really: if you did exactly the same again, it would end up
taking precisely the same path and the same face would be on top when i=
t
stops).

The thing is, it doesn't matter how many hills and valleys (data bits) =
it
hits along the way: the chance of getting a specific face up is always =
the
same, i.e. 1 / number_of_faces =3D=3D 1 / 2^number_of_checksum_bits.

Chris
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
