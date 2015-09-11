From: Loic Dachary <loic@dachary.org>
Subject: Re: pet project: OSD compatible daemon
Date: Fri, 11 Sep 2015 17:10:43 +0200
Message-ID: <55F2EEF3.9060603@dachary.org>
References: <55EFF1A6.9060201@dachary.org> <CAFdRU728GucijsJgcw+do9dp=JLx6KpLvr42apUU1vrgxLT7Ug@mail.gmail.com> <1005119049.15552536.1441980521113.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cqr1FVmSn83IVUXHjTKCvlU4jDbVnhUAA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53857 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752355AbbIKPKt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 11:10:49 -0400
In-Reply-To: <1005119049.15552536.1441980521113.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cqr1FVmSn83IVUXHjTKCvlU4jDbVnhUAA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 11/09/2015 16:08, Shinobu Kinjo wrote:
> What I'm thinking of is to use fluentd to get log with
> quite human-readable format.

If you refer to https://github.com/fluent/fluentd it's different. Or is i=
t something else ?

>=20
> Is it same of what you are thinking of?
>=20
> Shinobu
>=20
> ----- Original Message -----
> From: "Shinobu" <shinobu.kj@gmail.com>
> To: skinjo@redhat.com
> Sent: Friday, September 11, 2015 6:16:18 PM
> Subject: Fwd: pet project: OSD compatible daemon
>=20
> ---------- Forwarded message ----------
> From: Loic Dachary <loic@dachary.org>
> Date: Wed, Sep 9, 2015 at 5:45 PM
> Subject: pet project: OSD compatible daemon
> To: Ceph Development <ceph-devel@vger.kernel.org>
>=20
>=20
> Hi Ceph,
>=20
> I would like to try to write an OSD compatible daemon, as a pet project=
, to
> learn Go and better understand the message flow. I suspect it may also =
be
> useful for debug purposes but that's not my primary incentive.
>=20
> Has anyone tried something similar ? If so I'd happily contribute inste=
ad
> of starting something from scratch.
>=20
> Cheers
>=20
> P.S. Since it's a pet project it's likely to take months before there i=
s
> any kind of progress ;-)
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--cqr1FVmSn83IVUXHjTKCvlU4jDbVnhUAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXy7vMACgkQ8dLMyEl6F22WvwCggKWasSLxD19LtuT5kPwAeihO
d3QAoMYCSPCltMgK+tbETvXyOL0X/SP0
=e/yV
-----END PGP SIGNATURE-----

--cqr1FVmSn83IVUXHjTKCvlU4jDbVnhUAA--
