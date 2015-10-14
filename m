From: Gaudenz Steinlin <gaudenz@debian.org>
Subject: Re: [Ceph-announce] v9.1.0 Infernalis release candidate released
Date: Wed, 14 Oct 2015 10:06:56 +0200
Message-ID: <87io6998m7.fsf@meteor.durcheinandertal.bofh>
References: <alpine.DEB.2.00.1510131356001.27022@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vechigen.cirrax.com ([217.197.128.12]:58917 "EHLO
	mail.cirrax.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbJNIM5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Oct 2015 04:12:57 -0400
In-Reply-To: <alpine.DEB.2.00.1510131356001.27022@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com
Cc: James Page <jamespage@debian.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi

Sage Weil <sage@newdream.net> writes:
> Upgrading from Firefly
> ----------------------
>
> Upgrading directly from Firefly v0.80.z is not possible.  All clusters
> must first upgrade to Hammer v0.94.4 or a later v0.94.z release; only
> then is it possible to upgrade to Infernalis 9.2.z.
>

What's the exact issue with upgrading directly from Firefly to
Infernalis? Is it just that you can't run mixed Firefly and Infernalis
versions at the same time during an upgrade or is also the on disk
format changing so that Infernals daemons won't understand the Firefly
data structures?

This is bad for Debian as the current stable release contains Firefly
and the next Debian stable will likely contain the LTS release scheduled
after Infernalis. So there won't be a Debian stable with Hammer. But
upgrades are important and we would really like to have an upgrade path
From=20one Debian release to the next.

Is there anything that can be done about this? At least having an
offline upgrade option would be nice, if an online upgrade is not
possible. How are other distributions planing to handle this? Ubuntu
will likely have a similar problem at least for LTS to LTS upgrades.

Gaudenz

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVh4NIM3PKyWkzVd5AQpUhA//VaEq5BiDUVpLDJGI5d/r991ONEPeCjTI
M5JpD7KcBTmIIrZk65L9xJ1n/bizD4CqQnHPluZ2tBK3qYMNAPiWZBCc9Zx0Q9uN
e7DxLtcLm6QzSfj1pzKmD178E8obiyyuZLBcPkMoUrDygvZC+PZKZjpwjkYtJTg9
SpJWW9/fhbeOK2aggh4xyi0h5K7JA07aCef53yYNuYvwfG40ahHiMX0xbOW7fGM2
AyUg85P11Zjez+dDHyv+5Jl8pnHd68THMDo2Xvga7KqHjNt6kyMCk8PFmsTLRCar
J7qbYVSrqfnUqPGd2+U186bgW6s95hUs6cAtc6B6Gpw/EpqspwShA9gg0+7C61i9
Y/kB+d/1gAS+Fz+0Px1Qwe8dPFo99nAd8UehEPP9F6jcyebGBoa/bzP/aK0joPKf
MyV14H/V2N0of1PiMnLp1uvJF7h67mDHQuskpD6gsauZKL+AIV8C/ulXxkUG/wS0
aVjgvijEBOce0bOp2J2uo/gNn7S8nf+6Dkfw7hKQZ9xkpmJ6ca9WxXlQxMGcV0/0
zX7C8/mhrrExJU2X+YohznZVEllJkqPnY8x78eALcuQuHMLJ2b3zyuRsI33L94nC
Oq86RcfxXn17WItk+JVGTdvJJjAut/zqgWEKBoDbbnu2WLP0FDKv7y/Hc1PRC8lp
nKfQNFqnEWk=
=S+4J
-----END PGP SIGNATURE-----
--=-=-=--
