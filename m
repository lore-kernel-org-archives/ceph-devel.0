From: NeilBrown <neilb@suse.com>
Subject: Re: [GIT PULL] Ceph fixes for -rc7
Date: Fri, 25 Mar 2016 15:02:30 +1100
Message-ID: <87fuvfw6g9.fsf@notabene.neil.brown.name>
References: <alpine.DEB.2.11.1603052045320.25897@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1603052045320.25897@cpach.fuggernut.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sweil@redhat.com>, torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 06 2016, Sage Weil wrote:

> Hi Linus,
>
> Please pull the following Ceph patch from
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-=
linus
>
> This is a final commit we missed to align the protocol compatibility with=
=20
> the feature bits.  It decodes a few extra fields in two different message=
s=20
> and reports EIO when they are used (not yet supported).
>
> Thanks!
> sage
>
>
> ----------------------------------------------------------------
> Yan, Zheng (1):
>       ceph: initial CEPH_FEATURE_FS_FILE_LAYOUT_V2 support

Just wondering, but was CEPH_FEATURE_FS_FILE_LAYOUT_V2 supposed to have
exactly the same value as CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING (and
CEPH_FEATURE_CRUSH_TUNABLES5)??
Because when I backported this patch (and many others) to some ancient
enterprise kernel, it caused mounts to fail.  If it really is meant to
be the same value, then I must have some other backported issue to find
and fix.

Thanks,
NeilBrown


>
>  fs/ceph/addr.c                     |  4 ++++
>  fs/ceph/caps.c                     | 27 ++++++++++++++++++++++++---
>  fs/ceph/inode.c                    |  2 ++
>  fs/ceph/mds_client.c               | 16 ++++++++++++++++
>  fs/ceph/mds_client.h               |  1 +
>  fs/ceph/super.h                    |  1 +
>  include/linux/ceph/ceph_features.h |  1 +
>  7 files changed, 49 insertions(+), 3 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW9LhXAAoJEDnsnt1WYoG5UbsP/3kejOX7z23x1U2O5a429+Bu
CMCR9HasYJqMojP9BY4VBU9o8EwW+8dXFI2qR9fhFQMCHgaqgiGZz1a8uaNmUW9v
aBYFNgEKYK8nS+Dbl3ucatpdy3uuWgsqkZ+XBe1MWSXWV0Lrj1ELG/nuqRjQsT50
Taa3WQjPUu9svvqTkzQpIueQMfzaK6tD5mvH2sBoNM8Nj/IW/bue9l8UG+nkafci
zhWTN2sOunzqE8o3NNmWWkTJwylkBf58/RS2Ic2c+yNQ6xRDwiHcgob17JXqL0eE
3f4xJw69Ovtuct+9NDcF3EfJjUeggRKafm7h1bsVG6FyLtpVO9o76vN/yS4zt/gN
hffishe+/WGrkCCqzP4i0P6pnczgs7dvfRC14AGM/4l8IojUZaDj7lE1m8s6fimH
4JHYOl/EbowO08Y+ZUiKsTfsAjDGQzOLR/buOSie9fQJjepCazT9AJPISvYSxJdK
BwSAnL5fB0VqgXQ6+I02Ve4R1SDO0vvHLmPEeDQVGvNZaSqHhTRrnhVdTY21UlCX
ZteTKTt0uE5TeRb+Upm0qMyVD+oGmsbX+nYDwXZTEX3r3LiIw0V30l1tSmA2R+vC
g7inI3HQOfFkvI3qhrev9OBe+lDZsFB3q3PGWLk8U/8JGSs4KnTj0D+8An2SGGck
oyyXMK3NmcO2xrRyj1YJ
=JAJs
-----END PGP SIGNATURE-----
--=-=-=--
