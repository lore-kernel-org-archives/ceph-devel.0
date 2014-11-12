From: Sage Weil <sweil@redhat.com>
Subject: v0.88 released
Date: Tue, 11 Nov 2014 16:24:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411111624020.22119@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56584 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbaKLAYr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Nov 2014 19:24:47 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

This is the first development release after Giant.  The two main
features merged this round are the new AsyncMessenger (an alternative
implementation of the network layer) from Haomai Wang at UnitedStack,
and support for POSIX file locks in ceph-fuse and libcephfs from Yan,
Zheng.  There is also a big pile of smaller items that re merged while
we were stabilizing Giant, including a range of smaller performance
and bug fixes and some new tracepoints for LTTNG.

Notable Changes
---------------

* ceph-disk: Scientific Linux support (Dan van der Ster)
* ceph-disk: respect --statedir for keyring (Loic Dachary)
* ceph-fuse, libcephfs: POSIX file lock support (Yan, Zheng)
* ceph-fuse, libcephfs: fix cap flush overflow (Greg Farnum, Yan, Zheng)
* ceph-fuse, libcephfs: fix root inode xattrs (Yan, Zheng)
* ceph-fuse, libcephfs: preserve dir ordering (#9178 Yan, Zheng)
* ceph-fuse, libcephfs: trim inodes before reconnecting to MDS (Yan, 
  Zheng)
* ceph: do not parse injectargs twice (Loic Dachary)
* ceph: make 'ceph -s' output more readable (Sage Weil)
* ceph: new 'ceph tell mds.$name_or_rank_or_gid' (John Spray)
* ceph: test robustness (Joao Eduardo Luis)
* ceph_objectstore_tool: behave with sharded flag (#9661 David Zafman)
* cephfs-journal-tool: fix journal import (#10025 John Spray)
* cephfs-journal-tool: skip up to expire_pos (#9977 John Spray)
* cleanup rados.h definitions with macros (Ilya Dryomov)
* common: shared_cache unit tests (Cheng Cheng)
* config: add $cctid meta variable (Adam Crume)
* crush: fix buffer overrun for poorly formed rules (#9492 Johnu George)
* crush: improve constness (Loic Dachary)
* crushtool: add --location <id> command (Sage Weil, Loic Dachary)
* default to libnss instead of crypto++ (Federico Gimenez)
* doc: ceph osd reweight vs crush weight (Laurent Guerby)
* doc: document the LRC per-layer plugin configuration (Yuan Zhou)
* doc: erasure code doc updates (Loic Dachary)
* doc: misc updates (Alfredo Deza, VRan Liu)
* doc: preflight doc fixes (John Wilkins)
* doc: update PG count guide (Gerben Meijer, Laurent Guerby, Loic Dachary)
* keyvaluestore: misc fixes (Haomai Wang)
* keyvaluestore: performance improvements (Haomai Wang)
* librados: add rados_pool_get_base_tier() call (Adam Crume)
* librados: cap buffer length (Loic Dachary)
* librados: fix objecter races (#9617 Josh Durgin)
* libradosstriper: misc fixes (Sebastien Ponce)
* librbd: add missing python docstrings (Jason Dillaman)
* librbd: add readahead (Adam Crume)
* librbd: fix cache tiers in list_children and snap_unprotect (Adam Crume)
* librbd: fix performance regression in ObjectCacher (#9513 Adam Crume)
* librbd: lttng tracepoints (Adam Crume)
* librbd: misc fixes (Xinxin Shu, Jason Dillaman)
* mds: fix sessionmap lifecycle bugs (Yan, Zheng)
* mds: initialize root inode xattr version (Yan, Zheng)
* mds: introduce auth caps (John Spray)
* mds: misc bugs (Greg Farnum, John Spray, Yan, Zheng, Henry Change)
* misc coverity fixes (Danny Al-Gaaf)
* mon: add 'ceph osd rename-bucket ...' command (Loic Dachary)
* mon: clean up auth list output (Loic Dachary)
* mon: fix 'osd crush link' id resolution (John Spray)
* mon: fix misc error paths (Joao Eduardo Luis)
* mon: fix paxos off-by-one corner case (#9301 Sage Weil)
* mon: new 'ceph pool ls [detail]' command (Sage Weil)
* mon: wait for writeable before cross-proposing (#9794 Joao Eduardo Luis)
* msgr: avoid useless new/delete (Haomai Wang)
* msgr: fix delay injection bug (#9910 Sage Weil, Greg Farnum)
* msgr: new AsymcMessenger alternative implementation (Haomai Wang)
* msgr: prefetch data when doing recv (Yehuda Sadeh)
* osd: add erasure code corpus (Loic Dachary)
* osd: add misc tests (Loic Dachary, Danny Al-Gaaf)
* osd: cleanup boost optionals (William Kennington)
* osd: expose non-journal backends via ceph-osd CLI (Hoamai Wang)
* osd: fix JSON output for stray OSDs (Loic Dachary)
* osd: fix ioprio options (Loic Dachary)
* osd: fix transaction accounting (Jianpeng Ma)
* osd: misc optimizations (Xinxin Shu, Zhiqiang Wang, Xinze Chi)
* osd: use FIEMAP_FLAGS_SYNC instead of fsync (Jianpeng Ma)
* rados: fix put of /dev/null (Loic Dachary)
* rados: parse command-line arguments more strictly (#8983 Adam Crume)
* rbd-fuse: fix memory leak (Adam Crume)
* rbd-replay-many (Adam Crume)
* rbd-replay: --anonymize flag to rbd-replay-prep (Adam Crume)
* rbd: fix 'rbd diff' for non-existent objects (Adam Crume)
* rbd: fix error when striping with format 1 (Sebastien Han)
* rbd: fix export for image sizes over 2GB (Vicente Cheng)
* rbd: use rolling average for rbd bench-write throughput (Jason Dillaman)
* rgw: send explicit HTTP status string (Yehuda Sadeh)
* rgw: set length for keystone token validation request (#7796 Yehuda 
  Sadeh, Mark Kirkwood)
* udev: fix rules for CentOS7/RHEL7 (Loic Dachary)
* use clock_gettime instead of gettimeofday (Jianpeng Ma)
* vstart.sh: set up environment for s3-tests (Luis Pabon)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.88.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
