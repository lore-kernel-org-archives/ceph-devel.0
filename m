From: Loic Dachary <loic@dachary.org>
Subject: ceph-workbench release 1.0.2
Date: Thu, 26 Feb 2015 14:35:02 +0100
Message-ID: <54EF2106.20709@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uLgEwgMJpha8KXLMNU5Us420THF67tEfH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49372 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753475AbbBZNfN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 08:35:13 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 514F842B48
	for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 14:35:02 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uLgEwgMJpha8KXLMNU5Us420THF67tEfH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

ceph-workbench is a command line script that is designed to bind together=
 various scripts I'm using when working on Ceph. A while back I thought i=
t would be a good idea to have such a swiss knife to match the needs of a=
ll Ceph developers, instead of scripts scattered in various places to ins=
tall dependencies (install-deps.sh), run make check for CI purpose (run-m=
ake-check.sh), compile in a container (docker-test.sh),  analyze the resu=
lts of teuthology, and many more. However each Ceph developer has its own=
 way of doing things and attempting to capture all use cases into one too=
l seemed impossible. But there is nothing wrong in implementing just one =
development workflow, as long as it is useful to a few people.

In other words ceph-workbench is by no mean generic, it implements the wo=
rkflow I'm using. Maybe some people new to Ceph will choose to use it ins=
tead of inventing something of their own.

In the spirit of releasing earlier rather than later, it is available at =
https://pypi.python.org/pypi/ceph-workbench and can be installed with:

    pip install ceph-workbench

which installs the command line:

    $ ceph-workbench --help
usage: ceph-workbench [-h] {github2gitlab,backport} ...

development workflow for Ceph

optional arguments:
  -h, --help            show this help message and exit

subcommands:
  valid subcommands

  {github2gitlab,backport}
                        sub-command -h
    github2gitlab       Mirror a GitHub project to GitLab
    backport            Backport reports

I'm using it to create the backports inventory pages (for instance http:/=
/workbench.dachary.org/ceph/ceph-backports/wikis/v0-80-8) which are my po=
int of reference when working on Ceph backports. It does not do more at t=
he moment but it will grow depending on my needs. Although I don't expect=
 anyone else would be interested in contributing at this point in time, m=
erge requests are most welcome at http://workbench.dachary.org/dachary/ce=
ph-workbench :-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre



--uLgEwgMJpha8KXLMNU5Us420THF67tEfH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTvIQYACgkQ8dLMyEl6F23MagCdG9B0MaD+iMI4A2yEUErgVtA0
TLQAn0gGLOArEGfkV/HW7oI48G7NKqny
=PeeM
-----END PGP SIGNATURE-----

--uLgEwgMJpha8KXLMNU5Us420THF67tEfH--
