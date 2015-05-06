From: Siddharth Sharma <sisharma@redhat.com>
Subject: Re: hardening ceph build
Date: Thu, 07 May 2015 02:08:32 +0530
Message-ID: <62243403.NRpqDV1Elj@rem0te-expl0it>
References: <alpine.DEB.2.00.1505061321310.31339@cobra.newdream.net>
Reply-To: siddharth@redhat.com
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1625452.n7r4Kt1ukW"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58601 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbbEFUir (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 May 2015 16:38:47 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 0E5E891756
	for <ceph-devel@vger.kernel.org>; Wed,  6 May 2015 20:38:47 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.00.1505061321310.31339@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, mbroz@redhat.com, branto@redhat.com

--nextPart1625452.n7r4Kt1ukW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Wednesday, May 06, 2015 01:25:01 PM Sage Weil wrote:
> Is something like this what we should be doing?
>=20
>  http://mainisusuallyafunction.blogspot.com/2012/05/automatic-binary-=
hardeni
> ng-with.html
>=20
> Or just -fPIE?  Or ...
>=20
> I suspect we also wan to do something like --disable-static to halve =
the
> libtool build times.  Is -fPIC still needed if -fPIE is specified?
>=20
> Thanks!
> sage
Hi Sage,

=2DfPIC works on shared libraries where as -fpie works on independent=20
executable. It has been long time that all our builds are built with -f=
pic by=20
default. So both are required.

Regards,
=2D-=20
Siddharth Sharma / Red Hat Product Security / Key ID : 0xD9F6489A     =20=

Fingerprint :  0x6F04C684 A49C E4CE 8148 E841 CD6F 8E55 D9F6 489A

--nextPart1625452.n7r4Kt1ukW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVSnvTAAoJEM1vjlXZ9kiaQr4P/1W9Rh/Mn+N6LRWYG1A5+Yz8
X4UMfsYeYMbavwB443GRYZJBoEQbzqHhv03hz80tiqSwd2+/EzVWzGrsFkjkKZgF
c6BYVMiGmU4wRD4inyVPUsvCBaFl9GNnqVG24MzOdi30D29HldfUhznYUjxNzO6P
siYhhUSHrfppyqi0+BK0p+TrF6GEmGCxmeDUDNtepBBORF05E7uuKNrVZ0TfAgYi
B+Xcfa4jS/bkGhkOyEnapNAhVO8JwVLlFGCYHpDIorX3ZapSgbo8vPZup56dKZBV
7kZ0jat+QzT8Pp/iZW3Pu87QPZNQn99ZRrfuzEhXEyMkw94xz4xKjGYjplUZP9ff
cZRZ8TDYQooTASPakwDLhAlv2gIB18CFq2QqkOvjOqTTjwtzAk1iWNlcUCLMNqqt
4hAuuDPGDr2US0kc8pC8hvfRnmY8rW3ggrOYPOQdzM55AnuiWc0Ve9AVXEyccOSw
G4nGvOXsGuiBjCBSZHmuIR8iBnktPKPqxyNJnfDEg1IdOt2+vldy90/XMUVy8YYA
DoyyJ1GSSCdH27YBOjblZKfnmbf1T4rOMteg5fijRPSgxChbYZxAVPqVQZn8BfLP
TmWBXb123yL0jrGBM3qtSdYpdQz3lvjmv9HUKDp30XaB5k61Me7vFJw/QHZau4qh
DL6bpfPwFFc/Rp2goK1e
=t5Zg
-----END PGP SIGNATURE-----

--nextPart1625452.n7r4Kt1ukW--

