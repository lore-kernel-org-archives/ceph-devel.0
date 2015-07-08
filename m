From: Loic Dachary <loic@dachary.org>
Subject: ansible task progress
Date: Wed, 08 Jul 2015 02:41:00 +0200
Message-ID: <559C719C.8010707@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="n0c4tloFUDB4n7V7MUlqQM240l8532bsr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46351 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753684AbbGHAlD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jul 2015 20:41:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>, Andrew Schoen <aschoen@redhat.com>
Cc: Dan Mick <dmick@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n0c4tloFUDB4n7V7MUlqQM240l8532bsr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zack & Andrew,

With Dan's help we hacked passed the sudo problem with:

cat > /tmp/ansible.yaml <<EOF
overrides:
  ansible.cephlab:
    branch: wip-fix-defaults
    vars:
      ansible_sudo: true
interactive-on-error: true
EOF

teuthology-suite --machine-type openstack  --suite-dir $(pwd)/teuthology/=
test/integration --suite noop /tmp/ansible.yaml

with full logs at

http://integration.ceph.dachary.org:8081/ubuntu-2015-07-08_00:31:07-noop-=
master---basic-openstack/3/

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--n0c4tloFUDB4n7V7MUlqQM240l8532bsr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWccZwACgkQ8dLMyEl6F212awCgni33U9gaPY6lk8lqKS7mOqi8
tmwAoKRo+wLkCFSKPv2rKnicjJAnSiBo
=WZ2N
-----END PGP SIGNATURE-----

--n0c4tloFUDB4n7V7MUlqQM240l8532bsr--
