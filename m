From: =?ISO-8859-15?Q?Jo=E3o_Eduardo_Lu=EDs?= <jecluis@gmail.com>
Subject: Re: Strange write behavior on an osd
Date: Tue, 24 Apr 2012 17:31:42 +0100
Message-ID: <4F96D56E.1080205@gmail.com>
References: <4F96B971.5050806@tuxadero.com> <4F96C557.4090603@gmail.com> <4F96CF81.4030707@tuxadero.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig72FB958BBF89F5BC89E4E6A2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37971 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab2DXQbq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Apr 2012 12:31:46 -0400
Received: by bkuw12 with SMTP id w12so629872bku.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 Apr 2012 09:31:45 -0700 (PDT)
In-Reply-To: <4F96CF81.4030707@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig72FB958BBF89F5BC89E4E6A2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/24/2012 05:06 PM, Martin Mailand wrote:
> Hi,
>=20
> Am 24.04.2012 17:23, schrieb Jo=E3o Eduardo Lu=EDs:
>> Any chance you could run iotop during the busy periods and tell us whi=
ch
>> processes are issuing the io?
>=20
> sure,
> http://85.214.49.87/ceph/iotop.txt
>=20
> -martin
>=20

I don't want to rush into a definite answer, but it looks like the IO
bursts are caused by btrfs. The periods on which they happen are
consistent with btrfs' internal thread scheduling (which are fired every
30 seconds), and from iotop it would seem as if they're the ones
responsible for all the IO when it jumps from the "couple of MB/s" mark
to "several hundreds of MB/s".

I've seen it happen before, although on synthetic and very specific
workloads. Not sure on what may be the cause in your case though.

What kernel and btrfs versions are you using?

--=20
Jo=E3o Eduardo Lu=EDs
gpg key: 477C26E5 from pool.keyserver.eu


--------------enig72FB958BBF89F5BC89E4E6A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPltVuAAoJEJ9vvxhHfCblWoIH+wcWGgRm9vleyxWPibGG1SKt
cU16p+CYAypVafzMiIQAlvgv2tuxpxb4Y2unfyvTySZbhBzcdkLjwq1s5axWP/TP
wHQfeYy2LiFMXwlBHexxYZ7fD+j/RSvkiUTO+zTlO2gKX5ukhMuM2535+kxHNxLC
L4OziAMbwhkbVIiudx4axFCh/AxF8Pf6Ra7y9fAP6YIfLuzhaLhJC2w70Gml6tza
Iccii8LZEOfvrC2iQE1wJ16qtz3KqUjziuPbSHNu2o4C/sEQVspQ+PO8NCCNVKeW
1BXCX49piDn0Pv6W5kJqLzG8GlbBPKJkRE8oDNcCyUoZwsmp5RvmTSaYJysP8lM=
=5loe
-----END PGP SIGNATURE-----

--------------enig72FB958BBF89F5BC89E4E6A2--
