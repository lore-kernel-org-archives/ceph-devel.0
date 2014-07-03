From: Loic Dachary <loic@dachary.org>
Subject: Re: Reliability model for RADOS - effects during second failures
Date: Thu, 03 Jul 2014 09:10:37 +0200
Message-ID: <53B501ED.7070005@dachary.org>
References: <CACUN8h3wp31D=2s4v_wFh7_fc0jqykjsg4ZtSnoWK-ti9V5xqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nPuBuRs4NbpHCA1UE59T9g6fIuA0u2tJD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36552 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751250AbaGCHKq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jul 2014 03:10:46 -0400
In-Reply-To: <CACUN8h3wp31D=2s4v_wFh7_fc0jqykjsg4ZtSnoWK-ti9V5xqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuscus <koleosfuscus@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nPuBuRs4NbpHCA1UE59T9g6fIuA0u2tJD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi koleosfuscus,

On 03/07/2014 00:33, Koleos Fuscus wrote:
> Hi Kyle, Loic,
>=20
> The current code uses a =E2=80=9CFIT rate multiplier=E2=80=9D to includ=
e for instance
> the effect of operations done in parallel. That multiplier (n) has an
> effect on Pfail. In the initial failure, it is calculated using the
> number of replicas and the stripe count as seen in
> https://github.com/ceph/ceph-tools/blob/master/models/reliability/Rados=
Rely.py#L86.
>=20
> The thing that doesn=E2=80=99t have sense to me is the way the multipli=
er is
> calculated for the failure of the remaining copies in
> https://github.com/ceph/ceph-tools/blob/master/models/reliability/Rados=
Rely.py#L92
> Why the stripes are not taking into account? What is the purpose of
> using the =E2=80=9Cdeclustering factor=E2=80=9D on that equation? Is th=
at equation
> correct? I read this note by sage
> https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg01650.html
> trying to clarify the role of PGs but didn=E2=80=99t help me to underst=
and it.

At the risk of adding confusion to the discussion, does the current relia=
bility model make room to take into account what is described in anrg.usc=
=2Eedu/~maheswaran/Xorbas.pdf under "4. Reliability Analysis" ? In other =
words, is there a place where one could set things like "disk fail % of t=
he time" and "network is X Gb/s" and "repairing a disk failure requires d=
isk require reading B bytes from M disks" ? As far as I understand, such =
factors cannot be expressed with a single formula and this is why a Marko=
v model is useful.

> Besides, I have a simple question related with the equation on L86 for
> the initial failure. The stripping process splits user content in
> #number of objects, which equivalent to the stripe count. That group
> of objects constitutes an object set. Each object is composed by one
> or more stripes units. All stripes units (stripe count) are written in
> parallel. Typically each object is mapped to a different disk.  What
> happen when the object set is full and a new object is started? Are
> this new objects assigned to same disks used for the previous full
> object set?

In an ideal situation, if a disk / OSD is full it means the whole cluster=
 is full. Is it reasonable to ignore this situation when thinking about t=
he reliability model ? If not could you explain how ?

Cheers=20
>=20
> Best
>=20
> koleosfuscus
>=20
> ________________________________________________________________
> "My reply is: the software has no known bugs, therefore it has not
> been updated."
> Wietse Venema
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--nPuBuRs4NbpHCA1UE59T9g6fIuA0u2tJD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlO1Ae0ACgkQ8dLMyEl6F20HbwCgoQTB2+TSa8WpXafoEXxNCG2L
IisAnRP7+SktxWGHQx4hjJvmhqZOBjze
=iJbZ
-----END PGP SIGNATURE-----

--nPuBuRs4NbpHCA1UE59T9g6fIuA0u2tJD--
