From: Loic Dachary <loic@dachary.org>
Subject: pull request labels : related to
Date: Sun, 06 Sep 2015 18:04:28 +0200
Message-ID: <55EC640C.7020700@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QMEDj6Kgca54odPB0n1hCwoaqHCHilacu"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50502 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750871AbbIFQEb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Sep 2015 12:04:31 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 3B80742092
	for <ceph-devel@vger.kernel.org>; Sun,  6 Sep 2015 18:04:29 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QMEDj6Kgca54odPB0n1hCwoaqHCHilacu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I wen thru all pull request looking for those not related to anything (li=
ke having "bug fix" without "core" or "rgw"). Now that there are many lab=
els, it's not trivial for someone not used to Ceph to sort out what's wha=
t. We really have three kinds of labels:

 * those that relate the pull request to an area / component of Ceph (rgw=
, core, etc.)
 * those used to remember at what stage of QA the pull request is (wip-* =
and needs*qa)
 * those that describe the kind of pull request (cleanup, bug fix, perfor=
mance etc.)

To help reading the label I prefixed the names of rgw, core, etc. with "r=
elated to". If someone think that's not helpful or too long to read, feel=
 free to revert, it's just a proposal.

Cheers

P.S. For backport snippets that set the component to "core" we'll need to=
 change that to "related to core" instead. Not too much of an inconvenien=
ce IMHO but ...

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--QMEDj6Kgca54odPB0n1hCwoaqHCHilacu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXsZAwACgkQ8dLMyEl6F23NawCeMb02LSgp0eoWe2+TunyCBnTZ
EbMAniyfMHw417OaC6vKck0fmb5mWPmO
=F2a8
-----END PGP SIGNATURE-----

--QMEDj6Kgca54odPB0n1hCwoaqHCHilacu--
