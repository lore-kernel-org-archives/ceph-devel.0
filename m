From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: HELP! --> CLUSER DOWN (was "v13.2.1 Mimic
 released")
Date: Sat, 28 Jul 2018 09:49:49 -0500
Message-ID: <422702b2-35c6-413e-bb9f-506921ccb3fc@email.android.com>
References: <alpine.DEB.2.11.1807271924250.15688@piezo.novalocal>
 <086B2EB1-4349-4694-856C-ECA50FBF6211@godaddy.com>
 <trinity-977054d3-80b8-4be9-9a69-009e8b25c718-1532789176388@3c-app-gmx-bs12>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4772537358002510637=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <trinity-977054d3-80b8-4be9-9a69-009e8b25c718-1532789176388@3c-app-gmx-bs12>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============4772537358002510637==
Content-Type: multipart/alternative; boundary="----FE09FZHR6P45HMI122GNH3NFZCEAV6"
Content-Transfer-Encoding: 8bit

------FE09FZHR6P45HMI122GNH3NFZCEAV6
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8

Can you include more or your osd log file?

On July 28, 2018 9:46:16 AM CDT, ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org wrote:
>Dear users and developers.
> 
>I've updated our dev-cluster from v13.2.0 to v13.2.1 yesterday and
>since then everything is badly broken.
>I've restarted all Ceph components via "systemctl" and also rebootet
>the server SDS21 and SDS24, nothing changes.
>
>This cluster started as Kraken, was updated to Luminous (up to v12.2.5)
>and then to Mimic.
>
>Here are some system related infos, see
>https://semestriel.framapad.org/p/DTkBspmnfU
>
>Somehow I guess this may have to do with the various "ceph-disk",
>"ceph-volume", ceph-lvm" changes in the last months?!?
>
>Thanks & regards
> Anton
>
>------------------------------------------------------
>
> 
>
>Gesendet: Samstag, 28. Juli 2018 um 00:22 Uhr
>Von: "Bryan Stillwell" <bstillwell-SMpshsswsndBDgjK7y7TUQ@public.gmane.org>
>An: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>Betreff: Re: [ceph-users] v13.2.1 Mimic released
>
>I decided to upgrade my home cluster from Luminous (v12.2.7) to Mimic
>(v13.2.1) today and ran into a couple issues:
> 
>1. When restarting the OSDs during the upgrade it seems to forget my
>upmap settings.  I had to manually return them to the way they were
>with commands like:
> 
>ceph osd pg-upmap-items 5.1 11 18 8 6 9 0
>ceph osd pg-upmap-items 5.1f 11 17
> 
>I also saw this when upgrading from v12.2.5 to v12.2.7.
> 
>2. Also after restarting the first OSD during the upgrade I saw 21
>messages like these in ceph.log:
> 
>2018-07-27 15:53:49.868552 osd.1 osd.1 10.0.0.207:6806/4029643 97 :
>cluster [WRN] failed to encode map e100467 with expected crc
>2018-07-27 15:53:49.922365 osd.6 osd.6 10.0.0.16:6804/90400 25 :
>cluster [WRN] failed to encode map e100467 with expected crc
>2018-07-27 15:53:49.925585 osd.6 osd.6 10.0.0.16:6804/90400 26 :
>cluster [WRN] failed to encode map e100467 with expected crc
>2018-07-27 15:53:49.944414 osd.18 osd.18 10.0.0.15:6808/120845 8 :
>cluster [WRN] failed to encode map e100467 with expected crc
>2018-07-27 15:53:49.944756 osd.17 osd.17 10.0.0.15:6800/120749 13 :
>cluster [WRN] failed to encode map e100467 with expected crc
> 
>Is this a sign that full OSD maps were sent out by the mons to every
>OSD like back in the hammer days?  I seem to remember that OSD maps
>should be a lot smaller now, so maybe this isn't as big of a problem as
>it was back then?
> 
>Thanks,
>Bryan
> 
>
>From: ceph-users <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org> on behalf of Sage
>Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>Date: Friday, July 27, 2018 at 1:25 PM
>To: "ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>,
>"ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>,
>"ceph-maintainers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-maintainers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>,
>"ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>Subject: [ceph-users] v13.2.1 Mimic released
>
> 
>
>This is the first bugfix release of the Mimic v13.2.x long term stable
>release
>
>series. This release contains many fixes across all components of Ceph,
>
>including a few security fixes. We recommend that all users upgrade.
>
> 
>
>Notable Changes
>
>--------------
>
> 
>
>* CVE 2018-1128: auth: cephx authorizer subject to replay attack
>(issue#24836 http://tracker.ceph.com/issues/24836, Sage Weil)
>
>* CVE 2018-1129: auth: cephx signature check is weak (issue#24837
>http://tracker.ceph.com/issues/24837[http://tracker.ceph.com/issues/24837],
>Sage Weil)
>
>* CVE 2018-10861: mon: auth checks not correct for pool ops
>(issue#24838
>
>*
><http://tracker.ceph.com/issues/24838[http://tracker.ceph.com/issues/24838],
>Jason Dillaman)
>
> 
>
>For more details and links to various issues and pull requests, please
>
>refer to the ceph release blog at
>https://ceph.com/releases/13-2-1-mimic-released[https://ceph.com/releases/13-2-1-mimic-released]
>
> 
>
>Changelog
>
>---------
>
>* bluestore:  common/hobject: improved hash calculation for hobject_t
>etc (pr#22777, Adam Kupczyk, Sage Weil)
>
>* bluestore,core: mimic: os/bluestore: don't store/use
>path_block.{db,wal} from meta (pr#22477, Sage Weil, Alfredo Deza)
>
>* bluestore: os/bluestore: backport 24319 and 24550 (issue#24550,
>issue#24502, issue#24319, issue#24581, pr#22649, Sage Weil)
>
>* bluestore: os/bluestore: fix incomplete faulty range marking when
>doing compression (pr#22910, Igor Fedotov)
>
>* bluestore: spdk: fix ceph-osd crash when activate SPDK (issue#24472,
>issue#24371, pr#22684, tone-zhang)
>
>* build/ops: build/ops: ceph.git has two different versions of dpdk in
>the source tree (issue#24942, issue#24032, pr#23070, Kefu Chai)
>
>* build/ops: build/ops: install-deps.sh fails on newest openSUSE Leap
>(issue#25065, pr#23178, Kyr Shatskyy)
>
>* build/ops: build/ops: Mimic build fails with -DWITH_RADOSGW=0
>(issue#24766, pr#22851, Dan Mick)
>
>* build/ops: cmake: enable RTTI for both debug and release RocksDB
>builds (pr#22299, Igor Fedotov)
>
>* build/ops: deb/rpm: add python-six as build-time and run-time
>dependency (issue#24885, pr#22948, Nathan Cutler, Kefu Chai)
>
>* build/ops: deb,rpm: fix block.db symlink ownership (pr#23246, Sage
>Weil)
>
>* build/ops: include: fix build with older clang (OSX target)
>(pr#23049, Christopher Blum)
>
>* build/ops: include: fix build with older clang (pr#23034, Kefu Chai)
>
>* build/ops,rbd: build/ops: order rbdmap.service before
>remote-fs-pre.target (issue#24713, issue#24734, pr#22843, Ilya Dryomov)
>
>* cephfs: cephfs: allow prohibiting user snapshots in CephFS
>(issue#24705, issue#24284, pr#22812, "Yan, Zheng")
>
>* cephfs: cephfs-journal-tool: Fix purging when importing an
>zero-length journal (issue#24861, pr#22981, yupeng chen, zhongyan gu)
>
>* cephfs: client: fix bug #24491 _ll_drop_pins may access invalid
>iterator (issue#24534, pr#22791, Liu Yangkuan)
>
>* cephfs: client: update inode fields according to issued caps
>(issue#24539, issue#24269, pr#22819, "Yan, Zheng")
>
>* cephfs: common/DecayCounter: set last_decay to current time when
>decoding dec… (issue#24440, issue#24537, pr#22816, Zhi Zhang)
>
>* cephfs,core: mon/MDSMonitor: do not send redundant MDS health
>messages to cluster log (issue#24308, issue#24330, pr#22265, Sage Weil)
>
>* cephfs: mds: add magic to header of open file table (issue#24541,
>issue#24240, pr#22841, "Yan, Zheng")
>
>* cephfs: mds: low wrlock efficiency due to dirfrags traversal
>(issue#24704, issue#24467, pr#22884, Xuehan Xu)
>
>* cephfs: PurgeQueue sometimes ignores Journaler errors (issue#24533,
>issue#24703, pr#22810, John Spray)
>
>* cephfs,rbd: osdc: Fix the wrong BufferHead offset (issue#24583,
>pr#22869, dongdong tao)
>
>* cephfs: repeated eviction of idle client until some IO happens
>(issue#24052, issue#24296, pr#22550, "Yan, Zheng")
>
>* cephfs: test gets ENOSPC from bluestore block device (issue#24238,
>issue#24913, issue#24899, issue#24758, pr#22835, Patrick Donnelly, Sage
>Weil)
>
>* cephfs,tests: pjd: cd: too many arguments (issue#24310, pr#22882,
>Neha Ojha)
>
>* cephfs,tests: qa: client socket inaccessible without sudo
>(issue#24872, issue#24904, pr#23030, Patrick Donnelly)
>
>* cephfs,tests: qa: fix ffsb cd argument (issue#24719, issue#24829,
>issue#24680, issue#24579, pr#22956, Yan, Zheng, Patrick Donnelly)
>
>* cephfs,tests: qa/suites: Add supported-random-distro$ links
>(issue#24706, issue#24138, pr#22700, Warren Usui)
>
>* ceph-volume describe better the options for migrating away from
>ceph-disk (pr#22514, Alfredo Deza)
>
>* ceph-volume dmcrypt and activate --all documentation updates
>(pr#22529, Alfredo Deza)
>
>* ceph-volume: error on commands that need ceph.conf to operate
>(issue#23941, pr#22747, Andrew Schoen)
>
>* ceph-volume expand on the LVM API to create multiple LVs at different
>sizes (pr#22508, Alfredo Deza)
>
>* ceph-volume initial take on auto sub-command (pr#22515, Alfredo Deza)
>
>* ceph-volume lvm.activate Do not search for a MON configuration
>(pr#22398, Wido den Hollander)
>
>* ceph-volume lvm.common use destroy-new, doesn't need admin keyring
>(issue#24585, pr#22900, Alfredo Deza)
>
>* ceph-volume: provide a nice errror message when missing ceph.conf
>(pr#22832, Andrew Schoen)
>
>* ceph-volume tests destroy osds on monitor hosts (pr#22507, Alfredo
>Deza)
>
>* ceph-volume tests do not include admin keyring in OSD nodes
>(pr#22425, Alfredo Deza)
>
>* ceph-volume tests.functional install new ceph-ansible dependencies
>(pr#22535, Alfredo Deza)
>
>* ceph-volume: tests/functional run lvm list after OSD provisioning
>(issue#24961, pr#23148, Alfredo Deza)
>
>* ceph-volume tests/functional use Ansible 2.6 (pr#23244, Alfredo Deza)
>
>* ceph-volume: unmount lvs correctly before zapping (issue#24796,
>pr#23127, Andrew Schoen)
>
>* cmake: bump up the required boost version to 1.67 (pr#22412, Kefu
>Chai)
>
>* common: common: Abort in OSDMap::decode() during
>qa/standalone/erasure-code/test-erasure-eio.sh (issue#24865,
>issue#23492, pr#23024, Sage Weil)
>
>* common: common: fix typo in rados bench write JSON output
>(issue#24292, issue#24199, pr#22406, Sandor Zeestraten)
>
>* common,core: common: partially revert 95fc248 to make
>get_process_name work (issue#24123, issue#24215, pr#22311, Mykola
>Golub)
>
>* common: osd: Change osd_skip_data_digest default to false and make it
>LEVEL_DEV (pr#23084, Sage Weil, David Zafman)
>
>* common: tell ... config rm <foo> not idempotent (issue#24468,
>issue#24408, pr#22552, Sage Weil)
>
>* core: bluestore: flush_commit is racy (issue#24261, issue#21480,
>pr#22382, Sage Weil)
>
>* core: ceph osd safe-to-destroy crashes the mgr (issue#24708,
>issue#23249, pr#22805, Sage Weil)
>
>* core: change default filestore_merge_threshold to -10 (issue#24686,
>issue#24747, pr#22813, Douglas Fuller)
>
>* core: common/hobject: improved hash calculation (pr#22722, Adam
>Kupczyk)
>
>* core: cosbench stuck at booting cosbench driver (issue#24473,
>pr#22887, Neha Ojha)
>
>* core: librados: fix buffer overflow for aio_exec python binding
>(issue#24475, pr#22707, Aleksei Gutikov)
>
>* core: mon: enable level_compaction_dynamic_level_bytes for rocksdb
>(issue#24375, issue#24361, pr#22361, Kefu Chai)
>
>* core: mon/MgrMonitor: change 'unresponsive' message to info level
>(issue#24246, issue#24222, pr#22333, Sage Weil)
>
>* core: mon/OSDMonitor: no_reply on MOSDFailure messages (issue#24322,
>issue#24350, pr#22297, Sage Weil)
>
>* core: os/bluestore: firstly delete db then delete bluefs if open db
>met error (pr#22525, Jianpeng Ma)
>
>* core: os/bluestore: fix races on SharedBlob::coll in ~SharedBlob
>(issue#24859, issue#24887, pr#23065, Radoslaw Zarzynski)
>
>* core: osd: choose_acting loop (issue#24383, issue#24618, pr#22889,
>Neha Ojha)
>
>* core: osd: do not blindly roll forward to log.head (issue#24597,
>pr#22997, Sage Weil)
>
>* core: osd: eternal stuck PG in 'unfound_recovery' (issue#24500,
>issue#24373, pr#22545, Sage Weil)
>
>* core: osd: fix deep scrub with osd_skip_data_digest=true (default)
>and blue… (issue#24922, issue#24958, pr#23094, Sage Weil)
>
>* core: osd: fix getting osd maps on initial osd startup (pr#22651,
>Paul Emmerich)
>
>* core: osd: increase default hard pg limit (issue#24355, pr#22621,
>Josh Durgin)
>
>* core: osd: may get empty info at recovery (issue#24771, issue#24588,
>pr#22861, Sage Weil)
>
>* core: osd/PrimaryLogPG: rebuild attrs from clients (issue#24768,
>issue#24805, pr#22960, Sage Weil)
>
>* core: osd: retry to read object attrs at EC recovery (issue#24406,
>pr#22394, xiaofei cui)
>
>* core: osd/Session: fix invalid iterator dereference in
>Sessoin::have_backoff() (issue#24486, issue#24494, pr#22730, Sage Weil)
>
>* core: PG: add custom_reaction Backfilled and release reservations
>after bac… (issue#24332, pr#22559, Neha Ojha)
>
>* core: set correctly shard for existed Collection (issue#24769,
>issue#24761, pr#22859, Jianpeng Ma)
>
>* core,tests: Bring back diff -y for non-FreeBSD (issue#24738,
>issue#24470, pr#22826, Sage Weil, David Zafman)
>
>* core,tests: ceph_test_rados_api_misc: fix
>LibRadosMiscPool.PoolCreationRace (issue#24204, issue#24150, pr#22291,
>Sage Weil)
>
>* core,tests: qa/workunits/suites/blogbench.sh: use correct dir name
>(pr#22775, Neha Ojha)
>
>* core,tests: Wip scrub omap (issue#24366, issue#24381, pr#22374, David
>Zafman)
>
>* core,tools: ceph-detect-init: stop using platform.linux_distribution
>(issue#18163, pr#21523, Nathan Cutler)
>
>* core: ValueError: too many values to unpack due to lack of subdir
>(issue#24617, pr#22888, Neha Ojha)
>
>* doc: ceph-bluestore-tool manpage not getting rendered correctly
>(issue#25062, issue#24800, pr#23176, Nathan Cutler)
>
>* doc: doc: update experimental features - snapshots (pr#22803, Jos
>Collin)
>
>* doc: fix the links in releases/schedule.rst (pr#22372, Kefu Chai)
>
>* doc: [mimic] doc/cephfs: remove lingering "experimental" note about
>multimds (pr#22854, John Spray)
>
>* lvm: when osd creation fails log the exception (issue#24456,
>pr#22640, Andrew Schoen)
>
>* mgr/dashboard: Fix bug when creating S3 keys (pr#22468, Volker
>Theile)
>
>* mgr/dashboard: fix lint error caused by codelyzer update (pr#22713,
>Tiago Melo)
>
>* mgr/dashboard: Fix some datatable CSS issues (pr#22274, Volker
>Theile)
>
>* mgr/dashboard: Float numbers incorrectly formatted (issue#24081,
>issue#24707, pr#22886, Stephan Müller, Tiago Melo)
>
>* mgr/dashboard: Missing breadcrumb on monitor performance counters
>page (issue#24764, pr#22849, Ricardo Marques, Tiago Melo)
>
>* mgr/dashboard: Replace Pool with Pools (issue#24699, pr#22807, Lenz
>Grimmer)
>
>* mgr: mgr/dashboard: Listen on port 8443 by default and not 8080
>(pr#22449, Wido den Hollander)
>
>* mgr,mon: exception for dashboard in config-key warning (pr#22770,
>John Spray)
>
>* mgr,pybind: Python bindings use iteritems method which is not Python
>3 compatible (issue#24803, issue#24779, pr#22917, Nathan Cutler)
>
>* mgr: Sync up ceph-mgr prometheus related changes (pr#22341, Boris
>Ranto)
>
>* mon: don't require CEPHX_V2 from mons until nautilus (pr#23233, Sage
>Weil)
>
>* mon/OSDMonitor: Respect paxos_propose_interval (pr#22268, Xiaoxi
>CHEN)
>
>* osd: forward-port osd_distrust_data_digest from luminous (pr#23184,
>Sage Weil)
>
>* osd/OSDMap: fix CEPHX_V2 osd requirement to nautilus, not mimic
>(pr#23250, Sage Weil)
>
>* qa/rgw: disable testing on ec-cache pools (issue#23965, pr#23096,
>Casey Bodley)
>
>* qa/suites/upgrade/mimic-p2p: allow target version to apply (pr#23262,
>Sage Weil)
>
>* qa/tests: added supported distro for powercycle suite (pr#22224, Yuri
>Weinstein)
>
>* qa/tests: changed distro symlink to point to new way using supported
>OSes (pr#22653, Yuri Weinstein)
>
>* rbd: librbd: deep_copy: resize head object map if needed
>(issue#24499, issue#24399, pr#22768, Mykola Golub)
>
>* rbd: librbd: fix crash when opening nonexistent snapshot
>(issue#24637, issue#24698, pr#22943, Mykola Golub)
>
>* rbd: librbd: force 'invalid object map' flag on-disk update
>(issue#24496, issue#24434, pr#22754, Mykola Golub)
>
>* rbd: librbd: utilize the journal disabled policy when removing images
>(issue#24388, issue#23512, pr#22662, Jason Dillaman)
>
>* rbd: Prevent the use of internal feature bits from outside cls/rbd
>(issue#24165, issue#24203, pr#22222, Jason Dillaman)
>
>* rbd: rbd-mirror daemon failed to stop on active/passive test case
>(issue#24390, pr#22667, Jason Dillaman)
>
>* rbd: [rbd-mirror] entries_behind_master will not be zero after mirror
>over (issue#24391, issue#23516, pr#22549, Jason Dillaman)
>
>* rbd: rbd-mirror simple image map policy doesn't always level-load
>instances (issue#24519, issue#24161, pr#22892, Venky Shankar)
>
>* rbd: rbd trash purge --threshold should support data pool
>(issue#24476, issue#22872, pr#22891, Mahati Chamarthy)
>
>* rbd,tests: qa: krbd_exclusive_option.sh: bump lock_timeout to 60
>seconds (issue#25081, pr#23209, Ilya Dryomov)
>
>* rbd: yet another case when deep copying a clone may result in invalid
>object map (issue#24596, issue#24545, pr#22894, Mykola Golub)
>
>* rgw: cls_bucket_list fails causes cascading osd crashes (issue#24631,
>issue#24117, pr#22927, Yehuda Sadeh)
>
>* rgw: multisite: RGWSyncTraceNode released twice and crashed in reload
>(issue#24432, issue#24619, pr#22926, Tianshan Qu)
>
>* rgw: objects in cache never refresh after rgw_cache_expiry_interval
>(issue#24346, issue#24385, pr#22643, Casey Bodley)
>
>* rgw: add configurable AWS-compat invalid range get behavior
>(issue#24317, issue#24352, pr#22590, Matt Benjamin)
>
>* rgw: Admin OPS Api overwrites email when user is modified
>(issue#24253, pr#22523, Volker Theile)
>
>* rgw: fix gc may cause a large number of read traffic (issue#24807,
>issue#24767, pr#22941, Xin Liao)
>
>* rgw: have a configurable authentication order (issue#23089,
>issue#24547, pr#22842, Abhishek Lekshmanan)
>
>* rgw: index complete miss zones_trace set (issue#24701, issue#24590,
>pr#22818, Tianshan Qu)
>
>* rgw: Invalid Access-Control-Request-Request may bypass
>validate_cors_rule_method (issue#24809, issue#24223, pr#22935, Jeegn
>Chen)
>
>* rgw: meta and data notify thread miss stop cr manager (issue#24702,
>issue#24589, pr#22821, Tianshan Qu)
>
>* rgw:-multisite: endless loop in RGWBucketShardIncrementalSyncCR
>(issue#24700, issue#24603, pr#22815, cfanz)
>
>* rgw: performance regression for luminous 12.2.4 (issue#23379,
>issue#24633, pr#22929, Mark Kogan)
>
>* rgw: radogw-admin reshard status command should print text for
>reshar… (issue#24834, issue#23257, pr#23021, Orit Wasserman)
>
>* rgw: "radosgw-admin objects expire" always returns ok even if the
>pro… (issue#24831, issue#24592, pr#23001, Zhang Shaowen)
>
>* rgw: require --yes-i-really-mean-it to run radosgw-admin orphans find
>(issue#24146, issue#24843, pr#22986, Matt Benjamin)
>
>* rgw: REST admin metadata API paging failure bucket & bucket.instance:
>InvalidArgument (issue#23099, issue#24813, pr#22933, Matt Benjamin)
>
>* rgw: set cr state if aio_read err return in
>RGWCloneMetaLogCoroutine:state_send_rest_request (issue#24566,
>issue#24783, pr#22880, Tianshan Qu)
>
>* rgw: test/rgw: fix for bucket checkpoints (issue#24212, issue#24313,
>pr#22466, Casey Bodley)
>
>* rgw,tests: add unit test for cls bi list command (issue#24736,
>issue#24483, pr#22845, Orit Wasserman)
>
>* tests: mimic - qa/tests: Set ansible-version: 2.4 (issue#24926,
>pr#23122, Yuri Weinstein)
>
>* tests: osd sends op_reply out of order (issue#25010, pr#23136, Neha
>Ojha)
>
>* tests: qa/tests - added overrides stanza to allow runs on ovh on rhel
>OS (pr#23156, Yuri Weinstein)
>
>* tests: qa/tests - added skeleton for mimic point to point upgrades
>testing (pr#22697, Yuri Weinstein)
>
>* tests: qa/tests: fix supported distro lists for ceph-deploy
>(pr#23017, Vasu Kulkarni)
>
>* tests: qa: wait longer for osd to flush pg stats (issue#24321,
>pr#22492, Kefu Chai)
>
>* tests: tests: Health check failed: 1 MDSs report slow requests
>(MDS_SLOW_REQUEST) in powercycle (issue#25034, pr#23154, Neha Ojha)
>
>* tests: tests: make test_ceph_argparse.py pass on py3-only systems
>(issue#24825, issue#24816, pr#22988, Nathan Cutler)
>
>* tests: upgrade/luminous-x: whitelist REQUEST_SLOW for
>rados_mon_thrash (issue#25056, issue#25051, pr#23164, Nathan Cutler)
>
> 
>
>Getting ceph:
>
>* Git at git://github.com/ceph/ceph.git
>
>* Tarball at
>http://download.ceph.com/tarballs/ceph-13.2.1.tar.gz[http://download.ceph.com/tarballs/ceph-13.2.1.tar.gz]
>
>* For packages, see
>http://docs.ceph.com/docs/master/install/get-packages/[http://docs.ceph.com/docs/master/install/get-packages/]
>
>* Release git sha1: 5533ecdc0fda920179d7ad84e0aa65a127b20d77
>_______________________________________________ ceph-users mailing list
>ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com[http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com]
> 
> 
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

------FE09FZHR6P45HMI122GNH3NFZCEAV6
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body><p dir="ltr">Can you include more or your osd log file?</p>
<br><br><div class="gmail_quote">On July 28, 2018 9:46:16 AM CDT, ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class="k9mail">Dear users and developers.<br /> <br />I've updated our dev-cluster from v13.2.0 to v13.2.1 yesterday and since then everything is badly broken.<br />I've restarted all Ceph components via "systemctl" and also rebootet the server SDS21 and SDS24, nothing changes.<br /><br />This cluster started as Kraken, was updated to Luminous (up to v12.2.5) and then to Mimic.<br /><br />Here are some system related infos, see <a href="https://semestriel.framapad.org/p/DTkBspmnfU">https://semestriel.framapad.org/p/DTkBspmnfU</a><br /><br />Somehow I guess this may have to do with the various "ceph-disk", "ceph-volume", ceph-lvm" changes in the last months?!?<br /><br />Thanks &amp; regards<br /> Anton<br /><br /><hr /><br /><br /> <br /><br />Gesendet: Samstag, 28. Juli 2018 um 00
 :22 Uhr<br />Von: "Bryan Stillwell" &lt;bstillwell-SMpshsswsndBDgjK7y7TUQ@public.gmane.org&gt;<br />An: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" &lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;<br />Betreff: Re: [ceph-users] v13.2.1 Mimic released<br
/><br />I decided to upgrade my home cluster from Luminous (v12.2.7) to Mimic (v13.2.1) today and ran into a couple issues:<br /> <br />1. When restarting the OSDs during the upgrade it seems to forget my upmap settings.  I had to manually return them to the way they were with commands like:<br /> <br />ceph osd pg-upmap-items 5.1 11 18 8 6 9 0<br />ceph osd pg-upmap-items 5.1f 11 17<br /> <br />I also saw this when upgrading from v12.2.5 to v12.2.7.<br /> <br />2. Also after restarting the first OSD during the upgrade I saw 21 messages like these in ceph.log:<br /> <br />2018-07-27 15:53:49.868552 osd.1 osd.1 <a href="10.0.0.207:6806/4029643">10.0.0.207:6806/4029643</a> 97 : cluster [WRN] failed to encode map e100467 with expected crc<br />2018-07-27 15:53:49.922365 osd.6 osd.6 <a h
 ref="10.0.0.16:6804/90400">10.0.0.16:6804/90400</a> 25 : cluster [WRN] failed to encode map e100467 with expected crc<br />2018-07-27 15:53:49.925585 osd.6 osd.6 <a
href="10.0.0.16:6804/90400">10.0.0.16:6804/90400</a> 26 : cluster [WRN] failed to encode map e100467 with expected crc<br />2018-07-27 15:53:49.944414 osd.18 osd.18 <a href="10.0.0.15:6808/120845">10.0.0.15:6808/120845</a> 8 : cluster [WRN] failed to encode map e100467 with expected crc<br />2018-07-27 15:53:49.944756 osd.17 osd.17 <a href="10.0.0.15:6800/120749">10.0.0.15:6800/120749</a> 13 : cluster [WRN] failed to encode map e100467 with expected crc<br /> <br />Is this a sign that full OSD maps were sent out by the mons to every OSD like back in the hammer days?  I seem to remember that OSD maps should be a lot smaller now, so maybe this isn't as big of a problem as it was back then?<br /> <br />Thanks,<br />Bryan<br /> <br /><br />From: ceph-users &lt;ceph-users-bounces-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org
 .com&gt; on behalf of Sage Weil &lt;sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;<br />Date: Friday, July 27, 2018 at 1:25 PM<br />To: "ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" &lt;ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;,
"ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" &lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;, "ceph-maintainers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" &lt;ceph-maintainers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" &lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;<br />Subject: [ceph-users] v13.2.1 Mimic released<br /><br /> <br /><br />This is the first bugfix release of the Mimic v13.2.x long term stable release<br /><br />series. This release contains many fixes across all components of Ceph,<br /><br />including a few security fixes. We recommend that all users upgrade.<br /><br /> <br /><br />Notable Changes<br /><br />--------------<br /><br /> <br /><br />* CVE 2018-1128: auth: cephx authorizer subject to replay attack (issue#24836 <a href="http://tracker.ceph.com/issues/24836">http://tracker.ceph.com/issues/24836</a>, Sage Weil)<br /><br />
 * CVE 2018-1129: auth: cephx signature check is weak (issue#24837 <a href="http://tracker.ceph.com/issues/24837">http://tracker.ceph.com/issues/24837</a>[<a
href="http://tracker.ceph.com/issues/24837">http://tracker.ceph.com/issues/24837</a>], Sage Weil)<br /><br />* CVE 2018-10861: mon: auth checks not correct for pool ops (issue#24838<br /><br />* &lt;<a href="http://tracker.ceph.com/issues/24838">http://tracker.ceph.com/issues/24838</a>[<a href="http://tracker.ceph.com/issues/24838">http://tracker.ceph.com/issues/24838</a>], Jason Dillaman)<br /><br /> <br /><br />For more details and links to various issues and pull requests, please<br /><br />refer to the ceph release blog at <a href="https://ceph.com/releases/13-2-1-mimic-released">https://ceph.com/releases/13-2-1-mimic-released</a>[<a href="https://ceph.com/releases/13-2-1-mimic-released">https://ceph.com/releases/13-2-1-mimic-released</a>]<br /><br /> <br /><br />Changelog<br /><br /
 >---------<br /><br />* bluestore:  common/hobject: improved hash calculation for hobject_t etc (pr#22777, Adam Kupczyk, Sage Weil)<br /><br />* bluestore,core: mimic: os/bluestore: don't
store/use path_block.{db,wal} from meta (pr#22477, Sage Weil, Alfredo Deza)<br /><br />* bluestore: os/bluestore: backport 24319 and 24550 (issue#24550, issue#24502, issue#24319, issue#24581, pr#22649, Sage Weil)<br /><br />* bluestore: os/bluestore: fix incomplete faulty range marking when doing compression (pr#22910, Igor Fedotov)<br /><br />* bluestore: spdk: fix ceph-osd crash when activate SPDK (issue#24472, issue#24371, pr#22684, tone-zhang)<br /><br />* build/ops: build/ops: ceph.git has two different versions of dpdk in the source tree (issue#24942, issue#24032, pr#23070, Kefu Chai)<br /><br />* build/ops: build/ops: <a href="http://install-deps.sh">install-deps.sh</a> fails on newest openSUSE Leap (issue#25065, pr#23178, Kyr Shatskyy)<br /><br />* build/ops: build/ops: Mimic build
  fails with -DWITH_RADOSGW=0 (issue#24766, pr#22851, Dan Mick)<br /><br />* build/ops: cmake: enable RTTI for both debug and release RocksDB builds (pr#22299, Igor Fedotov)<br /><br />* build/ops:
deb/rpm: add python-six as build-time and run-time dependency (issue#24885, pr#22948, Nathan Cutler, Kefu Chai)<br /><br />* build/ops: deb,rpm: fix block.db symlink ownership (pr#23246, Sage Weil)<br /><br />* build/ops: include: fix build with older clang (OSX target) (pr#23049, Christopher Blum)<br /><br />* build/ops: include: fix build with older clang (pr#23034, Kefu Chai)<br /><br />* build/ops,rbd: build/ops: order rbdmap.service before remote-fs-pre.target (issue#24713, issue#24734, pr#22843, Ilya Dryomov)<br /><br />* cephfs: cephfs: allow prohibiting user snapshots in CephFS (issue#24705, issue#24284, pr#22812, "Yan, Zheng")<br /><br />* cephfs: cephfs-journal-tool: Fix purging when importing an zero-length journal (issue#24861, pr#22981, yupeng chen, zhongyan gu)<br /><br />* c
 ephfs: client: fix bug #24491 _ll_drop_pins may access invalid iterator (issue#24534, pr#22791, Liu Yangkuan)<br /><br />* cephfs: client: update inode fields according to issued caps (issue#24539,
issue#24269, pr#22819, "Yan, Zheng")<br /><br />* cephfs: common/DecayCounter: set last_decay to current time when decoding dec… (issue#24440, issue#24537, pr#22816, Zhi Zhang)<br /><br />* cephfs,core: mon/MDSMonitor: do not send redundant MDS health messages to cluster log (issue#24308, issue#24330, pr#22265, Sage Weil)<br /><br />* cephfs: mds: add magic to header of open file table (issue#24541, issue#24240, pr#22841, "Yan, Zheng")<br /><br />* cephfs: mds: low wrlock efficiency due to dirfrags traversal (issue#24704, issue#24467, pr#22884, Xuehan Xu)<br /><br />* cephfs: PurgeQueue sometimes ignores Journaler errors (issue#24533, issue#24703, pr#22810, John Spray)<br /><br />* cephfs,rbd: osdc: Fix the wrong BufferHead offset (issue#24583, pr#22869, dongdong tao)<br /><br />* cephfs
 : repeated eviction of idle client until some IO happens (issue#24052, issue#24296, pr#22550, "Yan, Zheng")<br /><br />* cephfs: test gets ENOSPC from bluestore block device (issue#24238,
issue#24913, issue#24899, issue#24758, pr#22835, Patrick Donnelly, Sage Weil)<br /><br />* cephfs,tests: pjd: cd: too many arguments (issue#24310, pr#22882, Neha Ojha)<br /><br />* cephfs,tests: qa: client socket inaccessible without sudo (issue#24872, issue#24904, pr#23030, Patrick Donnelly)<br /><br />* cephfs,tests: qa: fix ffsb cd argument (issue#24719, issue#24829, issue#24680, issue#24579, pr#22956, Yan, Zheng, Patrick Donnelly)<br /><br />* cephfs,tests: qa/suites: Add supported-random-distro$ links (issue#24706, issue#24138, pr#22700, Warren Usui)<br /><br />* ceph-volume describe better the options for migrating away from ceph-disk (pr#22514, Alfredo Deza)<br /><br />* ceph-volume dmcrypt and activate --all documentation updates (pr#22529, Alfredo Deza)<br /><br />* ceph-volume: e
 rror on commands that need ceph.conf to operate (issue#23941, pr#22747, Andrew Schoen)<br /><br />* ceph-volume expand on the LVM API to create multiple LVs at different sizes (pr#22508, Alfredo
Deza)<br /><br />* ceph-volume initial take on auto sub-command (pr#22515, Alfredo Deza)<br /><br />* ceph-volume lvm.activate Do not search for a MON configuration (pr#22398, Wido den Hollander)<br /><br />* ceph-volume lvm.common use destroy-new, doesn't need admin keyring (issue#24585, pr#22900, Alfredo Deza)<br /><br />* ceph-volume: provide a nice errror message when missing ceph.conf (pr#22832, Andrew Schoen)<br /><br />* ceph-volume tests destroy osds on monitor hosts (pr#22507, Alfredo Deza)<br /><br />* ceph-volume tests do not include admin keyring in OSD nodes (pr#22425, Alfredo Deza)<br /><br />* ceph-volume tests.functional install new ceph-ansible dependencies (pr#22535, Alfredo Deza)<br /><br />* ceph-volume: tests/functional run lvm list after OSD provisioning (issue#24961,
  pr#23148, Alfredo Deza)<br /><br />* ceph-volume tests/functional use Ansible 2.6 (pr#23244, Alfredo Deza)<br /><br />* ceph-volume: unmount lvs correctly before zapping (issue#24796, pr#23127,
Andrew Schoen)<br /><br />* cmake: bump up the required boost version to 1.67 (pr#22412, Kefu Chai)<br /><br />* common: common: Abort in OSDMap::decode() during qa/standalone/erasure-code/<a href="http://test-erasure-eio.sh">test-erasure-eio.sh</a> (issue#24865, issue#23492, pr#23024, Sage Weil)<br /><br />* common: common: fix typo in rados bench write JSON output (issue#24292, issue#24199, pr#22406, Sandor Zeestraten)<br /><br />* common,core: common: partially revert 95fc248 to make get_process_name work (issue#24123, issue#24215, pr#22311, Mykola Golub)<br /><br />* common: osd: Change osd_skip_data_digest default to false and make it LEVEL_DEV (pr#23084, Sage Weil, David Zafman)<br /><br />* common: tell ... config rm &lt;foo&gt; not idempotent (issue#24468, issue#24408, pr#22552, Sa
 ge Weil)<br /><br />* core: bluestore: flush_commit is racy (issue#24261, issue#21480, pr#22382, Sage Weil)<br /><br />* core: ceph osd safe-to-destroy crashes the mgr (issue#24708, issue#23249,
pr#22805, Sage Weil)<br /><br />* core: change default filestore_merge_threshold to -10 (issue#24686, issue#24747, pr#22813, Douglas Fuller)<br /><br />* core: common/hobject: improved hash calculation (pr#22722, Adam Kupczyk)<br /><br />* core: cosbench stuck at booting cosbench driver (issue#24473, pr#22887, Neha Ojha)<br /><br />* core: librados: fix buffer overflow for aio_exec python binding (issue#24475, pr#22707, Aleksei Gutikov)<br /><br />* core: mon: enable level_compaction_dynamic_level_bytes for rocksdb (issue#24375, issue#24361, pr#22361, Kefu Chai)<br /><br />* core: mon/MgrMonitor: change 'unresponsive' message to info level (issue#24246, issue#24222, pr#22333, Sage Weil)<br /><br />* core: mon/OSDMonitor: no_reply on MOSDFailure messages (issue#24322, issue#24350, pr#22297,
  Sage Weil)<br /><br />* core: os/bluestore: firstly delete db then delete bluefs if open db met error (pr#22525, Jianpeng Ma)<br /><br />* core: os/bluestore: fix races on SharedBlob::coll in
~SharedBlob (issue#24859, issue#24887, pr#23065, Radoslaw Zarzynski)<br /><br />* core: osd: choose_acting loop (issue#24383, issue#24618, pr#22889, Neha Ojha)<br /><br />* core: osd: do not blindly roll forward to log.head (issue#24597, pr#22997, Sage Weil)<br /><br />* core: osd: eternal stuck PG in 'unfound_recovery' (issue#24500, issue#24373, pr#22545, Sage Weil)<br /><br />* core: osd: fix deep scrub with osd_skip_data_digest=true (default) and blue… (issue#24922, issue#24958, pr#23094, Sage Weil)<br /><br />* core: osd: fix getting osd maps on initial osd startup (pr#22651, Paul Emmerich)<br /><br />* core: osd: increase default hard pg limit (issue#24355, pr#22621, Josh Durgin)<br /><br />* core: osd: may get empty info at recovery (issue#24771, issue#24588, pr#22861, Sage Weil)<b
 r /><br />* core: osd/PrimaryLogPG: rebuild attrs from clients (issue#24768, issue#24805, pr#22960, Sage Weil)<br /><br />* core: osd: retry to read object attrs at EC recovery (issue#24406,
pr#22394, xiaofei cui)<br /><br />* core: osd/Session: fix invalid iterator dereference in Sessoin::have_backoff() (issue#24486, issue#24494, pr#22730, Sage Weil)<br /><br />* core: PG: add custom_reaction Backfilled and release reservations after bac… (issue#24332, pr#22559, Neha Ojha)<br /><br />* core: set correctly shard for existed Collection (issue#24769, issue#24761, pr#22859, Jianpeng Ma)<br /><br />* core,tests: Bring back diff -y for non-FreeBSD (issue#24738, issue#24470, pr#22826, Sage Weil, David Zafman)<br /><br />* core,tests: ceph_test_rados_api_misc: fix LibRadosMiscPool.PoolCreationRace (issue#24204, issue#24150, pr#22291, Sage Weil)<br /><br />* core,tests: qa/workunits/suites/<a href="http://blogbench.sh">blogbench.sh</a>: use correct dir name (pr#22775, Neha Ojha)<br 
 /><br />* core,tests: Wip scrub omap (issue#24366, issue#24381, pr#22374, David Zafman)<br /><br />* core,tools: ceph-detect-init: stop using platform.linux_distribution (issue#18163, pr#21523,
Nathan Cutler)<br /><br />* core: ValueError: too many values to unpack due to lack of subdir (issue#24617, pr#22888, Neha Ojha)<br /><br />* doc: ceph-bluestore-tool manpage not getting rendered correctly (issue#25062, issue#24800, pr#23176, Nathan Cutler)<br /><br />* doc: doc: update experimental features - snapshots (pr#22803, Jos Collin)<br /><br />* doc: fix the links in releases/schedule.rst (pr#22372, Kefu Chai)<br /><br />* doc: [mimic] doc/cephfs: remove lingering "experimental" note about multimds (pr#22854, John Spray)<br /><br />* lvm: when osd creation fails log the exception (issue#24456, pr#22640, Andrew Schoen)<br /><br />* mgr/dashboard: Fix bug when creating S3 keys (pr#22468, Volker Theile)<br /><br />* mgr/dashboard: fix lint error caused by codelyzer update (pr#22713,
  Tiago Melo)<br /><br />* mgr/dashboard: Fix some datatable CSS issues (pr#22274, Volker Theile)<br /><br />* mgr/dashboard: Float numbers incorrectly formatted (issue#24081, issue#24707, pr#22886,
Stephan Müller, Tiago Melo)<br /><br />* mgr/dashboard: Missing breadcrumb on monitor performance counters page (issue#24764, pr#22849, Ricardo Marques, Tiago Melo)<br /><br />* mgr/dashboard: Replace Pool with Pools (issue#24699, pr#22807, Lenz Grimmer)<br /><br />* mgr: mgr/dashboard: Listen on port 8443 by default and not 8080 (pr#22449, Wido den Hollander)<br /><br />* mgr,mon: exception for dashboard in config-key warning (pr#22770, John Spray)<br /><br />* mgr,pybind: Python bindings use iteritems method which is not Python 3 compatible (issue#24803, issue#24779, pr#22917, Nathan Cutler)<br /><br />* mgr: Sync up ceph-mgr prometheus related changes (pr#22341, Boris Ranto)<br /><br />* mon: don't require CEPHX_V2 from mons until nautilus (pr#23233, Sage Weil)<br /><br />* mon/OSDMoni
 tor: Respect paxos_propose_interval (pr#22268, Xiaoxi CHEN)<br /><br />* osd: forward-port osd_distrust_data_digest from luminous (pr#23184, Sage Weil)<br /><br />* osd/OSDMap: fix CEPHX_V2 osd
requirement to nautilus, not mimic (pr#23250, Sage Weil)<br /><br />* qa/rgw: disable testing on ec-cache pools (issue#23965, pr#23096, Casey Bodley)<br /><br />* qa/suites/upgrade/mimic-p2p: allow target version to apply (pr#23262, Sage Weil)<br /><br />* qa/tests: added supported distro for powercycle suite (pr#22224, Yuri Weinstein)<br /><br />* qa/tests: changed distro symlink to point to new way using supported OSes (pr#22653, Yuri Weinstein)<br /><br />* rbd: librbd: deep_copy: resize head object map if needed (issue#24499, issue#24399, pr#22768, Mykola Golub)<br /><br />* rbd: librbd: fix crash when opening nonexistent snapshot (issue#24637, issue#24698, pr#22943, Mykola Golub)<br /><br />* rbd: librbd: force 'invalid object map' flag on-disk update (issue#24496, issue#24434, pr#227
 54, Mykola Golub)<br /><br />* rbd: librbd: utilize the journal disabled policy when removing images (issue#24388, issue#23512, pr#22662, Jason Dillaman)<br /><br />* rbd: Prevent the use of
internal feature bits from outside cls/rbd (issue#24165, issue#24203, pr#22222, Jason Dillaman)<br /><br />* rbd: rbd-mirror daemon failed to stop on active/passive test case (issue#24390, pr#22667, Jason Dillaman)<br /><br />* rbd: [rbd-mirror] entries_behind_master will not be zero after mirror over (issue#24391, issue#23516, pr#22549, Jason Dillaman)<br /><br />* rbd: rbd-mirror simple image map policy doesn't always level-load instances (issue#24519, issue#24161, pr#22892, Venky Shankar)<br /><br />* rbd: rbd trash purge --threshold should support data pool (issue#24476, issue#22872, pr#22891, Mahati Chamarthy)<br /><br />* rbd,tests: qa: krbd_exclusive_<a href="http://option.sh">option.sh</a>: bump lock_timeout to 60 seconds (issue#25081, pr#23209, Ilya Dryomov)<br /><br />* rbd: yet 
 another case when deep copying a clone may result in invalid object map (issue#24596, issue#24545, pr#22894, Mykola Golub)<br /><br />* rgw: cls_bucket_list fails causes cascading osd crashes
(issue#24631, issue#24117, pr#22927, Yehuda Sadeh)<br /><br />* rgw: multisite: RGWSyncTraceNode released twice and crashed in reload (issue#24432, issue#24619, pr#22926, Tianshan Qu)<br /><br />* rgw: objects in cache never refresh after rgw_cache_expiry_interval (issue#24346, issue#24385, pr#22643, Casey Bodley)<br /><br />* rgw: add configurable AWS-compat invalid range get behavior (issue#24317, issue#24352, pr#22590, Matt Benjamin)<br /><br />* rgw: Admin OPS Api overwrites email when user is modified (issue#24253, pr#22523, Volker Theile)<br /><br />* rgw: fix gc may cause a large number of read traffic (issue#24807, issue#24767, pr#22941, Xin Liao)<br /><br />* rgw: have a configurable authentication order (issue#23089, issue#24547, pr#22842, Abhishek Lekshmanan)<br /><br />* rgw: i
 ndex complete miss zones_trace set (issue#24701, issue#24590, pr#22818, Tianshan Qu)<br /><br />* rgw: Invalid Access-Control-Request-Request may bypass validate_cors_rule_method (issue#24809,
issue#24223, pr#22935, Jeegn Chen)<br /><br />* rgw: meta and data notify thread miss stop cr manager (issue#24702, issue#24589, pr#22821, Tianshan Qu)<br /><br />* rgw:-multisite: endless loop in RGWBucketShardIncrementalSyncCR (issue#24700, issue#24603, pr#22815, cfanz)<br /><br />* rgw: performance regression for luminous 12.2.4 (issue#23379, issue#24633, pr#22929, Mark Kogan)<br /><br />* rgw: radogw-admin reshard status command should print text for reshar… (issue#24834, issue#23257, pr#23021, Orit Wasserman)<br /><br />* rgw: "radosgw-admin objects expire" always returns ok even if the pro… (issue#24831, issue#24592, pr#23001, Zhang Shaowen)<br /><br />* rgw: require --yes-i-really-mean-it to run radosgw-admin orphans find (issue#24146, issue#24843, pr#22986, Matt Benjamin)<br />
 <br />* rgw: REST admin metadata API paging failure bucket &amp; bucket.instance: InvalidArgument (issue#23099, issue#24813, pr#22933, Matt Benjamin)<br /><br />* rgw: set cr state if aio_read err
return in RGWCloneMetaLogCoroutine:state_send_rest_request (issue#24566, issue#24783, pr#22880, Tianshan Qu)<br /><br />* rgw: test/rgw: fix for bucket checkpoints (issue#24212, issue#24313, pr#22466, Casey Bodley)<br /><br />* rgw,tests: add unit test for cls bi list command (issue#24736, issue#24483, pr#22845, Orit Wasserman)<br /><br />* tests: mimic - qa/tests: Set ansible-version: 2.4 (issue#24926, pr#23122, Yuri Weinstein)<br /><br />* tests: osd sends op_reply out of order (issue#25010, pr#23136, Neha Ojha)<br /><br />* tests: qa/tests - added overrides stanza to allow runs on ovh on rhel OS (pr#23156, Yuri Weinstein)<br /><br />* tests: qa/tests - added skeleton for mimic point to point upgrades testing (pr#22697, Yuri Weinstein)<br /><br />* tests: qa/tests: fix supported distro l
 ists for ceph-deploy (pr#23017, Vasu Kulkarni)<br /><br />* tests: qa: wait longer for osd to flush pg stats (issue#24321, pr#22492, Kefu Chai)<br /><br />* tests: tests: Health check failed: 1
MDSs report slow requests (MDS_SLOW_REQUEST) in powercycle (issue#25034, pr#23154, Neha Ojha)<br /><br />* tests: tests: make test_ceph_<a href="http://argparse.py">argparse.py</a> pass on py3-only systems (issue#24825, issue#24816, pr#22988, Nathan Cutler)<br /><br />* tests: upgrade/luminous-x: whitelist REQUEST_SLOW for rados_mon_thrash (issue#25056, issue#25051, pr#23164, Nathan Cutler)<br /><br /> <br /><br />Getting ceph:<br /><br />* Git at git://<a href="http://github.com/ceph/ceph.git">github.com/ceph/ceph.git</a><br /><br />* Tarball at <a href="http://download.ceph.com/tarballs/ceph-13.2.1.tar.gz">http://download.ceph.com/tarballs/ceph-13.2.1.tar.gz</a>[<a href="http://download.ceph.com/tarballs/ceph-13.2.1.tar.gz">http://download.ceph.com/tarballs/ceph-13.2.1.tar.gz</a>]<br />
 <br />* For packages, see <a href="http://docs.ceph.com/docs/master/install/get-packages">http://docs.ceph.com/docs/master/install/get-packages</a>/[<a
href="http://docs.ceph.com/docs/master/install/get-packages">http://docs.ceph.com/docs/master/install/get-packages</a>/]<br /><br />* Release git sha1: 5533ecdc0fda920179d7ad84e0aa65a127b20d77<br /><hr />ceph-users mailing list ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <a href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a>[<a href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a>]<br /> <br /> <br />--<br />To unsubscribe from this list: send the line "unsubscribe ceph-devel" in<br />the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br />More majordomo info at  <a href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a><br /><br /
 ></pre></blockquote></div></body></html>
------FE09FZHR6P45HMI122GNH3NFZCEAV6--


--===============4772537358002510637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4772537358002510637==--
