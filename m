From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: deleting objects from a pool
Date: Thu, 25 Jun 2015 15:40:46 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91669AD048@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91669AC8C2@SATLEXDAG01.amd.com>
 <90559C83A9C7FA45B5846C975DFA612DDB4C3F7250@ABGEX73E.FSC.NET>
 <BC97738F8E7C8742BABED7F06FB9DF91669ACA7B@SATLEXDAG01.amd.com>
 <66EBB02ADA308B4F8273E99FC000126C6BEA0BD5C8@ABGEX70E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0147.outbound.protection.outlook.com ([207.46.100.147]:40784
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751395AbbFYPzu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 11:55:50 -0400
In-Reply-To: <66EBB02ADA308B4F8273E99FC000126C6BEA0BD5C8@ABGEX70E.FSC.NET>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Podoski, Igor" <Igor.Podoski@ts.fujitsu.com>, =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>, ceph-devel <ceph-devel@vger.kernel.org>

Igor --

Good command to know, but this is still very slow on an erasure pool.
=46or example, on my cluster it took 10 seconds with rados bench to wri=
te 10,000 40K size objects to an ecpool.
And it took almost 6 minutes to delete them using the command below.

-- Tom


> -----Original Message-----
> From: Podoski, Igor [mailto:Igor.Podoski@ts.fujitsu.com]
> Sent: Thursday, June 25, 2015 1:06 AM
> To: Deneau, Tom; Da=B3ek, Piotr; ceph-devel
> Subject: RE: deleting objects from a pool
>=20
> Hi,
>=20
> It appears, that cleanup can be used as a purge:
>=20
> rados -p <poolname> cleanup  --prefix ""
>=20
> Regards,
> Igor.
>=20
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Deneau, Tom
> Sent: Wednesday, June 24, 2015 10:22 PM
> To: Da=B3ek, Piotr; ceph-devel
> Subject: RE: deleting objects from a pool
>=20
> I've noticed that deleting objects from a basic k=3D2 m=3D1 erasure p=
ool is much
> much slower than deleting a similar number of objects from a replicat=
ed size
> 3 pool (so the same number of files to be deleted).   It looked like =
the ec
> pool object deletion was almost 20x slower.  Is there a lot more work=
 to be
> done to delete an ec pool object?
>=20
> -- Tom
>=20
>=20
>=20
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Dalek, Piotr
> > Sent: Wednesday, June 24, 2015 11:56 AM
> > To: ceph-devel
> > Subject: Re: deleting objects from a pool
> >
> > > -----Original Message-----
> > > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > > owner@vger.kernel.org] On Behalf Of Deneau, Tom
> > > Sent: Wednesday, June 24, 2015 6:44 PM
> > >
> > > I have benchmarking situations where I want to leave a pool aroun=
d
> > > but delete a lot of objects from the pool.  Is there any really f=
ast
> > > way to do
> > that?
> > > I noticed rados rmpool is fast but I don't want to remove the poo=
l.
> > >
> > > I have been spawning multiple threads, each deleting a subset of =
the
> > objects
> > > (which I believe is what rados bench write does) but even that ca=
n
> > > be very slow.
> >
> > For now, apart from "rados -p <poolname> cleanup" (which doesn't pu=
rge
> > the pool, but merely removes objects written during last benchmark
> > run), the only option is by brute force:
> >
> > for i in $(rados -p <poolname> ls); do (rados -p <poolname> rm $i
> > &>/dev/null &); done;
> >
> > There's no "purge pool" command in rados -- not yet, at least. I wa=
s
> > thinking about one, but never really had time to implement one.
> >
> > With best regards / Pozdrawiam
> > Piotr Da=B3ek
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
> > in the body of a message to majordomo@vger.kernel.org More majordom=
o
> > info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
