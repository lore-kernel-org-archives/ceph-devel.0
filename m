From: Loic Dachary <loic@dachary.org>
Subject: Archival of teuthology runs
Date: Sat, 29 Aug 2015 10:41:52 +0200
Message-ID: <55E17050.3000006@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SChcGonpdwkiCrJ7EioxCEI850NIIXr6p"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45758 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751568AbbH2Il6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Aug 2015 04:41:58 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 9B3E942B44
	for <ceph-devel@vger.kernel.org>; Sat, 29 Aug 2015 10:41:52 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SChcGonpdwkiCrJ7EioxCEI850NIIXr6p
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

The publicly writable repository at http://integration.ceph.dachary.org/ =
can be used to publish teuthology job results. This is convenient for peo=
ple running short lived clusters (via the OpenStack backend for instance)=
 or when tests run behind a firewall need to be shared to show that they =
pass. For instance, multipath support in ceph-disk [1] passed the new cep=
h-disk suite [2] and the test logs are linked from the tracker [3] so the=
 reviewer can conveniently repeat and compare them if needs be.

The most convenient way to use this repository is via the --upload flag o=
f teuthology-openstack [4] like so:

   teuthology-openstack --key-filename myself.pem --key-name myself --sui=
te dummy --upload

It can also be done manually: it's less convenient but I'd be happy to ex=
plain if someone is interested.

Cheers

[1] multipath combined pull requests http://tracker.ceph.com/issues/11881=
#Need-review
[2] test results http://integration.ceph.dachary.org/ubuntu-2015-08-28_22=
%3a07%3a52-ceph-disk-wip-11881-multipath---basic-openstack/1/
[3] multipath implementation http://tracker.ceph.com/issues/11881#note-28=

[4] teuthology for OpenStack https://github.com/dachary/teuthology/tree/o=
penstack#openstack-backend
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--SChcGonpdwkiCrJ7EioxCEI850NIIXr6p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXhcFAACgkQ8dLMyEl6F23QqwCeNDBzSb2UcyrLBJb2gZbCSaDz
Xy4AoKEJIH7G/n4ONf4VBz8t8SnL8pCc
=Q1Bt
-----END PGP SIGNATURE-----

--SChcGonpdwkiCrJ7EioxCEI850NIIXr6p--
