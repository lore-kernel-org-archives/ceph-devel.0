From: Mario van der Linde <linde@b1-systems.de>
Subject: rbd - input/output error
Date: Sun, 13 Nov 2011 11:15:17 +0100
Message-ID: <4EBF98B5.7040706@b1-systems.de>
Reply-To: linde@b1-systems.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8EC67E0344BE091E0BF4E2AE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from schattenjagd.systems.b1-systems.de ([217.11.58.34]:60565 "EHLO
	mx1.b1-systems.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752765Ab1KMKXk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Nov 2011 05:23:40 -0500
Received: from chewbakkat4003.office.b1-systems.de (f051066117.adsl.alicedsl.de [78.51.66.117])
	by mx1.b1-systems.de (Postfix) with ESMTPSA id C83364075
	for <ceph-devel@vger.kernel.org>; Sun, 13 Nov 2011 11:15:18 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8EC67E0344BE091E0BF4E2AE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

i'm playing around with ceph and set up a cluster with 5 nodes. cephfs
is working fine, but if i try to use rbd i get the following error:

> ceph1:~ # modprobe rbd
> ceph1:~ # rbd create testimg --size 10240
> create error: error 5: Input/output error
> ceph1:~ # ceph --version
> ceph version 0.37 (commit:a6f3bbb744a6faea95ae48317f0b838edb16a896)

There are no log messages that give me a hint whats going wrong.

Does anybody know what the cause of this error is?

Here is the ceph.conf used for this cluster:
> [global]
>         log dir =3D /srv/ceph/out
>         logger dir =3D /srv/ceph/log
>        ; chdir =3D ""
>         pid file =3D /srv/ceph/out/$type$id.pid
> [mds]
>         pid file =3D /srv/ceph/out/$name.pid
>        ; lockdep =3D 1
>        ; debug ms =3D 1
>        ; debug mds =3D 20
>        ; mds log max segments =3D 2
>        max mds =3D 3
> [osd]
>        ; lockdep =3D 1
>        ; debug ms =3D 1
>        ; debug osd =3D 25
>        ; debug journal =3D 20
>        ; debug filestore =3D 10
>         osd data =3D /srv/ceph/dev/osd$id
>         osd journal =3D /srv/ceph/dev/osd$id/journal
>         osd journal size =3D 512
> [mon]
>        lockdep =3D 1
>        debug mon =3D 20
>        debug paxos =3D 20
>        debug ms =3D 1
>        mon data =3D "/srv/ceph/dev/mon$id"
> [mon.1]
>        host =3D ceph1
>        mon addr =3D 192.168.1.221:6789
> [mon.2]
>        host =3D ceph2
>        mon addr =3D 192.168.1.222:6789
> [mon.3]
>        host =3D ceph3
>        mon addr =3D 192.168.1.223:6789
> ;[mon.4]
> ;       host =3D ceph4
> ;       mon addr =3D 192.168.1.224:6789
> ;[mon.5]
> ;       host =3D ceph5
> ;       mon addr =3D 192.168.1.225:6789
> [osd.1]
>        host =3D ceph1
>        btrfs devs =3D /dev/sda6
> [osd.2]
>        host =3D ceph2
>        btrfs devs =3D /dev/sda6
> [osd.3]
>        host =3D ceph3
>        btrfs devs =3D /dev/sda6
> [osd.4]
>        host =3D ceph4
>        btrfs devs =3D /dev/sda6
> [osd.5]
>        host =3D ceph5
>        btrfs devs =3D /dev/sda6
> [mds.0]
>        host =3D ceph1
> [mds.1]
>        host =3D ceph2
> [mds.2]
>        host =3D ceph3


Greetings
Mario

--=20

Mario van der Linde                  Geschaeftsfuehrer: Ralph Dehner
Linux Consultant & Trainer           Unternehmenssitz:  Vohburg
B1 Systems GmbH                      Amtsgericht:       Ingolstadt
Osterfeldstra=DFe 7                    Handelsregister:   HRB 3537
85088 Vohburg                        http://www.b1-systems.de
Mobil: +49 151 168 794 85
EMail: linde@b1-systems.de

http://pgpkeys.pca.dfn.de/pks/lookup?op=3Dget&search=3D0xD31B76884480BB04=



--------------enig8EC67E0344BE091E0BF4E2AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6/mLgACgkQ0xt2iESAuwSwOQCeNYQwrbsK/LSoDG3t3XYBkz7K
iFAAoKD/ppn+DB5l9UD17SwOMh/IVUkG
=cuP7
-----END PGP SIGNATURE-----

--------------enig8EC67E0344BE091E0BF4E2AE--
