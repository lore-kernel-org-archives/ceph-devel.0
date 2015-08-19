From: Loic Dachary <loic@dachary.org>
Subject: Re: [Cbt] Ceph Community Lab: Understanding where the QA suites spend
 time
Date: Thu, 20 Aug 2015 00:05:13 +0200
Message-ID: <55D4FD99.6000508@dachary.org>
References: <55D4DD24.9010100@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="MN8o3rO8uLOQUjAaaK3p430ibHxClpFXN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40793 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751958AbbHSWFU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 18:05:20 -0400
In-Reply-To: <55D4DD24.9010100@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, cbt@lists.ceph.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MN8o3rO8uLOQUjAaaK3p430ibHxClpFXN
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

To help put things in perspective (please forgive me if it's a fact alrea=
dy known to everyone), > 95% of the teuthology jobs can run on virtual ma=
chines with 8GB RAM, 40GB disk, 2 processors and no attached disks. The c=
ost of running such virtual machines in the cloud currently is 0.033 euro=
s per hour. Running 40 teuthology jobs at all times would require an aver=
age of 80 such virtual machines (most jobs use 2 machines, some 1 or 3), =
that is 0.033 * 80 vms * 24 hours * 31 days =3D=3D ~2000 euros per month =
(also note that at least one cloud provider offers 50% discount if such v=
irtual machines are reserved full time). That's 3 to 6 times cheaper than=
 AWS.=20

I'm not sure how much it costs to run these 40 teuthology jobs on a hand =
made lab but I'd be surprised if it was cheaper, all included. Whatever h=
ardware already exists in the sepia lab can easily handle the remaining 5=
% of jobs that require actual hardware for one reason or the other.

My 3.3cts ;-)

On 19/08/2015 21:46, Mark Nelson wrote:
> Hi Guys,
>=20
> About a month ago we were going through the process of trying to figure=
 out how to replace some of the hardware in the community laboratory that=
 runs all of the nightly Teuthology tests.  Given a limited budget to rep=
lace the existing nodes, we wanted to understand how the current QA suite=
s actually spend time on the hardware.  To do this, we investigated the c=
omposition of suites, the amount of time that is spent in each suite, and=
 then a deeper dive into how the most resource intensive jobs spend their=
 time.  We then wrote a new benchmark for CBT to run ceph-test-rados in a=
 rather naive reproduction of what the ceph task in teuthology does and t=
ested it against several different storage device configurations to see h=
ow much benefit SSDs in the nodes may provide.
>=20
> A couple of folks at the Hackathon were interested in the paper we wrot=
e.  I thought I would share it with the community as well in case any fol=
ks ever wondered what Teuthology actually spends it's time doing.
>=20
> http://nhm.ceph.com/community/Ceph_Community_Lab_Performance_Investigat=
ion.pdf
>=20
> Thanks,
> Mark
> _______________________________________________
> Cbt mailing list
> Cbt@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/cbt-ceph.com

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--MN8o3rO8uLOQUjAaaK3p430ibHxClpFXN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXU/ZkACgkQ8dLMyEl6F21s0wCfW885QLVdyoo1mRsk1CscACBK
yjQAoKc/uH8zp2N8sUbyY4chuG+9/XSF
=HEtM
-----END PGP SIGNATURE-----

--MN8o3rO8uLOQUjAaaK3p430ibHxClpFXN--
