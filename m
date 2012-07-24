From: Mehdi Abaakouk <sileht@sileht.net>
Subject: Ceph Benchmark HowTo
Date: Tue, 24 Jul 2012 16:43:00 +0200
Message-ID: <20120724144300.GA3317@mail.sileht.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sileht.net ([178.33.111.110]:54016 "EHLO mail.sileht.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753790Ab2GXOxj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 24 Jul 2012 10:53:39 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I am currently doing some tests on Ceph, more precisely on the RDB and RADO=
SGW=20
parts.=20
My goal is to get some performance metrics according to the hardwares and=
=20
the Ceph setup.

To do so, I am preparing a benchmark how-to, to help people to compare their
metrics.

I have started the how-to here : http://ceph.com/w/index.php?title=3DBenchm=
ark
I have linked it in the misc section of the main page.

Then, first question, is it alright if I continue publishing this procedure=
=20
on your wiki ?

The how-to is not finished yet, this is only a first draft.
My test platform is not ready yet too, so the result of the bench can't be
used yet.

The next work I will do on the how-to is to add some explanations on how
to interpret the results of benchmark.

So, if you have some comments, ideas of benchmarks, or anything that can be=
=20
helpful to me to improve the how-to and/or compare future results,=20
I would be glad to read them.

And thanks a lot for your work on Ceph, this is a great storage system :)

Best Regards,
--=20
Mehdi Abaakouk for eNovance
mail: sileht@sileht.net
irc: sileht

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQDrR0AAoJEBiStC/OquvIHCMP/jzFhtHkzL7K2s0vpn9Fmgsv
SplrgDwq8nSufgCUR9xZga0iHFX2EVx7qKwIhJLPTI5TD1G0/CAp2/3J7YjaEed9
5uXr3dPQ0p7yGWIyg3NPDViXk7Q1MObWGgFLGNM89qLNp8s5KMFFWIXBQYgVsJEO
WvIcYRWYnYJt6ROjtY1KDLuEFxKJYr8hNoMGJ4I8ul8Wd4517X8f4Lq0xG5i/m7f
FppmwhcwmehS7tAeSx/Obrm/qwx2yrjRMI3LA2noWqBXY6cx9ter9iBheyb9htZa
wfq6MVmUJY8w4NPFNbsVB5oNeZPPO3iD98vM8LGXmA8n9zl4P3YPuLm5ha6CWarB
CfCAMRWniLsE6i8D6y0fe/sGgTWq5OgA59dE9oyXtDGDvWt1NoJyBM+WrYGrKPBB
QcGkQ8712EeH+WIcFOGXTA4KSkTLtnfijSHtwIRW+kJ/vII0zwAV88XxyuSGV6Zz
tefeRJHaRobmaeCutVkgueujQAjPuWoEZ1y/UuxJwbMaDI/Wjlrgygq/+IuO/rLa
0JbxHXMwJnNcT7yL9ovFmU6At9oHhjBopf0nZyKlii7Jn1JXayHcrEsHYPHV7eQ3
xEDAjFR61uX8Lp/ozMRIdkds2FMT6tdzSQ/z5gXfuuhjJK/l/xXNDNl4UxcgOW1e
RrLCrzGUswwB9J2ve6sO
=IPzf
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
