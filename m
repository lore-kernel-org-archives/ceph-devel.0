From: Loic Dachary <loic@dachary.org>
Subject: setup teuthology
Date: Fri, 14 Aug 2015 15:11:14 +0200
Message-ID: <55CDE8F2.70203@dachary.org>
References: <CAHRQ3VUJH7FfUes7f7u9PyyMwx7zmwPY8xm0pM9v78+k3iGJ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3TxkltP33cnHVFDIUXLiRo83jqdmW7vms"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38153 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752753AbbHNNLR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Aug 2015 09:11:17 -0400
In-Reply-To: <CAHRQ3VUJH7FfUes7f7u9PyyMwx7zmwPY8xm0pM9v78+k3iGJ3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Songbo Wang <songbo1227@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3TxkltP33cnHVFDIUXLiRo83jqdmW7vms
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Forwarding to ceph-devel where it has a better chance to be answered.

On 13/08/2015 13:50, Songbo Wang wrote:
> Hi,=20
>    =20
> When setting up teuthology in my own enviroment ,  I found a problem as=
 follows:
> In the file "teuthology/__init__.py",  when importing class "gevent.mon=
key", It will conflict  with "paramiko".  and if  "create_nodes.py" is us=
ed to connect to "paddles/pulpito" node, I will be hanged.
>=20
>          root@ubunut4:~/src/teuthology_master# git diff teuthology/__in=
it__.py
>          diff --git a/teuthology/__init__.py b/teuthology/__init__.py
>          index d0bcfc0..b34cf4e 100644
>          --- a/teuthology/__init__.py
>          +++ b/teuthology/__init__.py
>          @@ -1,5 +1,5 @@
>          -from gevent import monkey
>          -monkey.patch_all(dns=3DFalse)
>          +#from gevent import monkey
>          +#monkey.patch_all(dns=3DFalse)
>          from .orchestra import monkey
>          monkey.patch_all()
> =20
> Afer modification, anything will be ok. I am wandering Is this a bug ? =
=20
> Any reply will be highly appreciated.
>=20
>=20
>=20
> _______________________________________________
> Ceph-qa mailing list
> Ceph-qa@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-qa-ceph.com
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--3TxkltP33cnHVFDIUXLiRo83jqdmW7vms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXN6PIACgkQ8dLMyEl6F20+OgCfSVGvn7ia8IyLWAlHk1j2bN7Q
LCUAoMJgcjaHgjMrDrmCrF3y39GV0XoI
=ACCM
-----END PGP SIGNATURE-----

--3TxkltP33cnHVFDIUXLiRo83jqdmW7vms--
