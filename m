From: Loic Dachary <loic@dachary.org>
Subject: Locally Repairable Codes vs Pyramid
Date: Mon, 02 Jun 2014 18:00:34 +0200
Message-ID: <538C9FA2.3020805@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hTFOPgO9mDkI8aKgW9m5egxpjLOXhBWob"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:58483 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbaFBQAh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jun 2014 12:00:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Dan Lambright <dlambrig@redhat.com>, Xavier Hernandez <xhernandez@datalab.es>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hTFOPgO9mDkI8aKgW9m5egxpjLOXhBWob
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

TL;DR: s/pyramid/LRC/ in the implementation of http://pad.ceph.com/p/cdsg=
iant-pyramid-erasure-code for clarity

Although the term "Pyramid code" has been consistently used in reference =
to the technique used to reduce the network requirements when repairing f=
rom the loss of a single OSD (put simply ;-), I realized today when discu=
ssing with Dan Lambright and Xavier Hernandez from glusterfs that I was u=
nclear about what it really means.

As far as I can tell, LRC as described in http://anrg.usc.edu/~maheswaran=
/Xorbas.pdf suggests an implementation that is close to what has been des=
cribed during the last CDS. In contrast the pyramid code paper http://res=
earch.microsoft.com/pubs/70415/tr-2007-25.pdf suggests a more sophisticat=
ed approach which I do not fully understand.=20

Instead of hardcoding the word "pyramid" in the pathnames of the implemen=
tation it seems better to use "LRC" instead.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--hTFOPgO9mDkI8aKgW9m5egxpjLOXhBWob
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOMn6IACgkQ8dLMyEl6F21YYQCgnaoX8skhIAf10kNmWyFP+IpG
ysMAmwZRK2gSZD2UjtfynMOOj0vFppPB
=w3/4
-----END PGP SIGNATURE-----

--hTFOPgO9mDkI8aKgW9m5egxpjLOXhBWob--
