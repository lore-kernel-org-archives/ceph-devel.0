From: Loic Dachary <loic@dachary.org>
Subject: rgw errors on the firefly v0.80.10 integration branch
Date: Fri, 08 May 2015 21:16:48 +0200
Message-ID: <554D0BA0.4010902@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KPu6Dv8fOmpKlTkdQSEN9NIfrxhaFaglA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60117 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752886AbbEHTQv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 15:16:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KPu6Dv8fOmpKlTkdQSEN9NIfrxhaFaglA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The error we see in the rgw suite at http://tracker.ceph.com/issues/11090=
#rgw come from http://tracker.ceph.com/issues/11180 which was cherry pick=
ed to hammer and giant but not firefly. I cherry picked the relevant comm=
it and ran suites at https://github.com/ceph/ceph-qa-suite/pull/437 and i=
t's all good now. I'm glad I remembered this one, it was a little puzzlin=
g the first time around :-)

I think rgw, rbd and fs in http://tracker.ceph.com/issues/11090 can be up=
dated now. Please ping me when it's done and we'll move to the next step =
:-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--KPu6Dv8fOmpKlTkdQSEN9NIfrxhaFaglA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVNC6AACgkQ8dLMyEl6F20IawCgsP5m/r5JruRVftSMTpqDzBER
sj0AoIbvU+/DzbYRy13CwufJAMRcOpS5
=EJrj
-----END PGP SIGNATURE-----

--KPu6Dv8fOmpKlTkdQSEN9NIfrxhaFaglA--
