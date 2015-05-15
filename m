From: Colin Watson <cjwatson@debian.org>
Subject: Re: Request for static uid/gid for ceph
Date: Fri, 15 May 2015 11:24:15 +0100
Message-ID: <20150515102415.GN10485@riva.ucam.org>
References: <87egnl2u87.fsf@meteor.durcheinandertal.bofh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from b.a.painless.aa.net.uk ([81.187.30.65]:38836 "EHLO
	b.a.painless.aa.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934318AbbEOME3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 May 2015 08:04:29 -0400
Content-Disposition: inline
In-Reply-To: <87egnl2u87.fsf@meteor.durcheinandertal.bofh>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gaudenz Steinlin <gaudenz@debian.org>
Cc: base-passwd@packages.debian.org, Sage Weil <sweil@redhat.com>, Tim Serong <tserong@suse.com>, ceph-devel@vger.kernel.org, Ken Dreyer <kdreyer@redhat.com>, ceph-maintainers@ceph.com, timm@fnal.gov


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2015 at 07:10:16PM +0200, Gaudenz Steinlin wrote:
> Ceph is currently developing unprivileged user support, and the upstream
> developers are asking each of the distros to allocate a static numerical
> UID for the "ceph" user and group.
>=20
> The reason for the static number is to allow Ceph users to hot-swap hard
> drives from one OSD server to another. Currently this practice works
> because Ceph writes its files as "uid 0", but when Ceph starts writing
> its files as an unprivileged user, it will be nice to allow
> administrators to unplug a drive and plug it into another computer and
> everything to just work.
>=20
> For this I'm requesting an uid and gid from the reserved range
> 60000-64999 according to the process outlined in
> https://anonscm.debian.org/cgit/users/cjwatson/base-passwd.git/tree/READM=
E.

Sorry for the delay.  This seems entirely reasonable; I've allocated
uid/gid 64045, which you'll now find in the git tree above.  I haven't
uploaded base-passwd with this yet, but you can go ahead and make use of
this immediately in Debian/Ubuntu without needing to wait for an upload.

Regards,

--=20
Colin Watson                                       [cjwatson@debian.org]

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Colin Watson <cjwatson@debian.org> -- Debian developer

iQIVAwUBVVXJTzk1h9l9hlALAQhjFhAAtzmbG+K/3FZffZole7pjZyrq6Gefbofu
JUJsWgSpS6BNa+RxiNuoX+TwBlTGgB/kt0oqooTQmBO4qcj4YrCdN6M1/ietJ1a2
9C9xFKd5JEYsoInSwmysAgftiU15pJ8Fl4S/mXeWAdmXjmk0/5udkq4tO7NZpVCs
66phyVMkcrc7Q15ZSgHyXNWEyWLhOoFifH+hP7x9tYs7QANW0M7L6EnWtU9IVsk3
n4OcplZa1YbhUshixAGqHDKMtqg0ygF0/g5NRJSf6t2bNH/AVJytMsoYBX5GDzXP
eNcwHUuqXKMwxgW0vQOs2yV0iyKIf56Nern/PWXR9gA3Ht9yjmZBM9IN5TWldpVI
A5fE01EYw3QwEWujQdEI/k3vGEUWKPbtAAgZxSh+8uw4KN4IGSzLCnSdSpo500I3
UCY+JUUcU8qsZWTO2jyCusUvd9bbWBkOyUsIth4gzxYaJ5yokwlFAe9FcQrkxBAv
Tcng+nIm/3DI8uzR9z5E1bZoz7dYdj68RCa8KYCJFKhCU7l1iQehD7SOHDSXC1U+
pdXFW4xf9pwGqUsIDu0I1fjPKrKQVjZYMFqlxEPmD+V7/cBNYZOoC4g/x3UmcSum
Q/08AtAlSMOF52iNArZXNn5MOqVbPWsARM/g6a+K1whEYYACQfYBsvZntMDZ+C4F
3NfSZtX2GjI=
=uRPw
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
