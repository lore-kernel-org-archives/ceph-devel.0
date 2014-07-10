From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Cache tier READ_FORWARD transition
Date: Thu, 10 Jul 2014 06:34:08 +0200 (CEST)
Message-ID: <1a35b08f-aad2-46ad-b080-2fb1f907f3ae@mailpro>
References: <alpine.DEB.2.00.1407080856060.9196@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:58307 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbaGJEeQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jul 2014 00:34:16 -0400
In-Reply-To: <alpine.DEB.2.00.1407080856060.9196@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel@vger.kernel.org, Luis =?utf-8?Q?Pab=C3=B3n?= <lpabon@redhat.com>

>>Note that you can also accomplish this with the kernel rbd driver by=20
>>layering dm-cache or bcache or something similar on top and running i=
t in=20
>>write-through mode.  Most clients are (KVM+)librbd, though, so eventu=
ally=20
>>a userspace implementation for librbd (or maybe librados) makes sense=
=2E

I vote for this,
it would be wonderful to have a client cache at librbd level !


----- Mail original -----=20

De: "Sage Weil" <sweil@redhat.com>=20
=C3=80: "Luis Pab=C3=B3n" <lpabon@redhat.com>=20
Cc: "Mark Nelson" <mnelson@redhat.com>, ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mardi 8 Juillet 2014 18:01:46=20
Objet: Re: Cache tier READ_FORWARD transition=20

On Mon, 7 Jul 2014, Luis Pab?n wrote:=20
> What about the following usecase (please forgive some of my ceph arch=
itecture=20
> ignorance):=20
>=20
> If it was possible to setup OSD caching tier at the host (if the host=
 had a=20
> dedicated SSD for accelerating I/O), then caching pools could be crea=
ted to=20
> cache VM rbds, since they are inherently exclusive to a single host. =
Using a=20
> write through (or a readonly, depending on the workload) policy would=
 have a=20
> major increase in VM IOPs. Using writethrough or readonly policy woul=
d also=20
> ensure any writes are first written to the back end storage tier. Ena=
bling=20
> hosts to service most of their VM I/O reads would also increases the =
overall=20
> IOPs of the back end storage tier.=20

This could be accomplished by doing a rados pool per client host. The=20
rados caching only works in as a writeback cache, though, not=20
write-through, so you really need to replicate it for it to be usable i=
n=20
practice. So although it's possible, this isn't a particularly attracti=
ve=20
approach.=20

What you're describing is really a client-side write-through cache, eit=
her=20
for librbd or librados. We've discussed this in the past (mostly in the=
=20
context of a shared host-wide read-only data, not as write-through), bu=
t=20
in both cases the caching would plug into the client libraries. There a=
re=20
some CDS notes from emperor:=20

http://wiki.ceph.com/Planning/Sideboard/rbd%3A_shared_read_cache=20
http://pad.ceph.com/p/rbd-shared-read-cache=20
http://www.youtube.com/watch?v=3DSVgBdUv_Lv4&t=3D70m11s=20

Note that you can also accomplish this with the kernel rbd driver by=20
layering dm-cache or bcache or something similar on top and running it =
in=20
write-through mode. Most clients are (KVM+)librbd, though, so eventuall=
y=20
a userspace implementation for librbd (or maybe librados) makes sense.=20

sage=20


> Does this make sense?=20
>=20
> - Luis=20
>=20
> On 07/07/2014 03:29 PM, Sage Weil wrote:=20
> > On Mon, 7 Jul 2014, Luis Pabon wrote:=20
> > > Hi all,=20
> > > I am working on OSDMonitor.cc:5325 and wanted to confirm the=20
> > > following=20
> > > read_forward cache tier transition:=20
> > >=20
> > > readforward -> forward || writeback || (any && num_objects_dirty =
=3D=3D=20
> > > 0)=20
> > > forward -> writeback || readforward || (any && num_objects_dirty =
=3D=3D=20
> > > 0)=20
> > > writeback -> readforward || forward=20
> > >=20
> > > Is this the correct cache tier state transition?=20
> > That looks right to me.=20
> >=20
> > By the way, I had a thought after we spoke that we probably want so=
mething=20
> > that is somewhere inbetween the current writeback behavior (promote=
 on=20
> > first read) and the read_forward behavior (never promote on read). =
I=20
> > suspect a good all-around policy is something like promote on secon=
d read?=20
> > This should probably be rolled into the writeback mode as a tunable=
=2E..=20
> >=20
> > sage=20
> >=20
> >=20
> > --=20
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in=20
> > the body of a message to majordomo@vger.kernel.org=20
> > More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20
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
