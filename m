From: Loic Dachary <loic@dachary.org>
Subject: dumpling & giant backports update
Date: Tue, 10 Feb 2015 16:25:55 +0100
Message-ID: <54DA2303.9070003@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="panLakxqH8NlP5TxvjDBf9sxQoeQvCO06"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41806 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750729AbbBJPZ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 10:25:57 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--panLakxqH8NlP5TxvjDBf9sxQoeQvCO06
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

The dumpling integration branch https://github.com/ceph/ceph/commits/dump=
ling-backports is ready for Josh and Sam and we are expecting approval fr=
om Yehuda (the details are here http://tracker.ceph.com/issues/10560).

The giant integration branch https://github.com/ceph/ceph/commits/giant-b=
ackports is ready for Sam and we are expecting approval from Josh and Yeh=
uda (the details are here http://tracker.ceph.com/issues/10501).

It is likely that we get approval for one branch or the other in the next=
 48h. When we do, I assume you will be conducting your own round of testi=
ng, using the dumpling-backports and/or giant-backports branch. Do you ha=
ve a list of suites you plan to run already ? I'm also curious to underst=
and who will be analyzing the results and ultimately declare that it is r=
eady to be released.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre




--panLakxqH8NlP5TxvjDBf9sxQoeQvCO06
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTaIwMACgkQ8dLMyEl6F21lvwCglCLANrCVCjIkBwrWO4F0hKFy
LD4An0n/mKNqJyyiW441aHewa8y10YY5
=Cdd4
-----END PGP SIGNATURE-----

--panLakxqH8NlP5TxvjDBf9sxQoeQvCO06--
