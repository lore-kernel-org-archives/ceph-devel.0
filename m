From: Loic Dachary <loic@dachary.org>
Subject: rgw and the next hammer release v0.94.3
Date: Tue, 04 Aug 2015 12:41:35 +0200
Message-ID: <55C096DF.3080600@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="X3TNu5gDHo3Aadi7SdRu3R7sUi4Lwbqip"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:32900 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755974AbbHDKlh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 06:41:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X3TNu5gDHo3Aadi7SdRu3R7sUi4Lwbqip
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

The next hammer release as found at https://github.com/ceph/ceph/tree/ham=
mer passed the rgw suite (http://tracker.ceph.com/issues/11990#rgw and ht=
tp://tracker.ceph.com/issues/12502#note-6).=20

Do you think the hammer branch is ready for QE to start their own round o=
f testing ?

Cheers

P.S. http://tracker.ceph.com/issues/11990#Release-information has direct =
links to the pull requests merged into hammer since v0.94.2 in case you n=
eed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
















--X3TNu5gDHo3Aadi7SdRu3R7sUi4Lwbqip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXAlt8ACgkQ8dLMyEl6F213MQCdEXVt+KcQnuRXWFrfUyxXTS5p
eGMAn27Y3Aw0eXGGWeeQOM+ek0H9nLxo
=yjDV
-----END PGP SIGNATURE-----

--X3TNu5gDHo3Aadi7SdRu3R7sUi4Lwbqip--
