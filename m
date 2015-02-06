From: Loic Dachary <loic@dachary.org>
Subject: Re: RBD tests on the next dumpling release
Date: Fri, 06 Feb 2015 15:17:39 +0100
Message-ID: <54D4CD03.8000806@dachary.org>
References: <54D3EEF6.1070701@dachary.org> <1050495133.7647881.1423231520223.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="loX9RPjbuEoAQOGdtiSplQQ0nm1wp87dJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39923 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751151AbbBFORm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 09:17:42 -0500
In-Reply-To: <1050495133.7647881.1423231520223.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--loX9RPjbuEoAQOGdtiSplQQ0nm1wp87dJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Thanks for taking time to check :-)=20

http://tracker.ceph.com/issues/9854 is indeed in the list of issues that =
need backporting for dumpling:

http://workbench.dachary.org/ceph/ceph-backports/wikis/dumpling#issues-th=
at-need-backporting

so is http://tracker.ceph.com/issues/10299. I'm happy to do another round=
 of testing if you think these two need to be in the next release. Otherw=
ise they will be in the next point release. I'm hopeful we'll be able to =
do more frequent point releases in the future.

On 06/02/2015 15:05, Jason Dillaman wrote:> I'll take a look at it today,=
 but my gut tells me it probably has something to do w/ a new version of =
QEMU (assuming the binary isn't source controlled).  On a semi-related no=
te, I just discovered that http://tracker.ceph.com/issues/9854 is missing=
 a dumpling backport request.  I'll get a dumpling pull request for that =
issue ASAP.
>=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--loX9RPjbuEoAQOGdtiSplQQ0nm1wp87dJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTUzQMACgkQ8dLMyEl6F20QFQCcCTBF7bNMEGqmNvomox+Zgd9Q
yA0AnRYs0EVdBIALAGSro3TzxeO2V5K6
=2Eu3
-----END PGP SIGNATURE-----

--loX9RPjbuEoAQOGdtiSplQQ0nm1wp87dJ--
