From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Why FailedAssertion is not my favorite exception
Date: Fri, 4 Dec 2015 15:40:35 -0500
Message-ID: <20151204204035.GC10038@ultraspiritum.redhat.com>
References: <20151204203129.GA10038@ultraspiritum.redhat.com>
 <CAJ4mKGbg+wadiRnTsXbdZoWfv5PHQRUvYU=U=J03PG1k8yQdhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42326 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbbLDUkg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Dec 2015 15:40:36 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id B30EE1204AD
	for <ceph-devel@vger.kernel.org>; Fri,  4 Dec 2015 20:40:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGbg+wadiRnTsXbdZoWfv5PHQRUvYU=U=J03PG1k8yQdhA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Developers <ceph-devel@vger.kernel.org>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04/12/2015, Gregory Farnum wrote:
> I must be missing something here. As far as I can tell, "throw
> FailedAssertion" only happens in assert.cc, and I know that stuff
> doesn't destroy the relevant stack frames since I've pulled the info
> out of core dumps when debugging?
> -Greg

The behavior I'm seeing is that when I am attached to a process with gdb, a=
nd
an assertion fails it bounces all the way up to terminate with an uncaught
exception.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWYfo9XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jfoMH/2L/U8t8dYUZ2N9FZ/YFuYqS
1tZDiVD30cJgpf6Vfv90DdqfxgEksHTb/rZ3gvJn455ccU5JMs8WPVMQCh7hxVOk
nyvZZooL6KQaunEfCAEr+K6x8v+Nxw4f3H7Rtt1Vxlm8et6PX7AuCRQ1pk+6rmUk
bN5BWo5eghKInQogkU4rdw8q2PhmJmOXqxdcUG8kl+8hxv9QbGu0Mu/cDh7xLF/2
ODLiyADwILHa3T3ascxaEMH6okgqO1H6cI0Y0CuXoi9H6OLuhhLz079G4x25i71b
pP7a1eYnIfI1RidZfWKQ1+SvBvouonMzCrZBHmfI3K1vdDTbEez2rZEIJtbLzqw=
=cy0O
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
