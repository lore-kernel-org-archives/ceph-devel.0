From: "Podoski, Igor" <Igor.Podoski@ts.fujitsu.com>
Subject: RE: deleting objects from a pool
Date: Thu, 25 Jun 2015 08:06:05 +0200
Message-ID: <66EBB02ADA308B4F8273E99FC000126C6BEA0BD5C8@ABGEX70E.FSC.NET>
References: <BC97738F8E7C8742BABED7F06FB9DF91669AC8C2@SATLEXDAG01.amd.com>
 <90559C83A9C7FA45B5846C975DFA612DDB4C3F7250@ABGEX73E.FSC.NET>
 <BC97738F8E7C8742BABED7F06FB9DF91669ACA7B@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:44947 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbFYGGI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 02:06:08 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91669ACA7B@SATLEXDAG01.amd.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>, =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

It appears, that cleanup can be used as a purge:

rados -p <poolname> cleanup  --prefix ""

Regards,
Igor.


-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Deneau, Tom
Sent: Wednesday, June 24, 2015 10:22 PM
To: Da=B3ek, Piotr; ceph-devel
Subject: RE: deleting objects from a pool

I've noticed that deleting objects from a basic k=3D2 m=3D1 erasure poo=
l is much much slower than deleting a similar number of objects from a =
replicated size 3 pool (so the same number of files to be deleted).   I=
t looked like the ec pool object deletion was almost 20x slower.  Is th=
ere a lot more work to be done to delete an ec pool object?

-- Tom



> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-=20
> owner@vger.kernel.org] On Behalf Of Dalek, Piotr
> Sent: Wednesday, June 24, 2015 11:56 AM
> To: ceph-devel
> Subject: Re: deleting objects from a pool
>=20
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-=20
> > owner@vger.kernel.org] On Behalf Of Deneau, Tom
> > Sent: Wednesday, June 24, 2015 6:44 PM
> >
> > I have benchmarking situations where I want to leave a pool around=20
> > but delete a lot of objects from the pool.  Is there any really fas=
t=20
> > way to do
> that?
> > I noticed rados rmpool is fast but I don't want to remove the pool.
> >
> > I have been spawning multiple threads, each deleting a subset of th=
e
> objects
> > (which I believe is what rados bench write does) but even that can=20
> > be very slow.
>=20
> For now, apart from "rados -p <poolname> cleanup" (which doesn't purg=
e=20
> the pool, but merely removes objects written during last benchmark=20
> run), the only option is by brute force:
>=20
> for i in $(rados -p <poolname> ls); do (rados -p <poolname> rm $i=20
> &>/dev/null &); done;
>=20
> There's no "purge pool" command in rados -- not yet, at least. I was=20
> thinking about one, but never really had time to implement one.
>=20
> With best regards / Pozdrawiam
> Piotr Da=B3ek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
