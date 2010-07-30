From: Sage Weil <sage@newdream.net>
Subject: Re: cephx questions
Date: Fri, 30 Jul 2010 16:40:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007301639070.28085@cobra.newdream.net>
References: <7083006A98B5314F86152D05FFB1B99814AAEF06FF@ICE-MBX-2.ice.nd.edu>
 <Pine.LNX.4.64.1007301553230.28085@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2017183983-1280533202=:28085"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40582 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab0G3Xh2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 19:37:28 -0400
In-Reply-To: <Pine.LNX.4.64.1007301553230.28085@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Regola <nregola@nd.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2017183983-1280533202=:28085
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 30 Jul 2010, Sage Weil wrote:
> The cauthtool man page has a minimal set of caps for a machine to mount=
=20
> the file system.  Basically,
>=20
> client.foo
>         key: asdf
>         caps: [mds] allow
>         caps: [mon] allow r
>         caps: [osd] allow rw; allow rw pool=3D0

Correction: this should actually be

=09caps: [osd] allow rw pool=3Ddata

(The above works too, but only because the 'allow rw' grants it access to=
=20
all object pools.)

sage


>=20
> Or, if you're lazy, you can just use the client.admin key.  Just be sure=
=20
> to specify both name=3Dadmin,secret=3Dasdf (or name=3Dfoo,secret=3Dasdf, =
if using=20
> the above) as a mount option.  (The 'client.' name prefix is assumed.)
>=20
> I hope that answers your questions?
> sage
>=20
>=20
> > I pasted a redacted version of our=20
> > "auth list" output below. Perhaps we have an error in our authorization=
=20
> > list that caused the errors we experienced after the upgrade (and befor=
e=20
> > I changed some things).=A0 I can send a ceph.conf file as well if you n=
eed=20
> > it.=A0
> >=20
> > We can provide feedback on cephx code if you need it, as we were=20
> > planning on keeping our cluster "cephx enabled".=A0
> >=20
> > Thanks,
> >=20
> > Nathan Regola
> > Grid and Cloud Computing Analyst
> > University of Notre Dame
> > Center for Research Computing
> > P.O. Box 539
> > Room 110 Information Technology Center
> > Notre Dame, IN=A0 46556
> >=20
> > Phone: 574-631-5287
> >=20
> >=20
> > 10.07.30_13:07:08.584179 mon <- [auth,list]
> > 10.07.30_13:07:08.584825 mon0 -> 'installed auth entries:=20
> > mon.0
> > =A0=A0=A0=A0=A0=A0=A0 key: T
> > =A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow *
> > mds.opteron03
> > =A0=A0=A0=A0=A0=A0=A0 key: U
> > =A0=A0=A0=A0=A0=A0=A0 caps: [mds] allow
> > =A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
> > =A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
> > osd.0
> > =A0=A0=A0=A0=A0=A0=A0 key: V
> > =A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
> > =A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
> > osd.1
> > =A0=A0=A0=A0=A0=A0=A0 key: W
> > =A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
> > =A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
> > client.admin
> > =A0=A0=A0=A0=A0=A0=A0 key: X
> > =A0=A0=A0=A0=A0=A0=A0 caps: [mds] allow
> > =A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow *
> > =A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
> > ' (0)
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
> >=20
--557981400-2017183983-1280533202=:28085--
