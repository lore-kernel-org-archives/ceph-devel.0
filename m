From: Mehdi Abaakouk <sileht@sileht.net>
Subject: Re: Ceph Benchmark HowTo
Date: Wed, 25 Jul 2012 23:31:43 +0200
Message-ID: <20120725213143.GA11390@mail.sileht.net>
References: <20120724144300.GA3317@mail.sileht.net>
 <CAPUexz-G2R_amz9_Eh7bisOVrOC66uowMqavvdg7n87XTz56QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sileht.net ([178.33.111.110]:36109 "EHLO mail.sileht.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187Ab2GYVbq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 Jul 2012 17:31:46 -0400
Content-Disposition: inline
In-Reply-To: <CAPUexz-G2R_amz9_Eh7bisOVrOC66uowMqavvdg7n87XTz56QQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Wed, Jul 25, 2012 at 10:06:04PM +0200, Florian Haas wrote:
> Hi Mehdi,
> For the OSD tests, which OSD filesystem are you testing on? Are you      =
                                                                           =
               =20
> using a separate journal device? If yes, what type?    =20

Actually, I use xfs and the journal is on a same disk in an other partition.
After reading documentation, I seems that using a dedicated disk is=20
better and SSD is a good choice.

> seekwatcher -t rbd-latency-write.trace -o rbd-latency-write.png -p 'dd
> if=3D/dev/zero of=3D/dev/rbd0 bs=3D4M count=3D1000 oflag=3Ddirect' -d /de=
v/rbd0
>=20
> Just making sure: are you getting the same numbers just with dd,
> rather than dd invoked by seekwatcher?

yes

>=20
> Also, for your dd latency test of 4M direct I/O reads writes, you seem
> to be getting 39 and 300 ms average latency, yet further down it says
> "RBD latency read/write: 28ms and 114.5ms". Any explanation for the
> write latency being cut in half on what was apparently a different
> test run?

Yes this is a different run, the one on the bottom was with less servers
but with better hardware.

>=20
> Also, were read and write caches cleared between tests? (echo 3 >
> /proc/sys/vm/drop_caches)

No, I will add it=20

> Cheers,
> Florian

I known that my setup is not really optimal,
Writing these tests help me to understand how ceph work and
I'm sure with your advice I will build a better cluster :)

Thanks for your help.

Cheers,
--=20
Mehdi Abaakouk
mail: sileht@sileht.net
irc: sileht

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQEGW/AAoJEBiStC/OquvI9zwQAJhmrxenPBaPYqEBMriZWwyW
fjsqCUqD/7MjbdC0lj9QBSn733vLLdqF/d5ZQ+Wb35dG9qZduD00jodMkeT+ZXgs
zhMJLiUVmoipnYEBgAuCu3D78p0ibbhQQfSi0kgQJFHdBG9bLptmY1oUWAar9YP7
vCBpEiiUqI+mc17IQFOkn8vCvLMI3Vso4lM+Z32w2pKnMNpfpvz4EqlFw3ix20qK
wP6SmoaVRJ+yxXffksMVyAspOZm8UltOZqNyX7nZKWKhacAnDgkd1/t70+MNKpT9
XYKIW+7QmnEbsKnVZrK8prO4cFMSIexqCM7hdpVrckYr6nKNuJE8MhTbJUsHEN4n
gLCZiTAvYBdYOEjrLu8kSt6YkOSeuayh5kTqJOnwHHXq3qX348bRgh95Qb0agwSl
zDlAmZyUA3JbH7DFtfaWufBR/OP4AkBvI/jutE6UTl33EgygNSxesb8jlqgUKnaF
/v6i0cQG0kE+VCwCtrPXl4orFQAP76k35YBpqWvuX+WCHRyU4OFp9VwbTnWf4BXo
dKTtp0RCbv7H0H+bOEtUrcnidDVRVDftjs/N7sAnhFlADge+Z/JH137PtHhUx1Jl
Nm9KwA3lvhyVM/lKxpQbh/d/0tuQXjxpf7nAA61K0Wdr9CyXGSVrRw6Z3xW+9SLk
K+huYvOjxLg8b6VctdVe
=qq4+
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
