From: Karol Mroz <kmroz@suse.com>
Subject: rgw/civetweb privileged port bind
Date: Thu, 26 Nov 2015 11:25:48 -0800
Message-ID: <20151126192548.GA27729@oak.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:46986 "EHLO
	smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbbKZTZw (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 26 Nov 2015 14:25:52 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

As I understand it, with the release of infernalis, ceph
daemons are no longer being run as root. Thus, rgw/civetweb
is unable to bind to privileged ports:

http://tracker.ceph.com/issues/13600

We encountered this problem as well in our downstream (hammer
based) product, where we run rgw/civetweb as "wwwuser". To allow
privileged port binding, we used file caps (setcap from the spec file).
Going forward, however, we were thinking of taking one of two
approaches:

1. Start rgw/civetweb as root and utilize an existing civetweb
config option (run_as_user) to drop permissions _after_
the port bind and after certificate files have been read.

2. Utilize systemd socket activation, and allow systemd to bind
to the necessary port. Once rgw/civetweb is started, civetweb
can pull the listening socket from systemd.

Is this something you folks upstream have given some thought to?

--=20
Regards,
Karol

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWV1y4AAoJECp28bThgzatTY4IAICLJpHPCSMJG/DUKk2FJIqa
GzkepakzsuI4RCAxVTZN1dZRGh1kDkEYKTg6PZo09SQ4TAbL5SOiQ+6XTJqZ6fp9
A6bZZTBQNlF+vZfLHNM4AXB3l5veHU+0nbYIVYsmWcOvmQp80UktjP6RzqvHJ1f0
l4Dd/evbEywFtoVq8MVqOKAqmB9Yulh2LR8k82+640uUEg1ikPANnLUVQP4LR2Ct
gXPLFELQ00Sygvq/L2LzQugx8ORMQTYHffDW/1a6/813h7JBNFxriSTRrUZICUDO
PgOxPNZWQ7VzvBTj3O9i2ciSm2+H1iH4NCy6wI0p+vSFxzcQv34csCLyj6eVtWE=
=u4A6
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
