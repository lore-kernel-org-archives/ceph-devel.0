From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Tue, 12 Jan 2016 12:32:48 -0500
Message-ID: <20160112173248.GA8218@ultraspiritum.redhat.com>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com>
 <892700092.10054838.1452614393452.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58392 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967AbcALRct (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jan 2016 12:32:49 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 7719F18B253
	for <ceph-devel@vger.kernel.org>; Tue, 12 Jan 2016 17:32:49 +0000 (UTC)
Received: from ultraspiritum.redhat.com (ovpn-116-18.rdu2.redhat.com [10.10.116.18])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u0CHWm7n032268
	for <ceph-devel@vger.kernel.org>; Tue, 12 Jan 2016 12:32:49 -0500
Content-Disposition: inline
In-Reply-To: <892700092.10054838.1452614393452.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12/01/2016, Erwan Velu wrote:
> Hi folks,

Hello!

> When reading the code I noticed that ceph_clock_now() is mostly used to c=
ompute a local difference of time.
> I do see you are using "clock_gettime(CLOCK_REALTIME, &tp)" but was wonde=
ring if CLOCK_MONOTONIC_RAW isn't more accurate.
>=20
> I mean if the local system time is readujsted by NTP (or similar) some co=
mputation could be wrong leading to some possible mis-interpretation or wro=
ng scheduling.

I have done some work starting in that direction currently in master. In
common/ceph_time.h I define coarse and fine versions of the real clock
and monotonic clock and I've switched the osdc subsystem over to use them.

We use the std::chrono C++ time library, but we define our own clocks
(so we can pick the right one for performance/resolution tradeoffs) and an
in-memory timespan representation (so not every function taking a duration =
has
to be a template.)

The real_clock and mono_clock classes correspond to CLOCK_REALTIME and CLOC=
K_MONOTONIC, and coarse_real_clock and coarse_mono_clock correspond to CLOC=
K_REALTIME_COARSE and CLOCK_MONOTONIC_COARSE. If you require millisecond re=
solution but nothing finer, you should prefer the coarse variants.

The std::chrono library lets us integrate with other C++ libraries (and use=
 the
standard concurrency features) and has the advantage of stronger typing; we
can't use a duration where a time point is required or subtract a monotonic
time point from a real time point.

As I understand it, CLOCK_MONOTONIC_RAW is generally the wrong choice.
The raw hardware clock is prone to drift, and NTP synchronization (or other
corrective) makes the elapsed time measurements more accurate.

However, I am not a Time Lord. If someone knows better, please correct me h=
ere.

One concern with monotonic clocks, even for elapsed time, is that their epo=
ch is
unspecified. You cannot send a monotonic time over the network to another
machine nor can you save it to a file and re-read it later. Anything to be
serialized must be a real time.

This is unfortunate. If I were a Time Lord I'd travel back in time and make=
 the
POSIX committee adopt CLOCK_UTC and CLOCK_TAI so we could have serializable
monotonic time values.

> I could work on a PR is you find this interesting.

I find it interesting. If you want to change more subsystems to use ceph_ti=
me
and use monotonic and coarse clocks in appropriate places I think that woul=
d be
wonderful. It might be worthwhile to focus on the places where we use doubl=
e to
represent a time value.

Please read through ceph_time.h and osdc to get a feel for it. If you think=
 it
could use improvement, I'd be happy to hear your ideas.

Thank you.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWlTi6XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4j0YAH/RY+erkYN9T94gMuJ+XIFoQ0
/Fgp4tfOsdSduLr+4NSPB3agS9pdtLnSXjXYVLvJJEi6NvIjJU3Jtb2NP0tUmAd1
Z19LV5k9tIH21aG0Pp3at/T9Fnp/IK9052jXJbZAuJUtFVlYQ88AydjMiE7tIjaX
M6Y3KrBJwVrWEIgGHyUhkBAYLsb/AC9/mrL3RVJ+j+TFKIUT2V0DgICLr0HAcFPo
twy4ELBfEheYvtI1XutuuC/HKPkr10VmYWxS8ANo4fDxiZaiGWUHJYJx2PRYO8XS
kBZf5FY5K1za7ZHX8LVWF/fl4ftfhZxjWZ46b7+YTXPmrS71T5EcJqjxGpOdbxs=
=eI8v
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
