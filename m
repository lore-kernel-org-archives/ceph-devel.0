From: Sage Weil <sage@redhat.com>
Subject: v0.94.6 Hammer released
Date: Tue, 23 Feb 2016 11:01:55 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1090459261-1456243315=:7485"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42888 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbcBWQCZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Feb 2016 11:02:25 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1090459261-1456243315=:7485
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

This Hammer point release fixes a range of bugs, most notably a fix for=20
unbounded growth of the monitor=E2=80=99s leveldb store, and a workaround i=
n the=20
OSD to keep most xattrs small enough to be stored inline in XFS inodes.

We recommend that all hammer v0.94.x users upgrade.

For more detailed information, see the complete changelog:

  http://docs.ceph.com/docs/master/_downloads/v0.94.6.txt

Notable Changes
---------------

* build/ops: Ceph daemon failed to start, because the service name was alre=
ady used. (#13474, Chuanhong Wang)
* build/ops: LTTng-UST tracing should be dynamically enabled (#13274, Jason=
 Dillaman)
* build/ops: ceph upstart script rbdmap.conf incorrectly processes paramete=
rs (#13214, Sage Weil)
* build/ops: ceph.spec.in License line does not reflect COPYING (#12935, Na=
than Cutler)
* build/ops: ceph.spec.in libcephfs_jni1 has no %post and %postun  (#12927,=
 Owen Synge)
* build/ops: configure.ac: no use to add "+" before ac_ext=3Dc (#14330, Kef=
u Chai, Robin H. Johnson)
* build/ops: deb: strip tracepoint libraries from Wheezy/Precise builds (#1=
4801, Jason Dillaman)
* build/ops: init script reload doesn't work on EL7 (#13709, Herv=C3=A9 Rou=
sseau)
* build/ops: init-rbdmap uses distro-specific functions (#12415, Boris Rant=
o)
* build/ops: logrotate reload error on Ubuntu 14.04 (#11330, Sage Weil)
* build/ops: miscellaneous spec file fixes (#12931, #12994, #12924, #12360,=
 Boris Ranto, Nathan Cutler, Owen Synge, Travis Rhoden, Ken Dreyer)
* build/ops: pass tcmalloc env through to ceph-os (#14802, Sage Weil)
* build/ops: rbd-replay-* moved from ceph-test-dbg to ceph-common-dbg as we=
ll (#13785, Loic Dachary)
* build/ops: unknown argument --quiet in udevadm settle (#13560, Jason Dill=
aman)
* common: Objecter: pool op callback may hang forever. (#13642, xie xingguo=
)
* common: Objecter: potential null pointer access when do pool_snap_list. (=
#13639, xie xingguo)
* common: ThreadPool add/remove work queue methods not thread safe (#12662,=
 Jason Dillaman)
* common: auth/cephx: large amounts of log are produced by osd (#13610, Qia=
nkun Zheng)
* common: client nonce collision due to unshared pid namespaces (#13032, Jo=
sh Durgin)
* common: common/Thread:pthread_attr_destroy(thread_attr) when done with it=
 (#12570, Piotr Da=C5=82ek)
* common: log: Log.cc: Assign LOG_DEBUG priority to syslog calls (#13993, B=
rad Hubbard)
* common: objecter: cancellation bugs (#13071, Jianpeng Ma)
* common: pure virtual method called (#13636, Jason Dillaman)
* common: small probability sigabrt when setting rados_osd_op_timeout (#132=
08, Ruifeng Yang)
* common: wrong conditional for boolean function KeyServer::get_auth() (#97=
56, #13424, Nathan Cutler)
* crush: crash if we see CRUSH_ITEM_NONE in early rule step (#13477, Sage W=
eil)
* doc: man: document listwatchers cmd in "rados" manpage (#14556, Kefu Chai=
)
* doc: regenerate man pages, add orphans commands to radosgw-admin(8) (#146=
37, Ken Dreyer)
* fs: CephFS restriction on removing cache tiers is overly strict (#11504, =
John Spray)
* fs: fsstress.sh fails (#12710, Yan, Zheng)
* librados: LibRadosWatchNotify.WatchNotify2Timeout (#13114, Sage Weil)
* librbd: ImageWatcher shouldn't block the notification thread (#14373, Jas=
on Dillaman)
* librbd: diff_iterate needs to handle holes in parent images (#12885, Jaso=
n Dillaman)
* librbd: fix merge-diff for >2GB diff-files (#14030, Jason Dillaman)
* librbd: invalidate object map on error even w/o holding lock (#13372, Jas=
on Dillaman)
* librbd: reads larger than cache size hang (#13164, Lu Shi)
* mds: ceph mds add_data_pool check for EC pool is wrong (#12426, John Spra=
y)
* mon: MonitorDBStore: get_next_key() only if prefix matches (#11786, Joao =
Eduardo Luis)
* mon: OSDMonitor: do not assume a session exists in send_incremental() (#1=
4236, Joao Eduardo Luis)
* mon: check for store writeablility before participating in election (#130=
89, Sage Weil)
* mon: compact full epochs also (#14537, Kefu Chai)
* mon: include min_last_epoch_clean as part of PGMap::print_summary and PGM=
ap::dump (#13198, Guang Yang)
* mon: map_cache can become inaccurate if osd does not receive the osdmaps =
(#10930, Kefu Chai)
* mon: should not set isvalid =3D true when cephx_verify_authorizer return =
false (#13525, Ruifeng Yang)
* osd: Ceph Pools' MAX AVAIL is 0 if some OSDs' weight is 0 (#13840, Chengy=
uan Li)
* osd: FileStore calls syncfs(2) even it is not supported (#12512, Kefu Cha=
i)
* osd: FileStore: potential memory leak if getattrs fails. (#13597, xie xin=
gguo)
* osd: IO error on kvm/rbd with an erasure coded pool tier (#12012, Kefu Ch=
ai)
* osd: OSD::build_past_intervals_parallel() shall reset primary and up_prim=
ary when begin a new past_interval. (#13471, xiexingguo)
* osd: ReplicatedBackend: populate recovery_info.size for clone (bug sympto=
m is size mismatch on replicated backend on a clone in scrub) (#12828, Samu=
el Just)
* osd: ReplicatedPG: wrong result code checking logic during sparse_read (#=
14151, xie xingguo)
* osd: ReplicatedPG::hit_set_trim osd/ReplicatedPG.cc: 11006: FAILED assert=
(obc) (#13192, #9732, #12968, Kefu Chai, Zhiqiang Wang, Samuel Just, David =
Zafman)
* osd: avoid multi set osd_op.outdata in tier pool (#12540, Xinze Chi)
* osd: bug with cache/tiering and snapshot reads (#12748, Kefu Chai)
* osd: ceph osd pool stats broken in hammer (#13843, BJ Lougee)
* osd: ceph-disk prepare fails if device is a symlink (#13438, Joe Julian)
* osd: check for full before changing the cached obc (hammer) (#13098, Alex=
ey Sheplyakov)
* osd: config_opts: increase suicide timeout to 300 to match recovery (#143=
76, Samuel Just)
* osd: disable filestore_xfs_extsize by default (#14397, Ken Dreyer)
* osd: do not cache unused memory in attrs (#12565, Xinze Chi, Ning Yao)
* osd: dumpling incrementals do not work properly on hammer and newer (#132=
34, Samuel Just)
* osd: filestore: fix peek_queue for OpSequencer (#13209, Xinze Chi)
* osd: hit set clear repops fired in same epoch as map change -- segfault s=
ince they fall into the new interval even though the repops are cleared (#1=
2809, Samuel Just)
* osd: object_info_t::decode() has wrong version (#13462, David Zafman)
* osd: osd/OSD.cc: 2469: FAILED assert(pg_stat_queue.empty()) on shutdown (=
#14212, Sage Weil)
* osd: osd/PG.cc: 288: FAILED assert(info.last_epoch_started >=3D info.hist=
ory.last_epoch_started) (#14015, David Zafman)
* osd: osd/PG.cc: 3837: FAILED assert(0 =3D=3D "Running incompatible OSD") =
(#11661, David Zafman)
* osd: osd/ReplicatedPG: Recency fix (#14320, Sage Weil, Robert LeBlanc)
* osd: pg stuck in replay (#13116, Sage Weil)
* osd: race condition detected during send_failures (#13821, Sage Weil)
* osd: randomize scrub times (#10973, Kefu Chai)
* osd: requeue_scrub when kick_object_context_blocked (#12515, Xinze Chi)
* osd: revert: use GMT time for hitsets (#13812, Loic Dachary)
* osd: segfault in agent_work (#13199, Samuel Just)
* osd: should recalc the min_last_epoch_clean when decode PGMap (#13112, Ke=
fu Chai)
* osd: smaller object_info_t xattrs (#14803, Sage Weil)
* osd: we do not ignore notify from down osds (#12990, Samuel Just)
* rbd: QEMU hangs after creating snapshot and stopping VM (#13726, Jason Di=
llaman)
* rbd: TaskFinisher::cancel should remove event from SafeTimer (#14476, Dou=
glas Fuller)
* rbd: avoid re-writing old-format image header on resize (#13674, Jason Di=
llaman)
* rbd: fix bench-write (#14225, Sage Weil)
* rbd: rbd-replay does not check for EOF and goes to endless loop (#14452, =
Mykola Golub)
* rbd: rbd-replay-prep and rbd-replay improvements (#13221, #13220, #13378,=
 Jason Dillaman)
* rbd: verify self-managed snapshot functionality on image create (#13633, =
Jason Dillaman)
* rgw: Make RGW_MAX_PUT_SIZE configurable (#6999, Vladislav Odintsov, Yuan =
Zhou)
* rgw: Setting ACL on Object removes ETag (#12955, Brian Felton)
* rgw: backport content-type casing (#12939, Robin H. Johnson)
* rgw: bucket listing hangs on versioned buckets (#12913, Yehuda Sadeh)
* rgw: fix wrong etag calculation during POST on S3 bucket. (#11241, Vladis=
lav Odintsov, Radoslaw Zarzynski)
* rgw: get bucket location returns region name, not region api name (#13458=
, Yehuda Sadeh)
* rgw: missing handling of encoding-type=3Durl when listing keys in bucket =
(#12735, Jeff Weber)
* rgw: orphan tool should be careful about removing head objects (#12958, Y=
ehuda Sadeh)
* rgw: orphans finish segfaults (#13824, Igor Fedotov)
* rgw: rgw-admin: document orphans commands in usage (#14516, Yehuda Sadeh)
* rgw: swift API returns more than real object count and bytes used when re=
trieving account metadata (#13140, Sangdi Xu)
* rgw: swift use Civetweb ssl can not get right url (#13628, Weijun Duan)
* rgw: value of Swift API's X-Object-Manifest header is not url_decoded dur=
ing segment look up (#12728, Radoslaw Zarzynski)
* tests: fixed broken Makefiles after integration of ttng into rados (#1321=
0, Sebastien Ponce)
* tests: fsx failed to compile (#14384, Greg Farnum)
* tests: notification slave needs to wait for master (#13810, Jason Dillama=
n)
* tests: qa: remove legacy OS support from rbd/qemu-iotests (#13483, #14385=
, Vasu Kulkarni, Jason Dillaman)
* tests: testprofile must be removed before it is re-created (#13664, Loic =
Dachary)
* tools: ceph-monstore-tool must do out_store.close() (#10093, huangjun)
* tools: heavy memory shuffling in rados bench (#12946, Piotr Da=C5=82ek)
* tools: race condition in rados bench (#12947, Piotr Da=C5=82ek)
* tools: tool for artificially inflate the leveldb of the mon store for tes=
ting purposes  (#10093, #11815, #14217, Cilang Zhao, Bo Cai, Kefu Chai, hua=
ngjun, Joao Eduardo Luis)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-0.94.6.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-dep=
loy
--8323329-1090459261-1456243315=:7485--
