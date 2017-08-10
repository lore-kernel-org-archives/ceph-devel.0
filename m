From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: v11.2.1 Kraken Released
Date: Thu, 10 Aug 2017 11:23:38 +0200
Message-ID: <87bmnn6ajp.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:34931 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdHJJXl (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 10 Aug 2017 05:23:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

This is the first bugfix release for Kraken, and probably the last
release of the Kraken series (Kraken will be declared "End Of Life"
(EOL) when Luminous is declared stable, ie. when 12.2.0 is released). It
contains a large number of bugfixes across all Ceph components.

We recommend that all v11.2.x users upgrade.

For more detailed information, see the complete changelog[1] & the
release notes[2]

Notable Changes
---------------

* In previous versions, if a client sent an op to the wrong OSD, the OSD
  would reply with ENXIO.  The rationale here is that the client or OSD is
  clearly buggy and we want to surface the error as clearly as possible.
  We now only send the ENXIO reply if the osd_enxio_on_misdirected_op option
  is enabled (it's off by default).  This means that a VM using librbd that
  previously would have gotten an EIO and gone read-only will now see a
  blocked/hung IO instead.

* There was a bug introduced in Jewel (#19119) that broke the mapping behavior
  when an "out" OSD that still existed in the CRUSH map was removed with 'osd rm'.
  This could result in 'misdirected op' and other errors.  The bug is now fixed,
  but the fix itself introduces the same risk because the behavior may vary between
  clients and OSDs.  To avoid problems, please ensure that all OSDs are removed
  from the CRUSH map before deleting them.  That is, be sure to do::

     ceph osd crush rm osd.123

  before::

     ceph osd rm osd.123

* This release greatly improves control and throttling of the snap trimmer. It
  introduces the "osd max trimming pgs" option (defaulting to 2), which limits
  how many PGs on an OSD can be trimming snapshots at a time. And it restores
  the safe use of the "osd snap trim sleep" option, wihch defaults to 0 but
  otherwise adds the given number of seconds in delay between every dispatch
  of trim operations to the underlying system.

Other Notable Changes
---------------------

* build/ops: ceph-base missing dependency for psmisc in Ubuntu Xenial (issue#19129, issue#19564, pr#14425, Nathan Cutler)
* build/ops: logrotate is missing from debian package (kraken, master) (issue#19670, issue#19390, pr#14734, Kefu Chai)
* build/ops: selinux: Do parallel relabel on package install (issue#20077, issue#20184, issue#20191, issue#20193, pr#15509, Boris Ranto)
* build/ops: spec file mentions non-existent ceph-create-keys systemd unit file, causing ceph-mon units to not be enabled via preset (issue#19460, pr#14315, Sébastien Han)
* build/ops: systemd restarts Ceph Mon to quickly after failing to start (issue#18635, issue#18721, pr#13185, Wido den Hollander)
* build/ops: systemd: Start OSDs after MONs (issue#18907, issue#18516, pr#13494, Boris Ranto)
* ceph-disk: Add fix subcommand kraken back-port (issue#19544, pr#14345, Boris Ranto)
* ceph-disk: does not support cluster names different than 'ceph' (issue#18973, issue#17821, pr#13497, Loic Dachary)
* ceph-disk: enable directory backed OSD at boot time (issue#19628, issue#19647, pr#14604, Loic Dachary)
* ceph-disk: error on _bytes2str (issue#18431, issue#18371, pr#13501, Kefu Chai)
* ceph-disk: fails if OSD udev rule triggers prior to mount of /var (issue#20150, issue#19941, pr#16092, Loic Dachary)
* ceph-disk: Fix getting wrong group name when --setgroup in bluestore (issue#18956, pr#13488, craigchi)
* ceph-disk list reports mount error for OSD having mount options with SELinux context (issue#19537, issue#17331, pr#14403, Brad Hubbard)
* ceph-disk prepare get wrong group name in bluestore (issue#18997, pr#13543, craigchi)
* ceph-disk: Racing between partition creation & device node creation (issue#20034, pr#16138, Erwan Velu)
* ceph-disk: separate ceph-osd --check-needs-\* logs (issue#20010, issue#19888, pr#16135, Loic Dachary)
* cephfs: buffer overflow in test LibCephFS.DirLs (issue#18941, issue#19045, pr#14571, "Yan, Zheng")
* cephfs: ceph-fuse crash during snapshot tests (issue#18552, issue#18460, pr#14563, Yan, Zheng)
* cephfs: ceph-fuse does not recover after lost connection to MDS (issue#19678, issue#18757, pr#16105, Henrik Korkuc)
* cephfs: client: fix the cross-quota rename boundary check conditions (issue#18700, pr#14567, Greg Farnum)
* cephfs: Deadlock on two ceph-fuse clients accessing the same file (issue#20028, issue#19635, pr#16191, "Yan, Zheng")
* cephfs: fragment space check can cause replayed request fail (issue#18660, issue#18706, pr#14568, "Yan, Zheng")
* cephfs: MDS crashes on missing metadata object (issue#18179, issue#18566, pr#14565, Yan, Zheng)
* cephfs: MDS heartbeat timeout during rejoin, when working with large amount of caps/inodes (issue#19118, issue#19335, pr#14572, John Spray)
* cephfs: mds is crushed, after I set about 400 64KB xattr kv pairs to a file (issue#19674, issue#19033, pr#16103, Yang Honggang)
* cephfs: MDS server crashes due to inconsistent metadata (issue#19406, issue#19620, pr#14574, John Spray)
* cephfs: mds/StrayManager: avoid reusing deleted inode in StrayManager::_purge_stray_logged (issue#18950, pr#14570, Zhi Zhang)
* cephfs: mount point break off problem after mds switch (issue#19667, issue#19437, pr#16100, Guan yunfei, Sage Weil)
* cephfs: non-local quota changes not visible until some IO is done (issue#17939, issue#19763, pr#16108, John Spray)
* cephfs: No output for ceph mds rmfailed 0 --yes-i-really-mean-it command (issue#19483, issue#16709, pr#14573, John Spray)
* cephfs: normalize file open flags internally used by cephfs (issue#19845, pr#14998, Jan Fajerski)
* cephfs: segfault in handle_client_caps (issue#18306, issue#18616, pr#14566, Yan, Zheng)
* cephfs: speed up readdir by skipping unwanted dn (issue#18531, pr#13028, Xiaoxi Chen)
* cephfs: src/test/pybind/test_cephfs.py fails (issue#20500, issue#19890, pr#16114, "Yan, Zheng")
* cephfs: test_client_recovery.TestClientRecovery fails (issue#18562, issue#18396, pr#14564, Yan, Zheng)
* cephfs test failures (ceph.com/qa is broken, should be download.ceph.com/qa) (issue#18574, issue#18604, pr#13024, John Spray)
* cephfs: Test failure: test_data_isolated (tasks.cephfs.test_volume_client.TestVolumeClient) (issue#18914, issue#19676, pr#16104, "Yan, Zheng")
* cephfs: test_open_inode fails (issue#18899, issue#18661, pr#14569, John Spray)
* client: populate metadata during mount (issue#18361, issue#18540, pr#12951, John Spray)
* client: segfault on ceph_rmdir path / (issue#18612, issue#9935, pr#13030, Michal Jarzabek)
* cls_rbd: default initialize snapshot namespace for legacy clients (issue#19413, issue#19833, pr#14934, Jason Dillaman)
* cls/rgw: list_plain_entries() stops before bi_log entries (issue#19876, issue#20015, pr#15384, Casey Bodley)
* common: monitor creation with IPv6 public network segfaults (issue#19465, issue#19371, pr#14323, Fabian Grünbichler)
* common: possible lockdep false alarm for ThreadPool lock (issue#18819, issue#18894, pr#13487, Mykola Golub)
* core: api_misc: [  FAILED  ] LibRadosMiscConnectFailure.ConnectFailure (issue#19561, issue#15368, pr#14733, Sage Weil)
* core: bluestore bdev: flush no-op optimization is racy (issue#20495, issue#19326, issue#19327, issue#19250, issue#19251, pr#14736, Sage Weil)
* core: improve control and throttling of the snap trimmer (issue#19329, issue#19931, pr#14597, Samuel Just, Greg Farnum)
* core: two instances of omap_digest mismatch (issue#19391, pr#14200, Samuel Just, David Zafman)
* doc: PendingReleaseNotes: warning about 'osd rm ...' and #13733 (issue#19119, pr#14506, Sage Weil)
* doc: Python Swift client commands in Quick Developer Guide don't match configuration in vstart.sh (issue#17746, issue#18571, pr#13044, Ronak Jain)
* doc: rgw: admin ops: fix the quota section (issue#19397, issue#19462, pr#14521, Chu, Hua-Rong)
* fix: rgw crashed caused by shard id out of range when listing data log (issue#20156, issue#19732, pr#16173, redickwang)
* fuse: TestVolumeClient.test_evict_client failure creating pidfile (issue#18439, issue#18309, pr#12813, Nathan Cutler)
* librbd: allow to open an image without opening parent image (issue#18609, issue#18325, pr#13132, Ricardo Dias)
* librbd: corrected resize RPC message backwards compatibility (issue#19636, issue#19659, pr#14620, Jason Dillaman)
* librbd: Incomplete declaration for ContextWQ in librbd/Journal.h (issue#18862, issue#18892, pr#14153, Boris Ranto)
* librbd: is_exclusive_lock_owner API should ping OSD (issue#19467, issue#19287, pr#14480, Jason Dillaman)
* librbd: possible race in ExclusiveLock handle_peer_notification (issue#19368, pr#14163, Mykola Golub)
* librbd: prevent self-blacklisting during break lock (issue#18703, issue#18666, pr#13201, Jason Dillaman)
* make check fails with Error EIO: load dlopen(build/lib/libec_FAKE.so): build/lib/libec_FAKE.so: cannot open shared object file: No such file or directory (issue#20487, issue#20345, issue#18876, pr#16069, Kefu Chai, Kyr Shatskyy)
* mds: assert fail when shutting down (issue#19672, issue#19204, pr#16102, John Spray)
* mds: C_MDSInternalNoop::complete doesn't free itself (issue#19664, issue#19501, pr#16099, "Yan, Zheng")
* mds: daemon goes readonly writing backtrace for a file whose data pool has been removed (issue#19669, issue#19401, pr#16101, John Spray)
* mds: damage reporting by ino number is useless (issue#18509, issue#19680, pr#16106, John Spray)
* mds: Decode errors on backtrace will crash MDS (issue#18311, issue#18463, pr#12835, John Spray)
* mds: enable daemon to start when session ino info is corrupt (issue#19710, issue#16842, pr#16107, John Spray)
* mds: failed filelock.can_read(-1) assertion in Server::_dir_is_nonempty (issue#18707, issue#18578, pr#13555, Yan, Zheng)
* mds: finish clientreplay requests before requesting active state (issue#18678, issue#18461, pr#13112, Yan, Zheng)
* mds: unresponsive when truncating a very large file (issue#19755, issue#20026, pr#16190, "Yan, Zheng")
* mon: cache tiering: base pool last_force_resend not respected (racing read got wrong version) (issue#18366, issue#18403, pr#13116, Sage Weil)
* mon crash on shutdown, lease_ack_timeout event (issue#19928, issue#19825, pr#15084, Kefu Chai, Alexey Sheplyakov)
* mon: fail to form large quorum; msg/async busy loop (issue#20230, issue#20315, pr#15729, Haomai Wang)
* mon: force_create_pg could leave pg stuck in creating state (issue#19181, issue#18298, pr#13790, Adam C. Emerson, Sage Weil)
* mon/MonClient: make get_mon_log_message() atomic (issue#19618, issue#19427, pr#14588, Kefu Chai)
* mon: 'osd crush move ...' doesnt work on osds (issue#18682, issue#18587, pr#13500, Sage Weil)
* mon: osd crush set crushmap need sanity check (issue#19302, issue#20365, pr#16143, Loic Dachary)
* mon: peon wrongly delete routed pg stats op before receive pg stats ack (issue#18554, issue#18458, pr#13046, Mingxin Liu)
* mon/PGMap: factor mon_osd_full_ratio into MAX AVAIL calc (issue#18522, issue#20035, pr#15237, Sage Weil)
* msg/simple/SimpleMessenger.cc: 239: FAILED assert(!cleared) (issue#15784, issue#18378, pr#16133, Sage Weil)
* multisite: rest api fails to decode large period on 'period commit' (issue#19505, issue#19616, issue#19614, issue#20244, issue#19488, issue#19776, issue#20293, issue#19746, pr#16161, Casey Bodley, Abhishek Lekshmanan)
* objecter: full_try behavior not consistent with osd (issue#19560, issue#19430, pr#14732, Sage Weil)
* ojecter: epoch_barrier isn't respected in _op_submit() (issue#19396, issue#19496, pr#14331, Ilya Dryomov)
* os/bluestore: deep decode onode value (issue#20366, pr#15792, Sage Weil)
* os/bluestore: fix Allocator::allocate() int truncation (issue#20884, issue#18595, pr#13011, Sage Weil)
* osd: allow client throttler to be adjusted on-fly, without restart (issue#18791, issue#18793, pr#13216, Piotr Dałek)
* osd: An OSD was seen getting ENOSPC even with osd_failsafe_full_ratio passed (issue#20544, issue#16878, issue#19340, issue#19841, issue#20672, pr#16134, Sage Weil, David Zafman)
* osd: bogus assert when checking acting set on recovery completion in rados/upgrade (issue#18999, pr#13542, Sage Weil)
* osd: calc_clone_subsets misuses try_read_lock vs missing (issue#18610, issue#18583, issue#18723, issue#17831, pr#14616, Samuel Just)
* osd: ceph degraded and misplaced status output inaccurate (issue#18619, issue#19480, pr#14322, David Zafman)
* osd: condition object_info_t encoding on required (not up) features (issue#18842, issue#18831, issue#18814, pr#13485, Ilya Dryomov)
* osd: do not send ENXIO on misdirected op by default (issue#19622, pr#13253, Sage Weil)
* osd: FAILED assert(object_contexts.empty()) (live on master only from Jan-Feb 2017, all other instances are different) (issue#20522, issue#20523, issue#18927, issue#18809, pr#16132, Samuel Just)
* osd: --flush-journal: sporadic segfaults on exit (issue#18952, issue#18820, pr#13490, Alexey Sheplyakov)
* osd: Give requested scrubs a higher priority (issue#19685, issue#15789, pr#14735, David Zafman)
* osd: Implement asynchronous scrub sleep (issue#20033, issue#19986, issue#20173, issue#19497, pr#15526, Brad Hubbard)
* osd: leaked MOSDMap (issue#19760, issue#18293, pr#14942, Sage Weil)
* osd: leveldb corruption leads to Operation not permitted not handled and assert (issue#18037, issue#18418, pr#12790, Nathan Cutler)
* osd: metadata reports filestore when using bluestore (issue#18677, issue#18638, pr#16083, Wido den Hollander)
* osd: New added OSD always down when full flag is set (issue#19485, pr#14321, Mingxin Liu)
* osd: Object level shard errors are tracked and used if no auth available (issue#20089, pr#15421, David Zafman)
* osd: os/bluestore: fix statfs to not include DB partition in free space (issue#18599, issue#18722, pr#13284, Sage Weil)
* osd: osd/PrimaryLogPG: do not call on_shutdown() if (pg.deleting) (issue#19902, issue#19916, pr#15066, Kefu Chai)
* osd: pg log split does not rebuild index for parent or child (issue#19315, issue#18975, pr#14048, Sage Weil)
* osd: pglog: with config, don't assert in the presence of stale diverg… (issue#17916, issue#19702, pr#14646, Greg Farnum)
* osd: publish PG stats when backfill-related states change (issue#18497, issue#18369, pr#13295, Sage Weil)
* osd: Revert "PrimaryLogPG::failed_push: update missing as well" (issue#18659, pr#13091, David Zafman)
* osd: unlock sdata_op_ordering_lock with sdata_lock hold to avoid missing wakeup signal (issue#20443, pr#15962, Alexey Sheplyakov)
* pre-jewel "osd rm" incrementals are misinterpreted (issue#19209, issue#19119, pr#13883, Ilya Dryomov)
* rbd: Add missing parameter feedback to 'rbd snap limit' (issue#18601, pr#14537, Tang Jin)
* rbd: [api] is_exclusive_lock_owner shouldn't return -EBUSY (issue#20266, issue#20182, pr#16187, Jason Dillaman)
* rbd: [api] temporarily restrict (rbd\_)mirror_peer_add from adding multiple peers (issue#19256, issue#19324, pr#14545, Jason Dillaman)
* rbd: attempting to remove an image with incompatible features results in partial removal (issue#18456, issue#18315, pr#13247, Dongsheng Yang)
* rbd: [cli] ensure positional arguments exist before casting (issue#20264, issue#20185, pr#16186, Jason Dillaman)
* rbd: cli: map with cephx disabled results in error message (issue#19035, issue#20517, pr#16298, Jason Dillaman)
* rbd: [  FAILED  ] TestJournalTrimmer.RemoveObjectsWithOtherClient (issue#18769, issue#18738, pr#14147, Jason Dillaman)
* rbd: Improve compatibility between librbd + krbd for the data pool (issue#18771, issue#18653, pr#14539, Jason Dillaman)
* rbd: Issues with C API image metadata retrieval functions (issue#19588, issue#19611, pr#15612, Mykola Golub)
* rbd: 'metadata_set' API operation should not change global config setting (issue#18465, issue#18549, pr#14534, Mykola Golub)
* rbd-mirror: additional test stability improvements (issue#18935, issue#18947, pr#14155, Jason Dillaman)
* rbd-mirror: deleting a snapshot during sync can result in read errors (issue#19037, issue#18990, pr#14622, Jason Dillaman)
* rbd-mirror: ensure missing images are re-synced when detected (issue#20022, issue#19811, pr#15486, Jason Dillaman)
* rbd-mirror: failover and failback of unmodified image results in split-brain (issue#19872, issue#19858, pr#14974, Jason Dillaman)
* rbd-mirror: potential race mirroring cloned image (issue#18501, issue#17993, pr#14533, Jason Dillaman)
* rbd-mirror: sporadic image replayer shut down failure (issue#18493, issue#18441, pr#14531, Jason Dillaman)
* rbd-nbd: add signal handler (issue#19621, issue#19349, pr#16098, Kefu Chai, Pan Liu)
* rbd-nbd: check /sys/block/nbdX/size to ensure kernel mapped correctly (issue#18970, issue#17951, issue#18910, issue#18335, pr#14540, Mykola Golub, Pan Liu)
* rbd: Possible deadlock performing a synchronous API action while refresh in-progress (issue#18495, issue#18419, pr#14532, Jason Dillaman)
* rbd: Potential IO hang if image is flattened while read request is in-flight (issue#19832, issue#20154, pr#16184, Jason Dillaman)
* rbd: [qa] crash in journal-enabled fsx run (issue#18618, issue#18632, pr#14538, Jason Dillaman)
* rbd: qemu crash triggered by network issues (issue#18776, issue#18436, pr#13245, Jason Dillaman)
* rbd: 'rbd bench-write' will crash if --io-size is 4G (issue#18422, issue#18557, pr#14536, Gaurav Kumar Garg)
* rbd: rbd_clone_copy_on_read ineffective with exclusive-lock (issue#19173, issue#18888, pr#14543, Venky Shankar)
* rbd: rbd --pool=x rename y z does not work (issue#18777, issue#18326, pr#14149, Gaurav Kumar Garg)
* rbd: refuse to use an ec pool that doesn't support overwrites (issue#19081, issue#19336, pr#16096, Jason Dillaman)
* rgw: add apis to support ragweed suite (issue#19809, pr#14852, Yehuda Sadeh)
* rgw: add the remove-x-delete feature to cancel swift object expiration (issue#19472, issue#19074, pr#14522, Jing Wenjun)
* rgw: a few cases where rgw_obj is incorrectly initialized (issue#19146, issue#19096, pr#13843, Yehuda Sadeh)
* rgw: anonymous user error code of getting object is not consistent with SWIFT (issue#18806, issue#19178, pr#13877, Jing Wenjun)
* rgw: civetweb frontend segfaults in Luminous (issue#19749, issue#19840, pr#16166, Abhishek Lekshmanan, Jesse Williamson)
* rgw: civetweb: move to post 1.8 version (issue#19704, pr#14960, Yehuda Sadeh)
* rgw: "cluster [WRN] bad locator @X on object @X...." in cluster log (issue#19212, issue#18980, pr#14065, Casey Bodley)
* rgw: crash when updating period with placement group (issue#18772, issue#18631, pr#14511, Orit Wasserman)
* rgw: Custom data header support (issue#19843, pr#15985, Pavan Rallabhandi)
* rgw: datalog trim can't work as expected (issue#20263, issue#20190, pr#16175, Zhang Shaowen)
* rgw: DUMPABLE flag is cleared by setuid preventing coredumps (issue#19147, issue#19089, pr#13845, Brad Hubbard)
* rgw: Error parsing xml when get bucket lifecycle (issue#19363, issue#19534, pr#14528, liuchang0812)
* rgw: first write also tries to read object (issue#18904, issue#18622, issue#18623, issue#18621, pr#14515, Yehuda Sadeh)
* rgw: fix break inside of yield in RGWFetchAllMetaCR (issue#19322, issue#17655, pr#14067, Casey Bodley)
* rgw: fix handling RGWUserInfo::system in RGWHandler_REST_SWIFT (issue#18476, pr#13006, Radoslaw Zarzynski)
* rgw: fix RadosGW hang during multi-chunk upload of AWSv4 (issue#19837, issue#19754, pr#14939, Radoslaw Zarzynski)
* rgw: fix use of marker in List::list_objects() (issue#19047, issue#18331, pr#14517, Yehuda Sadeh)
* rgw: 'gc list --include-all' command infinite loop the first 1000 items (issue#19978, issue#20147, pr#16139, Shasha Lu, fang yuxiang)
* rgw: get wrong content when download object with specific range when compression was enabled (issue#20100, issue#20268, pr#16178, fang yuxiang)
* rgw: health check errors out incorrectly (issue#19025, issue#19157, pr#13866, Pavan Rallabhandi)
* rgw: Lifecycle thread will still handle the bucket even if it has been removed (issue#20285, issue#20405, pr#16183, Zhang Shaowen)
* rgw: make sending Content-Length in 204 and 304 controllable (issue#18985, issue#16602, pr#13514, Radoslaw Zarzynski)
* rgw: meta sync thread crash at RGWMetaSyncShardCR (issue#20251, issue#20347, pr#16180, Fang Yuxiang, Nathan Cutler)
* rgw: multisite: after CreateBucket is forwarded to master, local bucket may use different value for bucket index shards (issue#19745, issue#19759, pr#16290, Shasha Lu)
* rgw: multisite: EPERM when trying to read SLO objects as system/admin user (issue#19027, issue#19475, pr#14523, Casey Bodley)
* rgw: multisite: fetch_remote_obj() gets wrong version when copying from remote (issue#19608, pr#14606, Zhang Shaowen, Casey Bodley)
* rgw: multisite: RGWMetaSyncShardControlCR gives up on EIO (issue#19160, issue#19019, pr#13868, Casey Bodley)
* rgw: multisite: segfault after changing value of rgw_data_log_num_shards (issue#18488, issue#18548, pr#13181, Casey Bodley)
* rgw: multisite: some 'radosgw-admin data sync' commands hang (issue#19236, issue#19354, pr#14142, Shasha Lu)
* rgw: multisite: some yields in RGWMetaSyncShardCR::full_sync() resume in incremental_sync() (issue#19049, issue#18076, pr#13838, Casey Bodley)
* rgw: multisite: sync status reports master is on a different period (issue#18709, issue#18064, pr#13176, Abhishek Lekshmanan)
* rgw: no http referer info in container metadata dump in swift API (issue#18665, issue#18898, pr#13829, Jing Wenjun)
* rgw: "period update" does not remove short_zone_ids of deleted zones (issue#15618, issue#19342, pr#14141, Casey Bodley)
* rgw: radosgw-admin: add the 'object stat' command to usage (issue#19164, issue#19013, pr#13873, Pavan Rallabhandi)
* rgw: radosgw-admin period update reverts deleted zonegroup (issue#18713, issue#17239, pr#13172, Orit Wasserman)
* rgw: 'radosgw-admin usage show' listing 0 bytes_sent/received (issue#20261, pr#16174, Pritha Srivastava)
* rgw: 'radosgw-admin zone create' command with specified zone-id creates a zone with different id (issue#19524, issue#19498, pr#14526, Orit Wasserman)
* rgw: Realm set does not create a new period (issue#18333, issue#18499, pr#14509, Orit Wasserman)
* rgw: reduce log level of 'storing entry at' in cls_log (issue#19835, issue#19839, pr#16165, Willem Jan Withagen)
* rgw: Response header of swift API returned by radosgw does not contain x-openstack-request-id. But Swift returns it (issue#19443, issue#19573, pr#14529, tone-zhang)
* rgw: rgw_file: fix marker computation (issue#20158, issue#19526, issue#18989, issue#19470, issue#19471, issue#18651, issue#20195, issue#19059, issue#19112, issue#19018, issue#19036, issue#19154, issue#19170, issue#19663, issue#19661, issue#19111, issue#18992, issue#18650, issue#18991, issue#19623, issue#19149, issue#19270, issue#19723, issue#19625, issue#19624, issue#19060, issue#19166, issue#18810, issue#19168, issue#19162, issue#19066, issue#18808, issue#19634, issue#19435, issue#19144, issue#19229, issue#18902, pr#13871, Gui Hecheng, Matt Benjamin)
* rgw: S3 create bucket should not do response in json (issue#19172, issue#18889, pr#13875, Abhishek Lekshmanan)
* rgw: S3 v4 authentication issue with X-Amz-Expires (issue#19477, issue#18828, pr#14524, liuchang0812)
* rgw: S3 v4 authentication issue with X-Amz-Expires (issue#19725, issue#18828, pr#16162, liuchang0812)
* rgw: should parse the url to http host to compare with the container referer acl (issue#18896, issue#18685, pr#13780, Jing Wenjun)
* rgw: slave zonegroup cannot enable the bucket versioning (issue#18711, issue#18003, pr#13174, Orit Wasserman)
* rgw: Swift API: spurious newline after http body causes weird errors (issue#18780, issue#18473, pr#13224, Marcus Watts, Matt Benjamin)
* rgw: swift API: cannot disable object versioning with empty X-Versions-Location (issue#18852, issue#19175, pr#14519, Jing Wenjun)
* rgw: swift: disable revocation thread under certain circumstances (issue#19499, issue#9493, issue#19777, pr#16164, Marcus Watts)
* rgw: Swift's at-root features (/crossdomain.xml, /info, /healthcheck) are broken (issue#20031, issue#19520, pr#16168, Radoslaw Zarzynski)
* rgw: the swift container acl does not support field .ref (issue#18909, issue#19180, issue#18484, issue#18796, pr#14516, Jing Wenjun, Radoslaw Zarzynski)
* rgw: typo in rgw_admin.cc (issue#19156, issue#19026, pr#13864, Ronak Jain)
* rgw: unsafe access in RGWListBucket_ObjStore_SWIFT::send_response() (issue#19574, issue#19249, pr#14530, Yehuda Sadeh)
* rgw: upgrade to multisite v2 fails if there is a zone without zone info (issue#19331, issue#19231, pr#14137, Danny Al-Gaaf, Orit Wasserman)
* rgw: usage stats and quota are not operational for multi-tenant users (issue#18364, issue#18843, issue#16355, pr#14513, Radoslaw Zarzynski)
* rgw: Use decoded URI when verifying TempURL (issue#18590, issue#18627, pr#12986, Michal Koutný)
* rgw: VersionIdMarker and NextVersionIdMarker are not returned when listing object versions (issue#20363, issue#19886, pr#16181, Zhang Shaowen)
* rgw: when converting region_map we need to use rgw_zone_root_pool (issue#19195, issue#19356, pr#14144, Orit Wasserman)
* rgw: when uploading the objects continuesly in the versioned bucket, some objects will not sync (issue#19766, issue#18208, pr#16163, lvshuhua)
* rgw: wrong object size after copy of uncompressed multipart objects (issue#20269, issue#20071, pr#16179, fang yuxiang)
* rgw: zonegroupmap set does not work (issue#18725, issue#19479, pr#14525, Casey Bodley)
* tests: AttributeError: Thrasher instance has no attribute 'ceph_objectstore_tool' (issue#19064, issue#18799, pr#13609, Nathan Cutler)
* tests: backport Sage's fixes to qa/suites/upgrade/jewel-x (issue#19651, pr#14612, Sage Weil)
* tests: ceph-object-corpus: kraken objects (issue#20878, pr#14983, Sage Weil)
* tests: CMakeLists.txt: disable memstore make check test (issue#17743, pr#16215, Sage Weil)
* tests: HEALTH_WARN pool rbd pg_num 244 > pgp_num 224 during upgrade (issue#19771, issue#20024, pr#16137, Kefu Chai)
* tests: ignore bogus ceph-objectstore-tool error in ceph_manager (issue#18805, issue#16263, pr#13239, Nathan Cutler, Kefu Chai)
* tests: insufficient timeout in radosbench task (issue#20497, pr#16111, Sage Weil)
* tests: LibRadosMiscConnectFailure.ConnectFailure hang (issue#20271, issue#19901, pr#16140, Sage Weil)
* tests: [librados_test_stub] cls_cxx_map_get_XYZ methods don't return correct value (issue#19597, issue#19609, pr#16097, Jason Dillaman)
* tests: move swift.py task from teuthology to ceph, phase one (kraken) (issue#20392, pr#15869, Nathan Cutler, Sage Weil, Warren Usui, Greg Farnum, Ali Maredia, Tommi Virtanen, Zack Cerza, Sam Lang, Yehuda Sadeh, Joe Buck, Josh Durgin)
* tests: ObjectStore/StoreTest.OnodeSizeTracking/2 fails on bluestore (issue#20499, pr#16112, xie xingguo)
* tests: qa: ceph-ansible test tweaks (issue#20882, pr#12984, pr#13618, Tamil Muthamizhan, Yuri Weinstein)
* tests: qa/suites/upgrade: add tiering test to hammer-jewel-x (issue#20879, issue#19185, pr#14692, Kefu Chai)
* tests: qa/tasks: misc systemd updates (issue#19719, pr#14702, Vasu Kulkarni)
* tests: qa/tasks: rbd-mirror daemon not properly run in foreground mode (issue#20638, issue#20630, issue#20634, pr#16342, Jason Dillaman)
* tests: qa/tasks: set pgp = pg num on thrashing finish (issue#20881, pr#13757, Kefu Chai)
* tests: qa/tasks/workunit: Backport repo fixes from master (issue#19429, issue#19531, pr#14487, Kefu Chai, Dan Mick)
* tests: remove hard-coded image name from TestLibRBD.Mirror (issue#18555, issue#19130, issue#19227, issue#18447, issue#19807, issue#19798, pr#16113, Mykola Golub, Jason Dillaman)
* tests: remove qa/suites/buildpackages (issue#18849, issue#18846, pr#13298, Loic Dachary)
* tests: run certain upgrade/jewel-x tests on Xenial only (issue#20877, pr#16493, Nathan Cutler)
* tests: run-rbd-unit-tests.sh assert in lockdep_will_lock, TestLibRBD.ObjectMapConsistentSnap (issue#18822, issue#17447, pr#14151, Jason Dillaman)
* tests: SUSE yaml facets in qa/distros/all are out of date (issue#18849, issue#18870, issue#18846, issue#18856, pr#13330, Nathan Cutler)
* tests: swift.py: clone the ceph-kraken branch (issue#20520, pr#16131, Nathan Cutler)
* tests: test/librbd: decouple ceph_test_librbd_api from libceph-common (issue#20175, issue#20351, pr#16195, Kefu Chai)
* tests: test_notify.py: assert(not image.is_exclusive_lock_owner()) on line 147 (issue#19716, issue#19794, pr#14833, Mykola Golub)
* tests: test_notify.py: rbd.InvalidArgument: error updating features for image test_notify_clone2 (issue#19692, issue#19693, pr#14641, Jason Dillaman)
* tests: use ceph-kraken branch for s3tests (issue#18387, pr#12746, Nathan Cutler)
* tests: use librados API to retrieve config params (issue#18668, issue#18617, pr#13102, Jason Dillaman)
* tests: various OpenStack tweaks (issue#20882, pr#13707, pr#13641, pr#13635, pr#13633, pr#13613, pr#13283, pr#13673, pr#13638, pr#14485, Zack Cerza)
* tools: ceph-brag fails to count "in" mds (issue#19333, issue#19192, pr#14098, Peng Zhang)
* tools: ceph-disk prepare writes osd log 0 with root owner (issue#18538, issue#18606, pr#13026, Samuel Matzek)
* tools: RadosImport::import should return an error if Rados::connect fails (issue#19351, issue#19319, pr#14095, Brad Hubbard)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-11.2.1.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* For ceph-deploy, see http://docs.ceph.com/docs/master/install/install-ceph-deploy
* Release SHA1: e0354f9d3b1eea1d75a7dd487ba8098311be38a7

[1]: http://docs.ceph.com/docs/master/_downloads/v11.2.1.txt
[2]: http://ceph.com/releases/v11-2-1-kraken-released/

--
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
