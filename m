From: Loic Dachary <loic@dachary.org>
Subject: overriding the chef task
Date: Sat, 04 Jul 2015 13:37:30 +0200
Message-ID: <5597C57A.7040809@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kTD13ETf9Hg8oASlKMuvUxKPktxBOvjff"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44943 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751839AbbGEInj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Jul 2015 04:43:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack.cerza@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kTD13ETf9Hg8oASlKMuvUxKPktxBOvjff
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zack,

I tried to override the chef task which is added by teuthology/teuthology=
/suite.py with a chef.yaml file

tasks:
- chef:
   script_url: https://raw.githubusercontent.com/dachary/ceph-qa-chef/wip=
-6502-openstack/solo/solo-from-scratch
   chef_repo: https://github.com/dachary/ceph-qa-chef.git
   chef_branch: wip-6502-openstack

which translates into (according the teuthology-suite)

=2E..
  roles:
  - - mon.a
    - osd.0
  sha1: 02b75beaee03f26b73afdc100b5243a966f59d94
  stop_worker: true
  suite: noop
  suite_branch: master
  suite_path: /home/ubuntu/src/ceph-qa-suite_master
  tasks:
  - chef: null
  - clock.check: null
  - chef:
      branch: wip-6502-openstack
      repo: https://github.com/dachary/ceph-qa-chef.git
      script_url: https://raw.githubusercontent.com/dachary/ceph-qa-chef/=
wip-6502-openstack/solo/solo-from-scratch
  - exec:
      mon.a:
      - echo "Well done !"
  teuthology_branch: master

=2E..

and the first one, with chef: null seems to win the competition because I=
 get=20

2015-07-04 10:49:20,620.620 INFO:teuthology.orchestra.run.entercloudsuite=
000075:Running: "wget -O- 'http://git.ceph.com/?p=3Dceph-qa-chef.git;a=3D=
blob_plain;f=3Dsolo/solo-from-scratch;hb=3DHEAD' | CHEF_REPO=3D CHEF_BRAN=
CH\
=3D sh -x"

I don't see a generic task override mechanism nor do I see the chef.py ta=
sk handling overrides. What am I missing ?

Cheers

P.S. I keep in mind the ansible task is coming but I've seen a pull reque=
st fixing things in this area yesterday, which is why I try to stick to c=
hef which is known to work. I have enough things to figure out and I'm a =
little conservative right now ;-)

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--kTD13ETf9Hg8oASlKMuvUxKPktxBOvjff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWXxXoACgkQ8dLMyEl6F22N8gCfafiUf6hMBRPIDmOSJb61t6aK
WM0AoK53pltQUh56d+IyJ09TWxmJ2xcl
=xAwH
-----END PGP SIGNATURE-----

--kTD13ETf9Hg8oASlKMuvUxKPktxBOvjff--
