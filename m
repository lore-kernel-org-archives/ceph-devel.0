From: Loic Dachary <loic@dachary.org>
Subject: Mojette Transform implementation
Date: Wed, 29 May 2013 13:18:32 +0200
Message-ID: <51A5E408.6070104@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9F40F0CC9C1E0E78D4625773"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:45704 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965683Ab3E2LSg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 May 2013 07:18:36 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pierre Evenou <pierre.evenou@rozofs.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9F40F0CC9C1E0E78D4625773
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Pierre,

As discussed today over the phone, I'm very much interested in trying to =
reuse the Mojette Transform implementation in the context of the work rel=
ated to the implementation of an erasure coded backend in Ceph. The progr=
ess can be tracked from http://tracker.ceph.com/issues/5046 and the sub-t=
ickets and the original discussion from the last Ceph summit is at http:/=
/wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encoding_as_a_sto=
rage_backend

I was reading the code of rbs_restore_one_rb_entry at
https://github.com/rozofs/rozofs/blob/master/src/storaged/rbs.c#L104
and assumed the implementation is in
https://github.com/rozofs/rozofs/blob/master/src/storaged/rbs_transform.h=

https://github.com/rozofs/rozofs/blob/master/src/storaged/rbs_transform.c=
c

And also tried to understand http://en.wikipedia.org/wiki/Mojette_Transfo=
rm and bought "The Mojette Transform: Theory and Applications" http://eu.=
wiley.com/WileyCDA/WileyTitle/productCd-1848210809.html in the hope to ge=
t more sense out of it ;-)

Is there a part of the rozofs code you would advise me to read first in o=
rder to understand how it works ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig9F40F0CC9C1E0E78D4625773
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGl5AkACgkQ8dLMyEl6F22Y6wCgmYtWVPpqbvOhPOXQWqDt3O7Q
ecIAn0bdaQxujb/tjOY5KcIh2saf/Rhl
=iDvn
-----END PGP SIGNATURE-----

--------------enig9F40F0CC9C1E0E78D4625773--
