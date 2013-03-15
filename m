From: Dave Spano <dspano@optogenics.com>
Subject: Re: rados cppool and Openstack Glance and Cinder
Date: Fri, 15 Mar 2013 18:29:19 -0400 (EDT)
Message-ID: <3511211.179.1363386561337.JavaMail.dspano@it1>
References: <51439C85.7030601@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rrcs-24-103-221-203.nys.biz.rr.com ([24.103.221.203]:39684 "EHLO
	mail.optogenics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab3COW3U convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Mar 2013 18:29:20 -0400
In-Reply-To: <51439C85.7030601@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Greg Farnum <greg@inktank.com>, =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Samuel Just <sam.just@inktank.com>, Vladislav Gorbunov <vadikgo@gmail.com>

Thank you Josh. Have a great weekend.=20

Dave Spano=20



----- Original Message -----=20

=46rom: "Josh Durgin" <josh.durgin@inktank.com>=20
To: "Dave Spano" <dspano@optogenics.com>=20
Cc: "Greg Farnum" <greg@inktank.com>, "S=C3=A9bastien Han" <han.sebasti=
en@gmail.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Sage Weil" <=
sage@inktank.com>, "Wido den Hollander" <wido@42on.com>, "Sylvain Munau=
t" <s.munaut@whatever-company.com>, "Samuel Just" <sam.just@inktank.com=
>, "Vladislav Gorbunov" <vadikgo@gmail.com>=20
Sent: Friday, March 15, 2013 6:11:17 PM=20
Subject: Re: rados cppool and Openstack Glance and Cinder=20

On 03/15/2013 02:55 PM, Dave Spano wrote:=20
>=20
> During my journey of using rados cppool, which is an awesome feature =
by the way, I found an interesting behavior related to cephx. I wanted =
to share it for anyone else who may be using Openstack, that decides to=
 rename, or copy a pool.=20
>=20
> My client.glance entry is currently set to this (with the exception o=
f the key, of course):=20
>=20
> client.glance=20
> key: punkrawk=20
> caps: [mon] allow r=20
> caps: [osd] allow class-read object_prefix rbd_children, allow rwx=20
>=20
> It was limited to the images pool based on the following example list=
ed at http://ceph.com/docs/master/rbd/rbd-openstack/ :=20
>=20
> ceph auth get-or-create client.glance mon 'allow r' osd 'allow class-=
read object_prefix rbd_children, allow rwx pool=3Dimages'=20
>=20
> client.glance=20
> key: punkrawk=20
> caps: [mon] allow r=20
> caps: [osd] allow class-read object_prefix rbd_children, allow rwx po=
ol=3Dimages=20
>=20
>=20
>=20
> What I found was that when I would create my pool as images-new or an=
ything but images, then rename it to images I would have a problem. I c=
ould not even upload an image to an empty pool.=20
>=20
> I could, however; upload to the pool if I renamed the original to ima=
ges-old, then created a brand new pool called images.=20
>=20
> My first guess is that there's a reference to the old name which woul=
d interfere whenever my client would try to use it with the client.glan=
ce keyring. I have not looked in the code yet, so I don't have any othe=
r concrete idea.=20

Yeah, someone ran into this before, but apparently I hadn't finished=20
creating the bug, so now there's http://tracker.ceph.com/issues/4471.=20

Each pg includes its pool name in memory, and that isn't updated when=20
the pool is renamed. Restarting the osd would refresh it, and creating=20
a new pool creates entirely new pgs.=20

> As soon as I lifted the pool restriction, as if by the power greyskul=
l, I could upload, delete and take snapshots in the renamed pool.=20
>=20
> I believe this would be rather easy for anyone to reproduce with a te=
st install of Openstack.=20

No openstack needed, just any ceph client with a restriction based on=20
pool name.=20

> Just create pool named images-new. Rename it to images, then try to u=
pload an image. It should fail. Remove the pool restriction, and it wil=
l work.=20

Thanks for the detailed report!=20
Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
