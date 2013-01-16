From: Loic Dachary <loic@dachary.org>
Subject: HOWTO: teuthology and code coverage
Date: Wed, 16 Jan 2013 15:01:08 +0100
Message-ID: <50F6B2A4.5090608@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig03ACD7920D89C7E1A2CF30D0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:39030 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab3APOBL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 09:01:11 -0500
Received: from [10.8.2.6] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 740B626394
	for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 15:01:08 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03ACD7920D89C7E1A2CF30D0
Content-Type: multipart/mixed;
 boundary="------------050801050807090508090201"

This is a multi-part message in MIME format.
--------------050801050807090508090201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm happy to report that running teuthology to get a lcov code coverage r=
eport worked for me.

http://dachary.org/wp-uploads/2013/01/teuthology/total/mon/Monitor.cc.gco=
v.html

It took me a while to figure out the logic (thanks Josh for the help :-).=
 I wrote a HOWTO explaining the steps in detail. It should be straightfor=
ward to run on an OpenStack tenant, using virtual machines instead of bar=
e metal.

http://dachary.org/?p=3D1788

Cheers


--------------050801050807090508090201
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


--------------050801050807090508090201--

--------------enig03ACD7920D89C7E1A2CF30D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlD2sqQACgkQ8dLMyEl6F22w8QCfdDIpBl9StMOQde3pLBWkHFxc
hNkAnRT/dc1fInZl5gaShgfUrIxqCEqZ
=bvZf
-----END PGP SIGNATURE-----

--------------enig03ACD7920D89C7E1A2CF30D0--
