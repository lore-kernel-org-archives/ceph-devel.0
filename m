From: Wido den Hollander <wido@widodh.nl>
Subject: Re: /sys/class/rbd does not exist after loading ceph module
Date: Fri, 30 Jul 2010 15:25:42 +0200
Message-ID: <1280496342.1960.3.camel@wido-desktop>
References: <AANLkTi=r74Q3SBS71+QcditFhNxzUfdCf1F9F18R4Yiy@mail.gmail.com>
	 <AANLkTikOViq3VCY2fwtut1c1kU8dkM7pRRwqfrYyhEPL@mail.gmail.com>
	 <AANLkTimrYZQmLbHO=CU1yPLDT_MxpFxq=Cs0sF1x70+Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:51721 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755918Ab0G3NcS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 09:32:18 -0400
In-Reply-To: <AANLkTimrYZQmLbHO=CU1yPLDT_MxpFxq=Cs0sF1x70+Z@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoguang Liu <syslxg@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Xiaoguang,

You will have to download the source from git like explained on:
http://ceph.newdream.net/wiki/Rbd

But the module will not compile against 2.6.34, only against 2.6.35

There is a rbd-backport branch in "ceph-client-standalone.git", but i'm
not sure how up to date that one is.

If you want to test RBD, i would recommend upgrading to 2.6.35.

Wido

On Fri, 2010-07-30 at 21:17 +0800, Xiaoguang Liu wrote:
> I though all ceph client, including RBD, was already included in
> kernel 2.6.34. so I just download it from kernel.org and compile it,
> like make menuconfig, make, make modues_install etc.
>=20
> Do you mean that I still need patch kernel 2.6.34 and build the new c=
eph.ko?
>=20
>=20
> > I would like to try the RBD feature of Ceph. I am following
> > http://ceph.newdream.net/wiki/Rbd,=E8=81=BD but failed at :
>=20
> * did you really compile the ceph.ko module from source?
> * did you verify that you actually loaded the right ceph.ko module an=
d
> not stock ceph.ko?
>=20
> general note: do use the new 0.21. you won't get happy with 0.20.2.
>=20
> - Thomas
>=20
>=20
> On Fri, Jul 30, 2010 at 4:41 PM, Xiaoguang Liu <syslxg@gmail.com> wro=
te:
> >  I would like to try the RBD feature of Ceph. I am following
> > http://ceph.newdream.net/wiki/Rbd,  but failed at :
> >
> >  echo "xxx name=3Dadmin rbd foo" > /sys/class/rbd/add
> >
> >
> >  It was because folder /sys/class/rbd does not exist. But ceph kern=
el
> > module is loaded and I can mount -t ceph xxxx:/ /mnt/ceph.
> >
> >  I am using kernel 2.6.34.1 on fedora 13.
> >
> >  the following symbols are set in .config while compiling the kerne=
l.
> >
> >  CONFIG_CEPH_FS=3Dm
> >  CONFIG_CEPH_FS_PRETTYDEBUG=3Dy
> >
> >  Ceph 0.20.2 is installed by yum.
> >
> >  Did I miss anything?
> >
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
