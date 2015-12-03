From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 12:17:04 -0500
Message-ID: <20151203171704.GA13420@ultraspiritum.redhat.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
 <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
 <1998646860.28019612.1449155791509.JavaMail.zimbra@redhat.com>
 <CO1PR02MB208F00D967903C505E92074F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55888 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594AbbLCRRG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 12:17:06 -0500
Content-Disposition: inline
In-Reply-To: <CO1PR02MB208F00D967903C505E92074F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Casey Bodley <cbodley@redhat.com>, Sage Weil <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 03/12/2015, Somnath Roy wrote:
> I don't think make_shared / make_unique is part of c++11 (and ceph is using that). It is part of c++14 I guess..

std::make_shared is in C++11, std::make_unique is in C++14. In addition to
performance, std::make_shared is also more correct, in that:

  std::shared_ptr<T>(new T)

can leak object allocated by 'new T' if the allocation for the shared_ptr
fails.

std::make_unique is nice for cleanliness and symmetry, but doesn't add anything
for performance or safety. (Also you can write your own make_unique, where
make_shared is intimately involved with the details of shared_ptr.)

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWYHkJXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4j/1kH/ReZpFvMA9thBp+2lS/FRBiH
KRa7GjN1dwVTf0i3H9N7jg6+e17/bIBAoeXjrVr3Q4983JY66Vvv/o20AaUHujhb
+Lo0iArK5fX7HfqxDEpra3u9IV0StCWPQkx27RSd1Hf44jqGW+7uAc8pFnueHUMj
fGWBaE/arwvYvyDfHRAjgl6DP9Ep6RcUU9Oy6A/Swi8j8DGpJFS9kV15dszutBEk
jlW/9KMrOoOm6d5GAMBMyk+K8AKcn7BuQmPbn0qy5RgaRxnAQqgz8gmIKL1SF7N0
A8MPBveCa1eMc29wK9U4JRwOhrrHdezhDx7Y16n0g9S2sWvP1vRP/cP7W6Y+1qg=
=GFBx
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
