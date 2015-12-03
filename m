From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 12:25:09 -0500
Message-ID: <20151203172508.GB13420@ultraspiritum.redhat.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
 <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
 <CO1PR02MB2087E3AF3553B6269FBC10DF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40162 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723AbbLCRZK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 12:25:10 -0500
Content-Disposition: inline
In-Reply-To: <CO1PR02MB2087E3AF3553B6269FBC10DF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/12/2015, Somnath Roy wrote:
> Yes, I posted the new result after adding -O2 in the compiler flag and it=
 shows almost no overhead with unique_ptr.
> I will add the test of adding to list overhead and start implementing the=
 new interface.
> But, regarding my other point of changing all the objecstore interfaces (=
my first mail on this mail chain in case you have missed) taking Transactio=
n, any thought of that ?
> Should we reconsider having two queue_transaction interface ?

As I understand it, the concern with switching to unique_ptr was that the c=
allee
would move from the reference without this being known to the caller.

Would it make sense to pass as an RValue reference (i.e. TransactionRef&&)?=
 That
way the compiler should demand that the callers explicitly use std::move on=
 the
reference they're holding, documenting at the site of the call that they're
willing to give up ownership.


--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWYHrvXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4j5iUH/0HFIm2+pgAguqrm0CYHbbVY
dSy80ySy89JGiWKw47ycKLy84R0D3qBw8D58yBwhR/aUDu+c6rSYuHsgD0xxqaXW
KH5NiABbU/k1xT4n+kaH9DD9P8C7jqE/sBFawokb1Tsm8fixAhUMHaLB7nJKT3WQ
e1fy1a7Gjy3aIMKZ+0aljGMjN12EtLPTWQ6YZtPkhE5BB7eojVs51l6GP1lGRA6B
VWpMMLnsF3pfOFjTTw5jtC7vzfv/yLFh2xq3UG/h+ikvHnd4ZW1/Kq9ScQ9j9M0f
jXHjcQo9+jmFHFoiXlrjPHNrYI65QzAXJYu5CyDdaTGYhynn5b04CBY8K9hcxwQ=
=pHIR
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
