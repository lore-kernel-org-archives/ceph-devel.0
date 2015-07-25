From: Loic Dachary <loic@dachary.org>
Subject: What to do with non backports targeting a stable branch
Date: Sat, 25 Jul 2015 14:33:33 +0200
Message-ID: <55B3821D.4060403@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XWHOV02P9jPQWHIU1ghbWfa8JRUHddqg0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:56067 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753679AbbGYMdg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 Jul 2015 08:33:36 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XWHOV02P9jPQWHIU1ghbWfa8JRUHddqg0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry Nathan, I went AFK before answering:

<smithfarm_nb> one more question: why did you change the tracker from Bug=
 to Backport on http://tracker.ceph.com/issues/11542 ?
<smithfarm_nb> I'm guessing it was because there was only one backport ta=
rget (firefly)
<smithfarm_nb> it seems to me that, according to http://tracker.ceph.com/=
projects/ceph-releases/wiki/HOWTO_schedule_an_issue_for_backporting you s=
hould have copied the issue from Bug to Backport tracker
<smithfarm_nb> but if there is only one backport target this shortcut mak=
es sense

We did not write anything related to this and maybe we should. In theory,=
 for unification purposes, I should have created an issue, link it to the=
 master PR https://github.com/ceph/ceph/pull/1768 and created an issue fo=
r the backport. It's overkill for just one commit, but ... that happens v=
ery rarely (maybe once a month ?). Therefore I think we can tolerate the =
overkill administrative overhead. I shouldn't have tried to be creative.

Here is the missing issue : http://tracker.ceph.com/issues/12467

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--XWHOV02P9jPQWHIU1ghbWfa8JRUHddqg0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEUEARECAAYFAlWzgh0ACgkQ8dLMyEl6F20TRQCWJHnMgtO5JiAW4zrcvfViZW+A
MgCgnPvbbVKGKjOYkJnlPJXe74tHyrI=
=HiNH
-----END PGP SIGNATURE-----

--XWHOV02P9jPQWHIU1ghbWfa8JRUHddqg0--
