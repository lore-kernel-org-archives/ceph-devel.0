From: Abhishek <abhishek@suse.com>
Subject: Luminous v12.2.1 released
Date: Thu, 28 Sep 2017 17:46:30 +0200
Message-ID: <1b8b25baf4d8e5c661bf56d50ee17aa5@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750955AbdI1Pqb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 28 Sep 2017 11:46:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

This is the first bugfix release of Luminous v12.2.x long term stable
release series. It contains a range of bug fixes and a few features
across CephFS, RBD & RGW. We recommend all the users of 12.2.x series
update.

For more details, refer to the release notes entry at the official
blog[1] and the complete changelog[2]

Notable Changes
---------------

* Dynamic resharding is now enabled by default for RGW, RGW will now
    automatically reshard there bucket index once the index grows beyond
    `rgw_max_objs_per_shard`

* Limiting MDS cache via a memory limit is now supported using the new
    mds_cache_memory_limit config option (1GB by default).  A cache
reservation
    can also be specified using mds_cache_reservation as a percentage of
the
    limit (5% by default). Limits by inode count are still supported 
using
    mds_cache_size. Setting mds_cache_size to 0 (the default) disables 
the
    inode limit.

* The maximum number of PGs per OSD before the monitor issues a
    warning has been reduced from 300 to 200 PGs.  200 is still twice
    the generally recommended target of 100 PGs per OSD.  This limit can
    be adjusted via the ``mon_max_pg_per_osd`` option on the
    monitors.  The older ``mon_pg_warn_max_per_osd`` option has been
removed.

* Creating pools or adjusting pg_num will now fail if the change would
    make the number of PGs per OSD exceed the configured
    ``mon_max_pg_per_osd`` limit.  The option can be adjusted if it
    is really necessary to create a pool with more PGs.

* There was a bug in the PG mapping behavior of the new *upmap*
    feature. If you made use of this feature (e.g., via the `ceph osd
    pg-upmap-items` command), we recommend that all mappings be removed
(via
    the `ceph osd rm-pg-upmap-items` command) before upgrading to this
    point release.

* A stall in BlueStore IO submission that was affecting many users has
    been resolved.

Other Notable Changes
---------------------
* bluestore: asyn cdeferred_try_submit deadlock (issue#21207, pr#17494,
Sage Weil)
* bluestore: fix deferred write deadlock, aio short return handling
(issue#21171, pr#17601, Sage Weil)
* bluestore: osd crash when change option bluestore_csum_type from none
to CRC32 (issue#21175, pr#17497, xie xingguo)
* bluestore: os/bluestore/BlueFS.cc: 1255: FAILED
assert(!log_file->fnode.extents.empty()) (issue#21250, pr#17562, Sage
Weil)
* build/ops: ceph-fuse RPM should require fusermount (issue#21057,
pr#17470, Ken Dreyer)
* build/ops: RHEL 7.3 Selinux denials at OSD start (issue#19200,
pr#17468, Boris Ranto)
* build/ops: rocksdb,cmake:  build portable binaries (issue#20529,
pr#17745, Kefu Chai)
* cephfs: client/mds has wrong check to clear S_ISGID on chown
(issue#21004, pr#17471, Patrick Donnelly)
* cephfs: get_quota_root sends lookupname op for every buffered write
(issue#20945, pr#17473, Dan van der Ster)
* cephfs: MDCache::try_subtree_merge() may print N^2 lines of debug
message (issue#21221, pr#17712, Patrick Donnelly)
* cephfs: MDS rank add/remove log messages say wrong number of ranks
(issue#21421, pr#17887, John Spray)
* cephfs: MDS: standby-replay mds should avoid initiating subtree export
(issue#21378, issue#21222, pr#17714, "Yan, Zheng", Jianyu Li)
* cephfs: the standbys are not updated via ceph tell mds.\* command
(issue#21230, pr#17565, Kefu Chai)
* common: adding line break at end of some cli results (issue#21019,
pr#17467, songweibin)
* core: [cls] metadata_list API function does not honor `max_return`
parameter (issue#21247, pr#17558, Jason Dillaman)
* core: incorrect erasure-code space in command ceph df (issue#21243,
pr#17724, liuchang0812)
* core: interval_set: optimize intersect_of insert operations
(issue#21229, pr#17487, Zac Medico)
* core: osd crush rule rename not idempotent (issue#21162, pr#17481, xie
xingguo)
* core: osd/PGLog: write only changed dup entries (issue#21026,
pr#17378, Josh Durgin)
* doc: doc/rbd: iSCSI Gateway Documentation (issue#20437, pr#17381, Aron
Gunn, Jason Dillaman)
* mds: fix 'dirfrag end' check in Server::handle_client_readdir
(issue#21070, pr#17686, "Yan, Zheng")
* mds: support limiting cache by memory (issue#20594, pr#17711, "Yan,
Zheng", Patrick Donnelly)
* mgr: 500 error when attempting to view filesystem data (issue#20692,
pr#17477, John Spray)
* mgr: ceph mgr versions shows active mgr as Unknown (issue#21260,
pr#17635, John Spray)
* mgr: Crash in MonCommandCompletion (issue#21157, pr#17483, John Spray)
* mon: mon/OSDMonitor: deleting pool while pgs are being created leads
to assert(p != pools.end) in update_creating_pgs() (issue#21309,
pr#17634, Joao Eduardo Luis)
* mon: OSDMonitor: osd pool application get support (issue#20976,
pr#17472, xie xingguo)
* mon: rate limit on health check update logging (issue#20888, pr#17500,
John Spray)
* osd: build_initial_pg_history doesn't update up/acting/etc
(issue#21203, pr#17496, w11979, Sage Weil)
* osd: osd/PG: discard msgs from down peers (issue#19605, pr#17501, Kefu
Chai)
* osd/PrimaryLogPG: request osdmap update in the right block
(issue#21428, pr#17829, Josh Durgin)
* osd: PrimaryLogPG: sparse read won't trigger repair correctly
(issue#21123, pr#17475, xie xingguo)
* osd: request new map from PG when needed (issue#21428, pr#17796, Josh
Durgin)
* osd: Revert "osd/OSDMap: allow bidirectional swap of pg-upmap-items"
(issue#21410, pr#17812, Sage Weil)
* osd: subscribe to new osdmap while waiting_for_healthy (issue#21121,
pr#17498, Sage Weil)
* osd: update info only if new_interval (issue#21203, pr#17622, Kefu
Chai)
* pybind: dashboard usage graph getting bigger and bigger (issue#20746,
pr#17486, Yixing Yan)
* rbd: image-meta list does not return all entries (issue#21179,
pr#17561, Jason Dillaman)
* rbd: some generic options can not be passed by rbd-nbd (issue#20426,
pr#17557, Pan Liu)
* rbd: switch to new config option getter methods (issue#20737,
pr#17464, Jason Dillaman)
* rbd: TestMirroringWatcher.ModeUpdated: periodic failure due to
injected message failures (issue#21029, pr#17465, Jason Dillaman)
* rgw: bucket index sporadically reshards to 65521 shards (issue#20934,
pr#17476, Aleksei Gutikov)
* rgw: bytes_send and bytes_recv in the msg of usage show returning is 0
in master branch (issue#19870, pr#17444, Marcus Watts)
* rgw: data encryption sometimes fails to follow AWS settings
(issue#21349, pr#17642, hechuang)
* rgw: memory leak in MetadataHandlers (issue#21214, pr#17570, Luo
Kexue, Jos Collin)
* rgw: multisite: objects encrypted with SSE-KMS are stored unencrypted
in target zone (issue#20668, issue#20671, pr#17446, Casey Bodley)
* rgw: need to stream metadata full sync init (issue#18079, pr#17448,
Yehuda Sadeh)
* rgw: object copied from remote src acl permission become full-control
issue (issue#20658, pr#17478, Enming Zhang)
* rgw: put lifecycle configuration fails if Prefix is not set
(issue#19587, issue#20872, pr#17479, Shasha Lu, Abhishek Lekshmanan)
* rgw: rgw_file:  incorrect lane lock behavior in evict_block()
(issue#21141, pr#17485, Matt Benjamin)
* rgw: send data-log list infinitely (issue#20951, pr#17445,
fang.yuxiang)
* rgw: shadow objects are sometimes not removed (issue#20234, pr#17555,
Yehuda Sadeh)
* rgw: usage of --inconsistent-index should require user confirmation
and print a warning (issue#20777, pr#17488, Orit Wasserman)
* tools: [cli] rename of non-existent image results in seg fault
(issue#21248, pr#17556, Jason Dillaman)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-12.2.1.tar.gz
* For packages, see
http://docs.ceph.com/docs/master/install/get-packages/
* For ceph-deploy, see
http://docs.ceph.com/docs/master/install/install-ceph-deploy
* Release SHA1: 3e7492b9ada8bdc9a5cd0feafd42fbca27f9c38e

[1]: http://ceph.com/releases/v12-2-1-luminous-released/
[2]: https://github.com/ceph/ceph/blob/master/doc/changelog/v12.2.1.txt

Best,
Abhishek

