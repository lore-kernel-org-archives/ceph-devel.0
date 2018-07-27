From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: v13.2.1 Mimic released
Date: Fri, 27 Jul 2018 19:25:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1807271924250.15688@piezo.novalocal>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-165801633-1532719501=:15688"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-maintainers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-165801633-1532719501=:15688
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

This is the first bugfix release of the Mimic v13.2.x long term stable release
series. This release contains many fixes across all components of Ceph,
including a few security fixes. We recommend that all users upgrade.

Notable Changes
--------------

* CVE 2018-1128: auth: cephx authorizer subject to replay attack (issue#24836 http://tracker.ceph.com/issues/24836, Sage Weil)
* CVE 2018-1129: auth: cephx signature check is weak (issue#24837 http://tracker.ceph.com/issues/24837, Sage Weil)
* CVE 2018-10861: mon: auth checks not correct for pool ops (issue#24838
* <http://tracker.ceph.com/issues/24838, Jason Dillaman)

For more details and links to various issues and pull requests, please
refer to the ceph release blog at https://ceph.com/releases/13-2-1-mimic-released

Changelog
---------
* bluestore:  common/hobject: improved hash calculation for hobject_t etc (pr#22777, Adam Kupczyk, Sage Weil)
* bluestore,core: mimic: os/bluestore: don't store/use path_block.{db,wal} from meta (pr#22477, Sage Weil, Alfredo Deza)
* bluestore: os/bluestore: backport 24319 and 24550 (issue#24550, issue#24502, issue#24319, issue#24581, pr#22649, Sage Weil)
* bluestore: os/bluestore: fix incomplete faulty range marking when doing compression (pr#22910, Igor Fedotov)
* bluestore: spdk: fix ceph-osd crash when activate SPDK (issue#24472, issue#24371, pr#22684, tone-zhang)
* build/ops: build/ops: ceph.git has two different versions of dpdk in the source tree (issue#24942, issue#24032, pr#23070, Kefu Chai)
* build/ops: build/ops: install-deps.sh fails on newest openSUSE Leap (issue#25065, pr#23178, Kyr Shatskyy)
* build/ops: build/ops: Mimic build fails with -DWITH_RADOSGW=0 (issue#24766, pr#22851, Dan Mick)
* build/ops: cmake: enable RTTI for both debug and release RocksDB builds (pr#22299, Igor Fedotov)
* build/ops: deb/rpm: add python-six as build-time and run-time dependency (issue#24885, pr#22948, Nathan Cutler, Kefu Chai)
* build/ops: deb,rpm: fix block.db symlink ownership (pr#23246, Sage Weil)
* build/ops: include: fix build with older clang (OSX target) (pr#23049, Christopher Blum)
* build/ops: include: fix build with older clang (pr#23034, Kefu Chai)
* build/ops,rbd: build/ops: order rbdmap.service before remote-fs-pre.target (issue#24713, issue#24734, pr#22843, Ilya Dryomov)
* cephfs: cephfs: allow prohibiting user snapshots in CephFS (issue#24705, issue#24284, pr#22812, "Yan, Zheng")
* cephfs: cephfs-journal-tool: Fix purging when importing an zero-length journal (issue#24861, pr#22981, yupeng chen, zhongyan gu)
* cephfs: client: fix bug #24491 _ll_drop_pins may access invalid iterator (issue#24534, pr#22791, Liu Yangkuan)
* cephfs: client: update inode fields according to issued caps (issue#24539, issue#24269, pr#22819, "Yan, Zheng")
* cephfs: common/DecayCounter: set last_decay to current time when decoding dec… (issue#24440, issue#24537, pr#22816, Zhi Zhang)
* cephfs,core: mon/MDSMonitor: do not send redundant MDS health messages to cluster log (issue#24308, issue#24330, pr#22265, Sage Weil)
* cephfs: mds: add magic to header of open file table (issue#24541, issue#24240, pr#22841, "Yan, Zheng")
* cephfs: mds: low wrlock efficiency due to dirfrags traversal (issue#24704, issue#24467, pr#22884, Xuehan Xu)
* cephfs: PurgeQueue sometimes ignores Journaler errors (issue#24533, issue#24703, pr#22810, John Spray)
* cephfs,rbd: osdc: Fix the wrong BufferHead offset (issue#24583, pr#22869, dongdong tao)
* cephfs: repeated eviction of idle client until some IO happens (issue#24052, issue#24296, pr#22550, "Yan, Zheng")
* cephfs: test gets ENOSPC from bluestore block device (issue#24238, issue#24913, issue#24899, issue#24758, pr#22835, Patrick Donnelly, Sage Weil)
* cephfs,tests: pjd: cd: too many arguments (issue#24310, pr#22882, Neha Ojha)
* cephfs,tests: qa: client socket inaccessible without sudo (issue#24872, issue#24904, pr#23030, Patrick Donnelly)
* cephfs,tests: qa: fix ffsb cd argument (issue#24719, issue#24829, issue#24680, issue#24579, pr#22956, Yan, Zheng, Patrick Donnelly)
* cephfs,tests: qa/suites: Add supported-random-distro$ links (issue#24706, issue#24138, pr#22700, Warren Usui)
* ceph-volume describe better the options for migrating away from ceph-disk (pr#22514, Alfredo Deza)
* ceph-volume dmcrypt and activate --all documentation updates (pr#22529, Alfredo Deza)
* ceph-volume: error on commands that need ceph.conf to operate (issue#23941, pr#22747, Andrew Schoen)
* ceph-volume expand on the LVM API to create multiple LVs at different sizes (pr#22508, Alfredo Deza)
* ceph-volume initial take on auto sub-command (pr#22515, Alfredo Deza)
* ceph-volume lvm.activate Do not search for a MON configuration (pr#22398, Wido den Hollander)
* ceph-volume lvm.common use destroy-new, doesn't need admin keyring (issue#24585, pr#22900, Alfredo Deza)
* ceph-volume: provide a nice errror message when missing ceph.conf (pr#22832, Andrew Schoen)
* ceph-volume tests destroy osds on monitor hosts (pr#22507, Alfredo Deza)
* ceph-volume tests do not include admin keyring in OSD nodes (pr#22425, Alfredo Deza)
* ceph-volume tests.functional install new ceph-ansible dependencies (pr#22535, Alfredo Deza)
* ceph-volume: tests/functional run lvm list after OSD provisioning (issue#24961, pr#23148, Alfredo Deza)
* ceph-volume tests/functional use Ansible 2.6 (pr#23244, Alfredo Deza)
* ceph-volume: unmount lvs correctly before zapping (issue#24796, pr#23127, Andrew Schoen)
* cmake: bump up the required boost version to 1.67 (pr#22412, Kefu Chai)
* common: common: Abort in OSDMap::decode() during qa/standalone/erasure-code/test-erasure-eio.sh (issue#24865, issue#23492, pr#23024, Sage Weil)
* common: common: fix typo in rados bench write JSON output (issue#24292, issue#24199, pr#22406, Sandor Zeestraten)
* common,core: common: partially revert 95fc248 to make get_process_name work (issue#24123, issue#24215, pr#22311, Mykola Golub)
* common: osd: Change osd_skip_data_digest default to false and make it LEVEL_DEV (pr#23084, Sage Weil, David Zafman)
* common: tell ... config rm <foo> not idempotent (issue#24468, issue#24408, pr#22552, Sage Weil)
* core: bluestore: flush_commit is racy (issue#24261, issue#21480, pr#22382, Sage Weil)
* core: ceph osd safe-to-destroy crashes the mgr (issue#24708, issue#23249, pr#22805, Sage Weil)
* core: change default filestore_merge_threshold to -10 (issue#24686, issue#24747, pr#22813, Douglas Fuller)
* core: common/hobject: improved hash calculation (pr#22722, Adam Kupczyk)
* core: cosbench stuck at booting cosbench driver (issue#24473, pr#22887, Neha Ojha)
* core: librados: fix buffer overflow for aio_exec python binding (issue#24475, pr#22707, Aleksei Gutikov)
* core: mon: enable level_compaction_dynamic_level_bytes for rocksdb (issue#24375, issue#24361, pr#22361, Kefu Chai)
* core: mon/MgrMonitor: change 'unresponsive' message to info level (issue#24246, issue#24222, pr#22333, Sage Weil)
* core: mon/OSDMonitor: no_reply on MOSDFailure messages (issue#24322, issue#24350, pr#22297, Sage Weil)
* core: os/bluestore: firstly delete db then delete bluefs if open db met error (pr#22525, Jianpeng Ma)
* core: os/bluestore: fix races on SharedBlob::coll in ~SharedBlob (issue#24859, issue#24887, pr#23065, Radoslaw Zarzynski)
* core: osd: choose_acting loop (issue#24383, issue#24618, pr#22889, Neha Ojha)
* core: osd: do not blindly roll forward to log.head (issue#24597, pr#22997, Sage Weil)
* core: osd: eternal stuck PG in 'unfound_recovery' (issue#24500, issue#24373, pr#22545, Sage Weil)
* core: osd: fix deep scrub with osd_skip_data_digest=true (default) and blue… (issue#24922, issue#24958, pr#23094, Sage Weil)
* core: osd: fix getting osd maps on initial osd startup (pr#22651, Paul Emmerich)
* core: osd: increase default hard pg limit (issue#24355, pr#22621, Josh Durgin)
* core: osd: may get empty info at recovery (issue#24771, issue#24588, pr#22861, Sage Weil)
* core: osd/PrimaryLogPG: rebuild attrs from clients (issue#24768, issue#24805, pr#22960, Sage Weil)
* core: osd: retry to read object attrs at EC recovery (issue#24406, pr#22394, xiaofei cui)
* core: osd/Session: fix invalid iterator dereference in Sessoin::have_backoff() (issue#24486, issue#24494, pr#22730, Sage Weil)
* core: PG: add custom_reaction Backfilled and release reservations after bac… (issue#24332, pr#22559, Neha Ojha)
* core: set correctly shard for existed Collection (issue#24769, issue#24761, pr#22859, Jianpeng Ma)
* core,tests: Bring back diff -y for non-FreeBSD (issue#24738, issue#24470, pr#22826, Sage Weil, David Zafman)
* core,tests: ceph_test_rados_api_misc: fix LibRadosMiscPool.PoolCreationRace (issue#24204, issue#24150, pr#22291, Sage Weil)
* core,tests: qa/workunits/suites/blogbench.sh: use correct dir name (pr#22775, Neha Ojha)
* core,tests: Wip scrub omap (issue#24366, issue#24381, pr#22374, David Zafman)
* core,tools: ceph-detect-init: stop using platform.linux_distribution (issue#18163, pr#21523, Nathan Cutler)
* core: ValueError: too many values to unpack due to lack of subdir (issue#24617, pr#22888, Neha Ojha)
* doc: ceph-bluestore-tool manpage not getting rendered correctly (issue#25062, issue#24800, pr#23176, Nathan Cutler)
* doc: doc: update experimental features - snapshots (pr#22803, Jos Collin)
* doc: fix the links in releases/schedule.rst (pr#22372, Kefu Chai)
* doc: [mimic] doc/cephfs: remove lingering "experimental" note about multimds (pr#22854, John Spray)
* lvm: when osd creation fails log the exception (issue#24456, pr#22640, Andrew Schoen)
* mgr/dashboard: Fix bug when creating S3 keys (pr#22468, Volker Theile)
* mgr/dashboard: fix lint error caused by codelyzer update (pr#22713, Tiago Melo)
* mgr/dashboard: Fix some datatable CSS issues (pr#22274, Volker Theile)
* mgr/dashboard: Float numbers incorrectly formatted (issue#24081, issue#24707, pr#22886, Stephan Müller, Tiago Melo)
* mgr/dashboard: Missing breadcrumb on monitor performance counters page (issue#24764, pr#22849, Ricardo Marques, Tiago Melo)
* mgr/dashboard: Replace Pool with Pools (issue#24699, pr#22807, Lenz Grimmer)
* mgr: mgr/dashboard: Listen on port 8443 by default and not 8080 (pr#22449, Wido den Hollander)
* mgr,mon: exception for dashboard in config-key warning (pr#22770, John Spray)
* mgr,pybind: Python bindings use iteritems method which is not Python 3 compatible (issue#24803, issue#24779, pr#22917, Nathan Cutler)
* mgr: Sync up ceph-mgr prometheus related changes (pr#22341, Boris Ranto)
* mon: don't require CEPHX_V2 from mons until nautilus (pr#23233, Sage Weil)
* mon/OSDMonitor: Respect paxos_propose_interval (pr#22268, Xiaoxi CHEN)
* osd: forward-port osd_distrust_data_digest from luminous (pr#23184, Sage Weil)
* osd/OSDMap: fix CEPHX_V2 osd requirement to nautilus, not mimic (pr#23250, Sage Weil)
* qa/rgw: disable testing on ec-cache pools (issue#23965, pr#23096, Casey Bodley)
* qa/suites/upgrade/mimic-p2p: allow target version to apply (pr#23262, Sage Weil)
* qa/tests: added supported distro for powercycle suite (pr#22224, Yuri Weinstein)
* qa/tests: changed distro symlink to point to new way using supported OSes (pr#22653, Yuri Weinstein)
* rbd: librbd: deep_copy: resize head object map if needed (issue#24499, issue#24399, pr#22768, Mykola Golub)
* rbd: librbd: fix crash when opening nonexistent snapshot (issue#24637, issue#24698, pr#22943, Mykola Golub)
* rbd: librbd: force 'invalid object map' flag on-disk update (issue#24496, issue#24434, pr#22754, Mykola Golub)
* rbd: librbd: utilize the journal disabled policy when removing images (issue#24388, issue#23512, pr#22662, Jason Dillaman)
* rbd: Prevent the use of internal feature bits from outside cls/rbd (issue#24165, issue#24203, pr#22222, Jason Dillaman)
* rbd: rbd-mirror daemon failed to stop on active/passive test case (issue#24390, pr#22667, Jason Dillaman)
* rbd: [rbd-mirror] entries_behind_master will not be zero after mirror over (issue#24391, issue#23516, pr#22549, Jason Dillaman)
* rbd: rbd-mirror simple image map policy doesn't always level-load instances (issue#24519, issue#24161, pr#22892, Venky Shankar)
* rbd: rbd trash purge --threshold should support data pool (issue#24476, issue#22872, pr#22891, Mahati Chamarthy)
* rbd,tests: qa: krbd_exclusive_option.sh: bump lock_timeout to 60 seconds (issue#25081, pr#23209, Ilya Dryomov)
* rbd: yet another case when deep copying a clone may result in invalid object map (issue#24596, issue#24545, pr#22894, Mykola Golub)
* rgw: cls_bucket_list fails causes cascading osd crashes (issue#24631, issue#24117, pr#22927, Yehuda Sadeh)
* rgw: multisite: RGWSyncTraceNode released twice and crashed in reload (issue#24432, issue#24619, pr#22926, Tianshan Qu)
* rgw: objects in cache never refresh after rgw_cache_expiry_interval (issue#24346, issue#24385, pr#22643, Casey Bodley)
* rgw: add configurable AWS-compat invalid range get behavior (issue#24317, issue#24352, pr#22590, Matt Benjamin)
* rgw: Admin OPS Api overwrites email when user is modified (issue#24253, pr#22523, Volker Theile)
* rgw: fix gc may cause a large number of read traffic (issue#24807, issue#24767, pr#22941, Xin Liao)
* rgw: have a configurable authentication order (issue#23089, issue#24547, pr#22842, Abhishek Lekshmanan)
* rgw: index complete miss zones_trace set (issue#24701, issue#24590, pr#22818, Tianshan Qu)
* rgw: Invalid Access-Control-Request-Request may bypass validate_cors_rule_method (issue#24809, issue#24223, pr#22935, Jeegn Chen)
* rgw: meta and data notify thread miss stop cr manager (issue#24702, issue#24589, pr#22821, Tianshan Qu)
* rgw:-multisite: endless loop in RGWBucketShardIncrementalSyncCR (issue#24700, issue#24603, pr#22815, cfanz)
* rgw: performance regression for luminous 12.2.4 (issue#23379, issue#24633, pr#22929, Mark Kogan)
* rgw: radogw-admin reshard status command should print text for reshar… (issue#24834, issue#23257, pr#23021, Orit Wasserman)
* rgw: "radosgw-admin objects expire" always returns ok even if the pro… (issue#24831, issue#24592, pr#23001, Zhang Shaowen)
* rgw: require --yes-i-really-mean-it to run radosgw-admin orphans find (issue#24146, issue#24843, pr#22986, Matt Benjamin)
* rgw: REST admin metadata API paging failure bucket & bucket.instance: InvalidArgument (issue#23099, issue#24813, pr#22933, Matt Benjamin)
* rgw: set cr state if aio_read err return in RGWCloneMetaLogCoroutine:state_send_rest_request (issue#24566, issue#24783, pr#22880, Tianshan Qu)
* rgw: test/rgw: fix for bucket checkpoints (issue#24212, issue#24313, pr#22466, Casey Bodley)
* rgw,tests: add unit test for cls bi list command (issue#24736, issue#24483, pr#22845, Orit Wasserman)
* tests: mimic - qa/tests: Set ansible-version: 2.4 (issue#24926, pr#23122, Yuri Weinstein)
* tests: osd sends op_reply out of order (issue#25010, pr#23136, Neha Ojha)
* tests: qa/tests - added overrides stanza to allow runs on ovh on rhel OS (pr#23156, Yuri Weinstein)
* tests: qa/tests - added skeleton for mimic point to point upgrades testing (pr#22697, Yuri Weinstein)
* tests: qa/tests: fix supported distro lists for ceph-deploy (pr#23017, Vasu Kulkarni)
* tests: qa: wait longer for osd to flush pg stats (issue#24321, pr#22492, Kefu Chai)
* tests: tests: Health check failed: 1 MDSs report slow requests (MDS_SLOW_REQUEST) in powercycle (issue#25034, pr#23154, Neha Ojha)
* tests: tests: make test_ceph_argparse.py pass on py3-only systems (issue#24825, issue#24816, pr#22988, Nathan Cutler)
* tests: upgrade/luminous-x: whitelist REQUEST_SLOW for rados_mon_thrash (issue#25056, issue#25051, pr#23164, Nathan Cutler)

Getting ceph:
* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-13.2.1.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* Release git sha1: 5533ecdc0fda920179d7ad84e0aa65a127b20d77
--8323329-165801633-1532719501=:15688
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-165801633-1532719501=:15688--
