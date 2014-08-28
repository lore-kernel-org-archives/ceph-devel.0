From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: OSD's load_pgs takes a lot of time
Date: Thu, 28 Aug 2014 04:06:19 -0300
Message-ID: <orbnr5ayac.fsf@free.home>
References: <CADg7yx3mM+zagdcwQ6AO-omzxBM33=Gft3hvMEKDPEVysqKxBg@mail.gmail.com>
	<alpine.DEB.2.00.1408260601570.30994@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:59844 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbaH1HIl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Aug 2014 03:08:41 -0400
In-Reply-To: <alpine.DEB.2.00.1408260601570.30994@cobra.newdream.net> (Sage
	Weil's message of "Tue, 26 Aug 2014 06:03:43 -0700 (PDT)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: =?utf-8?Q?Micha=C5=82_Szyma=C5=84ski?= <michalszymanski91@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Aug 26, 2014, Sage Weil <sweil@redhat.com> wrote:

> On Tue, 26 Aug 2014, Micha? Szyma?ski wrote:
>> 2014-08-21 15:32:19.648610 7fba11569780 10 osd.1 139 load_pgs
>> 3.13b_TEMP clearing temp
>> 2014-08-21 15:32:34.674773 7fba11569780 10 osd.1 139 load_pgs
>> 3.36b_TEMP clearing temp

>> Have anybody noticed this behavior? Isn't it possible to clear temp fast=
er?

> load_pgs is doing a lot more than just clearing temp

But at least in some scenarios using btrfs, clearing temps turns out to
be the dominant factor, and I posted a patch a while ago that solves
that specific case, but I don't think it was ever merged.

Micha=C5=82, does this help?


--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline

From: Alexandre Oliva <oliva@gnu.org>
To: ceph-devel@vger.kernel.org
Subject: [PATCH] osd: avoid flushing every TEMP removal to speedup startup
Organization: Free thinker, not speaking for the GNU Project
Date: Sun, 18 May 2014 09:47:59 -0300
Message-ID: <oriop3xngg.fsf@free.home>
MIME-Version: 1.0

When a btrfs OSD suicides because it couldn't keep up with others
(recovery included), it is often the case that the filesystem is in a
state in which creating and removing snapshots takes a long time.  It
is likely that there are going to be plenty of recovering PGs (with
corresponding TEMP directories), and we will create and remove a btrfs
snapshot for every such directory we remove at startup.  This is very
wasteful: there's no reason to not pile up as many removals as
possible before syncing and flushing the removal so as to force a
btrfs snapshot.

This patch introduces an optional argument to the function used to
remove PGs to control whether or not to perform the final flush.  The
flush still happens if the call does not pass that argument, but with
the patch, the startup removals skip the per-PG flush, and run a
single flush at the end.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/osd/OSD.cc |   12 +++++++++---
 src/osd/OSD.h  |    3 ++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 4240ba8..504cb71 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -1774,7 +1774,8 @@ int OSD::read_superblock()
 
 
 
-void OSD::recursive_remove_collection(ObjectStore *store, coll_t tmp)
+void OSD::recursive_remove_collection(ObjectStore *store, coll_t tmp,
+				      bool flush)
 {
   OSDriver driver(
     store,
@@ -1810,7 +1811,8 @@ void OSD::recursive_remove_collection(ObjectStore *store, coll_t tmp)
   t.remove_collection(tmp);
   int r = store->apply_transaction(t);
   assert(r == 0);
-  store->sync_and_flush();
+  if (flush)
+    store->sync_and_flush();
 }
 
 
@@ -2046,6 +2048,7 @@ void OSD::load_pgs()
 
   set<spg_t> head_pgs;
   map<spg_t, interval_set<snapid_t> > pgs;
+  bool flush = false;
   for (vector<coll_t>::iterator it = ls.begin();
        it != ls.end();
        ++it) {
@@ -2056,7 +2059,8 @@ void OSD::load_pgs()
     if (it->is_temp(pgid) ||
 	it->is_removal(&seq, &pgid)) {
       dout(10) << "load_pgs " << *it << " clearing temp" << dendl;
-      recursive_remove_collection(store, *it);
+      recursive_remove_collection(store, *it, false);
+      flush = true;
       continue;
     }
 
@@ -2074,6 +2078,8 @@ void OSD::load_pgs()
 
     dout(10) << "load_pgs ignoring unrecognized " << *it << dendl;
   }
+  if (flush)
+    store->sync_and_flush();
 
   bool has_upgraded = false;
   for (map<spg_t, interval_set<snapid_t> >::iterator i = pgs.begin();
diff --git a/src/osd/OSD.h b/src/osd/OSD.h
index ce8b74c..f599e43 100644
--- a/src/osd/OSD.h
+++ b/src/osd/OSD.h
@@ -870,7 +870,8 @@ public:
     hobject_t oid(sobject_t("infos", CEPH_NOSNAP));
     return oid;
   }
-  static void recursive_remove_collection(ObjectStore *store, coll_t tmp);
+  static void recursive_remove_collection(ObjectStore *store, coll_t tmp,
+					  bool flush = true);
 
   /**
    * get_osd_initial_compat_set()

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer

--=-=-=--
