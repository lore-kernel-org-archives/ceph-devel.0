From: Loic Dachary <loic@dachary.org>
Subject: Ceph man page is out of sync with actual command options
Date: Thu, 29 Jan 2015 11:44:13 +0100
Message-ID: <54CA0EFD.40708@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="i0LDU8xiU7LLhBIN3Ng4bjkBb4xiSb44I"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49011 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759300AbbA2KoQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jan 2015 05:44:16 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i0LDU8xiU7LLhBIN3Ng4bjkBb4xiSb44I
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi David,

I see you created a pull requests for backporting documentation to firefl=
y https://github.com/ceph/ceph/pull/3521

And also three issues to track the backport on firefly, giant and future =
hammer:

http://tracker.ceph.com/issues/10676 http://tracker.ceph.com/issues/10677=
 http://tracker.ceph.com/issues/10678

I'm not sure why http://tracker.ceph.com/issues/10678 is necessary ?=20

Since there does not seem to be an issue associated with the man page upd=
ates being backported, I understand why you created http://tracker.ceph.c=
om/issues/10676. I would have expected to see, in the backport field of t=
his issue, the string "firefly,giant" to note that the intention is to ba=
ckport to these releases. I think that's what we usually do for backporti=
ng. Is there a specific reason for creating http://tracker.ceph.com/issue=
s/10677 ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--i0LDU8xiU7LLhBIN3Ng4bjkBb4xiSb44I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTKDv0ACgkQ8dLMyEl6F239KACfbruAWkkUJYo4une+ZhG8lPnE
l6UAn2GnKahGQYJRTZSQxrU2rglGuzE7
=4mC7
-----END PGP SIGNATURE-----

--i0LDU8xiU7LLhBIN3Ng4bjkBb4xiSb44I--
