From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-users] v0.80.4 Firefly released
Date: Wed, 16 Jul 2014 09:27:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407160926550.28285@cobra.newdream.net>
References: <alpine.DEB.2.00.1407151634250.21336@cobra.newdream.net> <CAMvtBPPr0MO5U_e=PEb6xqDUjQVhZLdh2oSD1tA0voVp_cu=Jw@mail.gmail.com> <CACkq2mrDrkp0anEE1MLxqwuw-O7aEhMrYua2_QjKrrS+Fqn5Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1666882128-1405528029=:28285"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47339 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965529AbaGPQ1K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jul 2014 12:27:10 -0400
In-Reply-To: <CACkq2mrDrkp0anEE1MLxqwuw-O7aEhMrYua2_QjKrrS+Fqn5Yg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: Andrija Panic <andrija.panic@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1666882128-1405528029=:28285
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Jul 2014, Travis Rhoden wrote:
> Hi Andrija,
>=20
> I'm running a cluster with both CentOS and Ubuntu machines in it.=C2=A0=
 I just
> did some upgrades to 0.80.4, and I can confirm that doing "yum update c=
eph"
> on the CentOS machine did result in having all OSDs on that machine
> restarted automatically.=C2=A0 I actually did not know that would happe=
n, as the
> CentOS machines were new additions (first update since deploying them w=
ith
> 0.80.1), and I'm used the Ubuntu behavior where I can update the packag=
e
> first, then reboot things at will.
>=20
> So yeah, that still happens with RPM.=C2=A0 :/

We'll make sure this is fixed in 0.80.5!

Thanks-
sage


>=20
>=20
> On Wed, Jul 16, 2014 at 3:55 AM, Andrija Panic <andrija.panic@gmail.com=
>
> wrote:
>       Hi Sage,
> can anyone validate, if there is still "bug" inside RPMs that does
> automatic CEPH service restart after updating packages ?
>=20
> We are instructed to first update/restart MONs, and after that OSD -
> but that is impossible if we have MON+OSDs on same host...since the
> ceph is automaticaly restarted with YUM/RPM, but NOT automaticaly
> restarted on Ubuntu/Debian (as reported by some other list memeber...)
>=20
> Thanks
>=20
>=20
> On 16 July 2014 01:45, Sage Weil <sage@inktank.com> wrote:
>       This Firefly point release fixes an potential data
>       corruption problem
>       when ceph-osd daemons run on top of XFS and service
>       Firefly librbd
>       clients. =C2=A0A recently added allocation hint that RBD
>       utilizes triggers
>       an XFS bug on some kernels (Linux 3.2, and likely others)
>       that leads
>       to data corruption and deep-scrub errors (and inconsistent
>       PGs). =C2=A0This
>       release avoids the situation by disabling the allocation
>       hint until we
>       can validate which kernels are affected and/or are known
>       to be safe to
>       use the hint on.
>=20
>       We recommend that all v0.80.x Firefly users urgently
>       upgrade,
>       especially if they are using RBD.
>=20
>       Notable Changes
>       ---------------
>=20
>       * osd: disable XFS extsize hint by default (#8830, Samuel
>       Just)
>       * rgw: fix extra data pool default name (Yehuda Sadeh)
>=20
>       For more detailed information, see:
>=20
>       =C2=A0 http://ceph.com/docs/master/_downloads/v0.80.4.txt
>=20
>       Getting Ceph
>       ------------
>=20
>       * Git at git://github.com/ceph/ceph.git
>       * Tarball at http://ceph.com/download/ceph-0.80.4.tar.gz
>       * For packages, see
>       http://ceph.com/docs/master/install/get-packages
>       * For ceph-deploy, see
>       http://ceph.com/docs/master/install/install-ceph-deploy
>=20
>       _______________________________________________
>       ceph-users mailing list
>       ceph-users@lists.ceph.com
>       http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
>=20
>=20
>=20
> --
>=20
> Andrija Pani?
> --------------------------------------
> =C2=A0 http://admintweets.com
> --------------------------------------
>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
>=20
>=20
>=20
--557981400-1666882128-1405528029=:28285--
