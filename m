From: Loic Dachary <loic@dachary.org>
Subject: teuthology integration tests on OpenStack
Date: Mon, 13 Jul 2015 01:59:45 +0200
Message-ID: <55A2FF71.7080408@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="031fOuVIvVk6hfu7dHf4m1JwUjq25MSII"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48883 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751216AbbGLX75 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Jul 2015 19:59:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>, Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--031fOuVIvVk6hfu7dHf4m1JwUjq25MSII
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zack & Andrew,

It turns out the simplest way to install teuthology on OpenStack (the one=
liner described at http://dachary.org/?p=3D3790) is also the simplest way=
 to run integration tests. Last Friday we discussed the fact that the teu=
thology installation is intrusive: it modifies system files, runs a web s=
ervice, reset ~/.teuthology.yaml etc. But it can conveniently be containe=
d in a dedicated, all in one (paddles, pulpito, workers, client) virtual =
machine.

Assuming a jenkins slave has access to an OpenStack tenant, it could be s=
omething like:

    . openrc.sh
    teuthology/openstack-bootstrap.sh ovh
    ssh -i $HOME/teuthology-admin teuthology grep -qq 'openstack-integrat=
ion: commands succeeded' /var/log/cloud-init.log
    nova delete teuthology

The http://tracker.ceph.com/issues/12295 feature request was created for =
that purpose. At this point it is primarily about creating the jenkins sl=
ave and since I know nothing about that (rather I forgot the little I lea=
rnt a few month ago ;-), I'm hoping someone will take care of it.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--031fOuVIvVk6hfu7dHf4m1JwUjq25MSII
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWi/3EACgkQ8dLMyEl6F22xXACbBxoa9FeGRSoiAvty2gi30Ctd
Y2sAn3l/nv4k0X2XtzIsSJTah/cV4uz7
=+nxa
-----END PGP SIGNATURE-----

--031fOuVIvVk6hfu7dHf4m1JwUjq25MSII--
