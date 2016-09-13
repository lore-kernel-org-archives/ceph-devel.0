From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: should we remove autotools from master?
Date: Tue, 13 Sep 2016 10:20:08 +0000
Message-ID: <VI1PR05MB1614E066A8F6A8DFBD781353A9FE0@VI1PR05MB1614.eurprd05.prod.outlook.com>
References: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to>
 <856563CD-6D2D-4248-B688-4A146A6F9C4B@Teradata.com>
 <alpine.DEB.2.11.1609071550470.32742@piezo.us.to>
 <VI1PR05MB16149F7E6289B00B66FE17DEA9FE0@VI1PR05MB1614.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0085.outbound.protection.outlook.com ([104.47.2.85]:26912
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750951AbcIMLx6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Sep 2016 07:53:58 -0400
In-Reply-To: <VI1PR05MB16149F7E6289B00B66FE17DEA9FE0@VI1PR05MB1614.eurprd05.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>, Sage Weil <sweil@redhat.com>, "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Brad Hubbard <bhubbard@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

More info:=20
I think that the link problem is probably because /usr/lib is missing from =
the *link_directories* in "makefiles" of some ceph executables (even though=
 they are linked with -lxio).  (ceph-osd probably gets /usr/lib because it =
takes tcmalloc from that directory)

I believe I will be able to fix it. However, I am putting that effort on ho=
ld for the moment as we are focusing on releasing new version of ceph with =
xio in 2 weeks.

Thanks,
  Avner


> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Avner Ben Hanoch
> Sent: Tuesday, September 13, 2016 09:43
>=20
> Hi,
>=20
> Thanks for the PR notice.
>=20
> I don't have any comment on the PR itself.  Only that I am not familiar w=
ith
> cmake and I don't manage to compile ceph with xio after cmake. Neither I
> manage to fix the cmake files.
>=20
> I am using cmake -DWITH_XIO=3DON, then - at make - I am getting many
> "undefined reference" link errors for xio symbols.  The point is that the=
 link
> errors seems to only come from *ceph test applications*. (ceph-mon and
> ceph-osd are built correctly with xio).
>=20
> For example:
> make ceph_test_mon_workloadgen =3D> FAIL
> make ceph-osd =3D> succeed
>=20
> I positively know that ceph-osd was built with xio because I double check=
ed it
> using:
>=20
> $ ldd bin/ceph-osd | grep libxio
>         libxio.so.0 =3D> /usr/lib/libxio.so.0 (0x00007fd84d4b9000)
>=20
> (also, I now that
> src/test/mon/CMakeFiles/ceph_test_mon_workloadgen.dir/link.txt does
> contain "-lxio")
>=20
> regards,
>   Avner
>=20
> > -----Original Message-----
> > From: Sage Weil
> > Sent: Wednesday, September 07, 2016 18:51
> > To: Kamble, Nitin A
> > Cc: Nathan Cutler; Brad Hubbard; Avner Ben Hanoch; Gregory Farnum;
> > Ceph Development <ceph- devel@vger.kernel.org>
> > Subject: Re: should we remove autotools from master?
> >
> > Here's a PR:
> >
> > 	https://github.com/ceph/ceph/pull/11007
> >
> > I suggest we merge this, and then do an upstream dev release to shake
> > out any lingering toolchain dependencies on autotools.
> >
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in =
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
