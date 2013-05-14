From: Loic Dachary <loic@dachary.org>
Subject: Fwd: Re: [ceph] update op added to a waiting queue or discarded (2c57719)
Date: Tue, 14 May 2013 22:56:20 +0200
Message-ID: <5192A4F4.6010108@dachary.org>
References: <dachary/ceph/commit/2c57719b658f41c34f8077899718956cc95f09b4/3210554@github.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC04FA52F059DF30B38BBFE02"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:56787 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758429Ab3ENU4X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 16:56:23 -0400
In-Reply-To: <dachary/ceph/commit/2c57719b658f41c34f8077899718956cc95f09b4/3210554@github.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC04FA52F059DF30B38BBFE02
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I'm not sure how this should be done thru github, therefore I send a regu=
lar mail instead ;-)

The https://github.com/ceph/ceph/pull/283 pull request was updated with a=
n amended patch, hopefully taking into account the changes from next.

https://github.com/dachary/ceph/commit/dbddffef0604a5fc672e503fbb1b78b112=
34c7ca#L0R78

Cheers

-------- Original Message --------
Subject: 	Re: [ceph] update op added to a waiting queue or discarded (2c5=
7719)
Date: 	Tue, 14 May 2013 10:45:19 -0700
From: 	athanatos <notifications@github.com>
Reply-To: 	dachary/ceph <reply+c-3210554-727dd2f4c2b6572624859680949de999=
defe5985-433594@reply.github.com>
To: 	dachary/ceph <ceph@noreply.github.com>
CC: 	Loic Dachary <loic@dachary.org>



Some of the details of the PG op queueing have changed again in next. See=
 fd90105 <https://github.com/dachary/ceph/commit/fd901056831586e8135e28c8=
f4ba9c2ec44dfcf6>.

=E2=80=94
Reply to this email directly or view it on GitHub <https://github.com/dac=
hary/ceph/commit/2c57719b658f41c34f8077899718956cc95f09b4#commitcomment-3=
210554>.



--------------enigC04FA52F059DF30B38BBFE02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGSpPUACgkQ8dLMyEl6F212ygCfTCRJLxwD7KSlm7boSOHNjARO
PAsAoI0jfe1buVgqqFABFFUd1Bi9WThj
=TUV7
-----END PGP SIGNATURE-----

--------------enigC04FA52F059DF30B38BBFE02--
