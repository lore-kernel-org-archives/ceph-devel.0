From: Christian Kauhaus <kc-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org>
Subject: Re: Blocked requests after "osd in"
Date: Thu, 10 Dec 2015 10:03:51 +0100
Message-ID: <56693FF7.8050708@flyingcircus.io>
References: <5667FC6E.5080600@flyingcircus.io>
	<B0751415-538E-471E-B310-76812C3C374C@schermer.cz>
	<56683B9E.8070201@flyingcircus.io>
	<CAANLjFqUoGTFSYrdwCwRw0apfXJN61SeS7FiXb0A_Bxtu4PJJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0340668854=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFqUoGTFSYrdwCwRw0apfXJN61SeS7FiXb0A_Bxtu4PJJg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Cc: Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0340668854==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ISAt8WBukaic0khTkvxMT7f7s15uHPG8Q"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ISAt8WBukaic0khTkvxMT7f7s15uHPG8Q
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 10.12.2015 um 06:38 schrieb Robert LeBlanc:
> I noticed this a while back and did some tracing. As soon as the PGs
> are read in by the OSD (very limited amount of housekeeping done), the
> OSD is set to the "in" state so that peering with other OSDs can
> happen and the recovery process can begin. The problem is that when
> the OSD is "in", the clients also see that and start sending requests
> to the OSDs before it has had a chance to actually get its bearings
> and is able to even service the requests. After discussion with some
> of the developers, there is no easy way around this other than let the
> PGs recover to other OSDs and then bring in the OSDs after recovery (a
> ton of data movement).

Many thanks for your detailed analysis. It's a bit disappointing that the=
re
seems to be no easy way around. Any work to improve the situation is much=

appreciated.

In the meantime, I'll be experimenting with pre-seeding the VFS cache to =
speed
things up at least a little bit.

Regards

Christian

--=20
Dipl-Inf. Christian Kauhaus <>< =C2=B7 kc-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org =C2=B7 +49 345 =
219401-0
Flying Circus Internet Operations GmbH =C2=B7 http://flyingcircus.io
Forsterstra=C3=9Fe 29 =C2=B7 06112 Halle (Saale) =C2=B7 Deutschland
HR Stendal 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, Chri=
stian Zagrodnick


--ISAt8WBukaic0khTkvxMT7f7s15uHPG8Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJWaT/3AAoJEDxNM5Hh8d3obAMIALFok1XPt2RIdUOXPn9v88Fn
k4hU7jUidJPyi3ElHtmOFoc0djHVJBWxEIhjXmJWFyhDMa0nMtUJEj6TsOJOH1qb
p/TsKNSGUEeOu89sKvAqDz5edBrz496DXCWZzNoRoEVlEwEuUPYtu6l4ZYxeSjX6
J2C8tghtVsF7K8gkzyO6OyKX8cZV6Ml3dZsto0JibvHp5v8BXTA51sCUjcDr217E
MyTWFeSX6Nfb1JF2lAMabfbRRoZZR6/dCGoY58r8kxMgdqvzPtTmY0e/hxlr5udJ
nOS0r+zsIQeSo4sHJArhNoPGXwZTDmwEGrVcEqmZMN/Y9qLSuORgovihtK7zWq4=
=1XZz
-----END PGP SIGNATURE-----

--ISAt8WBukaic0khTkvxMT7f7s15uHPG8Q--

--===============0340668854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0340668854==--
