From: Sage Weil <sage@newdream.net>
Subject: RE: rados bench single instance vs. multiple instances
Date: Wed, 13 May 2015 10:01:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505131001140.20395@cobra.newdream.net>
References: <BC97738F8E7C8742BABED7F06FB9DF916643E836@SATLEXDAG01.amd.com> <alpine.DEB.2.00.1505111003060.28239@cobra.newdream.net> <BC97738F8E7C8742BABED7F06FB9DF91664428FA@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-547215683-1431536486=:20395"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39825 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933607AbbEMRBk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 May 2015 13:01:40 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91664428FA@SATLEXDAG01.amd.com>
Content-ID: <alpine.DEB.2.00.1505131001340.20395@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-547215683-1431536486=:20395
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <alpine.DEB.2.00.1505131001341.20395@cobra.newdream.net>
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2015, Deneau, Tom wrote:
>=20
> > -----Original Message-----
> > From: Sage Weil [mailto:sage@newdream.net]
> > Sent: Monday, May 11, 2015 12:04 PM
> > To: Deneau, Tom
> > Cc: ceph-devel
> > Subject: Re: rados bench single instance vs. multiple instances
> >=20
> > On Mon, 11 May 2015, Deneau, Tom wrote:
> > > I have noticed the following while running rados bench seq read tes=
ts
> > > with a 40M object size
> > >
> > >     single rados bench, 4 concurrent ops,                     bandw=
idth =3D
> > 190 MB/s
> > >     4 copies of rados bench, 1 concurrent op each,  aggregate
> > > bandwidth =3D 310 MB/s
> > >
> > > and in fact the single rados bench seems limited to 190, no matter =
how many
> > concurrent ops.
> > >
> > > I don't see this kind of behavior with a 4M object size.
> > >
> > > (The above are with caches dropped on the osd targets)
> > >
> > > It doesn't seem to be related to the total number of bytes being
> > > processed by the single because if I don't drop the caches, both th=
e
> > > single rados bench and the 4-copy rados bench get much higher numbe=
rs
> > > (600 vs. 900) but still the single rados bench appears limited, no =
matter
> > how many concurrent ops are used.
> > >
> > > Is there kind of throttling going on by design here?
> >=20
> > It might be the librados throttles:
> >=20
> > OPTION(objecter_inflight_op_bytes, OPT_U64, 1024*1024*100) // max in-=
flight
> > data (both directions)
> > OPTION(objecter_inflight_ops, OPT_U64, 1024)               // max in-=
flight
> > ios
> >=20
> > IIRC these only affect librados.. which would include 'rados bench'.
> >=20
> > sage
> >=20
>=20
> Just a follow-up that changing the limits of the two options mentioned =
above
> did indeed solve my problem.

Great!

> Also, my na=EFve understanding of the architecture was that things like=
 RBD and RGW were
> layered on librados as shown in http://ceph.com/docs/master/architectur=
e/.  So wouldn't these
> throttles apply to those stacks as well?

Yep!

sage
--557981400-547215683-1431536486=:20395--
