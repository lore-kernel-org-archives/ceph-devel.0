From: Mario van der Linde <linde@b1-systems.de>
Subject: Re: rbd - input/output error
Date: Mon, 14 Nov 2011 22:59:34 +0100
Message-ID: <4EC18F46.70102@b1-systems.de>
References: <4EBF98B5.7040706@b1-systems.de> <Pine.LNX.4.64.1111141148220.29742@cobra.newdream.net> <4EC18864.4010308@b1-systems.de> <Pine.LNX.4.64.1111141338160.3717@cobra.newdream.net>
Reply-To: linde@b1-systems.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8DDADEC4E3339DC2DB41A13A"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from schattenjagd.systems.b1-systems.de ([217.11.58.34]:34542 "EHLO
	mx1.b1-systems.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755977Ab1KNV7e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 16:59:34 -0500
Received: from chewbakkat4003.office.b1-systems.de (g226139069.adsl.alicedsl.de [92.226.139.69])
	by mx1.b1-systems.de (Postfix) with ESMTPSA id 2D1A64084
	for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2011 22:59:32 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.1111141338160.3717@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8DDADEC4E3339DC2DB41A13A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

On 14.11.2011 22:39, Sage Weil wrote:
[...]
>> This one gave me some output:
>> rbd create testimg --size=3D10240 --log-to-stderr 2 --debug-ms 2
>>
>> See attached file.
>=20
> It sounds like the OSD can't find the libcls_rbd.so file.  Can you veri=
fy=20
> that it is in /usr/lib/rados-classes, and that that location isn't be=20
> overridden by something in ceph.conf?

At first, on all Systems this file exists, but in /usr/lib64, not /usr/li=
b:
> ceph5:~ # for f in `seq 1 5`; do ssh ceph${f} ls -l /usr/lib64/rados-cl=
asses; done | grep ' libcls_rbd.so '
> lrwxrwxrwx 1 root root    19 Nov 10 10:15 libcls_rbd.so -> libcls_rbd.s=
o.1.0.0
> lrwxrwxrwx 1 root root    19 Nov 10 10:15 libcls_rbd.so -> libcls_rbd.s=
o.1.0.0
> lrwxrwxrwx 1 root root    19 Nov 10 10:16 libcls_rbd.so -> libcls_rbd.s=
o.1.0.0
> lrwxrwxrwx 1 root root    19 Nov 10 10:16 libcls_rbd.so -> libcls_rbd.s=
o.1.0.0
> lrwxrwxrwx 1 root root    19 Nov 10 10:16 libcls_rbd.so -> libcls_rbd.s=
o.1.0.0

Seems to be the right place in an x86_64 system.

In ceph.conf there is no setting regarding to lib path.

Is ceph-radosgw needed for rbd? I think not, while radosgw is AFAIK the
REST interface...
This package is not installed (due to a not resolveable cgi dependency).


Regards
Mario


--=20
Mario van der Linde
Linux Consultant & Trainer
Tel.: +49-151-16879485
Mail: linde@b1-systems.de

B1 Systems GmbH
Osterfeldstra=DFe 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537


--------------enig8DDADEC4E3339DC2DB41A13A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7Bj0kACgkQ0xt2iESAuwQ9agCcCfoZPQ2bcpc4VrWKGUq5f837
hQAAn1qBSd5MqwcDf37IFN4wS19hZsOJ
=U75k
-----END PGP SIGNATURE-----

--------------enig8DDADEC4E3339DC2DB41A13A--
