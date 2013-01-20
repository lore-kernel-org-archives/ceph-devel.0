From: Loic Dachary <loic@dachary.org>
Subject: Throttle::wait use case clarification
Date: Sun, 20 Jan 2013 14:39:48 +0100
Message-ID: <50FBF3A4.4010200@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA358F39C3A8765224AEF135F"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:51088 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab3ATNjv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 08:39:51 -0500
Received: from [10.8.2.6] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id B223C26394
	for <ceph-devel@vger.kernel.org>; Sun, 20 Jan 2013 14:39:49 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA358F39C3A8765224AEF135F
Content-Type: multipart/mixed;
 boundary="------------020604010800010709060703"

This is a multi-part message in MIME format.
--------------020604010800010709060703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

While working on unit tests for Throttle.{cc,h} I tried to figure out a u=
se case related to the Throttle::wait method but couldn't

https://github.com/ceph/ceph/pull/34/files#L3R258

Although it was not a blocker and I managed to reach 100% coverage anyway=
, it got me curious and I would very much appreciate pointers to understa=
nd the rationale.

wait() can be called to set a new maximum before waiting for all pending =
threads to get get what they asked for. Since the maximum has changed, wa=
it() wakes up the first thread : the conditions under which it decided to=
 go to sleep have changed and the conclusion may be different.

However, it only does so when the new maximum is less than current one. F=
or instance

A) decision does not change

  max =3D 10, current 9
  thread 1 tries to get 5 but only 1 is available, it goes to sleep
  wait(8)
  max =3D 8, current 9
  wakes up thread 1
  thread 1 tries to get 5 but current is already beyond the maximum, it g=
oes to sleep

B) decision changes

  max =3D 10, current 1
  thread 1 tries to get 10 but only 9 is available, it goes to sleep
  wait(9)
  max =3D 9, current 1
  wakes up thread 1
  thread 1 tries to get 10 which is above the maximum : it succeeds becau=
se current is below the new maximum

It will not wake up a thread if the maximum increases, for instance:

  max =3D 10, current 9
  thread 1 tries to get 5 but only 1 is available, it goes to sleep
  wait(20)
  max =3D 20, current 9
  does *not* wake up thread 1
  keeps waiting until another thread put(N) with N >=3D 0 although there =
now is 11 available and it would allow it to get 5 out of it

Why is it not desirable for thread 1 to wake up in this case ? When debug=
ging a real world situation, I think it would show as a thread blocked al=
though the throttle it is waiting on has enough to satisfy its request. W=
hat am I missing ?

Cheers


--------------020604010800010709060703
Content-Type: text/x-vcard; charset=utf-8;
 name="loic.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="loic.vcf"

begin:vcard
fn:Loic Dachary
n:Dachary;Loic
org:Artisan Logiciel Libre
adr:;;12 bd Magenta;Paris;;75010;France
email;internet:loic@dachary.org
title:Senior Developer
tel;work:+33 4 84 25 08 05
tel;home:+33 9 51 18 43 38
tel;cell:+33 6 64 03 29 07
note:Born 131414404 before EPOCH.
url:http://dachary.org/
version:2.1
end:vcard


--------------020604010800010709060703--

--------------enigA358F39C3A8765224AEF135F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlD786UACgkQ8dLMyEl6F20puwCgtTXgKvw0gtLjj+BxTZfZ8NH7
QhgAoMKRsrpJxGgPRq9wNtDEdCzFjg6X
=0g6n
-----END PGP SIGNATURE-----

--------------enigA358F39C3A8765224AEF135F--
