From: Loic Dachary <loic@dachary.org>
Subject: Re: [Hammer Backports] Status of https://github.com/ceph/ceph/pull/5812
Date: Tue, 15 Sep 2015 16:09:40 +0200
Message-ID: <55F826A4.7060908@dachary.org>
References: <CAP3mxSx8ziqAhQH58eEim1MvwSj6f-A0bBkEey_YA7AtkZCLCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PHx4F4RaxDvuJ7vGXul0Mcw5FApKCaWro"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55771 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753296AbbIOOJm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 10:09:42 -0400
In-Reply-To: <CAP3mxSx8ziqAhQH58eEim1MvwSj6f-A0bBkEey_YA7AtkZCLCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>, abhishek.lekshmanan@gmail.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ncutler@suse.cz

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PHx4F4RaxDvuJ7vGXul0Mcw5FApKCaWro
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15/09/2015 12:36, Abhishek Varshney wrote:

>   * https://github.com/ceph/ceph/pull/5812 run-make-check-status SUCCES=
S.
>       o This is the PR with changes to obj_bencher.{cc,h}, and I guess =
we are waiting for Sage's approval to backport all commits from 9bcf5f0 t=
o 069d95e along with it.

Correct :-)

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--PHx4F4RaxDvuJ7vGXul0Mcw5FApKCaWro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEUEARECAAYFAlX4JqQACgkQ8dLMyEl6F21cggCeKVNt/CmtyvCKwiwgo0T+jkm6
9A4AmPmmcUOdFcRGAJ01Ao6VlJf2T6g=
=u042
-----END PGP SIGNATURE-----

--PHx4F4RaxDvuJ7vGXul0Mcw5FApKCaWro--
