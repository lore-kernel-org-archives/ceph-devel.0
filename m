From: Loic Dachary <loic@dachary.org>
Subject: Issues wrongfully marked resolved
Date: Tue, 24 Feb 2015 16:47:59 +0100
Message-ID: <54EC9D2F.9070205@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="txngtK8IRffmWetqdv3OhBJ8s3Mnw8fMN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48205 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752630AbbBXPsB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 10:48:01 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id BB6BE4210B
	for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2015 16:47:59 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--txngtK8IRffmWetqdv3OhBJ8s3Mnw8fMN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

On february 10th I wrongfully marked some issues as "resolved" in the Cep=
h issue tracker. Two of them were discovered later and people lost precio=
us time before finding out they were incorrectly marked as resolved. Toda=
y I went over all the issues and found one more:

    http://tracker.ceph.com/issues/8797 "ceph status" do not exit with py=
thon_2.7.8

which is yet to be backported to Firefly and I re-opened it. You can take=
 a quick look at the issues marked resolved that day [1] and if you find =
one that looks suspicious please let me know and I'll investigate.

Cheers

[1] issues marked resolved february 10th http://tracker.ceph.com/projects=
/ceph/issues?utf8=3D%E2%9C%93&set_filter=3D1&f%5B%5D=3Dstatus_id&op%5Bsta=
tus_id%5D=3D%3D&v%5Bstatus_id%5D%5B%5D=3D3&f%5B%5D=3Dupdated_on&op%5Bupda=
ted_on%5D=3D%3D&v%5Bupdated_on%5D%5B%5D=3D2015-02-10&f%5B%5D=3D&c%5B%5D=3D=
project&c%5B%5D=3Dtracker&c%5B%5D=3Dstatus&c%5B%5D=3Dpriority&c%5B%5D=3Ds=
ubject&c%5B%5D=3Dassigned_to&c%5B%5D=3Dupdated_on&c%5B%5D=3Dcategory&c%5B=
%5D=3Dfixed_version&c%5B%5D=3Dstory_points&c%5B%5D=3Dcf_3&c%5B%5D=3Dcf_4&=
group_by=3D

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--txngtK8IRffmWetqdv3OhBJ8s3Mnw8fMN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTsnS8ACgkQ8dLMyEl6F23EaQCdFq+hQGM6u4ymAcXp+ySXF24q
LE8AoITyDrddpvD8xuEONqP0b2efyIs6
=E6uO
-----END PGP SIGNATURE-----

--txngtK8IRffmWetqdv3OhBJ8s3Mnw8fMN--
