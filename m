From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: enable old OSD snapshot to re-join a cluster
Date: Tue, 17 Dec 2013 09:36:00 -0200
Message-ID: <orbo0faevz.fsf@livre.home>
References: <orr4kbgbn3.fsf@livre.home>
	<CAPYLRzjG3ws-TJt+XOv0vp-oRuOZti+b1yjBZw_shhmdQE9F4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:47255 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab3LQLhY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 06:37:24 -0500
In-Reply-To: <CAPYLRzjG3ws-TJt+XOv0vp-oRuOZti+b1yjBZw_shhmdQE9F4g@mail.gmail.com>
	(Gregory Farnum's message of "Wed, 20 Feb 2013 10:52:30 -0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Feb 20, 2013, Gregory Farnum <greg@inktank.com> wrote:

> On Tue, Feb 19, 2013 at 2:52 PM, Alexandre Oliva <oliva@gnu.org> wrote:
>> It recently occurred to me that I messed up an OSD's storage, and
>> decided that the easiest way to bring it back was to roll it back to an
>> earlier snapshot I'd taken (along the lines of clustersnap) and let it
>> recover from there.
>>=20
>> The problem with that idea was that the cluster had advanced too much
>> since the snapshot was taken: the latest OSDMap known by that snapshot
>> was far behind the range still carried by the monitors.
>>=20
>> Determined to let that osd recover from all the data it already had,
>> rather than restarting from scratch, I hacked up a =E2=80=9Csolution=E2=
=80=9D that
>> appears to work: with the patch below, the OSD will use the contents of
>> an earlier OSDMap (presumably the latest one it has) for a newer OSDMap
>> it can't get any more.
>>=20
>> A single run of osd with this patch was enough for it to pick up the
>> newer state and join the cluster; from then on, the patched osd was no
>> longer necessary, and presumably should not be used except for this sort
>> of emergency.
>>=20
>> Of course this can only possibly work reliably if other nodes are up
>> with same or newer versions of each of the PGs (but then, rolling back
>> the OSD to an older snapshot would't be safe otherwise).  I don't know
>> of any other scenarios in which this patch will not recover things
>> correctly, but unless someone far more familiar with ceph internals than
>> I am vows for it, I'd recommend using this only if you're really
>> desperate to avoid a recovery from scratch, and you save snapshots of
>> the other osds (as you probably already do, or you wouldn't have older
>> snapshots to rollback to :-) and the mon *before* you get the patched
>> ceph-osd to run, and that you stop the mds or otherwise avoid changes
>> that you're not willing to lose should the patch not work for you and
>> you have to go back to the saved state and let the osd recover from
>> scratch.  If it works, lucky us; if it breaks, well, I told you :-)

> Yeah, this ought to basically work but it's very dangerous =E2=80=94
> potentially breaking invariants about cluster state changes, etc. I
> wouldn't use it if the cluster wasn't otherwise healthy; other nodes
> breaking in the middle of this operation could cause serious problems,
> etc. I'd much prefer that one just recovers over the wire using normal
> recovery paths... ;)

Here's an updated version of the patch, that makes it much faster than
the earlier version, particularly when the gap between the latest osdmap
known by the osd and the earliest osdmap known by the cluster is large.
There are some #if0-ed out portions of the code for experiments that
turned out to be unnecessary, but that I didn't quite want to throw
away.  I've used this patch for quite a while, and I wanted to post a
working version, rather than some cleaned-up version in which I might
accidentally introduce errors.


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
 src/common/shared_cache.hpp |    5 +++++
 src/common/simple_cache.hpp |    5 +++++
 src/osd/OSD.cc              |   34 +++++++++++++++++++++++++++++++---
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/src/common/shared_cache.hpp b/src/common/shared_cache.hpp
index 178d100..ac3a347 100644
--- a/src/common/shared_cache.hpp
+++ b/src/common/shared_cache.hpp
@@ -105,6 +105,11 @@ public:
     }
   }
 
+  void ensure_size(size_t min_size) {
+    if (max_size < min_size)
+      set_size(min_size);
+  }
+
   // Returns K key s.t. key <= k for all currently cached k,v
   K cached_key_lower_bound() {
     Mutex::Locker l(lock);
diff --git a/src/common/simple_cache.hpp b/src/common/simple_cache.hpp
index 60919fd..c067062 100644
--- a/src/common/simple_cache.hpp
+++ b/src/common/simple_cache.hpp
@@ -68,6 +68,11 @@ public:
     trim_cache();
   }
 
+  void ensure_size(size_t min_size) {
+    if (max_size < min_size)
+      set_size(min_size);
+  }
+
   bool lookup(K key, V *out) {
     Mutex::Locker l(lock);
     typename list<pair<K, V> >::iterator loc = contents.count(key) ?
diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 1a60de6..8da4d96 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -5690,9 +5690,37 @@ OSDMapRef OSDService::try_get_map(epoch_t epoch)
   if (epoch > 0) {
     dout(20) << "get_map " << epoch << " - loading and decoding " << map << dendl;
     bufferlist bl;
-    if (!_get_map_bl(epoch, bl)) {
-      delete map;
-      return OSDMapRef();
+    if(!_get_map_bl(epoch, bl)) {
+      epoch_t older = epoch;
+      while(--older) {
+	OSDMapRef retval = map_cache.lookup(older);
+	if (retval) {
+	  *map = *retval;
+#if 0
+	  map->inc_epoch();
+#endif
+	} else if (_get_map_bl(older, bl)) {
+#if 0
+	  map_bl_cache.ensure_size (epoch - map_cache.cached_key_lower_bound()
+				    + 1000);
+	  for (epoch_t i = epoch; i > older; i--)
+	    _add_map_bl(i, bl);
+#endif
+	  if (older)
+	    map->decode(bl);
+	} else
+	  continue;
+	break;
+      }
+      map_cache.ensure_size (epoch - map_cache.cached_key_lower_bound()
+			     + 1000);
+      while (map->get_epoch() < epoch) {
+#if 0
+	map_cache.add(map->get_epoch(), new OSDMap(*map));
+#endif
+	map->inc_epoch();
+      }
+      return map_cache.add(epoch, map);
     }
     map->decode(bl);
   } else {

--=-=-=



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
