From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: issues with adjusting the crushmap in 0.51
Date: Thu, 6 Sep 2012 19:51:04 +0100
Message-ID: <20120906185104.GA6518@tchpc.tcd.ie>
References: <20120906175821.GA32205@tchpc.tcd.ie> <sfid-H20120906-191917-+051.46-1@marduk.tchpc.tcd.ie> <CAPYLRzggLqcgvMJWFDYOsHvQNK2oOvHmmTEnufK60R4=mdEQNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:46343 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab2IFSvK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 14:51:10 -0400
Content-Disposition: inline
In-Reply-To: <CAPYLRzggLqcgvMJWFDYOsHvQNK2oOvHmmTEnufK60R4=mdEQNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Thu, Sep 06, 2012 at 11:19:12AM -0700, Gregory Farnum wrote:
> You always need to end up with "devices" (the OSDs, generally) and
> then emit those from your CRUSH rule. You can do so hierarchically:
> rule data {
>         ruleset 0
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step choose firstn 0 type host
>         step choose firstn 1 osd
>         step emit
> }
> In this case, (with n being your replication count) this rule chooses
> n hosts, and then chooses 1 OSD from each chosen host.
>=20
> You can also use "chooseleaf", which is a bit more robust in the
> presence of failed OSDs:
> rule data {
>         ruleset 0
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step chooseleaf firstn 0 type host
>         step emit
> }
> This rule will choose n hosts and an OSD from each chosen host, and if
> it fails on any host then it will restart with a different host (the
> previous rule would stick with the chosen hosts and so it can't handle
> if eg an entire host's OSDs are down).
> -Greg
>=20

That explaination certainly has cleared things up for me, I had not
realised that I needed to end with a "device" at the end of a rule
based on the documentation that I could find on the website and the
old ceph wiki.

Also, the "ceph osd setcrushmap..." command doesn't up when a ceph
--help is run in the 0.51 release, however it is documented on the
wiki as far as I recall. It'd be real nice if the applications emitted
all the available commands, it would make experimenting much nicer and
fun.

Thanks,
Jimmy,

--=20
Jimmy Tang
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEABECAAYFAlBI8JUACgkQmRvHlXBDSyncfQCWMU0UOJu5PS/BErpC4OGivdKG
EwCgntdk39fVqzZ3G5FQfKPalfAziGI=
=I/rb
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
