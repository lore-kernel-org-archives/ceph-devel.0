From: Sage Weil <sage@redhat.com>
Subject: v0.94.4 Hammer released
Date: Mon, 19 Oct 2015 14:07:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510191404420.18978@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-247352914-1445288859=:18978"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50417 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbbJSVHk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 17:07:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-announce@ceph.com, ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-247352914-1445288859=:18978
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This Hammer point fixes several important bugs in Hammer, as well as
fixing interoperability issues that are required before an upgrade to
Infernalis. That is, all users of earlier version of Hammer or any
version of Firefly will first need to upgrade to hammer v0.94.4 or
later before upgrading to Infernalis (or future releases).

All v0.94.x Hammer users are strongly encouraged to upgrade.

Changes
-------

* build/ops: ceph.spec.in: 50-rbd.rules conditional is wrong (#12166, Nat=
han Cutler)
* build/ops: ceph.spec.in: ceph-common needs python-argparse on older dis=
tros, but doesn't require it (#12034, Nathan Cutler)
* build/ops: ceph.spec.in: radosgw requires apache for SUSE only -- makes=
 no sense (#12358, Nathan Cutler)
* build/ops: ceph.spec.in: rpm: cephfs_java not fully conditionalized (#1=
1991, Nathan Cutler)
* build/ops: ceph.spec.in: rpm: not possible to turn off Java (#11992, Ow=
en Synge)
* build/ops: ceph.spec.in: running fdupes unnecessarily (#12301, Nathan C=
utler)
* build/ops: ceph.spec.in: snappy-devel for all supported distros (#12361=
, Nathan Cutler)
* build/ops: ceph.spec.in: SUSE/openSUSE builds need libbz2-devel (#11629=
, Nathan Cutler)
* build/ops: ceph.spec.in: useless %py_requires breaks SLE11-SP3 build (#=
12351, Nathan Cutler)
* build/ops: error in ext_mime_map_init() when /etc/mime.types is missing=
 (#11864, Ken Dreyer)
* build/ops: upstart: limit respawn to 3 in 30 mins (instead of 5 in 30s)=
 (#11798, Sage Weil)
* build/ops: With root as default user, unable to have multiple RGW insta=
nces running (#10927, Sage Weil)
* build/ops: With root as default user, unable to have multiple RGW insta=
nces running (#11140, Sage Weil)
* build/ops: With root as default user, unable to have multiple RGW insta=
nces running (#11686, Sage Weil)
* build/ops: With root as default user, unable to have multiple RGW insta=
nces running (#12407, Sage Weil)
* cli: ceph: cli throws exception on unrecognized errno (#11354, Kefu Cha=
i)
* cli: ceph tell: broken error message / misleading hinting (#11101, Kefu=
 Chai)
* common: arm: all programs that link to librados2 hang forever on startu=
p (#12505, Boris Ranto)
* common: buffer: critical bufferlist::zero bug (#12252, Haomai Wang)
* common: ceph-object-corpus: add 0.94.2-207-g88e7ee7 hammer objects (#13=
070, Sage Weil)
* common: do not insert emtpy ptr when rebuild emtpy bufferlist (#12775, =
Xinze Chi)
* common: [  FAILED  ] TestLibRBD.BlockingAIO (#12479, Jason Dillaman)
* common: LibCephFS.GetPoolId failure (#12598, Yan, Zheng)
* common: Memory leak in Mutex.cc, pthread_mutexattr_init without pthread=
_mutexattr_destroy (#11762, Ketor Meng)
* common: object_map_update fails with -EINVAL return code (#12611, Jason=
 Dillaman)
* common: Pipe: Drop connect_seq increase line (#13093, Haomai Wang)
* common: recursive lock of md_config_t (0) (#12614, Josh Durgin)
* crush: ceph osd crush reweight-subtree does not reweight parent node (#=
11855, Sage Weil)
* doc: update docs to point to download.ceph.com (#13162, Alfredo Deza)
* fs: ceph-fuse 0.94.2-1trusty segfaults / aborts (#12297, Greg Farnum)
* fs: segfault launching ceph-fuse with bad --name (#12417, John Spray)
* librados: Change radosgw pools default crush ruleset (#11640, Yuan Zhou=
)
* librbd: correct issues discovered via lockdep / helgrind (#12345, Jason=
 Dillaman)
* librbd: Crash during TestInternal.MultipleResize (#12664, Jason Dillama=
n)
* librbd: deadlock during cooperative exclusive lock transition (#11537, =
Jason Dillaman)
* librbd: Possible crash while concurrently writing and shrinking an imag=
e (#11743, Jason Dillaman)
* mon: add a cache layer over MonitorDBStore (#12638, Kefu Chai)
* mon: fix crush testing for new pools (#13400, Sage Weil)
* mon: get pools health'info have error (#12402, renhwztetecs)
* mon: implicit erasure code crush ruleset is not validated (#11814, Loic=
 Dachary)
* mon: PaxosService: call post_refresh() instead of post_paxos_update() (=
#11470, Joao Eduardo Luis)
* mon: pgmonitor: wrong at/near target max=E2=80=9C reporting (#12401, hu=
angjun)
* mon: register_new_pgs() should check ruleno instead of its index (#1221=
0, Xinze Chi)
* mon: Show osd as NONE in ceph osd map <pool> <object>  output (#11820, =
Shylesh Kumar)
* mon: the output is wrong when runing ceph osd reweight (#12251, Joao Ed=
uardo Luis)
* osd: allow peek_map_epoch to return an error (#13060, Sage Weil)
* osd: cache agent is idle although one object is left in the cache (#126=
73, Loic Dachary)
* osd: copy-from doesn't preserve truncate_{seq,size} (#12551, Samuel Jus=
t)
* osd: crash creating/deleting pools (#12429, John Spray)
* osd: fix repair when recorded digest is wrong (#12577, Sage Weil)
* osd: include/ceph_features: define HAMMER_0_94_4 feature (#13026, Sage =
Weil)
* osd: is_new_interval() fixes (#10399, Jason Dillaman)
* osd: is_new_interval() fixes (#11771, Jason Dillaman)
* osd: long standing slow requests: connection->session->waiting_for_map-=
>connection ref cycle (#12338, Samuel Just)
* osd: Mutex Assert from PipeConnection::try_get_pipe (#12437, David Zafm=
an)
* osd: pg_interval_t::check_new_interval - for ec pool, should not rely o=
n min_size to determine if the PG was active at the interval (#12162, Gua=
ng G Yang)
* osd: PGLog.cc: 732: FAILED assert(log.log.size() =3D=3D log_keys_debug.=
size()) (#12652, Sage Weil)
* osd: PGLog::proc_replica_log: correctly handle case where entries betwe=
en olog.head and log.tail were split out (#11358, Samuel Just)
* osd: read on chunk-aligned xattr not handled (#12309, Sage Weil)
* osd: suicide timeout during peering - search for missing objects (#1252=
3, Guang G Yang)
* osd: WBThrottle::clear_object: signal on cond when we reduce throttle v=
alues (#12223, Samuel Just)
* rbd: crash during shutdown after writeback blocked by IO errors (#12597=
, Jianpeng Ma)
* rgw: add delimiter to prefix only when path is specified (#12960, Sylva=
in Baubeau)
* rgw: create a tool for orphaned objects cleanup (#9604, Yehuda Sadeh)
* rgw: don't preserve acls when copying object (#11563, Yehuda Sadeh)
* rgw: don't preserve acls when copying object (#12370, Yehuda Sadeh)
* rgw: don't preserve acls when copying object (#13015, Yehuda Sadeh)
* rgw: Ensure that swift keys don't include backslashes (#7647, Yehuda Sa=
deh)
* rgw: GWWatcher::handle_error -> common/Mutex.cc: 95: FAILED assert(r =3D=
=3D 0) (#12208, Yehuda Sadeh)
* rgw: HTTP return code is not being logged by CivetWeb  (#12432, Yehuda =
Sadeh)
* rgw: init_rados failed leads to repeated delete (#12978, Xiaowei Chen)
* rgw: init some manifest fields when handling explicit objs (#11455, Yeh=
uda Sadeh)
* rgw: Keystone Fernet tokens break auth (#12761, Abhishek Lekshmanan)
* rgw: region data still exist in region-map after region-map update (#12=
964, dwj192)
* rgw: remove trailing :port from host for purposes of subdomain matching=
 (#12353, Yehuda Sadeh)
* rgw: rest-bench common/WorkQueue.cc: 54: FAILED assert(_threads.empty()=
) (#3896, huangjun)
* rgw: returns requested bucket name raw in Bucket response header (#1253=
7, Yehuda Sadeh)
* rgw: segmentation fault when rgw_gc_max_objs > HASH_PRIME (#12630, Ruif=
eng Yang)
* rgw: segments are read during HEAD on Swift DLO (#12780, Yehuda Sadeh)
* rgw: setting max number of buckets for user via ceph.conf option  (#127=
14, Vikhyat Umrao)
* rgw: Swift API: X-Trans-Id header is wrongly formatted (#12108, Radosla=
w Zarzynski)
* rgw: testGetContentType and testHead failed (#11091, Radoslaw Zarzynski=
)
* rgw: testGetContentType and testHead failed (#11438, Radoslaw Zarzynski=
)
* rgw: testGetContentType and testHead failed (#12157, Radoslaw Zarzynski=
)
* rgw: testGetContentType and testHead failed (#12158, Radoslaw Zarzynski=
)
* rgw: testGetContentType and testHead failed (#12363, Radoslaw Zarzynski=
)
* rgw: the arguments 'domain' should not be assigned when return false (#=
12629, Ruifeng Yang)
* tests: qa/workunits/cephtool/test.sh: don't assume crash_replay_interva=
l=3D45 (#13406, Sage Weil)
* tests: TEST_crush_rule_create_erasure consistently fails on i386 builde=
r (#12419, Loic Dachary)
* tools: ceph-disk zap should ensure block device (#11272, Loic Dachary)

For more detailed information, see the complete changelog at

  http://docs.ceph.com/docs/master/_downloads/v0.94.4.txt

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-0.94.4.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-d=
eploy
--557981400-247352914-1445288859=:18978--
