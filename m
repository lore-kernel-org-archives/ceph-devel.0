From: Matthew Richardson <m.richardson@ed.ac.uk>
Subject: Re: Slow request warnings on 0.48
Date: Thu, 19 Jul 2012 11:48:35 +0100
Message-ID: <5007E603.4030903@ed.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4BA3C458033BFE3E1AC7A7B8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from treacle.ucs.ed.ac.uk ([129.215.16.102]:52712 "EHLO
	treacle.ucs.ed.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab2GSLd0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 07:33:26 -0400
Received: from lmtp1.ucs.ed.ac.uk (lmtp1.ucs.ed.ac.uk [129.215.149.64])
	by treacle.ucs.ed.ac.uk (8.13.8/8.13.4) with ESMTP id q6JAmd4W018092
	for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 11:48:45 +0100 (BST)
Received: from [129.215.183.3] (pcw3047.see.ed.ac.uk [129.215.183.3])
	(authenticated user=mrichar1 mech=PLAIN bits=0)
	by lmtp1.ucs.ed.ac.uk (8.13.8/8.13.7) with ESMTP id q6JAmdJt007818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 11:48:39 +0100 (BST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4BA3C458033BFE3E1AC7A7B8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I'd just like to report the same behaviour on my test cluster with 0.48.

I've set up a single box (Sl6.1 - 2.6.32-220.23.1 kernel) with 1 mds,
mon and osd, and replication set to '1' for both data and metadata.

Having mounted using ceph-fuse, I'm running a simple fio job to create lo=
ad:

[global]
directory=3D/mnt/ceph
size=3D500M
rw=3Dread
ioengine=3Dlibaio

[simple]

I'm then watching the latency with ioping.

With rw=3Dread, rw=3Drandread (random reads) or rw=3Dwrite (sequential wr=
ites)
I see no problems and the latency sits around 1-2ms.  However, with
rw=3Drandwrite (random writes) I see the latency jump to between 5 and 60=

seconds, and the following types of warning lines appear:

2012-07-19 10:29:39.417625 osd.0 [WRN] 11 slow requests, 6 included
below; oldest blocked for > 54.425766 secs
[WRN] slow request 54.420958 seconds old, received at 2012-07-19
10:28:44.996584: osd_op(client.4113.0:9153 100000003ed.0000003b [write
847872~4096] 0.dc4b476f snapc 1=3D[]) v4 currently started
2012-07-19 10:29:39.417641 osd.0 [WRN] slow request 54.420587 seconds
old, received at 2012-07-19 10:28:44.996955: osd_op(client.4113.0:9154
100000003ed.00000000 [write 1175552~4096] 0.44a7cb80 snapc 1=3D[]) v4
currently started
[...snip...]


Let me know if there's any more information that I can provide that
might help with diagnosing the problem (also bearing in mind that I'm
new to ceph so might need extra notes on generating tests, dumps etc :) )=


Thanks,

Matthew


--=20
The University of Edinburgh is a charitable body, registered in
Scotland, with registration number SC005336.


--------------enig4BA3C458033BFE3E1AC7A7B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAH5gcACgkQRWpi1WYCQdIJ/ACgjs+EqAA6Za5If32SeJ6jWttz
8roAoNmDW92CgjK7PI6uv6jtCpkKk1VN
=xlxg
-----END PGP SIGNATURE-----

--------------enig4BA3C458033BFE3E1AC7A7B8--
