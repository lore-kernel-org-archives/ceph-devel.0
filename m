From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: misc: ignore some unusable block devices
Date: Mon, 14 Dec 2015 18:18:26 +0000
Message-ID: <robbat2-20151214T181759-408594839Z@orbis-terrarum.net>
References: <566EDC50.3010901@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:46456 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932074AbbLNSSc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Dec 2015 13:18:32 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 9650E34084C
	for <ceph-devel@vger.kernel.org>; Mon, 14 Dec 2015 18:18:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <566EDC50.3010901@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, Ceph Development <ceph-devel@vger.kernel.org>


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 14, 2015 at 04:12:16PM +0100, Loic Dachary wrote:
> Hi Robin,
>=20
> I removed misc: ignore some unusable block devices
> 9c5eaeccb807d103884f46d174798dd982092696 from the openstack branch
> because it fails on CentOS 7 with
> the following. Could you please make a new pull request with it so we
> can keep testing it there ?
Will do, but I wonder how you managed to get a return code of 2 from it;
as that should be device-does-not-exist.

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iKYEARECAGYFAlZvB/FfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3Bl
bnBncC5maWZ0aGhvcnNlbWFuLm5ldDc1OTQwNEJFQkQ0MUY3MTIzODIzODZFRjNF
OTIyQzIyMzIzM0MyMkMACgkQPpIsIjIzwizIFwCg22lo4Tu5RS9ggLeDJpSCSvqb
jagAoKH2c7cfbWGVDjbSASCQ/jDUXhRo
=IJ0m
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--
