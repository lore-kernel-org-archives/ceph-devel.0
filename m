From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 14:12:33 -0500
Message-ID: <20151203191233.GA17144@ultraspiritum.redhat.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
 <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
 <CO1PR02MB2087E3AF3553B6269FBC10DF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
 <20151203172508.GB13420@ultraspiritum.redhat.com>
 <CO1PR02MB208C446A80363743FC5D341F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
 <CAN=+7FU1z9w=dDZ8+qbvKu-_ucYEU8K0eKS99Pd6Ku=A=t2gWg@mail.gmail.com>
 <CO1PR02MB208B0C5A0B6995CC4EE87F5F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
 <1575682875.28391996.1449169755619.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48497 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbbLCTMf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 14:12:35 -0500
Content-Disposition: inline
In-Reply-To: <1575682875.28391996.1449169755619.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Samuel Just <sjust@redhat.com>, Sage Weil <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, ceph-devel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 03/12/2015, Casey Bodley wrote:
[snip]
> The queue_transactions() interface could take a container of Transactions,
> rather than pointers to Transactions, and the ObjectStore would move them
> out of the container into whatever representation it prefers.
[snip]

Or a pointer and count (or we could steal array_view from GSL). That way we
could pass in any continguous range (std::vector or even a std::array or
regular C style array allocated on the stack.)

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWYJQaXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jL1IIAJgSYFn9rowy/Jbc3YEu8B7z
SqwtoaH6L7oi0eLhEooXUSh4vStz2JVqDq5mM4bLcH6cnfYcZjavqcn8p6eUyno6
kn2+3CsjIbX6R+YXrHHsrfsrOSi4AJLV0Rbgz9qw787R8tmDQm3Ql/l2eBaXKCtz
pm2wM/NoPsYdn5yH+Dbm5dCMuiPrM7hbFU9lAuKw3GtGe2d+XjRy/seZKyGUjl7K
m3hoyaqdXBYuYk8sMBZNMxUM80G7dN0xGI4v6/KWzki2fRFguRgN2401wRNPmVM8
hEeoy252wkrGsgcpyggnGU+Grwq3bY/fWf+zRx2eLBGQvH8+bk5Gc36HT2FizrM=
=nBG3
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
