From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: rados bench single instance vs. multiple instances
Date: Wed, 13 May 2015 15:05:46 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91664428FA@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF916643E836@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1505111003060.28239@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0111.outbound.protection.outlook.com ([65.55.169.111]:18400
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965582AbbEMPFx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 May 2015 11:05:53 -0400
In-Reply-To: <alpine.DEB.2.00.1505111003060.28239@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Monday, May 11, 2015 12:04 PM
> To: Deneau, Tom
> Cc: ceph-devel
> Subject: Re: rados bench single instance vs. multiple instances
>=20
> On Mon, 11 May 2015, Deneau, Tom wrote:
> > I have noticed the following while running rados bench seq read tes=
ts
> > with a 40M object size
> >
> >     single rados bench, 4 concurrent ops,                     bandw=
idth =3D
> 190 MB/s
> >     4 copies of rados bench, 1 concurrent op each,  aggregate
> > bandwidth =3D 310 MB/s
> >
> > and in fact the single rados bench seems limited to 190, no matter =
how many
> concurrent ops.
> >
> > I don't see this kind of behavior with a 4M object size.
> >
> > (The above are with caches dropped on the osd targets)
> >
> > It doesn't seem to be related to the total number of bytes being
> > processed by the single because if I don't drop the caches, both th=
e
> > single rados bench and the 4-copy rados bench get much higher numbe=
rs
> > (600 vs. 900) but still the single rados bench appears limited, no =
matter
> how many concurrent ops are used.
> >
> > Is there kind of throttling going on by design here?
>=20
> It might be the librados throttles:
>=20
> OPTION(objecter_inflight_op_bytes, OPT_U64, 1024*1024*100) // max in-=
flight
> data (both directions)
> OPTION(objecter_inflight_ops, OPT_U64, 1024)               // max in-=
flight
> ios
>=20
> IIRC these only affect librados.. which would include 'rados bench'.
>=20
> sage
>=20

Just a follow-up that changing the limits of the two options mentioned =
above
did indeed solve my problem.

Also, my na=EFve understanding of the architecture was that things like=
 RBD and RGW were
layered on librados as shown in http://ceph.com/docs/master/architectur=
e/.  So wouldn't these
throttles apply to those stacks as well?

-- Tom Deneau


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
