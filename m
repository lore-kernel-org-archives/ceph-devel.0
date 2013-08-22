From: Alexandre Oliva <oliva@gnu.org>
Subject: [PATCH] enable mds rejoin with active inodes' old parent xattrs
Date: Thu, 22 Aug 2013 03:40:22 -0300
Message-ID: <orvc2ytei1.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:41578 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab3HVGqO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 02:46:14 -0400
Received: from freie (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id r7M6f4WR027384
	for <ceph-devel@vger.kernel.org>; Thu, 22 Aug 2013 06:41:05 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When the parent xattrs of active inodes that the mds attempts to open
during rejoin lack pool info (struct_v < 5), this field will be filled
in with -1, causing the mds to retry fetching a backtrace with a pool
number that matches the expected value, which fails and causes the
err=3D=3D-ENOENT branch to be taken and retry pool 1, which succeeds, b=
ut
with pool -1, and so keeps on bouncing between the two retry cases
forever.

This patch arranges for the mds to go along with pool -1 instead of
insisting that it be refetched, enabling it to complete recovery
instead of eating cpu, network bandwidth and metadata osd's resources
like there's no tomorrow, in what AFAICT is an infinite and very busy
loop.

This is not a new problem: I've had it even before upgrading from
Cuttlefish to Dumpling, I'd just never managed to track it down, and
force-unmounting the filesystem and then restarting the mds was an
easier (if inconvenient) work-around, particularly because it always
hit when the filesystem was under active, heavy-ish use (or there
wouldn't be much reason for caps recovery ;-)


There are two issues not addressed in this patch, however.  One is
that nothing seems to proactively update the parent xattr when it is
found to be outdated, so it remains out of date forever.  Not even
renaming top-level directories causes the xattrs to be recursively
rewritten.  AFAICT that's a bug.

The other is that inodes that don't have a parent xattr (created by
even older versions of ceph) are reported as non-existing in the mds
rejoin message, because the absence of the parent xattr is signaled as
a missing inode (=E2=80=9Cfailed to reconnect caps for missing inodes=E2=
=80=9D).  I
suppose this may cause more serious recovery problems.

I suppose a global pass over the filesystem tree updating parent
xattrs that are out-of-date would be desirable, if we find any parent
xattrs still lacking current information; it might make sense to
activate it as a background thread from the backtrace decoding
function, when it finds a parent xattr that's too out-of-date, or as a
separate client (ceph-fsck?).

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/mds/MDCache.cc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index e592dde..b6c37aec 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -7940,7 +7940,7 @@ void MDCache::_open_ino_backtrace_fetched(inodeno=
_t ino, bufferlist& bl, int err
   inode_backtrace_t backtrace;
   if (err =3D=3D 0) {
     ::decode(backtrace, bl);
-    if (backtrace.pool !=3D info.pool) {
+    if (backtrace.pool !=3D info.pool && backtrace.pool !=3D -1) {
       dout(10) << " old object in pool " << info.pool
 	       << ", retrying pool " << backtrace.pool << dendl;
       info.pool =3D backtrace.pool;

--=20
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
=46ree Software Evangelist      Red Hat Brazil Compiler Engineer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
