From: Tomasz Kuzemko <tomasz.kuzemko@corp.ovh.com>
Subject: New Jewel cluster has firefly tunables by default
Date: Tue, 8 Nov 2016 15:00:21 +0100
Message-ID: <56283c4e-47f3-2fe8-5f14-d8b363e91426@corp.ovh.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="WfSt0okPhuIdBmrk0UfKR6qu04C9CIfcu"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 6.mo302.mail-out.ovh.net ([137.74.110.79]:51341 "EHLO
        6.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752859AbcKHOAf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 09:00:35 -0500
Received: from EX4.OVH.local (gw1.corp.ovh.com [51.255.55.226])
        by mo302.mail-out.ovh.net (Postfix) with ESMTPS id 6C58E1E73
        for <ceph-devel@vger.kernel.org>; Tue,  8 Nov 2016 15:00:33 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--WfSt0okPhuIdBmrk0UfKR6qu04C9CIfcu
Content-Type: multipart/mixed; boundary="ChCGJFjXjXKxusx3jo6uRmj2q3bobuuVT";
 protected-headers="v1"
From: Tomasz Kuzemko <tomasz.kuzemko@corp.ovh.com>
To: ceph-devel@vger.kernel.org
Message-ID: <56283c4e-47f3-2fe8-5f14-d8b363e91426@corp.ovh.com>
Subject: New Jewel cluster has firefly tunables by default

--ChCGJFjXjXKxusx3jo6uRmj2q3bobuuVT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
I noticed that when a fresh Jewel cluster is deployed, by default it has
"firefly" tunables set. Is there some reason not to set "optimal" by
default or is this a bug?


 root@caas-test01:~# ceph --version
 ceph version 10.2.3 (ecc23778eb545d8dd55e2e4735b53cc93f92e65b)
 root@caas-test01:~# ceph -s
     cluster 5c8b2c79-7a54-40ce-9203-4f4e4fad977d
      health HEALTH_ERR
             64 pgs are stuck inactive for more than 300 seconds
             64 pgs stuck inactive
             no osds
             mon.caas-test01 low disk space
      monmap e1: 1 mons at {caas-test01=3D167.114.246.213:6789/0}
             election epoch 3, quorum 0 caas-test01
      osdmap e1: 0 osds: 0 up, 0 in
             flags sortbitwise
       pgmap v2: 64 pgs, 1 pools, 0 bytes data, 0 objects
             0 kB used, 0 kB / 0 kB avail
                   64 creating
 root@caas-test01:~# ceph osd crush show-tunables
 {
     "choose_local_tries": 0,
     "choose_local_fallback_tries": 0,
     "choose_total_tries": 50,
     "chooseleaf_descend_once": 1,
     "chooseleaf_vary_r": 1,
     "chooseleaf_stable": 0,
     "straw_calc_version": 1,
     "allowed_bucket_algs": 22,
     "profile": "firefly",
     "optimal_tunables": 0,
     "legacy_tunables": 0,
     "minimum_required_version": "firefly",
     "require_feature_tunables": 1,
     "require_feature_tunables2": 1,
     "has_v2_rules": 0,
     "require_feature_tunables3": 1,
     "has_v3_rules": 0,
     "has_v4_buckets": 0,
     "require_feature_tunables5": 0,
     "has_v5_rules": 0
 }


--=20
Tomasz Kuzemko
tomasz.kuzemko@corp.ovh.com


--ChCGJFjXjXKxusx3jo6uRmj2q3bobuuVT--

--WfSt0okPhuIdBmrk0UfKR6qu04C9CIfcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJYIdp/AAoJEH0wj3uDfd0nHU0IAJvTMO2/S3nYXWjaO8BOO3mE
u1Z/BcgmCu+KZVBtZhxxtLPfOMLiHxtkBfixsnODmwMb7DHS8+aK0yvBBNhPmGJK
sFLNDiGeEwO6oVKBfKd0OzYTdLu79RKc7kpBSn4NiJpZ5qcdpE9ZerTUajcE2iQq
XXvoNlCxrapuijGyhW6asjBIDfSpRfoZ3H6XBLLHCQ6Sr75/usCHqtzcZ37tWrMB
rPGdtOkriL099Ez4Cr2OlKZF4614D/2ip2rIw4a+uJq+jcYvu459V2ZLySloq1ok
DmU0TWEkhjirddGmMX2ZPTNlQLM8a4puRgqSWTXcBVZnCYhweLN4vhIR2IT5Xdc=
=gRqM
-----END PGP SIGNATURE-----

--WfSt0okPhuIdBmrk0UfKR6qu04C9CIfcu--
