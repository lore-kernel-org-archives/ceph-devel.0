From: Loic Dachary <loic@dachary.org>
Subject: Affected Versions: and ceph-qa-suite: use case
Date: Fri, 27 Mar 2015 13:19:14 +0100
Message-ID: <55154AC2.10409@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="f64BDBsmaVTmfGkkDBHrr549TX1AlGwR6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37749 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752408AbbC0MTS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 08:19:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f64BDBsmaVTmfGkkDBHrr549TX1AlGwR6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

Here is how I understand the proposed use case for the Affected Versions:=
 and ceph-qa-suite: fields in http://tracker.ceph.com/

When the issue is created:

* Select Affected Versions: to match the Ceph version of the bug report
* Select the ceph-qa-suite where the bug can be reproduced or where the f=
eature will be tested

When a job from a suite S fails

* If the analysis of the job failure points to an existing issue
* If closed, the issue is re-opened
* The Affected Versions: is modified to include the Ceph version from the=
 job failure
* The ceph-qa-suite is modified to include the suite the job belongs to

When preparing a release for Ceph version V

* To check if the rados suite has no pending bug, query the issues that a=
re open and Affected Versions: matches V and ceph-qa-suite matches rados
* To check if there are no pending bug, query the issues that are open an=
d Affected Versions: matches V

Am I missing something ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre



--f64BDBsmaVTmfGkkDBHrr549TX1AlGwR6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUVSsIACgkQ8dLMyEl6F22mYwCfSBGU0U1LfDjNl2OxvtKdc+mc
yxgAn3hTP5i15YpGuSiyhlyzvL0Clp9K
=ighL
-----END PGP SIGNATURE-----

--f64BDBsmaVTmfGkkDBHrr549TX1AlGwR6--
