From: Loic Dachary <loic@dachary.org>
Subject: Re: Giant backport tasks
Date: Sat, 28 Mar 2015 11:46:40 +0100
Message-ID: <55168690.2060603@dachary.org>
References: <87zj6x3c49.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xvMiUpSI84iAFpTkPUIbnum62PwdA9Cnk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38113 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752054AbbC1Kqy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Mar 2015 06:46:54 -0400
In-Reply-To: <87zj6x3c49.fsf@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xvMiUpSI84iAFpTkPUIbnum62PwdA9Cnk
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

[cc'ing ceph-devel for archive]

On 28/03/2015 06:49, Abhishek L wrote:
> Hi Loic,
>=20
> I've started looking into the pending runs for giant. The rados suites
> came out green,=20

\o/

> rgw seems to have hit a bug, updated this in the
> tracker,=20

Reading http://tracker.ceph.com/issues/11153#rgw I suggest you use the me=
thod described at http://tracker.ceph.com/projects/ceph-releases/wiki/HOW=
TO_describe_a_test_result

$ python ../fail.py loic-2015-03-27_08:40:06-rgw-giant---basic-multi
** *'mkdir -p -- /home/ubuntu/cephtest/mnt.0/client.0/tmp && cd -- /home/=
ubuntu/cephtest/mnt.0/client.0/tmp && CEPH_CLI_TEST_DUP_COMMAND=3D1 CEPH_=
REF=3D90b37d9bdcc044e26f978632cd68f19ece82d19a TESTDIR=3D"/home/ubuntu/ce=
phtest" CEPH_ID=3D"0" PATH=3D$PATH:/usr/sbin adjust-ulimits ceph-coverage=
 /home/ubuntu/cephtest/archive/coverage timeout 3h /home/ubuntu/cephtest/=
workunit.client.0/rgw/s3_bucket_quota.pl'*
*** "rgw/multifs/{clusters/fixed-2.yaml frontend/civetweb.yaml fs/xfs.yam=
l rgw_pool_type/replicated.yaml tasks/rgw_bucket_quota.yaml}":http://pulp=
ito.ceph.com/loic-2015-03-27_08:40:06-rgw-giant---basic-multi/824286

When you have a single bug it's marginally useful but it helps a lot when=
 you have more than a dozen.


> some time on why the radosgw hit a bug a little more
> so that I can get to the cause of this.=20

Great, looking forward to read about it at http://tracker.ceph.com/issues=
/11259 ;-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--xvMiUpSI84iAFpTkPUIbnum62PwdA9Cnk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUWhpAACgkQ8dLMyEl6F210XACeJZdYFw4Li1N0PgscGBra0jym
kMcAniyCGUPtzSrLEa3PlKaLcixhluKE
=L4Om
-----END PGP SIGNATURE-----

--xvMiUpSI84iAFpTkPUIbnum62PwdA9Cnk--
