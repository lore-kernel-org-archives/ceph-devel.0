From: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Subject: Re: Ceph Upstream Tarball + Re: Ceph status for Wheezy
Date: Wed, 11 Jul 2012 21:43:13 +0000
Message-ID: <1342042993.12180.98.camel@julia>
References: <4FFC44BE.6090505@ubuntu.com> <1341966632.12180.22.camel@julia>
	 <4FFD40DA.7020408@ubuntu.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-p5KMX5fA5rB8hrlKwNuV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:39823 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab2GKVnf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 17:43:35 -0400
In-Reply-To: <4FFD40DA.7020408@ubuntu.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>, Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


--=-p5KMX5fA5rB8hrlKwNuV
Content-Type: multipart/mixed; boundary="=-OetBDsnAvYHeNOWIDU8L"


--=-OetBDsnAvYHeNOWIDU8L
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi James, Sage,

Let me answer you both at once.

On Wed, 2012-07-11 at 10:01 +0100, James Page wrote:
> On 11/07/12 01:30, Laszlo Boszormenyi (GCS) wrote:
> > You are right, the watch file is outdated.
 An updated watch file is attached. Please commit it Sage. It goes for
numbers only, so 0.48argonaut will be 0.48 .

> Ah-ha!  Thanks for this information - I had not realised the leveldb
> and libs3 source was overlaid outside of git.
 Sage still consider it better, to be able to build everything needed
from one tarball. I've two small patches to build with system leveldb
and libs3 instead.

> This creates a short term issue for me in that leveldb and libs3 are
> not currently in Ubuntu main (MIR is raised but still pending review
> and approval) so not having the bundled source for these libraries is
> a pain as I can't easily use the same upstream tarball that you are
> using [...]
 Is there any ETA when/if it will be in Ubuntu main? Sage, would you
reconsider the all-in-one tarball if Debian and Ubuntu will have leveldb
and libs3 in their package list? I _may_ become a RedHat / Fedora
package maintainer as well and when it happens, I'll add them to those
distributions as well.

> - guess I could plugin the required bundles in the interim as
> patches as I would like to push 0.48 to quantal this week.
 You may wait a bit. At least please see:
[ Sage and me about "Ceph status for Wheezy" ]
On Wed, 2012-07-11 at 09:18 -0700, Sage Weil wrote:
> > What do I miss? Manpages for
> > ceph-disk-activate , ceph-disk-prepare , rest-bench and maybe
> > librados-config .
> Okay, those should be pretty simple.  There will be a point release befor=
e=20
> too long that includes all of this stuff.  If there is anything in your=
=20
> packaging that isn't fixed upstream let me know.
 It sounds 0.48.1 may happen within a week time. I've added symbol
versioning, but don't know if it has any use. Currently kvm doesn't
work when compiled with previous version of Ceph, see Debian bug
#679686[1]. In answer, my symbol files are created with 0.47.2 and
updated to 0.48 . Didn't go more back with versions and don't know how
much Ceph libraries will change in the future.
Sage, can you please give us more detail how do you plan the releases?
Is there any plan for more stable releases on every (say) 3 months, with
bugfixing only? Should we follow the actual development tree, no matter
what?

> I'm hoping to get to a point where the packaging is the same; if
> nothing else it saves extra work!
 Sure, that would be better. I've a package of v0.48 ready to upload[2],
but can wait some days if you would like to check what I may need to
merge from your package.

Cheers,
Laszlo/GCS
[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D679686
[2] dget -x http://www.barcikacomp.hu/gcs/ceph_0.48-1.dsc

--=-OetBDsnAvYHeNOWIDU8L
Content-Disposition: attachment; filename="watch"
Content-Type: text/plain; name="watch"; charset="ISO-8859-1"
Content-Transfer-Encoding: base64

dmVyc2lvbj0zDQpodHRwczovL2dpdGh1Yi5jb20vY2VwaC9jZXBoL3RhZ3MgLiovemlwYmFsbC92
KFxkW1xkXC5dKykuKg0K


--=-OetBDsnAvYHeNOWIDU8L--

--=-p5KMX5fA5rB8hrlKwNuV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAk/983IACgkQGkxvZbuqR8mPggCgn72PHJYdrdM50SGiiv/kLpES
1Y4An1icrCxc/sxJxLqlTabOrLXp0J4K
=Q0zc
-----END PGP SIGNATURE-----

--=-p5KMX5fA5rB8hrlKwNuV--

