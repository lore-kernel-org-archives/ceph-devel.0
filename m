From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: timeframe for v10.2.1?
Date: Fri, 6 May 2016 21:26:42 +0000
Message-ID: <robbat2-20160506T211936-725304103Z@orbis-terrarum.net>
References: <CALqRxCx1j5dWar_+g4UTvgXSk5fh_OHoVVDemFSW2x74FCv1bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uwB7x3tnyrZQfZJI"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:57092 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758265AbcEFV0n (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2016 17:26:43 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 61C85340751
	for <ceph-devel@vger.kernel.org>; Fri,  6 May 2016 21:26:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALqRxCx1j5dWar_+g4UTvgXSk5fh_OHoVVDemFSW2x74FCv1bA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


--uwB7x3tnyrZQfZJI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 06, 2016 at 02:14:28PM -0600,  Ken Dreyer wrote:
> Hi folks,
>=20
> When is v10.2.1 going to be released? Is it going to happen in a week
> (like by next Friday), or are there big things that still need to
> land?
I've got two outstanding PRs for .1:
PR8669 - rgw/s3website: ErrorDoc & Double-fault support=20
PR8633 - rgw/s3website: Fix x-amz-website-redirect-location support.=20

They only failed Jenkins because the build servers died long before it
got to testing RGW pieces.

This PR needs to be included as a backport:
PR8788 - rgw: add AWS4 completion support for RGW_OP_SET_BUCKET_WEBSITE

I have one other ticket that I hoped to have solved for .1, but it's
maybe a delay to .2 if it doesn't stand out as having a solution soon:
15530 - s3website: VHost-style buckets do not fire correctly
AWS S3 solves it by using dedicated IPs for s3 vs s3website, but trying
to do that for RGW seems to upset the RESTManager.

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85

--uwB7x3tnyrZQfZJI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iKYEARECAGYFAlctDBFfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3Bl
bnBncC5maWZ0aGhvcnNlbWFuLm5ldDc1OTQwNEJFQkQ0MUY3MTIzODIzODZFRjNF
OTIyQzIyMzIzM0MyMkMACgkQPpIsIjIzwizapQCgvgcHpMs6927sIdDgYzllIvCM
hFIAoMKbzJ1/iZ3RD5v+gsLcB3omEwk3
=YkEd
-----END PGP SIGNATURE-----

--uwB7x3tnyrZQfZJI--
