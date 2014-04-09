From: Dmitry Smirnov <onlyjob@debian.org>
Subject: Re: problem with /lib/lsb/init-functions
Date: Wed, 09 Apr 2014 10:08:29 +1000
Message-ID: <2117804.rLAcrddlMO@debstor>
References: <alpine.DEB.2.00.1404080936130.28550@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2945774.TKu6H2j32X"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:38973 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232AbaDIAIi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 20:08:38 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so1719788pbc.23
        for <ceph-devel@vger.kernel.org>; Tue, 08 Apr 2014 17:08:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1404080936130.28550@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: alfredo.deza@inktank.com, ceph-devel@vger.kernel.org


--nextPart2945774.TKu6H2j32X
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Sage,

On Tue, 8 Apr 2014 09:38:06 Sage Weil wrote:
> In commit 012bb5fb5bbc76e5a2c5037dc0c6558f0b1b0a45 we added a depende=
ncy
> on /lib/lsb/init-functions which is not present on rpm-based machines=
.
> This thread
>=20
> =09http://www.redhat.com/archives/rhl-devel-list/2007-August/msg01920=
.html
>=20
> proposes a workaround but there is also some concern about this being=

> slow.  Do you know what the best practice is here?  I'm not familiar =
with
> this area.

I can't tell what is the best practice on Red Hat.
On Debian such include is a standard practice.


> =09http://tracker.ceph.com/issues/8028

I just updated the above ticket with the following:

    This is because of missing depends on "lsb-base". I reckon it (or s=
imilar
    package) should be available on RHEL/CentOS. Besides my commit is n=
ot a
    problem as other init scripts already had similar include.
    So to me it looks like RPM packaging issue...

I hope this helps...

=2D-=20
Cheers,
 Dmitry Smirnov.

=2D--

Reality is that which, when you stop believing in it, doesn't go away.
        -- Philip K. Dick

--nextPart2945774.TKu6H2j32X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAABCAAGBQJTRI+AAAoJEFK2u9lTlo0bmJoP/2879X9ik+AWD7hi0aoFhA9c
My7Q5D8VKFLPyP+Rd/3IEcnUfc6nooOVjNRs0QEtx8MiXTMKq9JqAw6GyIrffeB7
bXzaG41e3gWd33Y6HAPw5cA3uDyTr1ZYf0u0Rg0LNbIe6176xFGoCKA59eCPpXJH
3sUm3XJjZV6gMJ/T4NuSWsGXFpNbK6uDvpri879V5q/spMOV51EEt+dL9aZe2O8I
E+5VcAq8i+TzysVpD7RBlTU7jhpPSn0S6WbjOB4n4cFaoetpAPXXBOuynhnlFSAn
iH0WH9P+bc41hWvI6iC2aNQ3TNytZRh8/5b8q1FgVkm1Jrs5lpc4uSnDRkgjFTmD
s5191STXP+VKWSZ4Mj8jCOjepwZOXmRXXML8FOMNsdvl/G0+HDX846aMYOKgW5+r
so2Iprg1D6AhFmNW2JA9UTXwlL534zNuX5bAbaIFK0yJIAmMSkEDJP/SlireRvyL
C6O6d3HyMI5jPSmamckxwLTmvx8vosJaIhfVczCCgWN/P/iR3//9RO/OW1XsLlh3
tFVzt7J9SJi2nY6NEFXWynIufsqYQZ718NtysfG8dn/ZzO8+ajNC0/21I+HEVod4
OkxNQ/6tqOBB71FIe1c9MmoL8PYIVi+8GcJt+0+1touNdRz2n4v1JwUC+UEzFABB
1nGnCE6StxmIleVLa5OX
=8Nmf
-----END PGP SIGNATURE-----

--nextPart2945774.TKu6H2j32X--

