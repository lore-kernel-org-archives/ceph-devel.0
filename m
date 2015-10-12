From: Loic Dachary <loic@dachary.org>
Subject: hammer branch for v0.94.4 ready for QE
Date: Tue, 13 Oct 2015 01:28:16 +0200
Message-ID: <561C4210.2030101@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NxcUAroJpTbrLdsw8pGafipTmxROPOntx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41676 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751878AbbJLX2T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Oct 2015 19:28:19 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NxcUAroJpTbrLdsw8pGafipTmxROPOntx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

The hammer branch for v0.94.4 as found at https://github.com/ceph/ceph/co=
mmits/hammer has been approved by Yehuda, Josh and Sam (there are no Ceph=
FS related commits according to Greg, hence his approval was not relevant=
) and is ready for QE. For the record, the head is https://github.com/cep=
h/ceph/commit/7f485ed5aa620fe982561663bf64356b7e2c38f2 and the details of=
 the tests run are at http://tracker.ceph.com/issues/12701.

This time around, instead of adding the table to the description, I propo=
se you add it as a comment (which can be edited later on). It is easier b=
ecause it's not overloaded with unrelated content. There also is the matt=
er of the maximum size of the description field: there is a real risk of =
exceeding it and truncate the result.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre













--NxcUAroJpTbrLdsw8pGafipTmxROPOntx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYcQhAACgkQ8dLMyEl6F21hLQCgmdHTEN4yp4ozBftfDEALiDrp
bJ4AnjWl6CIVeWKIkJAv19O0LChRyfWp
=sUPW
-----END PGP SIGNATURE-----

--NxcUAroJpTbrLdsw8pGafipTmxROPOntx--
