From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Two questions
Date: Wed, 27 Jul 2011 12:47:08 +0200
Message-ID: <1311763628.2751.34.camel@wido-laptop.pcextreme.nl>
References: <8685614628192678277@unknownmsgid>
	 <1311750865.2751.4.camel@wido-laptop.pcextreme.nl>
	 <CAMwB3Ti66BpfdfwPx3XgmVQv2GAQ_Gc2beHRc6pBcWwphf_bhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:58586 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab1G0KrL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 06:47:11 -0400
In-Reply-To: <CAMwB3Ti66BpfdfwPx3XgmVQv2GAQ_Gc2beHRc6pBcWwphf_bhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C5=82awomir?= Skowron <szibis@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On Wed, 2011-07-27 at 12:19 +0200, S=C5=82awomir Skowron wrote:
> Thanks.
>=20
> 2011/7/27 Wido den Hollander <wido@widodh.nl>:
> > Hi,
> >
> > On Wed, 2011-07-27 at 07:58 +0200, S=C5=82awomir Skowron wrote:
> >> Hello. I have some questions.
> >>
> >> 1. Is there any chance to change default 4MB object size to for
> >> example 1MB or less ??
> >
> > If you are using the filesystem, you can change the stripe-size per
> > directory with the "cephfs" tool.
>=20
> Unfortunately i only use rados layer in this case, and i even don't
> have any mds :) is there any chance to change this in rados layer ??

The RADOS gateway does NOT stripe over multiple objects. If you upload =
a
1GB object through the RADOS gateway it will be a 1GB object.

Only the RBD (Rados Block Device) and the Ceph filesystem do striping
over RADOS objects.

RADOS itself doesn't stripe and the RADOS gateway is a almost 1:1
mapping of pools and objects.

Wido

>=20
> >>
> >> 2. I have create cluster of two mons, and 32 osd (1TB each) on two
> >> machines. At this radosgw with apache2 for test. When i putting da=
ta
> >> from s3 client to rados, everything is ok, but when one of osd is
> >> going down all s3 clients going to be freeze for some seconds, bef=
ore
> >> ceph sign this osd as down, and then everything is starting workin=
g
> >> again wit degraded osd. How can i tune this marking as a down for =
ms
> >> or 0 :) and not for seconds freeze ??
> >
> > Normally a OSD should be down within about 10 seconds and shouldn't
> > affect all I/O operations.
> >
> > By default it takes 300 seconds before a OSD gets marked as "out", =
this
> > is handled by "mon osd down out interval"
> >
> > If you want to change the "down" reporting behaviour you could do t=
his
> > with "osd min down reporters" and "osd min down reports". I'm not s=
ure
> > you really want to do this, as the default values should be ok.
>=20
> Ok. I will check this.
>=20
> > Wido
> >
> >>
> >> My setup is debian 6.0, kernel 2.6.37.6  x86_64 and ceph version
> >> 0.31-10 from stable repo.
> >>
> >> Best regards
> >>
> >> Slawomir Skowron
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >
>=20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
