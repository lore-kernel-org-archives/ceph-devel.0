From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: s3website 404 behaviour
Date: Mon, 2 May 2016 17:48:32 +0000
Message-ID: <robbat2-20160502T174646-839082880Z@orbis-terrarum.net>
References: <87eg9kva62.fsf@suse.com>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c7hkjup166d4FzgN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53964 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224AbcEBRsd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 May 2016 13:48:33 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 8B18E340AF0
	for <ceph-devel@vger.kernel.org>; Mon,  2 May 2016 17:48:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <87eg9kva62.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--c7hkjup166d4FzgN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(I'm on the list, no need to mail me directly).

On Mon, May 02, 2016 at 03:53:09PM +0200, Abhishek Lekshmanan wrote:
> the browser sees a 200 OK and just does a download of an empty file, rgw
> actually returns a 404 here[1]. I haven't checked the behavior on S3
> yet, Is there something else that needs to be set in bucket website
> configuration, or is this something RGW is doing wrong at the moment?
> [1]: https://gist.github.com/theanalyst/891781582ddc454bafdc5ef7d075ec7a
What commits are you using?
You'll need both PR8633 and PR8669 present.

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85

--c7hkjup166d4FzgN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iKYEARECAGYFAlcnku9fFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3Bl
bnBncC5maWZ0aGhvcnNlbWFuLm5ldDc1OTQwNEJFQkQ0MUY3MTIzODIzODZFRjNF
OTIyQzIyMzIzM0MyMkMACgkQPpIsIjIzwixahgCdFudxeVcij6ptG7AXAMfHUpuv
Jy0AoJwJjgNI02gMI8wIhe2cHrz0xDj3
=it7p
-----END PGP SIGNATURE-----

--c7hkjup166d4FzgN--
