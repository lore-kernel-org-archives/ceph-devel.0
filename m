From: Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: v10.0.0 released
Date: Mon, 23 Nov 2015 08:07:32 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511230805110.16122@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="557981400-1675907460-1448294852=:16122"
Return-path: <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-announce-ceph.com>,
	<mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-announce-ceph.com/>
List-Post: <mailto:ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-announce-ceph.com>,
	<mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "Ceph-announce" <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1675907460-1448294852=:16122
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is the first development release for the Jewel cycle.  We are off to=
=20
a good start, with lots of performance improvements flowing into the tree=
. =20
We are targetting sometime in Q1 2016 for the final Jewel.

Notable Changes
---------------

* build: cmake tweaks (`pr#6254 <http://github.com/ceph/ceph/pull/6254>`_=
, John Spray)
* build: more CMake package check fixes (`pr#6108 <http://github.com/ceph=
/ceph/pull/6108>`_, Daniel Gryniewicz)
* ceph-disk: get Nonetype when ceph-disk list with --format plain on sing=
le device. (`pr#6410 <http://github.com/ceph/ceph/pull/6410>`_, Vicente C=
heng)
* ceph: fix tell behavior (`pr#6329 <http://github.com/ceph/ceph/pull/632=
9>`_, David Zafman)
* ceph-fuse: While starting ceph-fuse, start the log thread first (`issue=
#13443 <http://tracker.ceph.com/issues/13443>`_, `pr#6224 <http://github.=
com/ceph/ceph/pull/6224>`_, Wenjun Huang)
* client: don't mark_down on command reply (`pr#6204 <http://github.com/c=
eph/ceph/pull/6204>`_, John Spray)
* client: drop prefix from ints (`pr#6275 <http://github.com/ceph/ceph/pu=
ll/6275>`_, John Coyle)
* client: sys/file.h includes for flock operations (`pr#6282 <http://gith=
ub.com/ceph/ceph/pull/6282>`_, John Coyle)
* cls_rbd: change object_map_update to return 0 on success, add logging (=
`pr#6467 <http://github.com/ceph/ceph/pull/6467>`_, Douglas Fuller)
* cmake: Use uname instead of arch. (`pr#6358 <http://github.com/ceph/cep=
h/pull/6358>`_, John Coyle)
* common: assert: __STRING macro is not defined by musl libc. (`pr#6210 <=
http://github.com/ceph/ceph/pull/6210>`_, John Coyle)
* common: fix OpTracker age histogram calculation (`pr#5065 <http://githu=
b.com/ceph/ceph/pull/5065>`_, Zhiqiang Wang)
* common/MemoryModel: Added explicit feature check for mallinfo(). (`pr#6=
252 <http://github.com/ceph/ceph/pull/6252>`_, John Coyle)
* common/obj_bencher.cc: fix verification crashing when there's no object=
s (`pr#5853 <http://github.com/ceph/ceph/pull/5853>`_, Piotr Da=C5=82ek)
* common: optimize debug logging (`pr#6307 <http://github.com/ceph/ceph/p=
ull/6307>`_, Adam Kupczyk)
* common: Thread: move copy constructor and assignment op (`pr#5133 <http=
://github.com/ceph/ceph/pull/5133>`_, Michal Jarzabek)
* common: WorkQueue: new PointerWQ base class for ContextWQ (`issue#13636=
 <http://tracker.ceph.com/issues/13636>`_, `pr#6525 <http://github.com/ce=
ph/ceph/pull/6525>`_, Jason Dillaman)
* compat: use prefixed typeof extension (`pr#6216 <http://github.com/ceph=
/ceph/pull/6216>`_, John Coyle)
* crush: validate bucket id before indexing buckets array (`issue#13477 <=
http://tracker.ceph.com/issues/13477>`_, `pr#6246 <http://github.com/ceph=
/ceph/pull/6246>`_, Sage Weil)
* doc: download GPG key from download.ceph.com (`issue#13603 <http://trac=
ker.ceph.com/issues/13603>`_, `pr#6384 <http://github.com/ceph/ceph/pull/=
6384>`_, Ken Dreyer)
* doc: fix outdated content in cache tier (`pr#6272 <http://github.com/ce=
ph/ceph/pull/6272>`_, Yuan Zhou)
* doc/release-notes: v9.1.0 (`pr#6281 <http://github.com/ceph/ceph/pull/6=
281>`_, Loic Dachary)
* doc/releases-notes: fix build error (`pr#6483 <http://github.com/ceph/c=
eph/pull/6483>`_, Kefu Chai)
* doc: remove toctree items under Create CephFS (`pr#6241 <http://github.=
com/ceph/ceph/pull/6241>`_, Jevon Qiao)
* doc: rename the "Create a Ceph User" section and add verbage about=E2=80=
=A6 (`issue#13502 <http://tracker.ceph.com/issues/13502>`_, `pr#6297 <htt=
p://github.com/ceph/ceph/pull/6297>`_, ritz303)
* docs: Fix styling of newly added mirror docs (`pr#6127 <http://github.c=
om/ceph/ceph/pull/6127>`_, Wido den Hollander)
* doc, tests: update all http://ceph.com/ to download.ceph.com (`pr#6435 =
<http://github.com/ceph/ceph/pull/6435>`_, Alfredo Deza)
* doc: update doc for with new pool settings (`pr#5951 <http://github.com=
/ceph/ceph/pull/5951>`_, Guang Yang)
* doc: update radosgw-admin example (`pr#6256 <http://github.com/ceph/cep=
h/pull/6256>`_, YankunLi)
* doc: update the OS recommendations for newer Ceph releases (`pr#6355 <h=
ttp://github.com/ceph/ceph/pull/6355>`_, ritz303)
* drop envz.h includes (`pr#6285 <http://github.com/ceph/ceph/pull/6285>`=
_, John Coyle)
* libcephfs: Improve portability by replacing loff_t type usage with off_=
t (`pr#6301 <http://github.com/ceph/ceph/pull/6301>`_, John Coyle)
* libcephfs: only check file offset on glibc platforms (`pr#6288 <http://=
github.com/ceph/ceph/pull/6288>`_, John Coyle)
* librados: fix examples/librados/Makefile error. (`pr#6320 <http://githu=
b.com/ceph/ceph/pull/6320>`_, You Ji)
* librados: init crush_location from config file. (`issue#13473 <http://t=
racker.ceph.com/issues/13473>`_, `pr#6243 <http://github.com/ceph/ceph/pu=
ll/6243>`_, Wei Luo)
* librados: wrongly passed in argument for stat command (`issue#13703 <ht=
tp://tracker.ceph.com/issues/13703>`_, `pr#6476 <http://github.com/ceph/c=
eph/pull/6476>`_, xie xingguo)
* librbd: deadlock while attempting to flush AIO requests (`issue#13726 <=
http://tracker.ceph.com/issues/13726>`_, `pr#6508 <http://github.com/ceph=
/ceph/pull/6508>`_, Jason Dillaman)
* librbd: fix enable objectmap feature issue (`issue#13558 <http://tracke=
r.ceph.com/issues/13558>`_, `pr#6339 <http://github.com/ceph/ceph/pull/63=
39>`_, xinxin shu)
* librbd: remove duplicate read_only test in librbd::async_flatten (`pr#5=
856 <http://github.com/ceph/ceph/pull/5856>`_, runsisi)
* mailmap: modify member info  (`pr#6468 <http://github.com/ceph/ceph/pul=
l/6468>`_, Xiaowei Chen)
* mailmap: updates (`pr#6258 <http://github.com/ceph/ceph/pull/6258>`_, M=
 Ranga Swami Reddy)
* mailmap: Xie Xingguo affiliation (`pr#6409 <http://github.com/ceph/ceph=
/pull/6409>`_, Loic Dachary)
* mds: implement snapshot rename (`pr#5645 <http://github.com/ceph/ceph/p=
ull/5645>`_, xinxin shu)
* mds: messages/MOSDOp: cast in assert to eliminate warnings (`issue#1362=
5 <http://tracker.ceph.com/issues/13625>`_, `pr#6414 <http://github.com/c=
eph/ceph/pull/6414>`_, David Zafman)
* mds: new filtered MDS tell commands for sessions (`pr#6180 <http://gith=
ub.com/ceph/ceph/pull/6180>`_, John Spray)
* mds/Session: use projected parent for auth path check (`issue#13364 <ht=
tp://tracker.ceph.com/issues/13364>`_, `pr#6200 <http://github.com/ceph/c=
eph/pull/6200>`_, Sage Weil)
* mon: should not set isvalid =3D true when cephx_verify_authorizer retur=
n false (`issue#13525 <http://tracker.ceph.com/issues/13525>`_, `pr#6306 =
<http://github.com/ceph/ceph/pull/6306>`_, Ruifeng Yang)
* osd: Add config option osd_read_ec_check_for_errors for testing (`pr#58=
65 <http://github.com/ceph/ceph/pull/5865>`_, David Zafman)
* osd: add pin/unpin support to cache tier (11066) (`pr#6326 <http://gith=
ub.com/ceph/ceph/pull/6326>`_, Zhiqiang Wang)
* osd: auto repair EC pool (`issue#12754 <http://tracker.ceph.com/issues/=
12754>`_, `pr#6196 <http://github.com/ceph/ceph/pull/6196>`_, Guang Yang)
* osd: drop the interim set from load_pgs() (`pr#6277 <http://github.com/=
ceph/ceph/pull/6277>`_, Piotr Da=C5=82ek)
* osd: FileJournal: _fdump wrongly returns if journal is currently unread=
able. (`issue#13626 <http://tracker.ceph.com/issues/13626>`_, `pr#6406 <h=
ttp://github.com/ceph/ceph/pull/6406>`_, xie xingguo)
* osd: FileStore: add a field indicate xattr only one chunk for set xattr=
. (`pr#6244 <http://github.com/ceph/ceph/pull/6244>`_, Jianpeng Ma)
* osd: FileStore: LFNIndex: remove redundant local variable 'obj'. (`issu=
e#13552 <http://tracker.ceph.com/issues/13552>`_, `pr#6333 <http://github=
.com/ceph/ceph/pull/6333>`_, xiexingguo)
* osd: FileStore: potential memory leak if _fgetattrs fails (`issue#13597=
 <http://tracker.ceph.com/issues/13597>`_, `pr#6377 <http://github.com/ce=
ph/ceph/pull/6377>`_, xie xingguo)
* osd: FileStore: remove unused local variable 'handle' (`pr#6381 <http:/=
/github.com/ceph/ceph/pull/6381>`_, xie xingguo)
* osd: fix bogus scrub results when missing a clone (`issue#12738 <http:/=
/tracker.ceph.com/issues/12738>`_, `issue#12740 <http://tracker.ceph.com/=
issues/12740>`_, `pr#5783 <http://github.com/ceph/ceph/pull/5783>`_, Davi=
d Zafman)
* osd: fix debug message in OSD::is_healthy (`pr#6226 <http://github.com/=
ceph/ceph/pull/6226>`_, Xiaoxi Chen)
* osd: fix MOSDOp encoding (`pr#6174 <http://github.com/ceph/ceph/pull/61=
74>`_, Sage Weil)
* osd: init started to 0 (`issue#13206 <http://tracker.ceph.com/issues/13=
206>`_, `pr#6107 <http://github.com/ceph/ceph/pull/6107>`_, Sage Weil)
* osd: KeyValueStore: fix the name's typo of keyvaluestore_default_strip_=
size (`pr#6375 <http://github.com/ceph/ceph/pull/6375>`_, Zhi Zhang)
* osd: new and delete ObjectStore::Transaction in a function is not neces=
sary (`pr#6299 <http://github.com/ceph/ceph/pull/6299>`_, Ruifeng Yang)
* osd: optimize get_object_context (`pr#6305 <http://github.com/ceph/ceph=
/pull/6305>`_, Jianpeng Ma)
* osd: optimize MOSDOp/do_op/handle_op (`pr#5211 <http://github.com/ceph/=
ceph/pull/5211>`_, Jacek J. Lakis)
* osd: os/chain_xattr: On linux use linux/limits.h for XATTR_NAME_MAX. (`=
pr#6343 <http://github.com/ceph/ceph/pull/6343>`_, John Coyle)
* osd: reorder bool fields in PGLog struct (`pr#6279 <http://github.com/c=
eph/ceph/pull/6279>`_, Piotr Da=C5=82ek)
* osd: ReplicatedPG: remove unused local variables (`issue#13575 <http://=
tracker.ceph.com/issues/13575>`_, `pr#6360 <http://github.com/ceph/ceph/p=
ull/6360>`_, xiexingguo)
* osd: reset primary and up_primary when building a new past_interval. (`=
issue#13471 <http://tracker.ceph.com/issues/13471>`_, `pr#6240 <http://gi=
thub.com/ceph/ceph/pull/6240>`_, xiexingguo)
* radosgw-admin: Checking the legality of the parameters (`issue#13018 <h=
ttp://tracker.ceph.com/issues/13018>`_, `pr#5879 <http://github.com/ceph/=
ceph/pull/5879>`_, Qiankun Zheng)
* radosgw-admin: Create --secret-key alias for --secret (`issue#5821 <htt=
p://tracker.ceph.com/issues/5821>`_, `pr#5335 <http://github.com/ceph/cep=
h/pull/5335>`_, Yuan Zhou)
* radosgw-admin: metadata list user should return an empty list when user=
 pool is empty (`issue#13596 <http://tracker.ceph.com/issues/13596>`_, `p=
r#6465 <http://github.com/ceph/ceph/pull/6465>`_, Orit Wasserman)
* rados: new options for write benchmark (`pr#6340 <http://github.com/cep=
h/ceph/pull/6340>`_, Joaquim Rocha)
* rbd: fix clone isssue (`issue#13553 <http://tracker.ceph.com/issues/135=
53>`_, `pr#6334 <http://github.com/ceph/ceph/pull/6334>`_, xinxin shu)
* rbd: fix init-rbdmap CMDPARAMS (`issue#13214 <http://tracker.ceph.com/i=
ssues/13214>`_, `pr#6109 <http://github.com/ceph/ceph/pull/6109>`_, Sage =
Weil)
* rbdmap: systemd support (`issue#13374 <http://tracker.ceph.com/issues/1=
3374>`_, `pr#6479 <http://github.com/ceph/ceph/pull/6479>`_, Boris Ranto)
* rbd: rbdmap improvements (`pr#6445 <http://github.com/ceph/ceph/pull/64=
45>`_, Boris Ranto)
* release-notes: draft v0.94.4 release notes (`pr#5907 <http://github.com=
/ceph/ceph/pull/5907>`_, Loic Dachary)
* release-notes: draft v0.94.4 release notes (`pr#6195 <http://github.com=
/ceph/ceph/pull/6195>`_, Loic Dachary)
* release-notes: draft v0.94.4 release notes (`pr#6238 <http://github.com=
/ceph/ceph/pull/6238>`_, Loic Dachary)
* rgw: add compat header for TEMP_FAILURE_RETRY (`pr#6294 <http://github.=
com/ceph/ceph/pull/6294>`_, John Coyle)
* rgw: add default quota config (`pr#6400 <http://github.com/ceph/ceph/pu=
ll/6400>`_, Daniel Gryniewicz)
* rgw: add support for getting Swift's DLO without manifest handling (`pr=
#6206 <http://github.com/ceph/ceph/pull/6206>`_, Radoslaw Zarzynski)
* rgw: clarify the error message when trying to create an existed user (`=
pr#5938 <http://github.com/ceph/ceph/pull/5938>`_, Zeqiang Zhuang)
* rgw: fix objects can not be displayed which object name does not cont=E2=
=80=A6 (`issue#12963 <http://tracker.ceph.com/issues/12963>`_, `pr#5738 <=
http://github.com/ceph/ceph/pull/5738>`_, Weijun Duan)
* rgw: fix typo in RGWHTTPClient::process error message (`pr#6424 <http:/=
/github.com/ceph/ceph/pull/6424>`_, Brad Hubbard)
* rgw: fix wrong etag calculation during POST on S3 bucket. (`issue#11241=
 <http://tracker.ceph.com/issues/11241>`_, `pr#6030 <http://github.com/ce=
ph/ceph/pull/6030>`_, Radoslaw Zarzynski)
* rgw: mdlog trim add usage prompt (`pr#6059 <http://github.com/ceph/ceph=
/pull/6059>`_, Weijun Duan)
* rgw: modify the conditional statement in parse_metadata_key method. (`p=
r#5875 <http://github.com/ceph/ceph/pull/5875>`_, Zengran Zhang)
* rgw: refuse to calculate digest when the s3 secret key is empty (`issue=
#13133 <http://tracker.ceph.com/issues/13133>`_, `pr#6045 <http://github.=
com/ceph/ceph/pull/6045>`_, Sangdi Xu)
* rgw: remove extra check in RGWGetObj::execute (`issue#12352 <http://tra=
cker.ceph.com/issues/12352>`_, `pr#5262 <http://github.com/ceph/ceph/pull=
/5262>`_, Javier M. Mellid)
* rgw: support core file limit for radosgw daemon (`pr#6346 <http://githu=
b.com/ceph/ceph/pull/6346>`_, Guang Yang)
* rgw: swift use Civetweb ssl can not get right url (`issue#13628 <http:/=
/tracker.ceph.com/issues/13628>`_, `pr#6408 <http://github.com/ceph/ceph/=
pull/6408>`_, Weijun Duan)
* rocksdb: build with PORTABLE=3D1 (`pr#6311 <http://github.com/ceph/ceph=
/pull/6311>`_, Sage Weil)
* rocksdb: remove rdb source files from dist tarball (`issue#13554 <http:=
//tracker.ceph.com/issues/13554>`_, `pr#6379 <http://github.com/ceph/ceph=
/pull/6379>`_, Kefu Chai)
* rocksdb: use native rocksdb makefile (and our autotools) (`pr#6290 <htt=
p://github.com/ceph/ceph/pull/6290>`_, Sage Weil)
* rpm: ceph.spec.in: correctly declare systemd dependency for SLE/openSUS=
E (`pr#6114 <http://github.com/ceph/ceph/pull/6114>`_, Nathan Cutler)
* rpm: ceph.spec.in: fix libs-compat / devel-compat conditional (`issue#1=
2315 <http://tracker.ceph.com/issues/12315>`_, `pr#5219 <http://github.co=
m/ceph/ceph/pull/5219>`_, Ken Dreyer)
* rpm: rhel 5.9 librados compile fix, moved blkid to RBD check/compilatio=
n (`issue#13177 <http://tracker.ceph.com/issues/13177>`_, `pr#5954 <http:=
//github.com/ceph/ceph/pull/5954>`_, Rohan Mars)
* scripts: release_notes can track original issue (`pr#6009 <http://githu=
b.com/ceph/ceph/pull/6009>`_, Abhishek Lekshmanan)
* test/libcephfs/flock: add sys/file.h include for flock operations (`pr#=
6310 <http://github.com/ceph/ceph/pull/6310>`_, John Coyle)
* test_rgw_admin: use freopen for output redirection. (`pr#6303 <http://g=
ithub.com/ceph/ceph/pull/6303>`_, John Coyle)
* tests: allow docker-test.sh to run under root (`issue#13355 <http://tra=
cker.ceph.com/issues/13355>`_, `pr#6173 <http://github.com/ceph/ceph/pull=
/6173>`_, Loic Dachary)
* tests: ceph-disk workunit uses configobj  (`pr#6342 <http://github.com/=
ceph/ceph/pull/6342>`_, Loic Dachary)
* tests: destroy testprofile before creating one (`issue#13664 <http://tr=
acker.ceph.com/issues/13664>`_, `pr#6446 <http://github.com/ceph/ceph/pul=
l/6446>`_, Loic Dachary)
* tests: port uniqueness reminder (`pr#6387 <http://github.com/ceph/ceph/=
pull/6387>`_, Loic Dachary)
* tests: test/librados/test.cc must create profile (`issue#13664 <http://=
tracker.ceph.com/issues/13664>`_, `pr#6452 <http://github.com/ceph/ceph/p=
ull/6452>`_, Loic Dachary)
* tools/cephfs: fix overflow writing header to fixed size buffer (#13816)=
 (`pr#6617 <http://github.com/ceph/ceph/pull/6617>`_, John Spray)
* tools: ceph-monstore-update-crush: add "--test" when testing crushmap (=
`pr#6418 <http://github.com/ceph/ceph/pull/6418>`_, Kefu Chai)
* tools:remove duplicate references (`pr#5917 <http://github.com/ceph/cep=
h/pull/5917>`_, Bo Cai)
* vstart: grant full access to Swift testing account (`pr#6239 <http://gi=
thub.com/ceph/ceph/pull/6239>`_, Yuan Zhou)
* vstart: set cephfs root uid/gid to caller (`pr#6255 <http://github.com/=
ceph/ceph/pull/6255>`_, John Spray)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-10.0.0.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-d=
eploy
--557981400-1675907460-1448294852=:16122
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-announce mailing list
Ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-announce-ceph.com

--557981400-1675907460-1448294852=:16122--
