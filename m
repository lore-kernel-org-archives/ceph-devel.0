From: Wido den Hollander <wido@widodh.nl>
Subject: Re: RBD performance is not good
Date: Tue, 10 Aug 2010 10:27:40 +0200
Message-ID: <1281428860.2436.6.camel@wido-desktop>
References: <C88708CC.5980%haifeng@yahoo-inc.com>
	 <341848787.2318972.1281428284840.JavaMail.fmail@mwmweb029>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:49818 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab0HJI1m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Aug 2010 04:27:42 -0400
In-Reply-To: <341848787.2318972.1281428284840.JavaMail.fmail@mwmweb029>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ulrich Oelmann <ulrich.oelmann@web.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

It might be usefull to benchmark your individual OSD's first.

Wiki: http://ceph.newdream.net/wiki/Troubleshooting#OSD_performance

There might be a slow OSD in your cluster which slows down the cluster.

With some test with the Ceph filesystem i was able to reach speeds up t=
o
150MB/sec (dd with conv=3Dsync) writing to my Ceph filesystem.

Haven't tried RBD yet on the cluster, but in my previous setup i was
reaching about 30 ~ 35MB/sec with RBD.

Wido

On Tue, 2010-08-10 at 10:18 +0200, Ulrich Oelmann wrote:
> Hi there,
>=20
> I don't think that Xiaoguang saw the speed of 30-60 MB/s because of c=
ache
> effects as the speed should be in the order of at least some hundred =
MB/s
> then. Do you agree?
>=20
> Could perhaps someone having an rbd-setup running confirm or reject
> Xiaoguangs measurements?
>=20
> Best regards
> Ulrich
>=20
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Haifeng Liu <haifeng@yahoo-inc.com>
> Gesendet: Aug 10, 2010 7:46:52 AM
> An: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
> Betreff: Re: RBD performance is not good
>=20
> >Xiaoguang,
> >
> >This should be a normal result =E2=80=93 the client=E2=80=99s pageca=
che buffered the write
> >when you dd onto a ceph fs, while no buffering when dd to a rbd. Wha=
t do you
> >think?=20
> >
> >Thanks
> >-haifeng
> >
> >
> >On 8/10/10 11:23 AM, "Xiaoguang Liu"  wrote:
> >
> >> on my 2-ods-node cluster, dd can only reach 13MB/s on rbd device. =
this
> >> is much lower than what I expected.
> >> I can get 30-60 MB/s on a ceph filesystem over the same cluster.
> >>=20
> >> any idea?
> >>=20
> >>=20
> >>=20
> >>=20
> >> [root@ceph-1 ~]# dd if=3D/dev/zero of=3D/dev/rbd0  bs=3D1M count=3D=
5000
> >> 5000+0 records in
> >> 5000+0 records out
> >> 5242880000 bytes (5.2 GB) copied, 391.508 s, 13.4 MB/s
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>=20
> >
> >N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=DD=A2j"=EF=BF=BD=EF=BF=BD
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
