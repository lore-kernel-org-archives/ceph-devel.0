From: Loic Dachary <loic@dachary.org>
Subject: rgw and the next giant release
Date: Tue, 10 Feb 2015 16:05:24 +0100
Message-ID: <54DA1E34.8050301@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xPhSrr0Ww7KWUwQIUXOlNsW31VQPuio5E"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41793 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750760AbbBJPFb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 10:05:31 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xPhSrr0Ww7KWUwQIUXOlNsW31VQPuio5E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

The rgw teuthology suite for the next giant release as found in https://g=
ithub.com/ceph/ceph/commits/giant-backports came back (see http://pulpito=
=2Eceph.com/loic-2015-02-02_23:56:11-rgw-giant-backports---basic-multi) w=
ith one environmental error http://tracker.ceph.com/issues/10501#teutholo=
gy-run-6b08a729540c61f3c8b15c5a3ce9382634bf800c-february-2015.=20

Do you think it is ready for QE to start their own round of testing ?

Note that the integration branch now contains all the rgw pull requests t=
argeting giant as listed here:

http://workbench.dachary.org/ceph/ceph-backports/wikis/giant#included-and=
-tested-in-integration-branch

Which includes cherry picks I did for the following as you suggested:

 - 9918  RGW-Swift: SubUser access permissions, does not seems to workmin=
or
 - 10103 swift tests failing
upgrade:dumpling-firefly-x:parallel-next-distro-basic-multi run
 - 10471 rgw: metadata sync doesn't create subusers correctly
 - 9254  rgw: civetweb requires explicit \r\n for http headers
 - 9478  Incorrect content type in response header
 - 9479  ETag is not included in the XML response to put object copy
operationminor
 - 9877  In some cases it's possible for rgw to segfault on http COPY
 - 5595  object has a Content-Type, but its content_type property is
not shown in Swift object enumeration
 - 9907  Normal    radosgw-admin: can't disable max_size quota
 - 9973  Validation of Swift DLO manifest object ETag doesn't match
OpenStack Swift behavior
 - 10307 rgw: setting bucket attributes (swift POST on bucket)
sometimes failminor
 - 9587  ceph-radosgw sysvinit script on EL6 cannot set ulimit

Your original list included three more:

 - 9878  rhel7 s3-tests fail due to missing reason
 - 10329 rgw: s3 need to return SignatureDoesNotMatch instead of AccessDe=
nied
 - 10334 rgw: s3 need to return InvalidAccessKeyId instead of AccessDenie=
d

but you wrote that 10329 and 10334 do not need backporting and 9878 was a=
lready backported.=20

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre




--xPhSrr0Ww7KWUwQIUXOlNsW31VQPuio5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTaHjQACgkQ8dLMyEl6F20VcwCdGlncNAsuG8vxvkoGBW+fpvsF
Y+EAoJBx6UqlUbP72txnFPmMhYPeF6ui
=nFFi
-----END PGP SIGNATURE-----

--xPhSrr0Ww7KWUwQIUXOlNsW31VQPuio5E--
