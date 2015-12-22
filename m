From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Let's Not Destroy the World in 2038
Date: Tue, 22 Dec 2015 15:10:40 -0500
Message-ID: <20151222201039.GA24590@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51082 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932707AbbLVUKl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Dec 2015 15:10:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 1CA4B49DAA
	for <ceph-devel@vger.kernel.org>; Tue, 22 Dec 2015 20:10:41 +0000 (UTC)
Received: from ultraspiritum.redhat.com (ovpn-116-43.rdu2.redhat.com [10.10.116.43])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBMKAeB2003368
	for <ceph-devel@vger.kernel.org>; Tue, 22 Dec 2015 15:10:40 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Comrades,

Ceph's victory is assured. It will be the storage system of The Future.
Matt Benjamin has reminded me that if we don't act fast=B9 Ceph will be
responsible for destroying the world.

utime_t() uses a 32-bit second count internally. This isn't great, but it's
something we can fix. ceph::real_time currently uses a 64-bit bit count of
nanoseconds, which is better. And we can change it to something else without
having to rewrite much other code.

The problem lies in our encode/deocde functions for time (both utime_t
and ceph::real_time, since I didn't want to break compatibility.) we
use a 32-bit second count. I would like to change the wire and disk
representation to a 64-bit second count and a 32-bit nanosecond count.

Would there be resistance to a project to do this? I don't know if a
FEATURE bit would help. A FEATURE bit to toggle the width of the second
count would be ideal if it would work. Otherwise it looks like the best
way to do this would be to find all the structures currently ::encoded
that hold time values, bump the version number and have an 'old_utime'
that we use for everything pre-change.

Thank you!

=B9 Within the next twenty-three years. But that's not really a long time i=
n the
  larger scheme of things.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWea44XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4joWkH/1ZxjNyK2l3iuYdD+4diWSts
oRkmjEI3gu4vqKOLX48PoUJvzUBzaT50OR46wjGzdy3jqbRS5gz8O41TBTwuWdM3
d/hzjvhb3yKJVPSnROLqAISWN3CLHwS2lREPnRCvXo7StZ3bNLf70D3szRxpwpKb
bUHfL3f9ysOyexdt+w3zUVa/WzMsYUEhRJvLiQKTGpZRI9+1HgKfBhXJ6sISKk9m
M/TZ2A10QEONGl6ou0h3ST2CrJqaEp8viizbJHCSdYADanZkNMc779SKJk5Sv0D2
3P9vR3bvJm2eAsFBoqfrBeU+vBpF4hEZjEnOK7dU5N7U9RTqAYF7eOJ2huUAwPY=
=1YtG
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
