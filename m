From: Abhishek L <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: v12.0.0 Luminous (dev) released
Date: Wed, 08 Feb 2017 20:49:31 +0100
Message-ID: <87lgtgxy2c.fsf@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1298208061=="
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1298208061==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


This is the first development checkpoint release of Luminous series, the
next long time stable release. We're off to a good start to release
Luminous in the spring of '17.

Major changes from Kraken
=2D------------------------
 * When assigning a network to the public network and not to
   the cluster network the network specification of the public
   network will be used for the cluster network as well.
   In older versions this would lead to cluster services
   being bound to 0.0.0.0:<port>, thus making the
   cluster service even more publicly available than the
   public services. When only specifying a cluster network it
   will still result in the public services binding to 0.0.0.0.

*  Some variants of the omap_get_keys and omap_get_vals librados
   functions have been deprecated in favor of omap_get_vals2 and
   omap_get_keys2.  The new methods include an output argument
   indicating whether there are additional keys left to fetch.
   Previously this had to be inferred from the requested key count vs
   the number of keys returned, but this breaks with new OSD-side
   limits on the number of keys or bytes that can be returned by a
   single omap request.  These limits were introduced by kraken but
   are effectively disabled by default (by setting a very large limit
   of 1 GB) because users of the newly deprecated interface cannot
   tell whether they should fetch more keys or not.  In the case of
   the standalone calls in the C++ interface
   (IoCtx::get_omap_{keys,vals}), librados has been updated to loop on
   the client side to provide a correct result via multiple calls to
   the OSD.  In the case of the methods used for building
   multi-operation transactions, however, client-side looping is not
   practical, and the methods have been deprecated.  Note that use of
   either the IoCtx methods on older librados versions or the
   deprecated methods on any version of librados will lead to
   incomplete results if/when the new OSD limits are enabled.

*  In previous versions, if a client sent an op to the wrong OSD, the OSD
   would reply with ENXIO.  The rationale here is that the client or OSD is
   clearly buggy and we want to surface the error as clearly as possible.
   We now only send the ENXIO reply if the osd_enxio_on_misdirected_op opti=
on
   is enabled (it's off by default).  This means that a VM using librbd that
   previously would have gotten an EIO and gone read-only will now see a
   blocked/hung IO instead.

*  When configuring ceph-fuse mounts in /etc/fstab, a new syntax is
   available that uses "ceph.<arg>=3D<val>" in the options column, instead
   of putting configuration in the device column.  The old style syntax
   still works.  See the documentation page "Mount CephFS in your
   file systems table" for details.

A more detailed information regarding the release is available at the
official ceph blog at http://ceph.com/releases/v12-0-0-luminous-dev-release=
d/

Notable Changes
=2D--------------
* bluestore: avoid unnecessary copy with coll_t (pr#12576, Yunchuan Wen)
* bluestore: fixed compilation error when enable spdk (pr#12672, Pan Liu)
* bluestore: os/bluestore: add a debug option to bypass block device writes=
 for bl=E2=80=A6 (pr#12464, Igor Fedotov)
* bluestore: os/bluestore: Add bluestore pextent vector to mempool (pr#1294=
6, Igor Fedotvo, Igor Fedotov)
* bluestore: os/bluestore: add perf variable for throttle info in bluestore=
 (pr#12583, Pan Liu)
* bluestore: os/bluestore: allow multiple SPDK BlueStore OSD instances (`is=
sue#16966, pr#12604, Orlando Moreno)
* bluestore: os/bluestore/BitmapFreelistManager: readability improvements (=
pr#12719, xie xingguo)
* bluestore: os/bluestore/BlueFS: fix reclaim_blocks (`issue#18368, pr#1272=
5, Sage Weil)
* bluestore: os/bluestore: conditionally load crr option (pr#12877, xie xin=
gguo)
* bluestore: os/bluestore: fix Allocator::allocate() int truncation (`issue=
#18595, pr#13010, Sage Weil)
* bluestore: os/bluestore: fix min_alloc_size at mkfs time (pr#13192, Sage =
Weil)
* bluestore: os/bluestore: fix NVMEDevice::open failure if serial number en=
ds with a =E2=80=A6 (pr#12956, Hongtong Liu)
* bluestore: os/bluestore: fix OnodeSizeTracking testing (pr#12684, xie xin=
gguo)
* bluestore: os/bluestore: fix potential assert in cache _trim method. (pr#=
13234, Igor Fedotov)
* bluestore: os/bluestore: fix reclaim_blocks and clean up Allocator interf=
ace (`issue#18573, pr#12963, Sage Weil)
* bluestore: os/bluestore: include logical object offset in crc error (pr#1=
3074, Sage Weil)
* bluestore: os/bluestore/KernelDevice: fix debug message (pr#13135, Sage W=
eil)
* bluestore: os/bluestore/KernelDevice: kill zeros (pr#12856, xie xingguo)
* bluestore: os/bluestore: kill BufferSpace.empty() (pr#12871, xie xingguo)
* bluestore: os/bluestore: kill orphan declaration of do_write_check_depth(=
) (pr#12853, xie xingguo)
* bluestore: os/bluestore: miscellaneous fixes to BitAllocator (pr#12696, x=
ie xingguo)
* bluestore: os/bluestore: nullptr in OmapIteratorImpl::valid (pr#12900, Xi=
nze Chi)
* bluestore: os/bluestore/NVMEDevice.cc: fix the random read issue. (pr#130=
55, optimistyzy)
* bluestore: os/bluestore/NVMEdevice: fix the unrelease segs issue (pr#1286=
2, optimistyzy)
* bluestore: os/bluestore: preallocate object[extent_shard] key to avoid re=
allocate (pr#12644, xie xingguo)
* bluestore: os/bluestore: put strings in mempool (pr#12651, Allen Samuels,=
 Sage Weil)
* bluestore: os/bluestore: refactor ExtentMap::update to avoid preceeding d=
b updat=E2=80=A6 (pr#12394, Igor Fedotov)
* bluestore: os/bluestore: remove a never read value (pr#12618, liuchang081=
2)
* bluestore: os/bluestore: remove intermediate key var to avoid string copy=
 (pr#12643, xie xingguo)
* bluestore: os/bluestore: shrink buffer_map key into uint32_t (pr#12850, x=
ie xingguo)
* bluestore: os/bluestore: _txc_release_alloc when do wal cleaning (pr#1269=
2, Xinze Chi)
* bluestore: os: extend ObjectStore interface to dump store's performance c=
ounters (pr#13203, Igor Fedotov)
* bluestore: rocksdb: add option: writable_file_max_buffer_size =3D 0 (pr#1=
2562, Jianpeng Ma)
* build/ops: add sanity checks to run-make-check.sh (pr#12683, Nathan Cutle=
r)
* build/ops: build/cmake:  provide asan, tsan, ubsan builds (pr#12615, Matt=
 Benjamin)
* build/ops: builds with dpdk v16.07 (pr#12707, Kefu Chai)
* build/ops: ceph-detect-init: adding Arch Linux support (pr#12787, Jamin W=
. Collins)
* build/ops,cleanup: auth: Let's not use the deprecated cephx option (pr#12=
721, Dave Chen)
* build/ops: CMakeLists.txt: boost_python.so requires libpython.*.so on Fre=
eBSD (pr#12763, Willem Jan Withagen)
* build/ops: common/module.c: do not use strerror_r the GNU way. (pr#12363,=
 Willem Jan Withagen)
* build/ops,core: ceph-disk: use correct user in check_journal_req (`issue#=
18538, pr#12947, Samuel Matzek)
* build/ops: mailmap: Update OVH contributors (pr#13063, Bart=C5=82omiej =
=C5=9Awi=C4=99cki)
* build/ops: packaging: install libceph-common.so* not libceph-common.so.* =
(`issue#18692, pr#13148, Kefu Chai)
* build/ops: Reviewd-by: Loic Dachary <ldachary-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> (`issue#18635, =
pr#13057, Wido den Hollander)
* build/ops,rgw: rgw_file: radosgw-admin can be built under FreeBSD (pr#121=
91, Willem Jan Withagen)
* build/ops: rocksdb: build with ppc64 (pr#12908, Kefu Chai)
* build/ops: script: adding contributor credits script (pr#13251, Patrick M=
cGarry)
* build/ops: script/sepia_bt.sh: download packages from shaman not gitbuild=
er (pr#12799, Kefu Chai)
* build/ops: spdk: upgrade spdk to v16.12 (pr#12734, Pan Liu)
* build/ops: src/CMakeLists.txt: disable -Werror on rocksdb (pr#12560, Will=
em Jan Withagen)
* build/ops: src/CMakeLists.txt: Move parse_secret_objs setting within defi=
nition block (pr#12785, Willem Jan Withagen)
* build/ops: test/fio_ceph_objectstore: fix fio plugin build failure caused=
 by rec=E2=80=A6 (pr#12655, Igor Fedotov)
* build/ops: tool: add some ceph relate processes to ps-ceph.pl (pr#12406, =
songbaisen)
* build/ops: tracing: Fix error in including all files in osd_tp (pr#12501,=
 Ganesh Mahalingam)
* cephfs: ceph_fuse: pid_file default to empty (`issue#18309, pr#12628, Nat=
han Cutler)
* cephfs,cleanup: client: fix potential buffer overflow (pr#12515, Yunchuan=
 Wen)
* cephfs,cleanup: client: simplify remove_cap interface (pr#12161, John Spr=
ay)
* cephfs,cleanup: libcephfs: cleanups (pr#12830, huanwen ren)
* cephfs,cleanup: qa: unpin knfs from ubuntu (`issue#16397, pr#13088, John =
Spray)
* cephfs,cleanup: Rewrite mount.fuse.ceph (to python) and move ceph-fuse op=
tions to fs_mntops (pr#11448, Edgaras Lukosevicius)
* cephfs: client/Client.cc: prevent segfaulting (`issue#9935, pr#12550, Mic=
hal Jarzabek)
* cephfs: client: don't request lookup parent if ino is root (pr#12478, hua=
nwen ren)
* cephfs: client: fix clang warn of "argument is an uninitialized value" (p=
r#12580, liuchang0812)
* cephfs: 	client: fix Client::handle_cap_flushsnap_ack() crash (`issue#184=
60, pr#12859, Yan, Zheng)
* cephfs: client: fix the cross-quota rename boundary check conditions (pr#=
12489, Greg Farnum)
* cephfs: client: populate metadata during mount (`issue#18361, pr#12915, J=
ohn Spray)
* cephfs: client: remove request from session->requests when handling forwa=
rd (`issue#18675, pr#13124, "Yan, Zheng")
* cephfs,common: include/fs_types: fix unsigned integer overflow (pr#12440,=
 runsisi)
* cephfs,common,rbd: osdc: cache should ignore error bhs during trim (`issu=
e#18436, pr#12966, Jason Dillaman)
* cephfs,core,cleanup,common: librados,osdc: kill ack vs commit distinction=
 (pr#12607, Sage Weil)
* cephfs: libcephfs.cc: fix memory leak (pr#12557, Michal Jarzabek)
* cephfs: libcephfs: fix cct refcount constructing from rados (pr#12831, Jo=
hn Spray)
* cephfs: mon/MDSMonitor.cc:refuse fs new on pools with obj (`issue#11124, =
pr#12825, Michal Jarzabek)
* cephfs: mount: do not print "unknown" option to kclient (`issue#18159, pr=
#12465, John Spray)
* cephfs: qa: update remaining ceph.com to download.ceph.com (`issue#18574,=
 pr#12964, John Spray)
* cephfs: tasks/cephfs: fix kernel force umount (`issue#18396, pr#12833, Ya=
n, Zheng)
* cleanup,bluestore: os/bluestore: avoid unnecessary memory copy, use varia=
ble reference in BlockDevice::Open (pr#12942, liuchang0812)
* cleanup,bluestore: os/bluestore: cleanup BitAllocator (pr#12661, xie xing=
guo)
* cleanup,bluestore: os/bluestore: remove no use parameter in bluestore_blo=
b_t::map_bl (pr#13013, wangzhengyong)
* cleanup,common: auth: Enhancement for the supported auth methods (pr#1293=
7, Dave Chen)
* cleanup,common: bufferlist: cleanup semantical wrong for bufferlist::appe=
nd (pr#12247, Yankun Li)
* cleanup,common: common/BackTrace: add operator<< (pr#9028, Kefu Chai)
* cleanup: common/config: fix return type of string::find and use string::n=
pos (pr#9924, Yan Jun)
* cleanup: common/config_opts.h: remove obsolete configuration option (pr#1=
2659, Li Wang)
* cleanup,common: global: we need to handle the init_on_startup return valu=
e when global_init. (pr#13018, song baisen)
* cleanup,common: msg/async: assert if compiled code doesn't support the co=
nfigured ms_=E2=80=A6 (pr#12559, Avner BenHanoch)
* cleanup,common: msg/async/rdma: clean line endings (pr#12688, Adir Lev)
* cleanup,common: msg/async/rdma: Remove compilation warning (pr#13142, Sar=
it Zubakov)
* cleanup,common: osd/OSDMap: get_previous_up_osd_before() may run into end=
less loop (pr#12976, Mingxin Liu)
* cleanup,common: osd/osd_types: clean up OSDOp printers (pr#12980, Sage We=
il)
* cleanup:   include/mempool: fix typo in comments (pr#12772, huangjun)
* cleanup: mds,mon: Clean issues detected by cppcheck (pr#13199, Ilya Shipi=
tsin)
* cleanup: misc: fix code typos in header files (pr#12716, Xianxia Xiao)
* cleanup: mon/PGMonitor: fix description for ceph pg ls (pr#12807, runsisi)
* cleanup: Move code from .h into .cc (pr#12737, Amir Vadai)
* cleanup: msg/async: avoid atomic variable overhead (pr#12809, Wei Jin)
* cleanup: msg/async: cleanups (pr#12832, Wei Jin)
* cleanup: msg/async/rdma: fix log line spacing (pr#13263, Adir Lev)
* cleanup: msg/async: rm nonused thread variable in posixworker (pr#12777, =
Wei Jin)
* cleanup: msg/Messenger.cc: add std::move (pr#9760, Michal Jarzabek)
* cleanup: msg: Revert the change from assert(0)-> ceph_abort() where is no=
t applicable (pr#12930, Dave Chen)
* cleanup: msg/simple: Remove dead code in pipe.cc (`issue#12684, pr#12601,=
 Rishabh Kumar)
* cleanup: os/bluestore/BlueStore.cc: remove unused variable (pr#12703, Li =
Wang)
* cleanup:   osdc/ObjectCacher: use state instead of get_state() (pr#12544,=
 huangjun)
* cmake: add RGW and MDS to libcephd (pr#12345, Bassam Tabbara)
* cmake: cleanup the use of udev and blkid in target_link_lib() (pr#12811, =
Willem Jan Withagen)
* cmake: disable mallinfo for jemalloc (pr#12469, Bassam Tabbara)
* cmake: explictly call find_package(PythonInterp) first to fix build err (=
pr#12385, Yixun Lan)
* cmake: Fix broken async/rdma compilation since move to libceph-common (pr=
#13122, Oren Duer)
* cmake: fix broken RDMA compilation after merge PR #12878 (pr#13186, Oren =
Duer)
* cmake: fix hard coded boost python lib (pr#12480, John Coyle)
* cmake: fix rpath on shared libraries and binaries targets (pr#12927, Rica=
rdo Dias)
* cmake: link ceph-{mgr,mon,mds,osd} against libcommon statically (pr#12878=
, Kefu Chai)
* cmake: remove Findpciaccess.cmake (pr#12776, optimistyzy)
* cmake: search for Keyutils in default paths (pr#12769, Pascal Bach)
* cmake: search for nspr include files for both suffixes: nspr4 and nspr (`=
issue#18535, pr#12939, John Lin)
* cmake: simplify find_package jemalloc (pr#12468, Bassam Tabbara)
* cmake: support for external rocksdb (pr#12467, Bassam Tabbara)
* cmake: turn libcommon into a shared library (pr#12840, Kefu Chai)
* common/admin-socket: fix potential buffer overflow (pr#12518, Yunchuan We=
n)
* common: common/BackTrace: demangle on FreeBSD also (pr#12992, Kefu Chai)
* common: common/buffer: close pipe fd if set nonblocking fails. (pr#12828,=
 donglinpeng)
* common: common/ceph_context: Show clear message if all features are enabl=
ed (pr#12676, Dave Chen)
* common: common/xmlformatter: turn on underscored and add unittest (pr#129=
16, liuchang0812)
* common: compressor/zstd: add zstd compression plugin (pr#13075, Kefu Chai=
, Sage Weil)
* common: config: Improve warning for unobserved value (`issue#18424, pr#12=
855, Brad Hubbard)
* common/config_opts.h: FreeBSD timing changed due to no SO_REUSEADDR (pr#1=
2594, Willem Jan Withagen)
* common: delete unused conf "filestore_debug_disable_sharded_check" (pr#13=
051, Chuanhong Wang)
* common: get rid of "warning: ignoring return value of =E2=80=98strerror_r=
=E2=80=99" (pr#12775, xie xingguo)
* common: include/denc: improvements (pr#12626, Adam C. Emerson)
* common: make attempts of auth rotating configurable  (pr#12563, xie xingg=
uo)
* common: misc fixes detected by crypto shutdown assert (pr#12925, Sage Wei=
l)
* common: msg/async/rdma: reduce number of rdma rx/tx buffers (pr#13190, Ad=
ir Lev)
* common: msg/async/rdma: Support for RoCE v2 and SL (pr#12556, Oren Duer)
* common: msg/simple: call clear_pipe in wait() shutdown path (`issue#15784=
, pr#12633, Sage Weil)
* common: tracing: Fix handle leak in TracepointProvider (pr#12652, Brad Hu=
bbard)
* core,bluestore: NVMEDevice: fix bug in data_buf_next_sge (pr#12812, optim=
istyzy)
* core,bluestore: os/bluestore: fix statfs to not include DB partition in f=
ree space (`issue#18599, pr#13140, Sage Weil)
* core,cephfs,cleanup: cleanup: use std::make_shared to replace new (pr#122=
76, Yunchuan Wen)
* core,cleanup: msg/async/AsyncConnection: socket's fd can be zero, avoid f=
alse assert (pr#13080, Haomai Wang)
* core,cleanup: osd/ECBackend: cleanup for unnecessary copy with pg_stat_t =
(pr#12564, Yunchuan Wen)
* core,cleanup: osd/ECBackend: only need check missing_loc when doing recov=
ery (pr#12526, huangjun)
* core,cleanup:   osd/ECBackend: remove unused variable "ReadCB" (pr#12543,=
 huangjun)
* core,cleanup: osd,librados: remove clone_range and associated multi-objec=
t cruft (pr#13008, Samuel Just)
* core,cleanup: osd/OpRequest: dump both name and addr for the client op (p=
r#12691, runsisi)
* core,cleanup: osd/OSDMap: Uncomment code to enable private default constr=
uctors (pr#12597, Brad Hubbard)
* core,cleanup: osd/osd_type: Fix logging output (pr#12778, Brad Hubbard)
* core,cleanup: osd/osd_types: Move comment to more relevant position (pr#1=
2779, Brad Hubbard)
* core,cleanup: osd/osd_types: print notify-ack op properly (pr#12585, Sage=
 Weil)
* core,cleanup: osd/PG: add new have_unfound() function in MissingLoc (pr#1=
2668, huangjun)
* core,cleanup: osd/PG: check the connection first in fulfill_log (pr#12579=
, huangjun)
* core,cleanup: osd/PG: simplify the logic of backfill_targets checking (pr=
#12519, huangjun)
* core,cleanup: osd/PrimaryLogPG: optimal pick_newest_available (pr#12695, =
huangjun)
* core,cleanup: osd/PrimaryLogPG: unify the access to primary pg (pr#12527,=
 huangjun)
* core,cleanup: os/filestore/JournalingObjectStore cleanup (pr#12528, Li Wa=
ng)
* core,common: common/pick_address.cc: Copy public_netw to cluster_netw if =
cluster empty (pr#12929, Willem Jan Withagen)
* core,common: mempool: put bloom_filter in mempool (pr#13009, Sage Weil)
* core: global: start removing g_ceph_context (pr#12149, Adam C. Emerson)
* core: messages/MOSDPGTrim: add the missed HEAD_VERSION AND COMPAT_VERSION=
 (`issue#18266, pr#12517, huangjun)
* core: messages/MOSDSubOp: Make encode_payload can be reentrant (pr#12654,=
 Haomai Wang)
* core: mon/OSDMonitor: fixup sortbitwise flag warning (pr#12682, huanwen r=
en)
* core: mon/OSDMonitor: make 'osd crush move ...' work on osds (`issue#1858=
7, pr#12981, Sage Weil)
* core: mon/OSDMonitor: make snaps on tier pool should not be allowed (pr#9=
348, Mingxin Liu)
* core: mon/OSDMonitor: set last_force_op_resend on overlay pool too (`issu=
e#18366, pr#12712, Sage Weil)
* core: mon/OSDMonitor: should propose osdmap update when cluster addr chan=
ged (pr#11065, Mingxin Liu)
* core: msg: allow different ms type for cluster network and public network=
 (pr#12023, Haomai Wang)
* core: msg/async/dpdk: fix compile errors (pr#12698, Haomai Wang)
* core: msg/async/rdma: fix ceph_clock_now calls (pr#12711, Haomai Wang)
* core: msg: client bind (pr#12901, Zengran Zhang, Haomai Wang)
* core: osdc/Objecter: resend pg commands on interval change (`issue#18358,=
 pr#12869, Samuel Just)
* core: osd/PG: publish PG stats when backfill-related states change (`issu=
e#18369, pr#12727, Sage Weil)
* core: osd/PrimaryLogPG::failed_push: update missing as well (`issue#18165=
, pr#12888, Samuel Just)
* core: osd/PrimaryLogPG::try_lock_for_read: give up if missing (`issue#185=
83, pr#13087, Samuel Just)
* core: osd/ReplicatedBackend: take read locks for clone sources during rec=
overy (`issue#17831, pr#12844, Samuel Just)
* core: os/filestore: fix clang static check warn "use-after-free=E2=80=9C =
(pr#12581, liuchang0812)
* core: os/filestore: version will be uninitialized varible if store_versio=
n doesn't exist (pr#12582, liuchang0812)
* core,performance: common/TrackedOp: various cleanups and optimizations (p=
r#12537, Sage Weil)
* core,performance: osd/ECBackend: Send write message to peers first, then =
do local write (pr#12522, huangjun)
* core,performance: osd/pg: bound the portion of the log we request in GetL=
og::GetLog() (pr#12233, Jie Wang)
* core: PrimaryLogPG: don't update digests for objects with mismatched name=
s (`issue#18409, pr#12788, Samuel Just)
* core: Revert "PrimaryLogPG::failed_push: update missing as well" (`issue#=
18624, pr#13090, David Zafman)
* core: test/pybind/test_rados.py: tolerate TimedOut in test_ping_monitor (=
`issue#18529, pr#12934, Samuel Just)
* core,tests: ceph_test_rados_api_misc: Fix trivial memory leak (pr#12680, =
Brad Hubbard)
* core,tests: c_write_operations.cc: Fix trivial memory leak (pr#12663, Bra=
d Hubbard)
* core,tests: qa/suites/rados/basic: set low omap limit for rgw workload (p=
r#13071, Sage Weil)
* core,tests: qa/workunits/rest: use unique pool names for cephfs test (pr#=
13188, Sage Weil)
* core,tests: test/librados/cmd.cc: Fix trivial memory leaks (pr#12671, Bra=
d Hubbard)
* core,tests: test/librados/c_read_operations.cc: Fix trivial memory leak (=
pr#12656, Brad Hubbard)
* core,tests: test/librados/c_read_operations.cc: Fix valgrind errors (`iss=
ue#18354, pr#12657, Brad Hubbard)
* core,tests: test/librados: Silence Coverity memory leak warnings (pr#1244=
2, Brad Hubbard, Samuel Just)
* core,tests: test/librados/snapshots.cc: Fix memory leak (pr#12690, Brad H=
ubbard)
* core,tests: test/librados/tier.cc: Fix valgrind errors (`issue#18360, pr#=
12705, Brad Hubbard)
* core,tests: test_rados_watch_notify: Fix trivial memory leaks (pr#12713, =
Brad Hubbard)
* crush: API documentation (pr#13205, Loic Dachary)
* crush: verify weights is influenced by the number of replicas (`issue#156=
53, pr#13083, Adam C. Emerson, Loic Dachary)
* crush:  when osd_location_hook does not exist, we should exit error. (pr#=
12961, song baisen)
* doc: add 0.94.10 and hammer EOL to releases.rst (pr#13069, Nathan Cutler)
* doc: add verbiage to rbdmap manpage (`issue#18262, pr#12509, Nathan Cutle=
r)
* doc: build/install-deps.sh: Add sphinx package for building docs on FreeB=
SD (pr#13223, Willem Jan Withagen)
* doc/cephfs/troubleshooting: fix broken bullet list (pr#12894, Dan Mick)
* doc: clarify "ceph quorum" syntax (`issue#17802, pr#11787, Nathan Cutler)
* doc: clarify SubmittingPatches.rst (pr#12988, Nathan Cutler)
* doc: clarify the path restriction mds cap example (pr#12993, John Spray)
* doc: correct S3 lifecycle support explain (`issue#18459, pr#12827, liucha=
ng0812)
* doc: doc/dev: update log_based_pg.rst, fix some display problem (pr#12730=
, liuchang0812)
* doc: Doc:Fixes Python Swift client commands (`issue#17746, pr#12887, Rona=
k Jain)
* doc: doc/release-notes: final kraken notes (pr#12968, Sage Weil)
* doc: document repair/scrub features (`issue#15786, pr#9032, Kefu Chai, Da=
vid Zafman)
* doc: Document that osd_heartbeat_grace applies to MON and OSD (pr#13098, =
Wido den Hollander)
* doc: explain about logging levels (pr#12920, liuchang0812)
* doc: fix document about rados mon (pr#12662, liuchang0812)
* doc: Fixes radosgw-admin ex: in swift auth section (`issue#16687, pr#1264=
6, SirishaGuduru)
* doc: fix the librados c api can not compile problem (pr#9396, song baisen)
* doc: mailmap: Michal Koutny affiliation (pr#13036, Nathan Cutler)
* doc: mailmap updates for v11.1.0 (pr#12335, Abhishek Lekshmanan)
* doc: minor change to a cloud testing paragraph (pr#13277, Jan Fajerski)
* doc: min_size advice is not helpful (pr#12936, Brad Hubbard)
* doc: organizationmap: add Xianxia Xiao to Kylin Cloud team (pr#12718, Yun=
chuan Wen)
* doc: README.FreeBSD: update current status (pr#12096, Willem Jan Withagen)
* doc: release notes for v11.1.1 (pr#12642, Abhishek Lekshmanan)
* doc: Remove "splitting" state (pr#12636, Brad Hubbard)
* doc: typo fix in s3_compliance (pr#12598, LiuYang)
* doc: Update disk thread section to reflect that scrubbing is no longe=E2=
=80=A6 (pr#12621, Nick Fisk)
* doc: Update keystone.rst (pr#12717, Chu, Hua-Rong)
* librados: asynchronous selfmanaged_snap_create/selfmanaged_snap_remove AP=
Is (`issue#16180, pr#12050, Jason Dillaman)
* librados: fix compile errors from simplified aio completions (pr#12849, x=
ie xingguo)
* librbd: added rbd_flatten_with_progress to API (`issue#15824, pr#12905, R=
icardo Dias)
* librbd: allow to open an image without opening the parent image (`issue#1=
8325, pr#12885, Ricardo Dias)
* librbd: avoid possible recursive lock when racing acquire lock (`issue#17=
447, pr#12991, Jason Dillaman)
* librbd: create fewer empty objects during copyup (`issue#15028, pr#12326,=
 Douglas Fuller, Venky Shankar)
* librbd: delay mirror registration when creating clones (`issue#17993, pr#=
12839, Jason Dillaman)
* librbd: don't continue to remove an image w/ incompatible features (`issu=
e#18315, pr#12638, Dongsheng Yang)
* librbd: fixed initializer list ordering (pr#13042, Jason Dillaman)
* librbd: initialize diff parent overlap to zero (pr#13077, Gu Zhongyan)
* librbd: introduce new constants for tracking max block name prefix (`issu=
e#18653, pr#13141, Jason Dillaman)
* librbd: managed lock refactoring (pr#12922, Mykola Golub)
* librbd: metadata_set API operation should not change global config settin=
g (`issue#18465, pr#12843, Mykola Golub)
* librbd: new API method to force break a peer's exclusive lock (`issue#184=
29, `issue#16988, `issue#18327, pr#12639, Jason Dillaman)
* librbd: permit removal of image being bootstrapped by rbd-mirror (`issue#=
16555, pr#12549, Mykola Golub)
* librbd: possible deadlock with flush if refresh in-progress (`issue#18419=
, pr#12838, Jason Dillaman)
* librbd: prevent self-blacklisting during break lock (`issue#18666, pr#131=
10, Jason Dillaman)
* librbd: race initializing exclusive lock and configuring IO path (pr#1308=
6, Jason Dillaman)
* librbd: refactor exclusive lock support into generic managed lock (`issue=
#17016, pr#12846, Ricardo Dias, Jason Dillaman)
* librbd: remove unnecessary dependencies of ManagedLock (pr#12982, Jason D=
illaman)
* librbd: resolve static analyser warnings (pr#12863, Jason Dillaman)
* librbd: support for shared locking in ManagedLock (pr#12886, Ricardo Dias)
* librbd: support to list snapshot timestamp (`issue#808, pr#12817, Pan Liu)
* librbd: warning message for mirroring pool option (`issue#18125, pr#12319=
, Gaurav Kumar Garg)
* log: use one write system call per message (pr#11955, Patrick Donnelly)
* mds: add authority check for delay dirfrag split (`issue#18487, pr#12994,=
 "Yan, Zheng")
* mds: check for errors decoding backtraces (`issue#18311, pr#12588, John S=
pray)
* mds: don't modify inode that is not projected (`issue#16768, pr#13052, "Y=
an, Zheng")
* mds: finish clientreplay requests before requesting active state (`issue#=
18461, pr#12852, Yan, Zheng)
* mds: fix incorrect assertion in Server::_dir_is_nonempty() (`issue#18578,=
 pr#12973, Yan, Zheng)
* mds: fix null pointer dereference in Locker::handle_client_caps (`issue#1=
8306, pr#12808, Yan, Zheng)
* mds: miscellaneous fixes (`issue#18646, pr#12974, Yan, Zheng, "Yan, Zheng=
")
* mds: misc multimds fixes part2 (pr#12794, Yan, Zheng)
* mds: misc multimds fixes (pr#12274, Yan, Zheng)
* mds: propagate error encountered during opening inode by number (`issue#1=
8179, pr#12749, Yan, Zheng)
* mds: skip fragment space check for replayed request (`issue#18660, pr#130=
95, "Yan, Zheng")
* mgr: Make stats period configurable (`issue#17449, pr#12732, liuchang0812)
* mon: clean up some osdmon/pgmon interactions (pr#12403, Sage Weil)
* mon: don't set last_osd_report when the pg stats msg is ignored (pr#12975=
, Zhiqiang Wang)
* mon: fix a few nits (pr#12670, Sage Weil)
* mon: fix wrongly delete routed pgstats op (`issue#18458, pr#12784, Mingxi=
n Liu)
* mon: no delay for single message MSG_ALIVE and MSG_PGTEMP (pr#12107, yaon=
ing)
* mon: optracker's initiated_at timestamp should not be NULL (pr#12826, Min=
gxin Liu)
* mon/OSDMonitor: fix process osd failure (pr#12938, Mingxin Liu)
* mon: post-jewel cleanups (pr#13150, Kefu Chai)
* msg/async: Fixed compilation error when enable -DWITH_DPDK (pr#12660, Pan=
 Liu)
* msg/async: fixed coredump when enable dpdk. (pr#12854, Pan Liu)
* msg/async: fixed the error "Cause: Cannot create lock on '/var/run/.rte_c=
=E2=80=A6 (pr#12860, Pan Liu)
* msg/async: fix file description leak in NetHandler (pr#13271, liuchang081=
2)
* msg/async: NVMEDevice.cc: cleanup the logic in data_buf_next_sge (pr#1305=
6, optimistyzy)
* msg/async/rdma: Fix memory leak of OSD (pr#13101, Sarit Zubakov)
* msg/async/rdma: fix RoCE v2 deafult value (pr#12648, Adir Lev, Oren Duer)
* msg/RDMA: Fix broken compilation due to new argument in net.connect() (pr=
#13096, Amir Vadai)
* os/bluestore: NVMEDevice: optimize sector_size usage (pr#12780, optimisty=
zy)
* osd: add asock command to dump the scrub queue (`issue#17861, pr#12728, l=
iuchang0812)
* osd: allow client throttler to be adjusted on-fly, without restart (`issu=
e#18791, pr#13213, Piotr Da=C5=82ek)
* osd: Calculate degraded and misplaced more accurately (`issue#18619, pr#1=
3031, David Zafman)
* osd: cleanup: use string & to avoid unnecessary copy (pr#12336, Yunchuan =
Wen)
* osd: condition object_info_t encoding on required (not up) features (`iss=
ue#18644, pr#13114, Sage Weil)
* osd: correct comment of perfcounter cached_crc in code (pr#13256, lvshuhu=
a)
* osd: do not send ENXIO on misdirected op by default (`issue#18751, pr#132=
06, Sage Weil)
* osd: _exit() intead of exit() for failure injection (`issue#18372, pr#127=
26, Sage Weil)
* osd: extend OMAP_GETKEYS and GETVALS to include a 'more' output field (pr=
#12950, Sage Weil)
* osd: fix coverity warning for uninitialized members (pr#12724, Li Wang)
* osd: Fix useless MAX(0, unsigned) to prevent out of wack misplaced (`issu=
e#18718, pr#13164, David Zafman)
* osd: improve error message when FileStore op fails due to EPERM (`issue#1=
8037, pr#12181, Nathan Cutler)
* osd: never send rados ack (only commit) (pr#12451, Sage Weil)
* osd: osd/OSDMap: require OSD features only of OSDs (`issue#18831, pr#1327=
5, Ilya Dryomov)
* osd: Return correct osd_objectstore in OSD metadata (`issue#18638, pr#130=
72, Wido den Hollander)
* osd: use separate waitlist for scrub (pr#13136, Sage Weil)
* performance,bluestore: os/bluestore/bluestore_types: drop std::bitset for=
 blob unused (pr#12569, Sage Weil)
* performance,bluestore: os/bluestore: do not cache shard keys (pr#12634, S=
age Weil)
* performance,bluestore: os/bluestore: generate same onode extent-shard key=
s in a more efficient way (pr#12681, xie xingguo)
* performance,bluestore: os/bluestore: kvdb histogram (pr#12620, Varada Kar=
i)
* performance,bluestore: os/bluestore: prevent lock for almost "flush" call=
s (pr#12524, Haomai Wang)
* performance,bluestore: os/bluestore: replace Blob ref_map with reference =
counting (pr#12904, Igor Fedotov)
* performance,bluestore: os/bluestore: set cache meta ratio to .9 (pr#12635=
, Sage Weil)
* performance,bluestore: os/bluestore: use aio for reads (pr#13066, Sage We=
il)
* performance,bluestore: os/bluestore: use Best-Effort policy when evicting=
 onode from cache (pr#12876, xie xingguo)
* performance,bluestore: os/bluestore: various onode changes to reduce its =
in-memory footprint. (pr#12700, Igor Fedotov)
* performance,bluestore: Tested-by: Chagam, Anjaneya <anjaneya.chagam@intel=
.com> (pr#13032, Sage Weil)
* performance,cephfs: mds/server: skip unwanted dn in handle_client_readdir=
 (pr#12870, Xiaoxi Chen)
* performance,common,bluestore: common/Finisher: Using queue(list<context*>=
) instead queue(context*). (pr#8942, Jianpeng Ma)
* performance: osd, messenger, librados: lttng oid tracing (pr#12492, Anjan=
eya Chagam)
* performance: osd/ReplicatedBackend: do not set omap header if it is empty=
 (pr#12612, fang yuxiang)
* pybind: conditional compile the linux specific constant (pr#12198, Kefu C=
hai)
* qa: Add openstack requirements to smoke suite (pr#12913, Zack Cerza)
* qa: src/test/test_denc.cc: Fix errors in buffer overflow (pr#12653, Wille=
m Jan Withagen)
* rbd: add error prompt when input command 'snap set limit' is incomplete (=
pr#12945, Tang Jin)
* rbd: additional validation for 'bench' optional parameters (pr#12697, Yun=
chuan Wen)
* rbd: bench-write should return error if io-size >=3D 4G (`issue#18422, pr=
#12864, Gaurav Kumar Garg)
* rbd: cleanup: fix the typo in namespace comment (pr#12858, Dongsheng Yang)
* rbd: correct coverity warnings (pr#12954, Jason Dillaman)
* rbd: destination pool should be source pool if it is not specified (`issu=
e#18326, pr#13189, Gaurav Kumar Garg)
* rbd: enable rbd on FreeBSD (without KRBD) (pr#12798, Willem Jan Withagen)
* rbd: journal: don't hold future lock during assignment (`issue#18618, pr#=
13033, Jason Dillaman)
* rbd: journal: stop processing removal after error (`issue#18738, pr#13193=
, Jason Dillaman)
* rbd: rbd-mirror: add support for active/passive daemon instances (`issue#=
17018, `issue#17019, `issue#17020, pr#12948, Mykola Golub)
* rbd: rbd-mirror: avoid processing new events after stop requested (`issue=
#18441, pr#12837, Jason Dillaman)
* rbd: rbd-mirror: check remote image mirroring state when bootstrapping (`=
issue#18447, pr#12820, Mykola Golub)
* rbd: rbd-mirror: delayed replication support (`issue#15371, pr#11879, Myk=
ola Golub)
* rbd: remove direct linking to static boost libraries (pr#12962, Jason Dil=
laman)
* rbd: remove unused condition within group action handler (pr#12723, Gaura=
v Kumar Garg)
* rgw: Added a globbing method for AWS Policies. (pr#12445, Pritha Srivasta=
va)
* rgw: Added code for REST APIs for AWS Roles. (pr#12104, Pritha Srivastava)
* rgw: add lifecycle validation according to S3. (`issue#18394, pr#12750, Z=
hang Shaowen)
* rgw: be aware abount tenants on cls_user_bucket -> rgw_bucket conversion =
(`issue#18364, `issue#16355, pr#13220, Radoslaw Zarzynski)
* rgw: clear master_zonegroup when reseting RGWPeriodMap (`issue#17239, pr#=
12658, Orit Wasserman)
* rgw: complete versioning enablement after sending it to meta master (`iss=
ue#18003, pr#12444, Orit Wasserman)
* rgw: fix handling RGWUserInfo::system in RGWHandler_REST_SWIFT. (`issue#1=
8476, pr#12865, Radoslaw Zarzynski)
* rgw: fix off-by-one in RGWDataChangesLog::get_info (`issue#18488, pr#1288=
4, Casey Bodley)
* rgw: fix period update crash (`issue#18631, pr#13054, Orit Wasserman)
* rgw: fix use of marker in List::list_objects() (`issue#18331, pr#13147, Y=
ehuda Sadeh)
* rgw: fix versioned bucket data sync fail when upload is busy (`issue#1820=
8, pr#12357, lvshuhua)
* rgw: ldap: simple_bind() should set ldap version option on tldap (pr#1261=
6, Weibing Zhang)
* rgw: librgw shut (`issue#18585, pr#12972, Matt Benjamin)
* rgw: orphan: fix error messages (pr#12782, Weibing Zhang)
* rgw: remove invalid read size4 (`issue#18071, pr#12767, Matt Benjamin)
* rgw: rgw_file: add timed namespace invalidation (`issue#18651, pr#13038, =
Matt Benjamin)
* rgw: rgw_file:  fix RGWLibFS::setattr for directory objects (`issue#18808=
, pr#13252, Matt Benjamin)
* rgw: rgw_file:  interned RGWFileHandle objects need parent refs (`issue#1=
8650, pr#13084, Matt Benjamin)
* rgw: rgw_file:  split last argv on ws, if provided (pr#12965, Matt Benjam=
in)
* rgw: RGWMetaSyncShardCR drops stack refs on destruction (`issue#18412, `i=
ssue#18300, pr#12605, Casey Bodley)
* rgw: rgw multisite: fix ref counting of completions (`issue#18414, `issue=
#18407, pr#12841, Casey Bodley)
* rgw: rgw realm set fixes (`issue#18333, pr#12731, Orit Wasserman)
* rgw: swift: fix anonymous user's error code of getting object (`issue#188=
06, pr#13242, Jing Wenjun)
* rgw: swift: the http referer acl in swift API should be shown (`issue#186=
65, pr#13003, Jing Wenjun)
* rgw: swift: The http referer should be parsed to compare in swift API (`i=
ssue#18685, pr#13005, Jing Wenjun)
* rgw: sync status compares the current master period (`issue#18064, pr#129=
07, Abhishek Lekshmanan)
* rgw: the swift container acl should support field .ref (`issue#18484, pr#=
12874, Jing Wenjun)
* rgw: Use decoded URI when verifying TempURL (`issue#18590, pr#13007, Mich=
al Koutn=C3=BD)
* rgw: Wip rgw openssl 7 (`issue#11239, `issue#16535, pr#11776, Yehuda Sade=
h, Marcus Watts)
* tests,bluestore: ceph_test_objectstore: match clone_range src and dst off=
set (pr#13211, Sage Weil)
* tests,cephfs: Improve vstart_runner to (optionally) create its own cluste=
r (pr#12800, John Spray)
* tests: ceph-helpers.sh reduce get_timeout_delays() verbosity (pr#13257, K=
efu Chai)
* tests: ceph_test_rados_api_watch_notify: move global variables into test =
class (`issue#18395, pr#12751, Kefu Chai)
* tests,cleanup,rbd: test: correct language mode in file headers (pr#12924,=
 Jason Dillaman)
* tests,cleanup: test: clean up unused variable (pr#12873, liuchang0812)
* tests,cleanup: test: update test_rados_tool.sh, use POOL and OBJ var (pr#=
12706, liuchang0812)
* tests: drop rbd_cli_tests.pl and RbdLib.pm (`issue#14825, pr#12821, Natha=
n Cutler)
* tests: drop unused rbd_functional_tests.pl script (`issue#14825, pr#12818=
, Nathan Cutler)
* tests: fix NULL references to be acceptable by Clang (pr#12880, Willem Ja=
n Withagen)
* tests: fix template specialization of PromoteRequest class (pr#12815, Ric=
ardo Dias)
* tests: ignore bogus ceph-objectstore-tool error in ceph_manager (`issue#1=
6263, pr#13194, Nathan Cutler)
* tests: nosetests: use /usr/bin/env to find nosetests (pr#12091, Willem Ja=
n Withagen)
* tests: qa: Cleaned up distros to use `latest` versions (pr#12804, Yuri We=
instein)
* tests: qa/distros: make centos_latest 7.3 (pr#12944, Sage Weil)
* tests: qa: do not mention ceph branch explicitly (pr#13225, Tamil Muthami=
zhan)
* tests: qa: fixed distros links (pr#12770, Yuri Weinstein)
* tests: qa: specify client for fs workunit (pr#12914, Tamil Muthamizhan)
* tests: qa/suite: Added a smoke suite for ceph-ansible (pr#12610, Tamil Mu=
thamizhan)
* tests: qa/suites/ceph-ansible: removing fs workunit (pr#12928, Tamil Muth=
amizhan)
* tests: qa/tasks/ceph-deploy: create-keys explicitly (pr#12867, Vasu Kulka=
rni)
* tests: qa/tasks/ceph-deploy: use the new create option during instantiati=
on (pr#12892, Vasu Kulkarni)
* tests: qa/test_rados_tool.sh: POSIX dd only accepts 'k' as multiplier (pr=
#12699, Willem Jan Withagen)
* tests: qa: Using centos 7.2 for `latest` version (pr#12806, Yuri Weinstei=
n)
* tests: qa/workunits/ceph-helpers: wait_for_clean() races with pg creation=
 (pr#12866, David Zafman)
* tests,rbd: qa: integrate OpenStack 'gate-tempest-dsvm-full-devstack-plugi=
n-ceph' (`issue#18594, pr#13158, Jason Dillaman)
* tests,rbd: qa/tasks/qemu: update default image url after ceph.com redesig=
n (`issue#18542, pr#12953, Jason Dillaman)
* tests,rbd: test/librbd: add break_lock test (pr#12842, Mykola Golub)
* tests: rbd/test_lock_fence.sh: fix rbdrw.py relative path (`issue#18388, =
pr#12747, Nathan Cutler)
* tests,rbd: test: use librados API to retrieve config params (`issue#18617=
, pr#13076, Jason Dillaman)
* tests: remove temporary file (pr#12919, Kefu Chai)
* tests,rgw: test/rgw: add test for versioned object sync (pr#12474, Casey =
Bodley)
* tests: subst repo and branch in git.ceph.com URL in qa/tasks/cram.py and =
qa/tasks/qemu.py (`issue#18440, pr#12816, Nathan Cutler)
* tests: test: librados_test_stub: tmap_update: return -ENOENT when removin=
g nonexisent key (pr#12667, Mykola Golub)
* tests: test: replace hard-code binary names with varibles (pr#12675, liuc=
hang0812)
* tests: Thrasher: eliminate a race between kill_osd and __init__ (`issue#1=
8799, pr#13237, Nathan Cutler)
* tools: ceph-disk: convert none str to str before printing it (`issue#1837=
1, pr#12760, Kefu Chai)
* tools: ceph-objectstore-tool: Handle object names that are also valid jso=
n (pr#12848, David Zafman)
* tools: ceph-release-notes: ignore low-numbered PRs (`issue#18695, pr#1315=
1, Nathan Cutler)
* tools,common: osdmaptool: show all the pg map to osds info (pr#9419, song=
 baisen)
* tools: script: ceph-release-notes check orig. issue only for backports (p=
r#12979, Abhishek Lekshmanan)
* tools: support hammer in rbd_recover_tool (pr#12413, Bart=C5=82omiej =C5=
=9Awi=C4=99cki)
* tools: tools/rados: add a parameter "--offset" to rados put command (pr#1=
2674, liuchang0812)

Getting Ceph
=2D-----------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-12.0.0.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-dep=
loy


=2D-
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton, =
HRB 21284 (AG N=C3=BCrnberg)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJYm3ZTAAoJEPnwZB8bZe1fj4oIAKksqGx4j9ModrpL/f1uJbto
6gp8iKUSG06pU0ztIOgpLCFGUSbaD01BcK6numSx3+PdjRzvoVnv8/0JYzGjxFCG
62rS3P2CO0M9LPWL/F0YSgQyH73ca3QafPsmz+pWJQUyFQJXIcWjITgM5Rv66XmD
EdJHy7ZxhJL69GC71oSu8AfcnxbdUn4DboUmEn1XPExAlaNXmRc2EdKiYwdVB6d/
jECCY7ZGWEd0Cu69SFQ/8SYoTFlKu0+2hUC9rYU+hl9XahbhkjoFHx0Cz4SEtYFy
86AxRr/h0O/wh83x2v8j+TKdDmoeH2ybXXHXKQE1q2lZzqFWdMJ3/uMgp/GJO2w=
=hzFN
-----END PGP SIGNATURE-----
--=-=-=--

--===============1298208061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1298208061==--
