From: Sage Weil <sage@inktank.com>
Subject: v0.86 released (Giant release candidate)
Date: Tue, 7 Oct 2014 12:20:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410071028030.13976@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39974 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbaJGTU0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Oct 2014 15:20:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

This is a release candidate for Giant, which will hopefully be out in 
another week or two (s v0.86).  We did a feature freeze about a month ago 
and since then have been doing only stabilization and bug fixing (and a 
handful on low-risk enhancements).  A fair bit of new functionality went 
into the final sprint, but it's baked for quite a while now and we're 
feeling pretty good about it.

Major items include:

* librados locking refactor to improve scaling and client performance
* local recovery code (LRC) erasure code plugin to trade some
  additional storage overhead for improved recovery performance
* LTTNG tracing framework, with initial tracepoints in librados,
  librbd, and the OSD FileStore backend
* separate monitor audit log for all administrative commands
* asynchronos monitor transaction commits to reduce the impact on
  monitor read requests while processing updates
* low-level tool for working with individual OSD data stores for
  debugging, recovery, and testing
* many MDS improvements (bug fixes, health reporting)

There are still a handful of known bugs in this release, but nothing
severe enough to prevent a release.  By and large we are pretty
pleased with the stability and expect the final Giant release to be
quite reliable.

Please try this out on your non-production clusters for a preview.

Notable Changes
---------------

* buffer: improve rebuild_page_aligned (Ma Jianpeng)
* build: fix CentOS 5 (Gerben Meijer)
* build: fix build on alpha (Michael Cree, Dmitry Smirnov)
* build: fix yasm check for x32 (Daniel Schepler, Sage Weil)
* ceph-disk: add Scientific Linux support (Dan van der Ster)
* ceph-fuse, libcephfs: fix crash in trim_caps (John Spray)
* ceph-fuse, libcephfs: improve cap trimming (John Spray)
* ceph-fuse, libcephfs: virtual xattrs for rstat (Yan, Zheng)
* ceph.conf: update sample (Sebastien Han)
* ceph.spec: many fixes (Erik Logtenberg, Boris Ranto, Dan Mick, Sandon Van Ness)
* ceph_objectstore_tool: vastly improved and extended tool for working offline with OSD data stores (David Zafman)
* common: add config diff admin socket command (Joao Eduardo Luis)
* common: add rwlock assertion checks (Yehuda Sadeh)
* crush: clean up CrushWrapper interface (Xioaxi Chen)
* crush: make ruleset ids unique (Xiaoxi Chen, Loic Dachary)
* doc: improve manual install docs (Francois Lafont)
* doc: misc updates (John Wilkins, Loic Dachary, David Moreau Simard, Wido den Hollander. Volker Voigt, Alfredo Deza, Stephen Jahl, Dan van der Ster)
* global: write pid file even when running in foreground (Alexandre Oliva)
* hadoop: improve tests (Huamin Chen, Greg Farnum, John Spray)
* journaler: fix locking (Zheng, Yan)
* librados, osd: return ETIMEDOUT on failed notify (Sage Weil)
* librados: fix crash on read op timeout (#9362 Matthias Kiefer, Sage Weil)
* librados: fix shutdown race (#9130 Sage Weil)
* librados: fix watch reregistration on acting set change (#9220 Samuel Just)
* librados: fix watch/notify test (#7934 David Zafman)
* librados: give Objecter fine-grained locks (Yehuda Sadeh, Sage Weil, John Spray)
* librados: lttng tracepoitns (Adam Crume)
* librados: pybind: fix reads when \0 is present (#9547 Mohammad Salehe)
* librbd: enforce cache size on read requests (Jason Dillaman)
* librbd: handle blacklisting during shutdown (#9105 John Spray)
* librbd: lttng tracepoints (Adam Crume)
* lttng: tracing infrastructure (Noah Watkins, Adam Crume)
* mailmap: updates (Loic Dachary, Abhishek Lekshmanan, M Ranga Swami Reddy)
* many many coverity fixes, cleanups (Danny Al-Gaaf)
* mds: adapt to new Objecter locking, give types to all Contexts (John Spray)
* mds: add internal health checks (John Spray)
* mds: avoid tight mon reconnect loop (#9428 Sage Weil)
* mds: fix crash killing sessions (#9173 John Spray)
* mds: fix ctime updates (#9514 Greg Farnum)
* mds: fix replay locking (Yan, Zheng)
* mds: fix standby-replay cache trimming (#8648 Zheng, Yan)
* mds: give perfcounters meaningful names (Sage Weil)
* mds: improve health reporting to monitor (John Spray)
* mds: improve journal locking (Zheng, Yan)
* mds: make max file recoveries tunable (Sage Weil)
* mds: prioritize file recovery when appropriate (Sage Weil)
* mds: refactor beacon, improve reliability (John Spray)
* mds: restart on EBLACKLISTED (John Spray)
* mds: track RECALL progress, report failure (#9284 John Spray)
* mds: update segment references during journal write (John Spray, Greg Farnum)
* mds: use meaningful names for clients (John Spray)
* mds: warn clients which aren't revoking caps (Zheng, Yan, John Spray)
* mon: add 'osd reweight-by-pg' command (Sage Weil, Guang Yang)
* mon: add audit log for all admin commands (Joao Eduardo Luis)
* mon: add cluster fingerprint (Sage Weil)
* mon: avoid creating unnecessary rule on pool create (#9304 Loic Dachary)
* mon: do not spam log (Aanchal Agrawal, Sage Weil)
* mon: fix 'osd perf' reported latency (#9269 Samuel Just)
* mon: fix double-free of old MOSDBoot (Sage Weil)
* mon: fix op write latency perfcounter (#9217 Xinxin Shu)
* mon: fix store check on startup (Joao Eduardo Luis)
* mon: make paxos transaction commits asynchronous (Sage Weil)
* mon: preload erasure plugins (#9153 Loic Dachary)
* mon: prevent cache pools from being used directly by CephFS (#9435 John Spray)
* mon: use user-provided ruleset for replicated pool (Xiaoxi Chen)
* mon: verify available disk space on startup (#9502 Joao Eduardo Luis)
* mon: verify erasure plugin version on load (Loic Dachary)
* msgr: fix logged address (Yongyue Sun)
* osd: account for hit_set_archive bytes (Sage Weil)
* osd: add ISA erasure plugin table cache (Andreas-Joachim Peters)
* osd: add ability to prehash filestore directories (Guang Yang)
* osd: add feature bit for erasure plugins (Loic Dachary)
* osd: add local recovery code (LRC) erasure plugin (Loic Dachary)
* osd: cap hit_set size (#9339 Samuel Just)
* osd: clear FDCache on unlink (#8914 Loic Dachary)
* osd: do not evict blocked objects (#9285 Zhiqiang Wang)
* osd: fix ISA erasure alignment (Loic Dachary, Andreas-Joachim Peters)
* osd: fix clone vs cache_evict bug (#8629 Sage Weil)
* osd: fix crash from duplicate backfill reservation (#8863 Sage Weil)
* osd: fix dead peer connection checks (#9295 Greg Farnum, Sage Weil)
* osd: fix keyvaluestore scrub (#8589 Haomai Wang)
* osd: fix keyvaluestore upgrade (Haomai Wang)
* osd: fix min_read_recency_for_promote default on upgrade (Zhiqiang Wang)
* osd: fix mount/remount sync race (#9144 Sage Weil)
* osd: fix purged_snap initialization on backfill (Sage Weil, Samuel Just, Dan van der Ster, Florian Haas)
* osd: fix race condition on object deletion (#9480 Somnath Roy)
* osd: fix snap object writeback from cache tier (#9054 Samuel Just)
* osd: improve journal shutdown (Ma Jianpeng, Mark Kirkwood)
* osd: improve locking in OpTracker (Pavan Rallabhandi, Somnath Roy)
* osd: improve tiering agent arithmetic (Zhiqiang Wang, Sage Weil, Samuel Just)
* osd: lttng tracepoints for filestore (Noah Watkins)
* osd: make blacklist encoding deterministic (#9211 Sage Weil)
* osd: many many important fixes (#8231 #8315 #9113 #9179 #9293 #9294 #9326 #9453 #9481 #9482 #9497 #9574 Samuel Just)
* osd: misc erasure code plugin fixes (Loic Dachary)
* osd: preload erasure plugins (#9153 Loic Dachary)
* osd: shard OpTracker to improve performance (Somnath Roy)
* osd: use local time for tiering decisions (Zhiqiang Wang)
* osd: verify erasure plugin version on load (Loic Dachary)
* rados: fix bench write arithmetic (Jiangheng)
* rbd: parallelize rbd import, export (Jason Dillaman)
* rbd: rbd-replay utility to replay captured rbd workload traces (Adam Crume)
* rbd: use write-back (not write-through) when caching is enabled (Jason Dillaman)
* rgw: add S3 bucket get location operation (Abhishek Lekshmanan)
* rgw: add civetweb as default frontent on port 7490 (#9013 Yehuda Sadeh)
* rgw: allow : in S3 access key (Roman Haritonov)
* rgw: fix admin create user op (#8583 Ray Lv)
* rgw: fix log filename suffix (#9353 Alexandre Marangone)
* rgw: fix usage (Abhishek Lekshmanan)
* rgw: many fixes for civetweb (Yehuda Sadeh)
* rgw: subuser creation fixes (#8587 Yehuda Sadeh)
* rgw: use systemd-run from sysvinit script (JuanJose Galvez)
* unit test improvements (Loic Dachary)
* vstart.sh: fix/improve rgw support (Luis Pabon, Abhishek Lekshmanan)


Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.86.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
