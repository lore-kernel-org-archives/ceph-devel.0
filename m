From: Mehdi Abaakouk <sileht@sileht.net>
Subject: Re: Ceph Benchmark HowTo
Date: Tue, 31 Jul 2012 14:31:06 +0200
Message-ID: <20120731123106.GA29835@mail.sileht.net>
References: <20120724144300.GA3317@mail.sileht.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sileht.net ([178.33.111.110]:35254 "EHLO mail.sileht.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755945Ab2GaMbJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 Jul 2012 08:31:09 -0400
Content-Disposition: inline
In-Reply-To: <20120724144300.GA3317@mail.sileht.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I have updated the how-to here:
http://ceph.com/wiki/Benchmark

And published the results of my latest tests:
http://ceph.com/wiki/Benchmark#First_Example

All results are good, my benchmark is clearly limited by my network
connection ~ 110MB/s.

In exception of the rest-api bench, the value seems really low.

I have configured radosgw with this:
http://ceph.com/docs/master/radosgw/config/
I clean disk cache on all servers before the bench,
and start rest-bench for 900 seconds with default value.

Is my rest-bench result normal ? Have I missed something ?

Don't hesitate if you need more informations on my setup.

And then, I have another question about how is the Standard Deviation
calculated with rados bench and rest-bench ? with the reported value=20
printed each second by the benchmark client ?
If yes, when latency is too high, the reported bandwith is sometime zero,
then has the calculated StdDev for bandwith a sens ?


Cheers,
--=20
Mehdi Abaakouk for eNovance
mail: sileht@sileht.net
irc: sileht

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQF9AKAAoJEBiStC/OquvINeUQAIrd8K75EPaaBrB7AzzUB7Ez
w4DaoClKzu/VCMs8+BCIxh6ktU8RCMmRMQB/4ptx3q/CIzJk2C3wbpKY2JzxdBQ+
ODnTC4u6A+p+q8k4AEE5ULXcymigvomcAyG6rTk057Li1yS7c37byq/5iMKMx+Ap
sgcqlOBQ+ZiYxNFA0MtAL3BQk9JSCLEemu0iWX8VBM6Tz5MkzQpAbdB54ZYqLCRD
PHulc8tZU6SHegGe/j61Wq3jVmFfWgHKn7A7ItqF+nb2yHqFqsKqGeeZzPOL6cuU
Do2ev1EZi+FqWZpchC0N/g7IHPRBlEOdHslqaqFCkuORG22PQLYuQKmWhXjW6SgG
WvV7BK5aH9w/8HarPqG5j2DkTnkrSiwCCOOkQAV4bZfwTQrK6fbx/dU+/xLMZmaa
CHPSWUPSq9bsNjg+u7c+kTUqEWs8xj8IRhNKNXBMUYkknrPiKHLAtgbeXgZgAXj0
ztJxfPQQgTE4emvsWyi2kh7y95qZl3RbTlEI9qXnc7a70Q9mwgmBndz1go6MHdGe
SQqm4EHtaPV8TP3BuyeojCcrdvBCnRhKoVxYlMnl+Aq1J8iNIBdGfx+sZvMwqIFs
TlNaU5OH6XPui24igZfAOolJCQIuHD+rUQ5O33D5GvlLzZGzp+5YmgClZYYpZ2m/
c9hPdXHM3buKnlRO22BD
=5eVm
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
