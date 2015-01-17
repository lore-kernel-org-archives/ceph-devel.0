From: Loic Dachary <loic@dachary.org>
Subject: ceph-qa analysis output
Date: Sat, 17 Jan 2015 14:07:25 +0100
Message-ID: <54BA5E8D.30508@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uDoTBFEnCgvc3wlx2xVW6hccmo4mxT2EF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42413 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752229AbbAQNH1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Jan 2015 08:07:27 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uDoTBFEnCgvc3wlx2xVW6hccmo4mxT2EF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

It would be great if the analysis you compile daily was machine readable.=
 For instance, in a mail you sent to ceph-qa I read

'701575', '701576', '701582', '701590' - known issue
http://tracker.ceph.com/issues/10543

"FAILED assert(m_seed < old_pg_num)"

(duplicate of http://tracker.ceph.com/issues/10430)

which could be something like:

'701575', '701576', '701582', '701590': http://tracker.ceph.com/issues/10=
543 FAILED assert(m_seed < old_pg_num)

or any other format you find easier to use consistently.=20

The reason I ask is because it would help me write a script that associat=
es redmine tickets to your findings, in the context of backporting. It's =
just an idea, not a request ;-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--uDoTBFEnCgvc3wlx2xVW6hccmo4mxT2EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS6Xo0ACgkQ8dLMyEl6F22UzACfdvfqRcmcMWimectawABTT8iK
Ew4An1+0DTz6s2Nd+CtUds9iVjDbIlt4
=EpaO
-----END PGP SIGNATURE-----

--uDoTBFEnCgvc3wlx2xVW6hccmo4mxT2EF--
