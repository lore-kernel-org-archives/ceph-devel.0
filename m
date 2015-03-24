From: Loic Dachary <loic@dachary.org>
Subject: Re: Teuthology tests for SHEC
Date: Tue, 24 Mar 2015 14:22:58 +0100
Message-ID: <55116532.9010303@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA9F476@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="J12Sjvehus2cpk4JIjQmjBw0w5UOKnlUB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35716 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752379AbbCXNXB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Mar 2015 09:23:01 -0400
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA9F476@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J12Sjvehus2cpk4JIjQmjBw0w5UOKnlUB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/03/2015 09:32, Miyamae, Takeshi wrote:
> Dear Loic,
>=20
> We have just let teuthology work on our local cluster at last.

Congratulations !

> If six nodes are enough to provide qualified results, we will continue =
the teuthology tests
> on our cluster. How many nodes are required at least for such kind of p=
urpose ?

Six nodes will be good. The tests typically use two or three nodes and cr=
eate up to 14 OSDs on them.

> And then, we will use a local branch as a test target until #4132 will =
be merged.

That sounds right. Please speak up if you're having troubles.

Cheers

>=20
> Best regards,
> Takeshi Miyamae
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--J12Sjvehus2cpk4JIjQmjBw0w5UOKnlUB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlURZTIACgkQ8dLMyEl6F22XbwCguceHDZbrHt19mmF45biGxkOg
D6sAnRTwCwoXC2moUA5Fn3W5odRm+WXn
=tP7O
-----END PGP SIGNATURE-----

--J12Sjvehus2cpk4JIjQmjBw0w5UOKnlUB--
