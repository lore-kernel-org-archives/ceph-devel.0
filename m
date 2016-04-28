From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: building boost statically
Date: Thu, 28 Apr 2016 22:56:56 +0000
Message-ID: <robbat2-20160428T225021-424429122Z@orbis-terrarum.net>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:45246 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615AbcD1W45 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Apr 2016 18:56:57 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 0338D340CB4
	for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 22:56:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 28, 2016 at 06:47:55PM -0400,  Sage Weil wrote:
> Hi all,
>=20
> We'd really like to use the latest boost, mainly so that we can use=20
> small_vector in a zillion places and avoid extra memory allocations.  The=
=20
> distros, as always, are behind.
=46rom a distribution perspective, LESS static building is better, so this
proposal is a concern, but I do realize that the Gentoo/ArchLinux/CoreOS
perspective is very different than the Ubuntu LTS perspective.

What's the state of having a more-up-to-date Boost in things like Ubuntu
backports, so that you don't have the overhead of having to maintain
your own boost packages or statically link?

If support for statically linking a newer Boost is brought it, please,
please keep dynamic boost builds as fully supported, for distributions
that can keep up to date. As a bonus, at some point in the future, when
the slower distributions catch up, you might be able to escape the
static again.

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iKYEARECAGYFAlcilTdfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3Bl
bnBncC5maWZ0aGhvcnNlbWFuLm5ldDc1OTQwNEJFQkQ0MUY3MTIzODIzODZFRjNF
OTIyQzIyMzIzM0MyMkMACgkQPpIsIjIzwiy6IQCcCcySWeYuTOHEDtKKax8rDJUW
dwIAnAveSoRS3T2sJdaptSR/MqFMegcv
=xmzF
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
