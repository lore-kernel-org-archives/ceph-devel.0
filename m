From: Alexandre Oliva <oliva@gnu.org>
Subject: enable old OSD snapshot to re-join a cluster
Date: Tue, 19 Feb 2013 19:52:00 -0300
Message-ID: <orr4kbgbn3.fsf@livre.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:35866 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933849Ab3BSWwR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 17:52:17 -0500
Received: from freie (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r1JMqDVN030276
	for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 22:52:15 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

It recently occurred to me that I messed up an OSD's storage, and
decided that the easiest way to bring it back was to roll it back to an
earlier snapshot I'd taken (along the lines of clustersnap) and let it
recover from there.

The problem with that idea was that the cluster had advanced too much
since the snapshot was taken: the latest OSDMap known by that snapshot
was far behind the range still carried by the monitors.

Determined to let that osd recover from all the data it already had,
rather than restarting from scratch, I hacked up a =E2=80=9Csolution=E2=80=
=9D that
appears to work: with the patch below, the OSD will use the contents of
an earlier OSDMap (presumably the latest one it has) for a newer OSDMap
it can't get any more.

A single run of osd with this patch was enough for it to pick up the
newer state and join the cluster; from then on, the patched osd was no
longer necessary, and presumably should not be used except for this sort
of emergency.

Of course this can only possibly work reliably if other nodes are up
with same or newer versions of each of the PGs (but then, rolling back
the OSD to an older snapshot would't be safe otherwise).  I don't know
of any other scenarios in which this patch will not recover things
correctly, but unless someone far more familiar with ceph internals than
I am vows for it, I'd recommend using this only if you're really
desperate to avoid a recovery from scratch, and you save snapshots of
the other osds (as you probably already do, or you wouldn't have older
snapshots to rollback to :-) and the mon *before* you get the patched
ceph-osd to run, and that you stop the mds or otherwise avoid changes
that you're not willing to lose should the patch not work for you and
you have to go back to the saved state and let the osd recover from
scratch.  If it works, lucky us; if it breaks, well, I told you :-)



--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=LOCAL-osd-super-recover.patch

Ugly work around to enable osds to recover from old snapshots

From: Alexandre Oliva <oliva@gnu.org>

Use the contents of the latest OSDMap that we have as if they were the
contents of more recent OSDMaps that we don't have and that have
already been removed in the cluster.  I hope this should work fine as
long as there haven't been major changes to the cluster.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/osd/OSD.cc |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 779849c..c0ea833 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -4452,7 +4452,17 @@ OSDMapRef OSDService::get_map(epoch_t epoch)
   if (epoch > 0) {
     dout(20) << "get_map " << epoch << " - loading and decoding " << map << dendl;
     bufferlist bl;
-    assert(_get_map_bl(epoch, bl));
+    if(!_get_map_bl(epoch, bl)) {
+      epoch_t older = epoch;
+      while(--older)
+	if (_get_map_bl(older, bl))
+	  break;
+      if (older)
+	map->decode(bl);
+      while (map->get_epoch() < epoch)
+	map->inc_epoch();
+      return _add_map(map);
+    }
     map->decode(bl);
   } else {
     dout(20) << "get_map " << epoch << " - return initial " << map << dendl;

--=-=-=


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
