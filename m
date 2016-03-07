From: Karol Mroz <kmroz@suse.com>
Subject: master build failure with boost 1.60
Date: Mon, 7 Mar 2016 15:49:44 +0100
Message-ID: <20160307144944.GA21590@pxe-sup5.sup.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:38134 "EHLO
	smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbcCGOtu (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 7 Mar 2016 09:49:50 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

We've recently hit a build failure on ceph master for which Abhishek has op=
ened
a bug: http://tracker.ceph.com/issues/14998.

Our rolling distribution (openSUSE Tumbleweed) has pushed out boost 1.60
which looks to be at the heart of the failure. Is boost 1.60 to be supporte=
d in
Jewel?

Thanks!

--=20
Regards,
Karol

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW3ZUGAAoJECp28bThgzat+bwH/3LzjqXuWbJoG17E77+fvIJj
AgNz7YV1ebV86f5PET7JaKtTiZXo2FS/C1PhFnxr0wXHDb/moOAg34uIXfFd+hph
ud3J2RMpP1NMHJMwAqFNfZrhBWd4LOG1B75MGNUBDZusgCrC1YsEHkvvX82YnzSf
AT6WGSOgza62Ss7vUaqA29cd4Ft5VqWdF3Y1SM5oooP8CftTVgtk71r9UC0jL1FS
vPMhcPIkwvwv6d0lPnBEubGjPt5ahMr/lX5JmYqueq/p9qiRJ3vVlfEEsr/Gc1IF
tL8Fg/Q88lWvLmpC16nxZ4+gCQdErqhumeZjEkZP7Dk7smUkqtREPakRSu5J5Pc=
=cVeO
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
