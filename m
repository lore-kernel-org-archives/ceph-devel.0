From: Loic Dachary <loic@dachary.org>
Subject: ISA erasure code plugin and cache
Date: Mon, 04 Aug 2014 13:56:59 +0200
Message-ID: <53DF750B.6080107@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="46DKqwx14tvjDxgaR5foEsvphJ7CiXlp1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53422 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751776AbaHDL5J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Aug 2014 07:57:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--46DKqwx14tvjDxgaR5foEsvphJ7CiXlp1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Here is how I understand the current code:

When an OSD is missing, recovery is required and the primary OSD will col=
lect the available chunks to do so. It will then call the decode method v=
ia ECUtil::decode which is a small wrapper around the corresponding Erasu=
reCodeInterface::decode method.

   https://github.com/ceph/ceph/blob/master/src/osd/ECBackend.cc#L361

The ISA plugin will then use the isa_decode method to perform the work

   https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureC=
odeIsa.cc#L212

and will be repeatedly called until all objects in the PGs that were rely=
ing on the missing OSD are recovered. To avoid computing the decoding tab=
le for each object, it is stored in a LRU cache

   https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureC=
odeIsa.cc#L480

and copied in the stack if already there:

   https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureC=
odeIsa.cc#L433

Each PG has a separate instance of ErasureCodeIsa, obtained when it is cr=
eated:

   https://github.com/ceph/ceph/blob/master/src/osd/PGBackend.cc#L292

It means that data members of each ErasureCodeIsa are copied as many time=
s as there are PGs. If an OSD handles participates in 200 PG that belong =
to an erasure coded pool configured to use ErasureCodeIsa, the data membe=
rs will be duplicated 200 times.

It is good practice to make it so that the encode/decode methods of Erasu=
reCodeIsa are thread safe. In the jerasure plugin these methods have no s=
ide effect on the object. In the isa plugin the LRU cache storing the dec=
ode tables is modified by the decode method and guarded by a mutex:

   get https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Eras=
ureCodeIsa.cc#L281
   put https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Eras=
ureCodeIsa.cc#L310

Please correct me if I'm mistaken ;-) I've not reviewed the code yet and =
try to find problems, I just wanted to make sure I get the intention befo=
re doing so.

Cheers
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--46DKqwx14tvjDxgaR5foEsvphJ7CiXlp1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPfdQsACgkQ8dLMyEl6F22C8gCgi4F2c4u/5aB9ejjJ1e1rpF3X
JAkAnRoK92kGZv0UVIMqcKifhth9mD+U
=TnzF
-----END PGP SIGNATURE-----

--46DKqwx14tvjDxgaR5foEsvphJ7CiXlp1--
