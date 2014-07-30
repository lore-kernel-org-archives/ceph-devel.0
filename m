From: Sage Weil <sage@inktank.com>
Subject: v0.83 released
Date: Tue, 29 Jul 2014 18:21:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407291820100.5744@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55211 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbaG3BVF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 21:21:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@redhat.com

Another Ceph development release!  This has been a longer cycle, so there 
has been quite a bit of bug fixing and stabilization in this round.  
There is also a bunch of packaging fixes for RPM distros (RHEL/CentOS, 
Fedora, and SUSE) and for systemd.  We've also added a new 
librados-striper library from Sebastien Ponce that provides a generic 
striping API for applications to code to.

Upgrading
---------

* The experimental keyvaluestore-dev OSD backend had an on-disk format
  change that prevents existing OSD data from being upgraded.  This
  affects developers and testers only.

* mon-specific and osd-specific leveldb options have been removed.
  From this point onward users should use 'leveldb_' generic options and add
  the options in the appropriate sections of their configuration files.
  Monitors will still maintain the following monitor-specific defaults:

    leveldb_write_buffer_size = 32*1024*1024  = 33554432  // 32MB
    leveldb_cache_size        = 512*1024*1204 = 536870912 // 512MB
    leveldb_block_size        = 64*1024       = 65536     // 64KB
    leveldb_compression       = false
    leveldb_log               = ""

  OSDs will still maintain the following osd-specific defaults:

    leveldb_log               = ""

Notable Changes
---------------

* ceph-disk: fix dmcrypt support (Stephen Taylor)
* cephtool: fix help (Yilong Zhao)
* cephtool: test cleanup (Joao Eduardo Luis)
* doc: librados example fixes (Kevin Dalley)
* doc: many doc updates (John Wilkins)
* doc: update erasure docs (Loic Dachary, Venky Shankar)
* filestore: disable use of XFS hint (buggy on old kernels) (Samuel Just)
* filestore: fix xattr spillout (Greg Farnum, Haomai Wang)
* keyvaluestore: header cache (Haomai Wang)
* librados_striper: striping library for librados (Sebastien Ponce)
* libs3: update to latest (Danny Al-Gaaf)
* log: fix derr level (Joao Eduardo Luis)
* logrotate: fix osd log rotation on ubuntu (Sage Weil)
* mds: fix xattr bug triggered by ACLs (Yan, Zheng)
* misc memory leaks, cleanups, fixes (Danny Al-Gaaf, Sahid Ferdjaoui)
* misc suse fixes (Danny Al-Gaaf)
* misc word size fixes (Kevin Cox)
* mon: drop mon- and osd- specific leveldb options (Joao Eduardo Luis)
* mon: ec pool profile fixes (Loic Dachary)
* mon: fix health down messages (Sage Weil)
* mon: fix quorum feature check (#8738, Greg Farnum)
* mon: 'osd crush reweight-subtree ...' (Sage Weil)
* mon, osd: relax client EC support requirements (Sage Weil)
* mon: some instrumentation (Sage Weil)
* objecter: flag operations that are redirected by caching (Sage Weil)
* osd: clean up shard_id_t, shard_t (Loic Dachary)
* osd: fix connection reconnect race (Greg Farnum)
* osd: fix dumps (Joao Eduardo Luis)
* osd: fix erasure-code lib initialization (Loic Dachary)
* osd: fix extent normalization (Adam Crume)
* osd: fix loopback msgr issue (Ma Jianpeng)
* osd: fix LSB release parsing (Danny Al-Gaaf)
* osd: improved backfill priorities (Sage Weil)
* osd: many many core fixes (Samuel Just)
* osd, mon: config sanity checks on start (Sage Weil, Joao Eduardo Luis)
* osd: sharded threadpool to improve parallelism (Somnath Roy)
* osd: simple io prioritization for scrub (Sage Weil)
* osd: simple scrub throttling (Sage Weil)
* osd: tests for bench command (Loic Dachary)
* osd: use xfs hint less frequently (Ilya Dryomov)
* pybind/rados: fix small timeouts (John Spray)
* qa: xfstests updates (Ilya Dryomov)
* rgw: cache bucket info (Yehuda Sadeh)
* rgw: cache decoded user info (Yehuda Sadeh)
* rgw: fix multipart object attr regression (#8452, Yehuda Sadeh)
* rgw: fix radosgw-admin 'show log' command (#8553, Yehuda Sadeh)
* rgw: fix URL decoding (#8702, Brian Rak)
* rgw: handle empty extra pool name (Yehuda Sadeh)
* rpm: do not restart daemons on upgrade (Alfredo Deza)
* rpm: misc packaging fixes for rhel7 (Sandon Van Ness)
* rpm: split ceph-common from ceph (Sandon Van Ness)
* systemd: wrap started daemons in new systemd environment (Sage Weil, Dan 
  Mick)
* sysvinit: less sensitive to failures (Sage Weil)
* upstart: increase max open files limit (Sage Weil)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.83.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
