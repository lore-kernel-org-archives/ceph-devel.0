From: Loic Dachary <loic@dachary.org>
Subject: Ceph backports
Date: Mon, 05 Jan 2015 12:53:42 +0100
Message-ID: <54AA7B46.6090706@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Qpv4PR0Up2UcNNN8vbtK99nbmEVM0udp0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33612 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753258AbbAELxp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 06:53:45 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 3C506420B2
	for <ceph-devel@vger.kernel.org>; Mon,  5 Jan 2015 12:53:42 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qpv4PR0Up2UcNNN8vbtK99nbmEVM0udp0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

I'm going to spend time to care for the Ceph backports (i.e. help reduce =
the time they stay in pull requests or redmine tickets). It should roughl=
y go as follows:

0. Developer follows normal process to land PR to master. Once complete a=
nd ticket is marked Pending Backport this process initiates.
1. I periodically polls Redmine to look for tickets in Pending Backport s=
tate
2. I find commit associated with Redmine ticket and Cherry Picks it to ba=
ckport integration branch off of desired maintenance branch (Dumping, Fir=
efly, etc). (Note - patch may require backport to multiple branches)
3. I resolve any merge conflicts with the cherry-picked commit
4. Once satisfied with group of backported commits to integration branch,=
 I notifies QE.
5. QE tests backport integration branch against appropriate suites
6a. If QE is satisfied with test results, they merge backport integration=
 branch.
6b. If QE is NOT satisfied with the test results, they indicate backport =
integration branch is NOT ready to merge and return to me to work with or=
iginal Developer to resolve issue and return to steps 2/3
7. Ticket is moved to Resolved once backport integration branch containin=
g cherry-picked backport is merged to the desired mainteance branch(es)

I'll first try to implement this semi manually and document / script when=
 convenient. If anyone has ideas to improve this tentative process, now i=
s the time :-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Qpv4PR0Up2UcNNN8vbtK99nbmEVM0udp0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSqe0YACgkQ8dLMyEl6F21O9wCeLczJU7Zyh43s+0fDO9AROI5K
LDEAn0Ionn/V171O799UljDH54t5Du1D
=s10J
-----END PGP SIGNATURE-----

--Qpv4PR0Up2UcNNN8vbtK99nbmEVM0udp0--
