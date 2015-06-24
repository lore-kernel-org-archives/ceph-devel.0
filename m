From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: deleting objects from a pool
Date: Wed, 24 Jun 2015 20:22:11 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91669ACA7B@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91669AC8C2@SATLEXDAG01.amd.com>
 <90559C83A9C7FA45B5846C975DFA612DDB4C3F7250@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0116.outbound.protection.outlook.com ([157.56.110.116]:3936
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753781AbbFXUWS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jun 2015 16:22:18 -0400
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB4C3F7250@ABGEX73E.FSC.NET>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>, ceph-devel <ceph-devel@vger.kernel.org>

I've noticed that deleting objects from a basic k=3D2 m=3D1 erasure poo=
l is much much slower than deleting a similar number of objects from a =
replicated size 3 pool (so the same number of files to be deleted).   I=
t looked like the ec pool object deletion was almost 20x slower.  Is th=
ere a lot more work to be done to delete an ec pool object?

-- Tom



> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Dalek, Piotr
> Sent: Wednesday, June 24, 2015 11:56 AM
> To: ceph-devel
> Subject: Re: deleting objects from a pool
>=20
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Deneau, Tom
> > Sent: Wednesday, June 24, 2015 6:44 PM
> >
> > I have benchmarking situations where I want to leave a pool around =
but
> > delete a lot of objects from the pool.  Is there any really fast wa=
y to do
> that?
> > I noticed rados rmpool is fast but I don't want to remove the pool.
> >
> > I have been spawning multiple threads, each deleting a subset of th=
e
> objects
> > (which I believe is what rados bench write does) but even that can =
be very
> > slow.
>=20
> For now, apart from "rados -p <poolname> cleanup" (which doesn't purg=
e the
> pool, but merely removes objects written during last benchmark run), =
the only
> option is by brute force:
>=20
> for i in $(rados -p <poolname> ls); do (rados -p <poolname> rm $i &>/=
dev/null
> &); done;
>=20
> There's no "purge pool" command in rados -- not yet, at least. I was =
thinking
> about one, but never really had time to implement one.
>=20
> With best regards / Pozdrawiam
> Piotr Da=B3ek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
