From: Loic Dachary <loic@dachary.org>
Subject: misc: ignore some unusable block devices
Date: Mon, 14 Dec 2015 16:12:16 +0100
Message-ID: <566EDC50.3010901@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IxkGH1k9Uw76As15E1879XsssK7Kj2Ex2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49878 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751700AbbLNPMa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Dec 2015 10:12:30 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IxkGH1k9Uw76As15E1879XsssK7Kj2Ex2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Robin,

I removed misc: ignore some unusable block devices 9c5eaeccb807d103884f46=
d174798dd982092696 from the openstack branch because it fails on CentOS 7=
 with
the following. Could you please make a new pull request with it so we can=
 keep testing it there ?

Thanks !

2015-12-14T14:37:36.305 INFO:teuthology.orchestra.run.target167114236178:=
Running: 'sudo blkid -o export -p /dev/vdc'
2015-12-14T14:37:36.731 ERROR:teuthology.contextutil:Saw exception from n=
ested tasks
Traceback (most recent call last):
  File "/home/ubuntu/teuthology/teuthology/contextutil.py", line 28, in n=
ested
    vars.append(enter())
  File "/usr/lib/python2.7/contextlib.py", line 17, in __enter__
    return self.gen.next()
  File "/home/ubuntu/src/ceph-qa-suite_master/tasks/ceph.py", line 357, i=
n cluster
    devs =3D teuthology.get_scratch_devices(remote)
  File "/home/ubuntu/teuthology/teuthology/misc.py", line 860, in get_scr=
atch_devices
    stderr=3DStringIO(),
  File "/home/ubuntu/teuthology/teuthology/orchestra/remote.py", line 156=
, in run
    r =3D self._runner(client=3Dself.ssh, name=3Dself.shortname, **kwargs=
)
  File "/home/ubuntu/teuthology/teuthology/orchestra/run.py", line 378, i=
n run
    r.wait()
  File "/home/ubuntu/teuthology/teuthology/orchestra/run.py", line 114, i=
n wait
    label=3Dself.label)
CommandFailedError: Command failed on target167114236178 with status 2: '=
sudo blkid -o export -p /dev/vdc'

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--IxkGH1k9Uw76As15E1879XsssK7Kj2Ex2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZu3FAACgkQ8dLMyEl6F20XIwCeN0Iq39fGHdEOTvJPViX4NPjg
GoYAoIYURtCHrRoX3Xiem84++G1pDHDg
=WqpM
-----END PGP SIGNATURE-----

--IxkGH1k9Uw76As15E1879XsssK7Kj2Ex2--
