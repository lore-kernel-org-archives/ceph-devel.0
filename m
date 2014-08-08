From: Loic Dachary <loic@dachary.org>
Subject: Resolving the ruleno / ruleset confusion
Date: Fri, 08 Aug 2014 15:38:13 +0200
Message-ID: <53E4D2C5.8050600@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XchJ5Th2CrEFxaBC0W36Up9jBiuV9QgAc"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:56151 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752115AbaHHNiP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Aug 2014 09:38:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ma Jianpeng <majianpeng@gmail.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XchJ5Th2CrEFxaBC0W36Up9jBiuV9QgAc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

As you noticed, there are places where ruleset and ruleno / ruleid are us=
ed interchangeably although they are not. This is a source of subtle bugs=
 that can be hard to trace. By default ruleid and ruleset are the same, b=
ut dumping a crush map including

rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take default
        step chooseleaf firstn 0 type host
        step emit
}
rule metadata {
        ruleset 1
        type replicated
        min_size 1
        max_size 10
        step take default
        step chooseleaf firstn 0 type host
        step emit
}

and swapping the rules as follows

rule metadata {
        ruleset 1
        type replicated
        min_size 1
        max_size 10
        step take default
        step chooseleaf firstn 0 type host
        step emit
}

rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take default
        step chooseleaf firstn 0 type host
        step emit
}

will have ruleset 1 with rule id 0 and ruleset 0 with rule id 1

Since the ruleset is the only reliable number, from the user point of vie=
w, we could simply change CrushWrapper.h to never return the rule id and =
assume only ruleset are given in argument, even where it currently claims=
 to be a rule id.

The downside is that looking up the ruleset implies iterating over all th=
e rules, but that's probably not an issue.

What do you think ?

Cheers
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--XchJ5Th2CrEFxaBC0W36Up9jBiuV9QgAc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPk0sUACgkQ8dLMyEl6F21ChgCeMjqnf1AP2N2nQGWIXeUH8fuC
b3IAoK9A8OB50JfF5gIoVZJa0/qMmMmo
=B1WH
-----END PGP SIGNATURE-----

--XchJ5Th2CrEFxaBC0W36Up9jBiuV9QgAc--
