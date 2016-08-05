From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Jewel Civetweb no longer works on IPv6, please include in next
 release
Date: Fri, 5 Aug 2016 00:32:22 +0000
Message-ID: <20160805003222.GI18768@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="15rqq6UvmZq3FwB1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:58432 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966516AbcHEAcX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Aug 2016 20:32:23 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 145DE340B7A
	for <ceph-devel@vger.kernel.org>; Fri,  5 Aug 2016 00:32:22 +0000 (UTC)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: mbenjamin@redhat.com, yehuda@redhat.com


--15rqq6UvmZq3FwB1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In Jewel release, civetweb no longer listens on IPv6, due to a missing
compile define. This is a regression from hammer, introduced in commit
c38e3cb.

It would be really nice to have this included in the next Jewel release
that's about to come out.

Nothing in any of the test suites include coverage of which IP family
the CivetWeb code is listening on.

Bug: http://tracker.ceph.com/issues/16928
Fix for master: https://github.com/ceph/ceph/pull/10579
Fix for Jewel: https://github.com/ceph/ceph/pull/10580

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--15rqq6UvmZq3FwB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iKYEARECAGYFAlej3pVfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3Bl
bnBncC5maWZ0aGhvcnNlbWFuLm5ldDc1OTQwNEJFQkQ0MUY3MTIzODIzODZFRjNF
OTIyQzIyMzIzM0MyMkMACgkQPpIsIjIzwixY7wCdGFSc1Q0YyYPfVMrN4qAdFv0x
DJYAoJjSphTJUSeDZqHwCORrXP0ESyNu
=AXup
-----END PGP SIGNATURE-----

--15rqq6UvmZq3FwB1--
