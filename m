From: Loic Dachary <loic@dachary.org>
Subject: v0.94.4 backports status
Date: Tue, 01 Sep 2015 17:35:49 +0200
Message-ID: <55E5C5D5.1060901@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="P2oftjBrj81h03qCXL4X3lTFxQToNan2g"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47578 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751535AbbIAPfw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Sep 2015 11:35:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P2oftjBrj81h03qCXL4X3lTFxQToNan2g
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

http://tracker.ceph.com/issues/12701#note-57 is the current status of the=
 v0.94.4 backport. I switched to using comments instead of updating the d=
escription because the length of the description is limited and it overfl=
ows. It's also better as it's organized chronoligicaly, maybe we should k=
eep doing that.

In a nutshell, right now all the DNM: pull requests are associated with a=
 way to reproduce the problem, which includes 3 pull requests that cause =
the errors in the rgw suite. I'm running a rgw suite at http://tracker.ce=
ph.com/issues/12701#note-58 and hope it will pass. Since I've added a few=
 (5 or 6) new backports in the meantime in an attempt to fix the problems=
 we were seeing, there also is a potential for regression. But I'm optimi=
stic :)

After all backports in the New state have a matching pull request, we can=
 schedule another run of rados, fs, upgrade and rbd.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--P2oftjBrj81h03qCXL4X3lTFxQToNan2g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXlxdUACgkQ8dLMyEl6F23aHQCeI7s26pn2s9IVhNeqGjBkG/Ft
0acAnR/YgZuB5ojyo1o8lFFbIvb2OmCk
=jsqw
-----END PGP SIGNATURE-----

--P2oftjBrj81h03qCXL4X3lTFxQToNan2g--
