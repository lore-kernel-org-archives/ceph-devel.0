From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: coverity scan - a plea for help!
Date: Thu, 09 May 2013 22:31:30 +0200
Message-ID: <518C07A2.1030806@bisect.de>
References: <alpine.DEB.2.00.1305090922300.4023@cobra.newdream.net>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2KLEENEBFOJNWLJDPPISD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:47341 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751996Ab3EIUbk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 May 2013 16:31:40 -0400
In-Reply-To: <alpine.DEB.2.00.1305090922300.4023@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2KLEENEBFOJNWLJDPPISD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

I would like to take a look at the issues.

Danny

Am 09.05.2013 18:26, schrieb Sage Weil:
> We were added to coverity's awesome scan program a while back, which gi=
ves=20
> free access to their static analysis tool to open source projects.
>=20
> Currently it identifies 421 issues.  We've already taken care of the on=
es=20
> that are highest impact, but the usefulness of periodic scans is limite=
d=20
> until we can eliminate the noise from the remaining issues and easily s=
ee=20
> when new problems come up.
>=20
> If anybody is interested in helping out in the cleanup effort, let me k=
now=20
> and I'll share the login info.  This would provide significant value to=
=20
> our overall quality efforts and is a pretty easy way to make a meaningf=
ul=20
> contribution to the project without a huge investment in understanding =
the=20
> code and architecture!
>=20
> sage



------enig2KLEENEBFOJNWLJDPPISD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iJwEAQECAAYFAlGMB6cACgkQ9DHLX79LmTK97QP8DDcKntPURmHcLF0euWVjzCiU
+I+mzM7j45ueeVIJLSA8rhCh4ZUAAliYxBUXfKzp7Ay0J+td2uOu3IQ5phzIjAw5
JJ3Hjm6GEMl+PNF/dXSe4x1WCKUbzM3BHHu96/dNGwDwv+z7n53ZvavUtsVhYy2Y
LLlhnT8fll2+2OR2viA=
=yeH0
-----END PGP SIGNATURE-----

------enig2KLEENEBFOJNWLJDPPISD--
