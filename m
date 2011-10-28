From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph updates for 3.2-rc1
Date: Fri, 28 Oct 2011 15:00:19 -0700
Message-ID: <1319839219.32370.5.camel@slip>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tm5TTlQUWMD+Gb3rq//q"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49981 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172Ab1J1WAU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2011 18:00:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org


--=-tm5TTlQUWMD+Gb3rq//q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull the following Ceph updates for 3.2-rc1 from

  git://github.com/NewDreamNetwork/ceph-client.git for-linus
or
  git://ceph.newdream.net/git/ceph-client.git for-linus

(That's the old tree location.  I haven't reestablished korg access because
I don't see other kernel devs much around these parts.  Still working on it=
.)

The biggest thing here is a rewrite of the read path that vastly improves=
=20
read(ahead) performance.  There is also optional support for server name=
=20
resolution using the dns stuff, a fix for 32-bit ino number uniqueness,=20
and a range of cleanups and small memory leak fixes.

Once Christoph picks up the fixed d_prune patch I'll have a few more=20
patches to send you that trun some Ceph client-side dentry caching stuff=
=20
back on.

Thanks!
sage



Amon Ott (1):
      ceph: fix 32-bit ino numbers

Greg Farnum (1):
      ceph: let the set_layout ioctl set single traits

Noah Watkins (3):
      ceph: replace leading spaces with tabs
      ceph: fix ceph_monc_init memory leak
      ceph: use kernel DNS resolver

Sage Weil (11):
      ceph: make readpages fully async
      ceph: rename rsize -> rasize
      ceph: implement (optional) max read size
      ceph: document ioctls
      libceph: create messenger with client
      libceph: always preallocate mon connection
      libceph: don't complain on msgpool alloc failures
      libceph: warn on msg allocation failures
      Revert "ceph: don't truncate dirty pages in invalidate work thread"
      libceph: force resend of osd requests if we skip an osdmap
      libceph: fix double-free of page vector

 drivers/block/rbd.c            |    2 +-
 fs/ceph/addr.c                 |  193 +++++++++++++++++++++++++-----------=
----
 fs/ceph/caps.c                 |    2 +-
 fs/ceph/inode.c                |   46 +---------
 fs/ceph/ioctl.c                |   34 ++++++--
 fs/ceph/ioctl.h                |   55 +++++++++++-
 fs/ceph/mds_client.c           |   11 ++-
 fs/ceph/super.c                |   61 ++++++++-----
 fs/ceph/super.h                |   19 +++--
 include/linux/ceph/libceph.h   |    4 +-
 include/linux/ceph/messenger.h |    3 +-
 net/ceph/Kconfig               |   14 +++
 net/ceph/ceph_common.c         |   47 +++++-----
 net/ceph/messenger.c           |  130 +++++++++++++++++++++++----
 net/ceph/mon_client.c          |   79 +++++++++--------
 net/ceph/msgpool.c             |    4 +-
 net/ceph/osd_client.c          |   34 ++++---
 17 files changed, 483 insertions(+), 255 deletions(-)


--=-tm5TTlQUWMD+Gb3rq//q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk6rJeoACgkQ2kQg7SiJlcgS7ACfR0KT6jFGfURJ5o0K1etP538s
pl4AoM+xX6MhWL/6UM3lXTlk0tm/+3Wo
=19kC
-----END PGP SIGNATURE-----

--=-tm5TTlQUWMD+Gb3rq//q--

