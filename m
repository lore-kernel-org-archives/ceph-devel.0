From: Loic Dachary <loic@dachary.org>
Subject: Inventory of public teuthology clusters
Date: Sat, 11 Jul 2015 15:24:48 +0200
Message-ID: <55A11920.90609@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="d4dUCu0D6W3vT6MVi01ckf8f206A5C89O"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48506 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750799AbbGKNZC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Jul 2015 09:25:02 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 152BF420B1
	for <ceph-devel@vger.kernel.org>; Sat, 11 Jul 2015 15:24:49 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d4dUCu0D6W3vT6MVi01ckf8f206A5C89O
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

With the teuthology OpenStack backend[1] and OpenStack public cloud provi=
ders[2], operating your own teuthology cluster is a few hours of work[3].=
 It is useful to developers who can test their modification even if they =
don't have access to the community lab and without waiting for more impor=
tant jobs to complete. It is also import for non profit organizations suc=
h as http://tetaneutral.net/ who routinely deploy their own Ceph packages=
, to make sure the set of patches they chose to include on top of a Ceph =
stable release does not introduce a regression. It helps Ceph core develo=
pers when reviewing contributions that fail integration tests: the author=
 of the contribution can reproduce the problem by running the job.

Although some organizations are expected to run their teuthology lab behi=
nd firewalls[4], we could see more and more teuthology clusters with resu=
lts publicly available. The Ceph community lab[5] which runs hundreds of =
machines will hopefully be joined by other, more modest, clusters sharing=
 their results in public. It would be great to have an inventory looking =
like this:

   URL: http://pulpito.ceph.com/
   Organization: Ceph
   Sponsors: Red Hat
   Contact: Ceph Development <ceph-devel@vger.kernel.org>

   URL: http://ceph.aevoo.fr:8081/
   Organization: Aevoo
   Sponsors: Aevoo
   Contact: David Casier <contact@aevoo.fr>

   URL: http://integration.ceph.dachary.org:8081/
   Organization: None
   Sponsors: Red Hat
   Contact: Loic Dachary <ldachary@redhat.com>

   etc.

I'm not sure where such a list could be hosted. The http://tracker.ceph.c=
om/projects/lab/ wiki and http://ceph.github.io/sepia/ are dedicated to t=
he Sepia lab, the other projects are dedicated to development. Any ideas =
?

Maybe in a few months from now, if there are enough public facing teuthol=
ogy clusters, we will be able to harvest and compare their result to redu=
ce the redundancy and improve coverage. But I'm getting ahead of myself :=
-)=20

Cheers

[1] teuthology OpenStack backend https://github.com/dachary/teuthology/tr=
ee/wip-6502-openstack/
[2] Public OpenStack providers useable within the hour http://dachary.org=
/?p=3D3741
[3] Running your own Ceph integration tests with OpenStack http://dachary=
=2Eorg/?p=3D3767
[4] Red Hat, SUSE, Fujitsu, Intel have teuthology clusters behind firewal=
ls, for instance
[5] Sepia lab http://ceph.github.io/sepia/

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--d4dUCu0D6W3vT6MVi01ckf8f206A5C89O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWhGSAACgkQ8dLMyEl6F20fHQCgoFNSIuZrWSFN6eLV0vjy1VBV
eJ0AnAxDIvfMQREPJiNiFh2kGEn4S13S
=IciF
-----END PGP SIGNATURE-----

--d4dUCu0D6W3vT6MVi01ckf8f206A5C89O--
