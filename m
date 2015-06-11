From: Loic Dachary <loic@dachary.org>
Subject: cloud-init resolv.conf updates
Date: Thu, 11 Jun 2015 23:37:39 +0200
Message-ID: <5579FFA3.2060903@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Cqjngc43prafteocJAkua7QXOl3Mur1NG"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60658 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750958AbbFKVhl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jun 2015 17:37:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mehdi Abaakouk <sileht@sileht.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cqjngc43prafteocJAkua7QXOl3Mur1NG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Mehdi,

I tried to=20

manage_resolv_conf: true

resolv_conf:
  nameservers: ['8.8.4.4', '8.8.8.8']

but did not get any result and according to /var/log/cloud-init.log it do=
es not seem to be taken into account.

It looks like this is still an open issue according to=20

https://answers.launchpad.net/ubuntu/+source/cloud-init/+question/234041 =

https://bugs.launchpad.net/cloud-init/+bug/1394061

even when you get past the misleading example that spells manage-resolv-c=
onf instead of manag_resolv_conf at

http://cloudinit.readthedocs.org/en/stable/topics/examples.html#configure=
-an-instances-resolv-conf

It looks like there would be a need to add

cloud_config_modules:
 - resolv_conf

according to http://bazaar.launchpad.net/~cloud-init-dev/cloud-init/trunk=
/view/head:/doc/examples/cloud-config.txt#L300 but I don't know which mod=
ules I need and which are optional and if the list is going to be merged =
with the default or override.

so I ended up doing:

#cloud-config
bootcmd:
 - echo "nameserver 10.0.3.31" | sudo tee -a /etc/resolvconf/resolv.conf.=
d/head
 - sudo resolvconf -u

Which works for Ubuntu 14.04 but isn't going to work for every operating =
system ;-)

I'm sure you faced something similar in the past and I'd very much apprec=
iate a pointer in the right direction.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Cqjngc43prafteocJAkua7QXOl3Mur1NG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlV5/6MACgkQ8dLMyEl6F20OvACguwXO16SUBtLLkqMSL/NzGqdO
vAoAoIMFcx2c7e3ZaY1B44mGzQnRc6r9
=bAwc
-----END PGP SIGNATURE-----

--Cqjngc43prafteocJAkua7QXOl3Mur1NG--
