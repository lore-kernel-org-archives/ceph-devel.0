From: Sage Weil <sweil@redhat.com>
Subject: v0.91 released
Date: Wed, 14 Jan 2015 15:13:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501141513050.12077@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43407 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbbANXNO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Jan 2015 18:13:14 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-announce@ceph.com
Cc: ceph-users@ceph.com, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

We are quickly approaching the Hammer feature freeze but have a few more 
dev releases to go before we get there.  The headline items are 
subtree-based quota support in CephFS (ceph-fuse/libcephfs client support 
only for now), a rewrite of the watch/notify librados API used by RBD and 
RGW, OSDMap checksums to ensure that maps are always consistent inside the 
cluster, new API calls in librados and librbd for IO hinting modeled after 
posix_fadvise, and improved storage of per-PG state.

We expect two more releases before the Hammer feature freeze (v0.93).

Upgrading
---------

* The 'category' field for objects has been removed.  This was originally 
  added to track PG stat summations over different categories of objects 
  for use by radosgw.  It is no longer has any known users and is prone to 
  abuse because it can lead to a pg_stat_t structure that is unbounded.  
  The librados API calls that accept this field now ignore it, and the OSD 
  no longers tracks the per-category summations.

* The output for 'rados df' has changed.  The 'category' level has been
  eliminated, so there is now a single stat object per pool.  The 
  structure of the JSON output is different, and the plaintext output has 
  one less column.

* The 'rados create <objectname> [category]' optional category argument is 
  no longer supported or recognized.

* rados.py's Rados class no longer has a __del__ method; it was causing
  problems on interpreter shutdown and use of threads.  If your code has
  Rados objects with limited lifetimes and you're concerned about locked
  resources, call Rados.shutdown() explicitly.

* There is a new version of the librados watch/notify API with vastly
  improved semantics.  Any applications using this interface are
  encouraged to migrate to the new API.  The old API calls are marked
  as deprecated and will eventually be removed.

* The librados rados_unwatch() call used to be safe to call on an
  invalid handle.  The new version has undefined behavior when passed
  a bogus value (for example, when rados_watch() returns an error and
  handle is not defined).

* The structure of the formatted 'pg stat' command is changed for the
  portion that counts states by name to avoid using the '+' character
  (which appears in state names) as part of the XML token (it is not
  legal).

Notable Changes
---------------

* asyncmsgr: misc fixes (Haomai Wang)
* buffer: add 'shareable' construct (Matt Benjamin)
* build: aarch64 build fixes (Noah Watkins, Haomai Wang)
* build: support for jemalloc (Shishir Gowda)
* ceph-disk: allow journal partition re-use (#10146 Loic Dachary, Dav van 
  der Ster)
* ceph-disk: misc fixes (Christos Stavrakakis)
* ceph-fuse: fix kernel cache trimming (#10277 Yan, Zheng)
* ceph-objectstore-tool: many many improvements (David Zafman)
* common: support new gperftools header locations (Key Dreyer)
* crush: straw bucket weight calculation fixes (#9998 Sage Weil)
* doc: misc improvements (Nilamdyuti Goswami, John Wilkins, Chris 
  Holcombe)
* libcephfs,ceph-fuse: add 'status' asok (John Spray)
* librados, osd: new watch/notify implementation (Sage Weil)
* librados: drop 'category' feature (Sage Weil)
* librados: fix pool deletion handling (#10372 Sage Weil)
* librados: new fadvise API (Ma Jianpeng)
* libradosstriper: fix remove() (Dongmao Zhang)
* librbd: complete pending ops before closing image (#10299 Josh Durgin)
* librbd: fadvise API (Ma Jianpeng)
* mds: ENOSPC and OSDMap epoch barriers (#7317 John Spray)
* mds: dirfrag buf fix (Yan, Zheng)
* mds: disallow most commands on inactive MDS's (Greg Farnum)
* mds: drop dentries, leases on deleted directories (#10164 Yan, Zheng)
* mds: handle zero-size xattr (#10335 Yan, Zheng)
* mds: subtree quota support (Yunchuan Wen)
* memstore: free space tracking (John Spray)
* misc cleanup (Danny Al-Gaaf, David Anderson)
* mon: 'osd crush reweight-all' command (Sage Weil)
* mon: allow full flag to be manually cleared (#9323 Sage Weil)
* mon: delay failure injection (Joao Eduardo Luis)
* mon: fix paxos timeouts (#10220 Joao Eduardo Luis)
* mon: get canonical OSDMap from leader (#10422 Sage Weil)
* msgr: fix RESETSESSION bug (#10080 Greg Farnum)
* objectstore: deprecate collection attrs (Sage Weil)
* osd, mon: add checksums to all OSDMaps (Sage Weil)
* osd: allow deletion of objects with watcher (#2339 Sage Weil)
* osd: allow sparse read for Push/Pull (Haomai Wang)
* osd: cache reverse_nibbles hash value (Dong Yuan)
* osd: drop upgrade support for pre-dumpling (Sage Weil)
* osd: enable and use posix_fadvise (Sage Weil)
* osd: erasure-code: enforce chunk size alignment (#10211 Loic Dachary)
* osd: erasure-code: jerasure support for NEON (Loic Dachary)
* osd: erasure-code: relax cauchy w restrictions (#10325 David Zhang, Loic 
  Dachary)
* osd: erasure-code: update gf-complete to latest upstream (Loic Dachary)
* osd: fix WBTHrottle perf counters (Haomai Wang)
* osd: fix backfill bug (#10150 Samuel Just)
* osd: fix occasional peering stalls (#10431 Sage Weil)
* osd: fix scrub vs try-flush bug (#8011 Samuel Just)
* osd: fix stderr with -f or -d (Dan Mick)
* osd: misc FIEMAP fixes (Ma Jianpeng)
* osd: optimize Finisher (Xinze Chi)
* osd: store PG metadata in per-collection objects for better concurrency 
  (Sage Weil)
* pyrados: add object lock support (#6114 Mehdi Abaakouk)
* pyrados: fix misnamed wait_* routings (#10104 Dan Mick)
* pyrados: misc cleanups (Kefu Chai)
* qa: add large auth ticket tests (Ilya Dryomov)
* qa: many 'make check' improvements (Loic Dachary)
* qa: misc tests (Loic Dachary, Yan, Zheng)
* rgw: conditional PUT on ETag (#8562 Ray Lv)
* rgw: fix error codes (#10334 #10329 Yehuda Sadeh)
* rgw: index swift keys appropriately (#10471 Yehuda Sadeh)
* rgw: prevent illegal bucket policy that doesn't match placement rule 
  (Yehuda Sadeh)
* rgw: run radosgw as apache with systemd (#10125 Loic Dachary)
* rgw: support X-Storage-Policy header for Swift storage policy compat 
  (Yehuda Sadeh)
* rgw: use \r\n for http headers (#9254 Yehuda Sadeh)
* rpm: misc fixes (Key Dreyer)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.91.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
