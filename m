From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: rados bench single instance vs. multiple instances
Date: Wed, 13 May 2015 17:13:14 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9166442A40@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF916643E836@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1505111003060.28239@cobra.newdream.net>
 <BC97738F8E7C8742BABED7F06FB9DF91664428FA@SATLEXDAG01.amd.com>
 <555378E3.4000309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0143.outbound.protection.outlook.com ([157.56.110.143]:28222
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933950AbbEMRNS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 May 2015 13:13:18 -0400
In-Reply-To: <555378E3.4000309@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Wednesday, May 13, 2015 11:17 AM
> To: Deneau, Tom; Sage Weil
> Cc: ceph-devel
> Subject: Re: rados bench single instance vs. multiple instances
>=20
> On 05/13/2015 10:05 AM, Deneau, Tom wrote:
> >
> >
> >> -----Original Message-----
> >> From: Sage Weil [mailto:sage@newdream.net]
> >> Sent: Monday, May 11, 2015 12:04 PM
> >> To: Deneau, Tom
> >> Cc: ceph-devel
> >> Subject: Re: rados bench single instance vs. multiple instances
> >>
> >> On Mon, 11 May 2015, Deneau, Tom wrote:
> >>> I have noticed the following while running rados bench seq read
> >>> tests with a 40M object size
> >>>
> >>>      single rados bench, 4 concurrent ops,                     ba=
ndwidth
> =3D
> >> 190 MB/s
> >>>      4 copies of rados bench, 1 concurrent op each,  aggregate
> >>> bandwidth =3D 310 MB/s
> >>>
> >>> and in fact the single rados bench seems limited to 190, no matte=
r
> >>> how many
> >> concurrent ops.
> >>>
> >>> I don't see this kind of behavior with a 4M object size.
> >>>
> >>> (The above are with caches dropped on the osd targets)
> >>>
> >>> It doesn't seem to be related to the total number of bytes being
> >>> processed by the single because if I don't drop the caches, both =
the
> >>> single rados bench and the 4-copy rados bench get much higher
> >>> numbers
> >>> (600 vs. 900) but still the single rados bench appears limited, n=
o
> >>> matter
> >> how many concurrent ops are used.
> >>>
> >>> Is there kind of throttling going on by design here?
> >>
> >> It might be the librados throttles:
> >>
> >> OPTION(objecter_inflight_op_bytes, OPT_U64, 1024*1024*100) // max
> >> in-flight data (both directions)
> >> OPTION(objecter_inflight_ops, OPT_U64, 1024)               // max =
in-
> flight
> >> ios
> >>
> >> IIRC these only affect librados.. which would include 'rados bench=
'.
> >>
> >> sage
> >>
> >
> > Just a follow-up that changing the limits of the two options mentio=
ned
> > above did indeed solve my problem.
>=20
> Yay!  I suspect max bytes more so than max ops?
>=20
>=20
> Mark
>=20

Yes, we were really only hitting the limit of inflight bytes.
(rather easy to do since the object size I was trying was 40M).

Another question:=20

I had noticed previously that rados bench (since it does its writes as =
a single request
for the entire length of the object) is limited by osd_max_write_size t=
o objects of 90MB or less.

If I wanted to experiment with larger object sizes, should I expect any=
 negative
side effects from increasing osd_max_write_size?

-- Tom

> >
> > Also, my na=EFve understanding of the architecture was that things =
like
> > RBD and RGW were layered on librados as shown in
> > http://ceph.com/docs/master/architecture/.  So wouldn't these throt=
tles
> apply to those stacks as well?
> >
> > -- Tom Deneau
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
> > in the body of a message to majordomo@vger.kernel.org More majordom=
o
> > info at  http://vger.kernel.org/majordomo-info.html
> >
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
