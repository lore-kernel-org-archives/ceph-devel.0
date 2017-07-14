From: Nathan Cutler <ncutler@suse.cz>
Subject: v10.2.8 Jewel released
Date: Fri, 14 Jul 2017 22:46:54 +0200
Message-ID: <04b2a1cb-481a-ee6d-db26-577578be8300@suse.cz>
References: <333d2b6c-f2d7-69a2-a879-4f321006e765@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750853AbdGNUq4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 14 Jul 2017 16:46:56 -0400
In-Reply-To: <333d2b6c-f2d7-69a2-a879-4f321006e765@suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com
Cc: Abhishek Lekshmanan <abhishek@suse.com>

v10.2.8 Jewel released
======================

This point release brought a number of important bugfixes in all major
components of Ceph. However, it also introduced a regression that
could cause MDS damage, and a new release, v10.2.9, was published to
address this.  Therefore, Jewel users should not upgrade to this
version – instead, we recommend upgrading directly to v10.2.9.

That being said, the v10.2.8 release notes do contain important
information, so please read on.

For more detailed information, refer to the complete changelog[1] and
the release notes[2].

OSD Removal Caveat
------------------

There was a bug introduced in Jewel (#19119) that broke the mapping
behavior when an “out” OSD that still existed in the CRUSH map was
removed with ‘osd rm’.  This could result in ‘misdirected op’ and
other errors. The bug is now fixed, but the fix itself introduces the
same risk because the behavior may vary between clients and OSDs. To
avoid problems, please ensure that all OSDs are removed from the CRUSH
map before deleting them. That is, be sure to do:

    ceph osd crush rm osd.123

before:

    ceph osd rm osd.123

Snap Trimmer Improvements
-------------------------

This release greatly improves control and throttling of the snap
trimmer. It introduces the “osd max trimming pgs” option (defaulting
to 2), which limits how many PGs on an OSD can be trimming snapshots
at a time. And it restores the safe use of the “osd snap trim sleep”
option, wihch defaults to 0 but otherwise adds the given number of
seconds in delay between every dispatch of trim operations to the
underlying system.

Other Notable Changes
---------------------

* build/ops: “osd marked itself down” will not recognised if host runs
   mon + osd on shutdown/reboot (pr#13492, Boris Ranto)
* build/ops: ceph-base package missing dependency for psmisc
   (pr#13786, Nathan Cutler)
* build/ops: enable build of ceph-resource-agents package on rpm-based
   os (pr#13606, Nathan Cutler)
* build/ops: rbdmap.service not included in debian packaging
   (jewel-only) (pr#14383, Ken Dreyer)
* cephfs: Journaler may execute on_safe contexts prematurely
   (pr#15468, “Yan, Zheng”)
* cephfs: MDS assert failed when shutting down (issue#19204, pr#14683,
   John Spray)
* cephfs: MDS goes readonly writing backtrace for a file whose data
   pool has been removed (pr#14682, John Spray)
* cephfs: MDS server crashes due to inconsistent metadata (pr#14676,
   John Spray)
* cephfs: No output for ceph mds rmfailed 0 –yes-i-really-mean-it
   command (pr#14674, John Spray)
* cephfs: Test failure: test_data_isolated
   (tasks.cephfs.test_volume_client.TestVolumeClient) (pr#14685, “Yan,
   Zheng”)
* cephfs: Test failure: test_open_inode (issue#18661, pr#14669, John
   Spray)
* cephfs: The mount point break off when mds switch hanppened
   (pr#14679, Guan yunfei)
* cephfs: ceph-fuse does not recover after lost connection to MDS
   (pr#14698, Kefu Chai, Henrik Korkuc, Patrick Donnelly)
* cephfs: client: fix the cross-quota rename boundary check conditions
   (pr#14667, Greg Farnum)
* cephfs: mds is crushed, after I set about 400 64KB xattr kv pairs to
   a file (pr#14684, Yang Honggang)
* cephfs: non-local quota changes not visible until some IO is done
   (pr#15466, John Spray, Nathan Cutler)
* cephfs: normalize file open flags internally used by cephfs
   (pr#15000, Jan Fajerski, “Yan, Zheng”)
* common: monitor creation with IPv6 public network segfaults
   (pr#14324, Fabian Grünbichler)
* common: radosstriper: protect aio_write API from calls with 0 bytes
   (pr#13254, Sebastien Ponce)
* core: Objecter::epoch_barrier isn’t respected in _op_submit()
   (pr#14332, Ilya Dryomov)
* core: clear divergent_priors set off disk (issue#17916, pr#14596,
   Greg Farnum)
* core: improve snap trimming, enable restriction of parallelism
   (pr#14492, Samuel Just, Greg Farnum)
* core: os/filestore/HashIndex: be loud about splits (pr#13788, Dan
   van der Ster)
* core: os/filestore: fix clang static check warn use-after-free
   (pr#14044, liuchang0812, yaoning)
* core: transient jerasure unit test failures (issue#18070,
   issue#17951, pr#14701, Kefu Chai, Pan Liu, Loic Dachary, Jason
   Dillaman)
* core: two instances of omap_digest mismatch (issue#18533, pr#14204,
   Samuel Just, David Zafman)
* doc: Improvements to crushtool manpage (issue#19649, pr#14635, Loic
   Dachary, Nathan Cutler)
* doc: PendingReleaseNotes: note about 19119 (issue#19119, pr#13732,
   Sage Weil)
* doc: admin ops: fix the quota section (issue#19397, pr#14654, Chu,
   Hua-Rong)
* doc: radosgw-admin: add the ‘object stat’ command to usage
   (pr#13872, Pavan Rallabhandi)
* doc: rgw S3 create bucket should not do response in json (pr#13874,
   Abhishek Lekshmanan)
* fs: Invalid error code returned by MDS is causing a kernel client
   WARNING (pr#13831, Jan Fajerski, xie xingguo)
* librbd: Incomplete declaration for ContextWQ in librbd/Journal.h
   (pr#14152, Boris Ranto)
* librbd: Issues with C API image metadata retrieval functions
   (pr#14666, Mykola Golub)
* librbd: Possible deadlock performing a synchronous API action while
   refresh in-progress (pr#13154, Jason Dillaman)
* librbd: is_exclusive_lock_owner API should ping OSD (pr#14481, Jason
   Dillaman)
* librbd: remove image header lock assertions (issue#18244, pr#13809,
   Jason Dillaman)
* mds: C_MDSInternalNoop::complete doesn’t free itself (pr#14677,
   “Yan, Zheng”)
* mds: Too many stat ops when trying to probe a large file (pr#15472,
   “Yan, Zheng”)
* mds: avoid reusing deleted inode in
   StrayManager::_purge_stray_logged (pr#14670, Zhi Zhang)
* mds: enable start when session ino info is corrupt (pr#14700, John
   Spray)
* mds: fragment space check can cause replayed request fail (pr#14668,
   “Yan, Zheng”)
* mds: heartbeat timeout during rejoin, when working with large amount
   of caps/inodes (pr#14672, John Spray)
* mds: issue new caps when sending reply to client (issue#19635,
   pr#15438, “Yan, Zheng”)
* mon: OSDMonitor: make ‘osd crush move …’ work on osds (pr#13261,
   Sage Weil)
* mon: fix ‘sortbitwise’ warning on jewel (issue#20578, pr#15208,
   huanwen ren, Sage Weil)
* mon: make get_mon_log_message() atomic (issue#19427, pr#14587, Kefu
   Chai)
* mon: remove bad rocksdb option (pr#14236, Sage Weil)
* msg: IPv6 Heartbeat packets are not marked with DSCP QoS – simple
   messenger (pr#13450, Yan Jun, Robin H.  Johnson)
* msg: set close on exec flag (pr#13585, Kefu Chai)
* osd: –flush-journal: sporadic segfaults on exit (issue#18820,
   pr#13477, Alexey Sheplyakov)
* osd: Give requested scrubs a higher priority (issue#15789, pr#14686,
   David Zafman)
* osd: Implement asynchronous scrub sleep (issue#19986, pr#15529, Brad
   Hubbard)
* osd: Object level shard errors are tracked and used if no auth
   available (pr#15416, David Zafman)
* osd: ReplicatedPG: try with pool’s use-gmt setting if hitset archive
   not found (pr#13827, Kefu Chai)
* osd: allow client throttler to be adjusted on-fly, without restart
   (pr#13214, Piotr Dałek)
* osd: bypass readonly ops when osd full (issue#19394, pr#14181,
   Jianpeng Ma, yaoning)
* osd: degraded and misplaced status output inaccurate (pr#14325,
   David Zafman)
* osd: new added OSD always down when full flag is set (pr#14326,
   Mingxin Liu)
* osd: pg_pool_t::encode(): be compatible with Hammer <= 0.94.6
   (pr#14392, Alexey Sheplyakov)
* osd: pre-jewel “osd rm” incrementals are misinterpreted (pr#13884,
   Ilya Dryomov)
* osd: preserve allocation hint attribute during recovery (pr#13647,
   yaoning)
* osd: promote throttle parameters are reversed (issue#19773,
   pr#14791, Mark Nelson)
* osd: reindex properly on pg log split (issue#18975, pr#14047, Alexey
   Sheplyakov)
* osd: restrict want_acting to up+acting on recovery completion
   (pr#13541, Sage Weil)
* rbd-nbd: check /sys/block/nbdX/size to ensure kernel mapped
   correctly (pr#13932, Mykola Golub, Alexey Sheplyakov)
* rbd: rbd_)mirror_peer_add from adding multiple peers (pr#14664,
   Jason Dillaman)
* rbd: qemu crash triggered by network issues (issue#18436, pr#13244,
   Jason Dillaman)
* rbd: rbd –pool=x rename y z does not work (issue#18326, pr#14148,
   Gaurav Kumar Garg)
* rbd: systemctl stop rbdmap unmaps all rbds and not just the ones in
   /etc/ceph/rbdmap (issue#18262, pr#14083, David Disseldorp, Nathan
   Cutler)
* rgw: “cluster  bad locator @X on object @X….” in cluster log
   (pr#14064, Casey Bodley)
* rgw: ‘radosgw-admin sync status’ on master zone of non-master
   zonegroup (pr#13779, Jing Wenjun)
* rgw: Change loglevel to 20 for ‘System already converted’ message
   (pr#13834, Vikhyat Umrao)
* rgw: Use decoded URI when verifying TempURL (issue#18590, pr#13724,
   Alexey Sheplyakov)
* rgw: a few cases where rgw_obj is incorrectly initialized (pr#13842,
   Yehuda Sadeh)
* rgw: add apis to support ragweed suite (issue#19804, pr#14851,
   Yehuda Sadeh)
* rgw: add bucket size limit check to radosgw-admin (pr#14787, Matt
   Benjamin)
* rgw: allow system users to read SLO parts (issue#19027, pr#14752,
   Casey Bodley)
* rgw: don’t return skew time in pre-signed url (issue#18828,
   pr#14605, liuchang0812)
* rgw: failure to create s3 type subuser from admin rest api
   (pr#14815, snakeAngel2015)
* rgw: fix break inside of yield in RGWFetchAllMetaCR (pr#14066, Casey
   Bodley)
* rgw: fix failed to create bucket if a non-master zonegroup has a
   single zone (pr#14766, weiqiaomiao)
* rgw: health check errors out incorrectly (issue#19025, pr#13865,
   Pavan Rallabhandi)
* rgw: list_plain_entries() stops before bi_log entries (pr#15383,
   Casey Bodley)
* rgw: multisite: fetch_remote_obj() gets wrong version when copying
   from remote (pr#14607, Zhang Shaowen, Casey Bodley)
* rgw: multisite: some yields in RGWMetaSyncShardCR::full_sync()
   resume in incremental_sync() (pr#13837, Casey Bodley, Abhishek
   Lekshmanan)
* rgw: only append zonegroups to rest params if not empty (pr#15312,
   Yehuda Sadeh, Karol Mroz)
* rgw: pullup civet chunked (pr#14776, Matt Benjamin)
* rgw: rgw_file: fix event expire check, don’t expire directories
   being read (issue#19625, issue#19435, pr#14653, Gui Hecheng, Matt
   Benjamin)
* rgw: swift: disable revocation thread under certain circumstances
   (pr#14789, Marcus Watts)
* rgw: the swift container acl does not support field .ref (pr#13833,
   Jing Wenjun)
* rgw: typo in rgw_admin.cc (pr#13863, Ronak Jain)
* rgw: unsafe access in RGWListBucket_ObjStore_SWIFT::send_response()
   (pr#14661, Yehuda Sadeh)
* rgw: upgrade to multisite v2 fails if there is a zone without zone
   info (pr#14136, Danny Al-Gaaf, Orit Wasserman)
* rgw: use separate http_manager for read_sync_status (pr#14195, Casey
   Bodley, Shasha Lu)
* rgw: when converting region_map we need to use rgw_zone_root_pool
   (pr#14143, Orit Wasserman)
* rgw: zonegroupmap set does not work (issue#19498, pr#14660, Orit
   Wasserman, Casey Bodley)
* rgw:fix memory leaks in data/md sync (issue#20088, pr#15382,
   weiqiaomiao)
* tests: ‘ceph auth import -i’ overwrites caps, should alert user
   before overwrite (pr#13544, Vikhyat Umrao)
* tests: New upgrade test for #19508 (issue#19829, pr#14930, Nathan
   Cutler)
* tests:  TestLibRBD.ImagePollIO in
   upgrade:client-upgrade-kraken-distro-basic-smithi (pr#13107, Jason
   Dillaman)
* tests:  cls_cxx_map_get_XYZ methods don’t return correct value
   (pr#14665, Jason Dillaman)
* tests: additional rbd-mirror test stability improvements (pr#14154,
   Jason Dillaman)
* tests: api_misc: LibRadosMiscConnectFailure.ConnectFailure
   (issue#15368, pr#14763, Sage Weil)
* tests: buffer overflow in test LibCephFS.DirLs (issue#18941,
   pr#14671, “Yan, Zheng”)
* tests: clone workunit using the branch specified by task (pr#14371,
   Kefu Chai, Dan Mick)
* tests: drop upgrade/hammer-jewel-x (issue#20574, pr#15933, Nathan
   Cutler)
* tests: dummy suite fails in OpenStack (issue#18259, pr#14070, Nathan
   Cutler)
* tests: eliminate race condition in Thrasher constructor (pr#13608,
   Nathan Cutler)
* tests: enable quotas for pre-luminous quota tests (pr#15936, Patrick
   Donnelly)
* tests: fix oversight in yaml comment (issue#20581, pr#14449, Nathan
   Cutler)
* tests: move swift.py task from teuthology to ceph, phase one (jewel)
   (pr#15870, Nathan Cutler, Sage Weil, Warren Usui, Greg Farnum, Ali
   Maredia, Tommi Virtanen, Zack Cerza, Sam Lang, Yehuda Sadeh, Joe
   Buck, Josh Durgin)
* tests: qa/Fixed upgrade sequence to 10.2.0 -> 10.2.7 -> latest -x
   (10.2.8) (pr#16089, Yuri Weinstein)
* tests: qa/suites/upgrade/hammer-x: set “sortbitwise” for jewel
   clusters (pr#15842, Nathan Cutler)
* tests: qa/workunits/rados/test-upgrade-*: whitelist tests for master
   (part 1) (pr#15360, Sage Weil)
* tests: qa/workunits/rados/test-upgrade-*: whitelist tests for master
   (part 2) (pr#15778, Kefu Chai)
* tests: qa/workunits/rados/test-upgrade-*: whitelist tests the right
   way (pr#15824, Kefu Chai)
* tests: rados: sleep before ceph tell osd.0 flush_pg_stats after
   restart (pr#14710, Kefu Chai, Nathan Cutler)
* tests: run upgrade/client-upgrade on latest CentOS 7.3 (pr#16088,
   Nathan Cutler)
* tests: run-rbd-unit-tests.sh assert in lockdep_will_lock,
   TestLibRBD.ObjectMapConsistentSnap (issue#17447, pr#14150, Jason
   Dillaman)
* tests: systemd test backport to jewel (issue#19717, pr#14694, Vasu
   Kulkarni)
* tests: test/librados/tmap_migrate: g_ceph_context->put() upon return
   (pr#14809, Kefu Chai)
* tests: test_notify.py: rbd.InvalidArgument: error updating features
   for image test_notify_clone2 (pr#14680, Jason Dillaman)
* tests: upgrade/hammer-x failing with OSD has the store locked when
   Thrasher runs ceph-objectstore-tool on down PG (issue#19556,
   pr#14416, Nathan Cutler)
* tests: upgrade:hammer-x/stress-split-erasure-code-x86_64 fails in
   10.2.8 integration testing (pr#15904, Nathan Cutler)
* tools: brag fails to count “in” mds (issue#19192, pr#14112, Oleh
   Prypin, Peng Zhang)
* tools: ceph-disk does not support cluster names different than
   ‘ceph’ (pr#14765, Loic Dachary)
* tools: ceph-disk: Racing between partition creation and device node
   creation (pr#14329, Erwan Velu)
* tools: ceph-disk: bluestore –setgroup incorrectly set with user
   (pr#13489, craigchi)
* tools: ceph-disk: ceph-disk list reports mount error for OSD having
   mount options with SELinux context (issue#17331, pr#14402, Brad
   Hubbard)
* tools: ceph-disk: do not setup_statedir on trigger (pr#15504, Loic
   Dachary)
* tools: ceph-disk: enable directory backed OSD at boot time
   (pr#14602, Loic Dachary)
* tools: rados: RadosImport::import should return an error if
   Rados::connect fails (pr#14113, Brad Hubbard)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-10.2.8.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* For ceph-deploy, see 
http://docs.ceph.com/docs/master/install/install-ceph-deploy
* Release SHA1: f5b1f1fd7c0be0506ba73502a675de9d048b744e

[1]: http://docs.ceph.com/docs/master/_downloads/v10.2.8.txt
[2]: http://ceph.com/releases/v10-2-8-jewel-released/
