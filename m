From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Why FailedAssertion is not my favorite exception
Date: Fri, 4 Dec 2015 15:31:30 -0500
Message-ID: <20151204203129.GA10038@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56734 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338AbbLDUbb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Dec 2015 15:31:31 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 24D2991351
	for <ceph-devel@vger.kernel.org>; Fri,  4 Dec 2015 20:31:31 +0000 (UTC)
Received: from ultraspiritum.redhat.com (ovpn-116-27.rdu2.redhat.com [10.10.116.27])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tB4KVUwd008459
	for <ceph-devel@vger.kernel.org>; Fri, 4 Dec 2015 15:31:30 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Developers <ceph-devel@vger.kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Noble Creators of the Squid Cybernetic Swimming in a Distributed Data Sea,

There is a spectre haunting src/common/assert.cc: The spectre of throw
FailedAssertion.

This seemingly inconsequential yet villainous statement destroys the
stack frame in which a failing assert statement is evaluated-- a stack
frame of great interest to those hoping to divine the cause of such
failures-- at the moment of their detection.

This consequence follows from the hope that some caller might be able to
catch and recover from the failure. That is an unworthy goal, for any
failure sufficiently dire to rate an 'assert' is a failure from which
there can be no recovery. As I survey the code, I see FailedAssertion
is only caught as part of unit tests and in a few small programs where
it lead to an immediate exit.

Therefore! If there is no objection, I would like to submit a patch that
will replace 'throw FailedException' with abort(). In support of this
goal, the patch will also remove attempts to catch FailedException from
driver programs like librados-config and change tests expecting a throw
of FailedAssertion to use the EXPECT_DEATH or ASSERT_DEATH macros instead.

These changes, taken together, should be non-disruptive and make
debugging easier.

Thank you all.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWYfgaXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jW7AH/1dY6n48n6e0O0qFzGdxe9ey
1mW/L9rRTU1b71KtxsRLSHS7Ax+Z04OEc2ZrPZuyUVYxr2foNy8em9rRt62i3/yu
grf+SFFBwKnt/OYylLaX7Sejc1/XnIKszzmHZtYCJeZFiLw/ViS7oJ6djeZGfGi3
oLlzye4/d1UGo9rRFaGGLoFTZ9vESSSNOcdHQfpwlqkuRmArmWYRHKIGVYScUMzg
yNESGX26jNU5h4Ze+LMlDINWX8dddVy5TM36AzU3ZrFctnZpiQv5eRaUcaHhw6kI
9xtb0d3wPP7UkUgr1TdXtsGuRfNeO+NcNOOQAT2SbB8oV3qTaTcjoIHB6Wa3mVA=
=oND1
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
