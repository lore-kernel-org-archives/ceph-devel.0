From: Loic Dachary <loic@dachary.org>
Subject: Re: Hitchhiker erasure code
Date: Fri, 20 Mar 2015 13:42:35 +0100
Message-ID: <550C15BB.9090305@dachary.org>
References: <550BF72E.6030406@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE8CF7E2@CERNXCHG43.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NtfENLl8RuCFgNVTAMbhp46GVGRsE2IAJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33367 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750990AbbCTMmj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Mar 2015 08:42:39 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE8CF7E2@CERNXCHG43.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NtfENLl8RuCFgNVTAMbhp46GVGRsE2IAJ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 20/03/2015 13:37, Andreas Joachim Peters wrote:
> Hi Loic,=20
> I looked at that some time ago.
>=20
> Table 1 in the paper says it all:
>=20
> If you care about decoding and reconstruction of data it gives a good i=
mprovement.
> If you care mainly about encoding speed, it is not the optimal choice (=
+72.1%).
>=20
> The algorithm optimizes the reconstruction of data units. This is relev=
ant if your read-size is typically smaller than the block-size e.g. you e=
ncode 4 MB objects and you read 4kb pages. With normal EC you get a read =
amplification of K*4k if a data stripe is down, while with hitchhiker you=
 get only 2/3 of that traffic in case of (10,4).
>=20
> The most interesting to implement is probably Hitchhiker-XOR+, which yo=
u have to combine with a Vandermonde matrix, it requires that the first p=
arity is just the xor of all data chunks.
>=20
> So, yes, there is certainly a benefit in implementing that compared to =
other approaches (Xorbas,LRC) since it does not involve a space overhead =
and opens the door to use larger K values and save space!
>=20

That sounds appealing :-) Do you think it would be more relevant to imple=
ment this as an additional Ceph plugin ? Or as a new jerasure technique ?=


--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--NtfENLl8RuCFgNVTAMbhp46GVGRsE2IAJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUMFbsACgkQ8dLMyEl6F21IAACfd26wwhiDDsm90nt2pW3PK5Zv
7AoAn2z362uRGXqs0XeRWZDnM6n0vwvs
=B4vB
-----END PGP SIGNATURE-----

--NtfENLl8RuCFgNVTAMbhp46GVGRsE2IAJ--
