From: Loic Dachary <loic@dachary.org>
Subject: obj_bencher.{cc,h} hammer backports
Date: Mon, 07 Sep 2015 18:02:36 +0200
Message-ID: <55EDB51C.2050802@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mSq1o9sOR9IPQMGrahmQfjNwFToMc0W1C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51128 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752471AbbIGQCu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Sep 2015 12:02:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Abhishek Varshney <abhishek.varshney@flipkart.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mSq1o9sOR9IPQMGrahmQfjNwFToMc0W1C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

While Abhishek (cc'ed) was working on backporting a bug fix in obj_bench[=
1], he ended up pulling more and more commits in an attempt to have it ap=
ply cleanly.=20

The goal is to backport these two commits from http://tracker.ceph.com/is=
sues/12947

9bcf5f0 tools: fix race condition in seq/rand bench
55a6f9e bufferlist: implement bufferlist::invalidate_crc()

After looking at the modification history of obj_bencher.cc, going from 9=
bcf5f0 back to hammer, it turns out there are two bug fixes that would be=
 nice to have in hammer ( cd0f2b7 obj_bencher: does not accumulate bandwi=
dth that is zero + e3d62a9 common: make rados bench return correctly errn=
o ) and one feature (3944264 obj_bencher: add IOPS metric calculation). T=
he rest is refactoring and cleanup, reason why the backports are difficul=
t.

I think we could backport all commits from

9bcf5f0 tools: fix race condition in seq/rand bench
down to
069d95e obj_bencher: fix indents

Leaving out the documentation commit.

Abhishek tested that it applies cleanly, compiles and passes make check. =
Luckily all these commits are limited to the obj_bencher.{cc,h}, rest_ben=
ch.cc and rados.cc files.=20

More importantly, although this series look like a lot, in reality it doe=
s not change much. Not only does it make this backport simpler because th=
ere are no conflicts to resolve, I think it would also make future backpo=
rts in this area easier because they will not stumble on cosmetic changes=
=2E

Do you see a problem to proceed in this direction ?

Cheers

[1] https://github.com/ceph/ceph/pull/5812

$ git --no-pager log --full-diff --no-merges --stat --oneline ceph/hammer=
=2E.ceph/master src/common/obj_bencher.cc
08296dc rados: make 'rados bench' support json format output Fixes: #1286=
4 rados bench add '[--format json]' and '[-o | --output outfile]' support=
=2E output option only take effect in json format. now we can use the ben=
ch result draw performance graph easily.
 src/common/obj_bencher.cc   | 124 ++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 src/common/obj_bencher.h    |   9 ++++++++
 src/test/test_rados_tool.sh |   5 +++++
 src/tools/rados/rados.cc    |  24 ++++++++++++++++++++
 4 files changed, 148 insertions(+), 14 deletions(-)
4eaa9ea fix print error of rados bench
 src/common/obj_bencher.cc | 10 ++++------
 src/common/obj_bencher.h  |  9 +++++----
 2 files changed, 9 insertions(+), 10 deletions(-)
f4d2032 c++11: disambiguate std::isnan
 src/common/obj_bencher.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
90fdbbf common, tools, test: Add "rados purge" feature to remove all obje=
cts from a pool
 src/common/obj_bencher.cc   | 24 ++++++++++++------------
 src/common/obj_bencher.h    | 10 +++++++---
 src/test/test_rados_tool.sh |  7 +++++++
 src/tools/rados/rados.cc    | 37 +++++++++++++++++++++++++++++++++++--
 src/tools/rest_bench.cc     |  7 ++++---
 5 files changed, 65 insertions(+), 20 deletions(-)
9bcf5f0 tools: fix race condition in seq/rand bench
 src/common/obj_bencher.cc | 80 +++++++++++++++++++++++++++++++++++++++++=
+++------------------------------------
 1 file changed, 44 insertions(+), 36 deletions(-)
813897c obj_bencher: remove trailing space
 src/common/obj_bencher.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
0f7aeee obj_bencher: check run_name and prefix for empty string instead o=
f NULL
 src/common/obj_bencher.cc | 12 ++++++------
 src/common/obj_bencher.h  |  4 ++--
 src/tools/rest_bench.cc   |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)
ca6abca tools: add --no-verify option to rados bench
 src/common/obj_bencher.cc | 67 +++++++++++++++++++++++++++++++++++++++++=
+-------------------------
 src/common/obj_bencher.h  |  6 +++---
 src/tools/rados/rados.cc  | 11 ++++++++++-
 3 files changed, 55 insertions(+), 29 deletions(-)
b894fc7 tools: Don't delete, recreate and re-fill buffers in rados bench.=

 src/common/obj_bencher.cc | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)
fe79bab common: fix ObjBencher::aio_bench signature
 src/common/obj_bencher.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
5c6190d common: rados bench data.finished =3D 0
 src/common/obj_bencher.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
1ac7279 common: remove unused maxObjectsToCreate
 src/common/obj_bencher.cc | 22 +++++++++-------------
 src/common/obj_bencher.h  |  4 ++--
 src/tools/rados/rados.cc  |  2 +-
 3 files changed, 12 insertions(+), 16 deletions(-)
cd0f2b7 obj_bencher: does not accumulate bandwidth that is zero
 src/common/obj_bencher.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
a87ac4d obj_bencher: aio_bench - rename op_size to object_size
 src/common/obj_bencher.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
1d1d0aa obj_bencher: remove excess 'object_size =3D op_size'
 src/common/obj_bencher.cc | 2 --
 1 file changed, 2 deletions(-)
31d16e9 obj_bencher: remove 'trans_size' as obsolete
 src/common/obj_bencher.cc | 5 ++---
 src/common/obj_bencher.h  | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)
e3d62a9 common: make rados bench return correctly errno.
 src/common/obj_bencher.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
3944264 obj_bencher: add IOPS metric calculation
 src/common/obj_bencher.cc | 28 ++++++++++++++++++++++++++++
 src/common/obj_bencher.h  |  3 +++
 2 files changed, 31 insertions(+)
ddb422f obj_bencher: cosmetic display fixes
 src/common/obj_bencher.cc | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)
e360bfd obj_bencher: generalize vec_stddev function
 src/common/obj_bencher.cc | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)
069d95e obj_bencher: fix indents
 src/common/obj_bencher.cc | 116 ++++++++++++++++++++++++++++++++++++++++=
++++++++++++----------------------------------------------------
 1 file changed, 58 insertions(+), 58 deletions(-)
c1e792d doc: update doc with latest code
 doc/dev/osd_internals/map_message_handling.rst |  4 ++--
 doc/dev/osd_internals/snaps.rst                |  4 ++--
 src/common/obj_bencher.cc                      |  3 +--
 src/include/cephfs/libcephfs.h                 | 18 +++++++++---------
 src/include/rados/librados.h                   | 38 +++++++++++++++++++-=
------------------
 src/include/rados/librados.hpp                 | 15 +++++++--------
 src/include/radosstriper/libradosstriper.h     |  8 ++++----
 src/include/str_map.h                          |  2 +-
 src/mds/CInode.h                               |  4 ++--
 src/mon/Elector.h                              |  2 +-
 src/mon/Monitor.h                              |  4 ++--
 src/mon/MonitorStore.h                         |  3 ++-
 src/mon/PGMap.cc                               |  1 +
 src/mon/Paxos.h                                |  9 +++++----
 src/mon/PaxosService.h                         |  8 ++++----
 src/msg/Messenger.h                            | 12 ++++++------
 src/msg/async/AsyncMessenger.h                 |  5 +----
 src/msg/simple/SimpleMessenger.h               |  2 +-
 src/os/CollectionIndex.h                       |  2 +-
 src/os/ObjectStore.h                           |  6 +++---
 src/osd/OSDCap.h                               |  1 -
 src/osd/osd_types.h                            |  8 ++++----
 src/test/messenger/xio_dispatcher.h            |  2 +-
 23 files changed, 79 insertions(+), 82 deletions(-)

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--mSq1o9sOR9IPQMGrahmQfjNwFToMc0W1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXttRwACgkQ8dLMyEl6F22BHgCgqwpoxWTRR8agWSYb1v+YoRDl
YJ8AniaYrb/8jyCFF0vbveGkZO6zf1db
=37zu
-----END PGP SIGNATURE-----

--mSq1o9sOR9IPQMGrahmQfjNwFToMc0W1C--
