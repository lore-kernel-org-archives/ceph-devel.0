From: Loic Dachary <loic@dachary.org>
Subject: caching get_chunk_size()
Date: Sun, 02 Feb 2014 16:06:14 +0100
Message-ID: <52EE5EE6.7010904@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1nXJXkN7tfjkxVsTHSIeWMilnkCrUNba4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:59248 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbaBBPGW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Feb 2014 10:06:22 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1nXJXkN7tfjkxVsTHSIeWMilnkCrUNba4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[cc' ceph-devel]

Hi Sam,

Assuming https://github.com/ceph/ceph/pull/1144 gets merged, MONs can que=
ry the plugin for a given pool or crush ruleset conveniently:

https://github.com/dachary/ceph/blob/15c90fbf61445063967fc80ee1c916d70c59=
3a54/src/mon/OSDMonitor.cc#L2803

      ErasureCodeInterfaceRef erasure_code;
      err =3D get_erasure_code(properties, &erasure_code, ss);
      if (err =3D=3D 0)
         *size =3D erasure_code->get_chunk_count();

And OSDs can do something similar (and must whenever an erasure coded poo=
l is instantiated). If I understood correctly, you would like the result =
of erasure_code->get_chunk_size(some_osd_config_opt_value_defining_the_st=
ripe_size) to be set as a new value in pg_pool_t https://github.com/dacha=
ry/ceph/blob/15c90fbf61445063967fc80ee1c916d70c593a54/src/osd/osd_types.h=
#L700 when the pool is created.=20

The benefit of having pg_pool_t::chunk_size would be=20

a) the value is shared cluster wide and does not depend on the specific v=
ersion of the OSD/MON
b) if the value is needed frequently in a context where the plugin would =
have to be loaded, this will improve performances

However, whenever an OSD instantiates a PG that belongs to a pool, it mus=
t assert that the get_chunk_count() returned by the plugin matches the va=
lue stored in pg_pool_t::chunk_size otherwise it will encode inconsistent=
ly.=20

If my reasoning matches yours, I'll implement the change. Otherwise, plea=
se correct me :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--1nXJXkN7tfjkxVsTHSIeWMilnkCrUNba4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLuXuYACgkQ8dLMyEl6F23OswCfYW5jElbVfOPeH4bPTPUNC2Vk
vNcAoIA24CvE3Liq/lex3yEJ9KPn25/z
=/6Eg
-----END PGP SIGNATURE-----

--1nXJXkN7tfjkxVsTHSIeWMilnkCrUNba4--
