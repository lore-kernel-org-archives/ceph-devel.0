From: Sage Weil <sage@redhat.com>
Subject: v9.0.2 released
Date: Thu, 16 Jul 2015 12:19:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507161218240.12319@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55195 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbbGPTT3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jul 2015 15:19:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-announce@ceph.com, ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

This development release features more of the OSD work queue
unification, randomized osd scrub times, a huge pile of librbd fixes,
more MDS repair and snapshot fixes, and a significant amount of work
on the tests and build infrastructure.

Notable Changes
---------------

* buffer: some cleanup (Michal Jarzabek)
* build: cmake: fix nss linking (Danny Al-Gaaf)
* build: cmake: misc fixes (Orit Wasserman, Casey Bodley)
* build: install-deps: misc fixes (Loic Dachary)
* build: make_dist_tarball.sh (Sage Weil)
* ceph-detect-init: added Linux Mint (Michal Jarzabek)
* ceph-detect-init: robust init system detection (Owen Synge)
* ceph-disk: ensure 'zap' only operates on a full disk (#11272 Loic 
  Dachary)
* ceph-disk: misc fixes to respect init system (Loic Dachary, Owen Synge)
* ceph-disk: support NVMe device partitions (#11612 Ilja Slepnev)
* ceph: fix 'df' units (Zhe Zhang)
* ceph: fix parsing in interactive cli mode (#11279 Kefu Chai)
* ceph-objectstore-tool: many many changes (David Zafman)
* ceph-post-file: misc fixes (Joey McDonald, Sage Weil)
* client: avoid sending unnecessary FLUSHSNAP messages (Yan, Zheng)
* client: exclude setfilelock when calculating oldest tid (Yan, Zheng)
* client: fix error handling in check_pool_perm (John Spray)
* client: fsync waits only for inode's caps to flush (Yan, Zheng)
* client: invalidate kernel dcache when cache size exceeds limits (Yan, 
  Zheng)
* client: make fsync wait for unsafe dir operations (Yan, Zheng)
* client: pin lookup dentry to avoid inode being freed (Yan, Zheng)
* common: detect overflow of int config values (#11484 Kefu Chai)
* common: fix json parsing of utf8 (#7387 Tim Serong)
* common: fix leak of pthread_mutexattr (#11762 Ketor Meng)
* crush: respect default replicated ruleset config on map creation (Ilya 
  Dryomov)
* deb, rpm: move ceph-objectstore-tool to ceph (Ken Dreyer)
* doc: man page updates (Kefu Chai)
* doc: misc updates (#11396 Nilamdyuti, Fracois Lafont, Ken Dreyer, Kefu 
  Chai)
* init-radosgw: merge with sysv version; fix enumeration (Sage Weil)
* librados: add config observer (Alistair Strachan)
* librbd: add const for single-client-only features (Josh Durgin)
* librbd: add deep-flatten operation (Jason Dillaman)
* librbd: avoid blocking aio API methods (#11056 Jason Dillaman)
* librbd: fix fast diff bugs (#11553 Jason Dillaman)
* librbd: fix image format detection (Zhiqiang Wang)
* librbd: fix lock ordering issue (#11577 Jason Dillaman)
* librbd: flatten/copyup fixes (Jason Dillaman)
* librbd: lockdep, helgrind validation (Jason Dillaman, Josh Durgin)
* librbd: only update image flags while hold exclusive lock (#11791 Jason 
  Dillaman)
* librbd: return result code from close (#12069 Jason Dillaman)
* librbd: tolerate old osds when getting image metadata (#11549 Jason 
  Dillaman)
* mds: do not add snapped items to bloom filter (Yan, Zheng)
* mds: fix handling for missing mydir dirfrag (#11641 John Spray)
* mds: fix rejoin (Yan, Zheng)
* mds: fix stra reintegration (Yan, Zheng)
* mds: fix suicide beason (John Spray)
* mds: misc repair improvements (John Spray)
* mds: misc snapshot fixes (Yan, Zheng)
* mds: respawn instead of suicide on blacklist (John Spray)
* misc coverity fixes (Danny Al-Gaaf)
* mon: add 'mon_metadata <id>' command (Kefu Chai)
* mon: add 'node ls ...' command (Kefu Chai)
* mon: disallow ec pools as tiers (#11650 Samuel Just)
* mon: fix mds beacon replies (#11590 Kefu Chai)
* mon: fix 'pg ls' sort order, state names (#11569 Kefu Chai)
* mon: normalize erasure-code profile for storage and comparison (Loic 
  Dachary)
* mon: optionally specify osd id on 'osd create' (Mykola Golub)
* mon: 'osd tree' fixes (Kefu Chai)
* mon: prevent pool with snapshot state from being used as a tier (#11493 
  Sage Weil)
* mon: refine check_remove_tier checks (#11504 John Spray)
* mon: remove spurious who arg from 'mds rm ...' (John Spray)
* msgr: async: misc fixes (Haomai Wang)
* msgr: xio: fix ip and nonce (Raju Kurunkad)
* msgr: xio: improve lane assignment (Vu Pham)
* msgr: xio: misc fixes (Vu Pham, Cosey Bodley)
* osd: avoid transaction append in some cases (Sage Weil)
* osdc/Objecter: allow per-pool calls to op_cancel_writes (John Spray)
* osd: elminiate txn apend, ECSubWrite copy (Samuel Just)
* osd: filejournal: cleanup (David Zafman)
* osd: fix check_for_full (Henry Chang)
* osd: fix dirty accounting in make_writeable (Zhiqiang Wang)
* osd: fix osdmap dump of blacklist items (John Spray)
* osd: fix snap flushing from cache tier (again) (#11787 Samuel Just)
* osd: fix snap handling on promotion (#11296 Sam Just)
* osd: handle log split with overlapping entries (#11358 Samuel Just)
* osd: keyvaluestore: misc fixes (Varada Kari)
* osd: make suicide timeouts individually configurable (Samuel Just)
* osd: move scrub in OpWQ (Samuel Just)
* osd: pool size change triggers new interval (#11771 Samuel Just)
* osd: randomize scrub times (#10973 Kefu Chai)
* osd: refactor scrub and digest recording (Sage Weil)
* osd: refuse first write to EC object at non-zero offset (Jianpeng Ma)
* osd: stripe over small xattrs to fit in XFS's 255 byte inline limit 
  (Sage Weil, Ning Yao)
* osd: sync object_map on syncfs (Samuel Just)
* osd: take excl lock of op is rw (Samuel Just)
* osd: WBThrottle cleanups (Jianpeng Ma)
* pycephfs: many fixes for bindings (Haomai Wang)
* rados: bench: add --no-verify option to improve performance (Piotr 
  Dalek)
* rados: misc bench fixes (Dmitry Yatsushkevich)
* rbd: add disk usage tool (#7746 Jason Dillaman)
* rgw: alwasy check if token is expired (#11367 Anton Aksola, Riku Lehto)
* rgw: conversion tool to repair broken multipart objects (#12079 Yehuda 
  Sadeh)
* rgw: do not enclose bucket header in quotes (#11860 Wido den Hollander)
* rgw: error out if frontend did not send all data (#11851 Yehuda Sadeh)
* rgw: fix assignment of copy obj attributes (#11563 Yehuda Sadeh)
* rgw: fix reset_loc (#11974 Yehuda Sadeh)
* rgw: improve content-length env var handling (#11419 Robin H. Johnson)
* rgw: only scan for objects not in a namespace (#11984 Yehuda Sadeh)
* rgw: remove trailing :port from HTTP_HOST header (Sage Weil)
* rgw: shard work over multiple librados instances (Pavan Rallabhandi)
* rgw: swift: enforce Content-Type in response (#12157 Radoslaw Zarzynski)
* rgw: use attrs from source bucket on copy (#11639 Javier M. Mellid)
* rocksdb: pass options as single string (Xiaoxi Chen)
* rpm: many spec file fixes (Owen Synge, Ken Dreyer)
* tests: fixes for rbd xstests (Douglas Fuller)
* tests: fix tiering health checks (Loic Dachary)
* tests for low-level performance (Haomai Wang)
* tests: many ec non-regression improvements (Loic Dachary)
* tests: many many ec test improvements (Loic Dachary)
* upstart: throttle restarts (#11798 Sage Weil, Greg Farnum)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-9.0.2.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
