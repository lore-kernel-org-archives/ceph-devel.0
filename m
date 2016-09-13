From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: should we remove autotools from master?
Date: Tue, 13 Sep 2016 06:42:41 +0000
Message-ID: <VI1PR05MB16149F7E6289B00B66FE17DEA9FE0@VI1PR05MB1614.eurprd05.prod.outlook.com>
References: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to>
 <856563CD-6D2D-4248-B688-4A146A6F9C4B@Teradata.com>
 <alpine.DEB.2.11.1609071550470.32742@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0067.outbound.protection.outlook.com ([104.47.2.67]:54709
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750940AbcIMG5d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Sep 2016 02:57:33 -0400
In-Reply-To: <alpine.DEB.2.11.1609071550470.32742@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Brad Hubbard <bhubbard@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Thanks for the PR notice.

I don't have any comment on the PR itself.  Only that I am not familiar wit=
h cmake and I don't manage to compile ceph with xio after cmake. Neither I =
manage to fix the cmake files.

I am using cmake -DWITH_XIO=3DON, then - at make - I am getting many "undef=
ined reference" link errors for xio symbols.  The point is that the link er=
rors seems to only come from *ceph test applications*. (ceph-mon and ceph-o=
sd are built correctly with xio).

For example:
make ceph_test_mon_workloadgen =3D> FAIL
make ceph-osd =3D> succeed

I positively know that ceph-osd was built with xio because I double checked=
 it using:

$ ldd bin/ceph-osd | grep libxio
        libxio.so.0 =3D> /usr/lib/libxio.so.0 (0x00007fd84d4b9000)

(also, I now that src/test/mon/CMakeFiles/ceph_test_mon_workloadgen.dir/lin=
k.txt does contain "-lxio")

regards,
  Avner

> -----Original Message-----
> From: Sage Weil=20
> Sent: Wednesday, September 07, 2016 18:51
> To: Kamble, Nitin A=20
> Cc: Nathan Cutler; Brad Hubbard; Avner Ben Hanoch;
> Gregory Farnum; Ceph Development <ceph-
> devel@vger.kernel.org>
> Subject: Re: should we remove autotools from master?
>=20
> Here's a PR:
>=20
> 	https://github.com/ceph/ceph/pull/11007
>=20
> I suggest we merge this, and then do an upstream dev release to shake out
> any lingering toolchain dependencies on autotools.
>=20
> sage
