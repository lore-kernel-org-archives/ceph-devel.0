From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Luminous v12.2.2 released
Date: Fri, 01 Dec 2017 18:34:08 +0100
Message-ID: <877eu6uzcf.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:54843 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdLAReK (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 1 Dec 2017 12:34:10 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

We're glad to announce the second bugfix release of Luminous v12.2.x
stable release series. It contains a range of bug fixes and a few
features across Bluestore, CephFS, RBD & RGW. We recommend all the users
of 12.2.x series update. 

For more detailed information, see the blog[1] and the complete
changelog[2]

A big thank you to everyone for the continual feedback & bug
reports we've received over this release cycle

Notable Changes
---------------
* Standby ceph-mgr daemons now redirect requests to the active messenger, easing
  configuration for tools & users accessing the web dashboard, restful API, or
  other ceph-mgr module services.
* The prometheus module has several significant updates and improvements.
* The new balancer module enables automatic optimization of CRUSH weights to
  balance data across the cluster.
* The ceph-volume tool has been updated to include support for BlueStore as well
  as FileStore. The only major missing ceph-volume feature is dm-crypt support.
* RGW's dynamic bucket index resharding is disabled in multisite environments,
  as it can cause inconsistencies in replication of bucket indexes to remote
  sites

Other Notable Changes
---------------------
* build/ops: bump sphinx to 1.6 (issue#21717, pr#18167, Kefu Chai, Alfredo Deza)
* build/ops: macros expanding in spec file comment (issue#22250, pr#19173, Ken Dreyer)
* build/ops: python-numpy-devel build dependency for SUSE (issue#21176, pr#17692, Nathan Cutler)
* build/ops: selinux: Allow getattr on lnk sysfs files (issue#21492, pr#18650, Boris Ranto)
* build/ops: Ubuntu amd64 client can not discover the ubuntu arm64 ceph cluster (issue#19705, pr#18293, Kefu Chai)
* core: buffer: fix ABI breakage by removing list _mempool member (issue#21573, pr#18491, Sage Weil)
* core: Daemons(OSD, Mon…) exit abnormally at injectargs command (issue#21365, pr#17864, Yan Jun)
* core: Disable messenger logging (debug ms = 0/0) for clients unless overridden (issue#21860, pr#18529, Jason Dillaman)
* core: Improve OSD startup time by only scanning for omap corruption once (issue#21328, pr#17889, Luo Kexue, David Zafman)
* core: upmap does not respect osd reweights (issue#21538, pr#18699, Theofilos Mouratidis)
* dashboard: barfs on nulls where it expects numbers (issue#21570, pr#18728, John Spray)
* dashboard: OSD list has servers and osds in arbitrary order (issue#21572, pr#18736, John Spray)
* dashboard: the dashboard uses absolute links for filesystems and clients (issue#20568, pr#18737, Nick Erdmann)
* filestore: set default readahead and compaction threads for rocksdb (issue#21505, pr#18234, Josh Durgin, Mark Nelson)
* librbd: object map batch update might cause OSD suicide timeout (issue#21797, pr#18416, Jason Dillaman)
* librbd: snapshots should be created/removed against data pool (issue#21567, pr#18336, Jason Dillaman)
* mds: make sure snap inode’s last matches its parent dentry’s last (issue#21337, pr#17994, “Yan, Zheng”)
* mds: sanitize mdsmap of removed pools (issue#21945, issue#21568, pr#18628, Patrick Donnelly)
* mgr: bulk backport of ceph-mgr improvements (issue#21594, issue#17460,
  issue#21197, issue#21158, issue#21593, pr#18675, Benjeman Meekhof,
  Sage Weil, Jan Fajerski, John Spray, Kefu Chai, My Do, Spandan Kumar Sahu)
* mgr: ceph-mgr gets process called “exe” after respawn (issue#21404, pr#18738, John Spray)
* mgr: fix crashable DaemonStateIndex::get calls (issue#17737, pr#18412, John Spray)
* mgr: key mismatch for mgr after upgrade from jewel to luminous(dev) (issue#20950, pr#18727, John Spray)
* mgr: mgr status module uses base 10 units (issue#21189, issue#21752, pr#18257, John Spray, Yanhu Cao)
* mgr: mgr[zabbix] float division by zero (issue#21518, pr#18734, John Spray)
* mgr: Prometheus crash when update (issue#21253, pr#17867, John Spray)
* mgr: prometheus module generates invalid output when counter names contain non-alphanum characters (issue#20899, pr#17868, John Spray, Jeremy H Austin)
* mgr: Quieten scary RuntimeError from restful module on startup (issue#21292, pr#17866, John Spray)
* mgr: Spurious ceph-mgr failovers during mon elections (issue#20629, pr#18726, John Spray)
* mon: Client client.admin marked osd.2 out, after it was down for 1504627577 seconds (issue#21249, pr#17862, John Spray)
* mon: DNS SRV default service name not used anymore (issue#21204, pr#17863, Kefu Chai)
* mon/MgrMonitor: handle cmd descs to/from disk in the absence of active mgr (issue#21300, pr#18038, Joao Eduardo Luis)
* mon/mgr: sync “mgr_command_descs”,”osd_metadata” and “mgr_metadata” prefixes to new mons (issue#21527, pr#18620, huanwen ren)
* mon: osd feature checks with 0 up osds (issue#21471, issue#20751, pr#18364, Brad Hubbard, Sage Weil)
* mon,osd: fix “pg ls {forced_backfill, backfilling}” (issue#21609, pr#18236, Kefu Chai)
* mon/OSDMonitor: add option to fix up ruleset-* to crush-* for ec profiles (issue#22128, pr#18945, Sage Weil)
* mon, osd: per pool space-full flag support (issue#21409, pr#17730, xie xingguo)
* mon/PGMap: Fix %USED calculation (issue#22247, pr#19230, Xiaoxi Chen)
* mon: update get_store_prefixes implementations (issue#21534, pr#18621, John Spray, huanwen ren)
* msgr: messages/MOSDMap: do compat reencode of crush map, too (issue#21882, pr#18456, Sage Weil)
* msgr: src/messages/MOSDMap: reencode OSDMap for older clients (issue#21660, pr#18140, Sage Weil)
* os/bluestore/BlueFS: fix race with log flush during async log compaction (issue#21878, pr#18503, Sage Weil)
* os/bluestore: fix another aio stall/deadlock (issue#21470, pr#18127, Sage Weil)
* os/bluestore: fix SharedBlob unregistration (issue#22039, pr#18983, Sage Weil)
* os/bluestore: handle compressed extents in blob unsharing checks (issue#21766, pr#18501, Sage Weil)
* os/bluestore: replace 21089 repair with something online (instead of fsck) (issue#21089, pr#17734, Sage Weil)
* os/bluestore: set bitmap freelist resolution to min_alloc_size (issue#21408, pr#18050, Sage Weil)
* os/blueStore::umount will crash when the BlueStore is opened by start_kv_only() (issue#21624, pr#18750, Chang Liu)
* osd: additional protection for out-of-bounds EC reads (issue#21629, pr#18413, Jason Dillaman)
* osd: allow recovery preemption (issue#21613, pr#18025, Sage Weil)
* osd: build_past_intervals_parallel: Ignore new partially created PGs (issue#21833, pr#18673, David Zafman)
* osd: dump bluestore debug on shutdown if debug option is set (issue#21259, pr#18103, Sage Weil)
* osd: make stat_bytes and stat_bytes_used counters PRIO_USEFUL (issue#21981, pr#18723, Yao Zongyou)
* osd: make the PG’s SORTBITWISE assert a more generous shutdown (issue#20416, pr#18132, Greg Farnum)
* osd: OSD metadata ‘backend_filestore_dev_node’ is unknown even for simple deployment (issue#20944, pr#17865, Sage Weil)
* rbd: [cli] mirror getter commands will fail if mirroring has never been enabled (issue#21319, pr#17861, Jason Dillaman)
* rbd: cls/journal: fixed possible infinite loop in expire_tags (issue#21956, pr#18626, Jason Dillaman)
* rbd: cls/journal: possible infinite loop within tag_list class method (issue#21771, pr#18417, Jason Dillaman)
* rbd: [rbd-mirror] asok hook names not updated when image is renamed (issue#20860, pr#17860, Mykola Golub)
* rbd: [rbd-mirror] forced promotion can result in incorrect status (issue#21559, pr#18337, Jason Dillaman)
* rbd: [rbd-mirror] peer cluster connections should filter out command line optionals (issue#21894, pr#18566, Jason Dillaman)
* rgw: add support for Swift’s per storage policy statistics (issue#17932, issue#21506, pr#17835, Radoslaw Zarzynski, Casey Bodley)
* rgw: add support for Swift’s reversed account listings (issue#21148, pr#17834, Radoslaw Zarzynski)
* rgw: avoid logging keystone revocation failures when no keystone is configured (issue#21400, pr#18441, Abhishek Lekshmanan)
* rgw: disable dynamic resharding in multisite enviorment (issue#21725, pr#18432, Orit Wasserman)
* rgw: encryption: PutObj response does not include sse-kms headers (issue#21576, pr#18442, Casey Bodley)
* rgw: encryption: reject requests that don’t provide all expected headers (issue#21581, pr#18429, Enming Zhang)
* rgw: expose --sync-stats via admin api (issues#21301, pr#18439, Nathan Johnson)
* rgw: failed CompleteMultipartUpload request does not release lock (issue#21596, pr#18430, Matt Benjamin)
* rgw_file: set s->obj_size from bytes_written (issue#21940, pr#18599, Matt Benjamin)
* rgw: fix a bug about inconsistent unit of comparison (issue#21590, pr#18438, gaosibei)
* rgw: fix bilog entries on multipart complete (issue#21772, pr#18334, Casey Bodley)
* rgw: fix error handling in ListBucketIndexesCR (issue#21735, pr#18591, Casey Bodley)
* rgw: fix refcnt issues (issue#21819, pr#18539, baixueyu)
* rgw: lc process only schdule the first item of lc objects (issue#21022, pr#17859, Shasha Lu)
* rgw: list bucket which enable versioning get wrong result when user marker (issue#21500, pr#18569, yuliyang)
* rgw: list_objects() honors end_marker regardless of namespace (issue#18977, pr#17832, Radoslaw Zarzynski)
* rgw: Multipart upload may double the quota (issue#21586, pr#18435, Sibei Gao)
* rgw: multisite: Get bucket location which is located in another zonegroup, will return 301 Moved Permanently (issue#21125, pr#17857, Shasha Lu)
* rgw: multisite: race between sync of bucket and bucket instance metadata (issue#21990, pr#18767, Casey Bodley)
* rgw: policy checks missing from Get/SetRequestPayment operations (issue#21389, pr#18440, Adam C. Emerson)
* rgw: radosgw-admin usage show loops indefinitly (issue#21196, pr#18437, Mark Kogan)
* rgw: rgw_file: explicit NFSv3 open() emulation (issue#21854, pr#18446, Matt Benjamin)
* rgw: rgw_file: fix write error when the write offset overlaps (issue#21455, pr#18004, Yao Zongyou)
* rgw: rgw file write error (issue#21455, pr#18433, Yao Zongyou)
* rgw: s3:GetBucketCORS/s3:PutBucketCORS policy fails with 403 (issue#21578, pr#18444, Adam C. Emerson)
* rgw: s3:GetBucketLocation bucket policy fails with 403 (issue#21582, pr#18443, Adam C. Emerson)
* rgw: s3:GetBucketWebsite/PutBucketWebsite fails with 403 (issue#21597, pr#18445, Adam C. Emerson)
* rgw: setxattrs call leads to different mtimes for bucket index and object (issue#21200, pr#17856, Abhishek Lekshmanan)
* rgw: stop/join TokenCache revoke thread only if started (issue#21666, pr#18138, Karol Mroz)
* rgw: string_view instance points to expired memory in PrefixableSignatureHelper (issue#21085, pr#17858, Radoslaw Zarzynski)
* rgw: user creation can overwrite existing user even if different uid is given (issue#21685, pr#18436, Casey Bodley)
* rgw: We cant’t get torrents if objects are encrypted using SSE-C (issue#21720, pr#18431, Zhang Shaowen)
* rgw: wrong error message is returned when putting container with a name that is too long (issue#17938, issue#21169, issue#17935, issue#17934, issue#17936, pr#17811, Radoslaw Zarzynski)
* rgw: zone compression type is not validated (issue#21775, pr#18434, Casey Bodley)
* tools: ceph-disk create deprecation warnings (issue#22154, pr#18989, Alfredo Deza)
* tools: ceph-disk: fix '--runtime' omission for ceph-osd service (issue#21498, pr#17914, Carl Xiong)
* tools: ceph-disk flake8 test fails on very old, and very new, versions of flake8 (issue#22207, pr#19152, Nathan Cutler)
* tools: ceph-disk: retry on OSError (issue#21728, pr#18189, Kefu Chai)
* tools: ceph-disk: unlocks dmcrypted partitions when activating them (issue#20488, pr#18625, Kefu Chai, Felix Winterhalter)
* tools: ceph-kvstore-tool does not call bluestore’s umount when exit (issue#21625, pr#18751, Chang Liu)
* tools: ceph_monstore_tool: rebuild initial mgrmap also (issue#22266, pr#19240, Kefu Chai)
* tools: ceph-objectstore-tool and ceph-bluestore-tool: backports from master (issue#21272, pr#17896, Sage Weil, David Zafman)
* tools: ceph_volume_client: add get, put, and delete object interfaces (issue#21601, pr#18037, Ramana Raja)
* tools: cli/crushtools/build.t sometimes fails in jenkins’ make check run (issue#21758, pr#18398, Kefu Chai, Sage Weil)


Getting Ceph
------------
* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-12.2.2.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* For ceph-deploy, see http://docs.ceph.com/docs/master/install/install-ceph-deploy
* Release git sha1: cf0baeeeeba3b47f9427c6c97e2144b094b7e5ba

[1]: http://ceph.com/releases/v12-2-2-luminous-released/
[2]: http://docs.ceph.com/docs/master/_downloads/v12.2.2.txt

--
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
