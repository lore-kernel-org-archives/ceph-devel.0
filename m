From: Abhishek L <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: v0.94.10 Hammer released
Date: Wed, 22 Feb 2017 11:43:24 +0100
Message-ID: <87ino2y08j.fsf@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1378875394=="
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

--===============1378875394==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This Hammer point release fixes several bugs and adds a couple of new
features.

We recommend that all hammer v0.94.x users upgrade.

Please note that Hammer will be retired when Luminous is released later
during the spring of this year. Until then, the focus will be primarily
on bugs that would hinder upgrades to Jewel.

New Features
=2D-----------

* ceph-objectstore-tool and ceph-monstore-tool now enable user to
rebuild the monitor database from OSDs. (This feature is especially useful =
when
all monitors fail to boot due to leveldb corruption.)

* In RADOS Gateway, it is now possible to reshard an existing bucket's index
using an off-line tool.

Usage:

$ radosgw-admin bucket reshard --bucket=3D<bucket_name> --num_shards=3D<num=
_shards>

This will create a new linked bucket instance that points to the newly crea=
ted
index objects. The old bucket instance still exists and currently it's up to
the user to manually remove the old bucket index objects. (Note that bucket
resharding currently requires that all IO (especially writes) to the specif=
ic
bucket is quiesced.)

Other Notable Changes
=2D--------------------

* build/ops: ceph-create-keys loops forever (issue#17753, pr#12805,  Alfred=
o Deza)
* build/ops: improve ceph.in error message (issue#11101,  pr#10905,  Kefu C=
hai)
* build/ops: make stop.sh more portable (issue#16918, pr#10569,  Mykola Gol=
ub)
* build/ops: remove SYSTEMD_RUN from initscript (issue#16440, issue#7627, p=
r#9873,  Vladislav Odintsov)
* cephx: Fix multiple segfaults due to attempts to encrypt or decrypt (issu=
e#16266, pr#11930,  Brad Hubbard)
* common: SIGABRT in TrackedOp::dump() via dump_ops_in_flight() (issue#8885=
, pr#12121,  Jianpeng Ma, Zhiqiang Wang, David Zafman)
* common: os/ObjectStore: fix _update_op for split dest_cid (issue#15345, p=
r#12071,  Sage Weil)
* crush: reset bucket->h.items[i] when removing tree item (issue#16525, pr#=
10724,  Kefu Chai)
* doc: add "Upgrading to Hammer" section (issue#17386, pr#11372,  Kefu Chai)
* doc: add orphan options to radosgw-admin --help and man page (issue#17281=
, issue#17280, pr#11140,  Abhishek Lekshmanan, Casey Bodley, Ken Dreyer, Th=
omas Serlin)
* doc: clarify that RGW bucket object versioning is supported (issue#16574,=
 pr#10437,  Yuan Zhou, shawn chen)
* librados: bad flags can crash the osd (issue#16012, pr#11936,  Jianpeng M=
a, Sage Weil)
* librbd: ceph 10.2.2 rbd status on image format 2 returns "(2) No such fil=
e or directory" (issue#16887, pr#10987,  Jason Dillaman)
* librbd: diffs to clone's first snapshot should include parent diffs (issu=
e#18068, pr#12446,  Jason Dillaman)
* librbd: image.stat() call in librbdpy fails sometimes (issue#17310, pr#11=
949,  Jason Dillaman)
* librbd: request exclusive lock if current owner cannot execute op (issue#=
16171, pr#12018,  Mykola Golub)
* mds: fix cephfs-java ftruncate unit test failure (issue#11258, pr#11939, =
 Yan, Zheng)
* mon: %USED of ceph df is wrong (issue#16933, pr#11934,  Kefu Chai)
* mon: MonmapMonitor should return success when MON will be removed (issue#=
17725, pr#12006,  Joao Eduardo Luis)
* mon: OSDMonitor: Missing nearfull flag set (issue#17390, pr#11273,  Igor =
Podoski)
* mon: OSDs marked OUT wrongly after monitor failover (issue#17719, pr#1194=
6,  Dong Wu)
* mon: fix memory leak in prepare_beacon (issue#17285, pr#10238,  Igor Podo=
ski)
* mon: osd flag health message is misleading (issue#18175, pr#12687,  Sage =
Weil)
* mon: prepare_pgtemp needs to only update up_thru if newer than the existi=
ng one (issue#16185, pr#11937,  Samuel Just)
* mon: return size_t from MonitorDBStore::Transaction::size() (issue#14217,=
 pr#10904,  Kefu Chai)
* mon: send updated monmap to its subscribers (issue#17558, pr#11457,  Kefu=
 Chai)
* msgr: OpTracker needs to release the message throttle in _unregistered (i=
ssue#14248, pr#11938,  Samuel Just)
* msgr: simple/Pipe: error decoding addr (issue#18072, pr#12266,  Sage Weil)
* osd: PG::_update_calc_stats wrong for CRUSH_ITEM_NONE up set items (issue=
#16998, pr#11933,  Samuel Just)
* osd: PG::choose_acting valgrind error or ./common/hobject.h: 182: FAILED =
assert(!max || (*this =3D=3D hobject_t(hobject_t::get_max()))) (issue#13967=
, pr#11932,  Tao Chang)
* osd: ReplicatedBackend::build_push_op: add a second config to limit omap =
entries/chunk independently of object data (issue#16128, pr#12417,  Wanlong=
 Gao)
* osd: crash on EIO during deep-scrubbing (issue#16034, pr#11935,  Nathan C=
utler)
* osd: filestore: FALLOC_FL_PUNCH_HOLE must be used with FALLOC_FL_KEEP_SIZ=
E (issue#18446, pr#13041,  xinxin shu)
* osd: fix cached_removed_snaps bug in PGPool::update after map gap (issue#=
18628, issue#15943, pr#12906,  Samuel Just)
* osd: fix collection_list shadow return value (issue#17713, pr#11927,  Hao=
mai Wang)
* osd: fix fiemap issue in xfs when #extents > 1364 (issue#17610, pr#11615,=
  Kefu Chai, Ning Yao)
* osd: update PGPool to detect map gaps and reset cached_removed_snaps (iss=
ue#15943, pr#11676,  Samuel Just)
* rbd: export diff should open image as read-only (issue#17671, pr#11948,  =
liyankun)
* rbd: fix parameter check (issue#18237, pr#12312,  Yankun Li)
* rbd: fix possible rbd data corruption (issue#16002, pr#11618,  Yan, Zheng=
, Greg Farnum)
* rgw: Anonymous user is able to read bucket with authenticated read ACL(is=
sue#13207, pr#11045,  rahul aggarwal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org)
* rgw: COPY broke multipart files uploaded under dumpling (issue#16435, pr#=
11950,  Yehuda Sadeh)
* rgw: TempURL in radosgw behaves now like its Swift's counterpart.  (issue=
#18316, pr#12619,  Radoslaw Zarzynski)
* rgw: default quota fixes (issue#16410, pr#10839,  Pavan Rallabhandi, Dani=
el Gryniewicz)
* rgw: do not abort when accept a CORS request with short origin (issue#181=
87, pr#12398,  LiuYang)
* rgw: do not omap_getvals with (u64)-1 max (issue#17985, pr#12418,  Yehuda=
 Sadeh, Sage Weil)
* rgw: fix crash when client posts object with null condition (issue#17635,=
 pr#11809,  Yehuda Sadeh)
* rgw: fix inconsistent uid/email handling in radosgw-admin (issue#13598, p=
r#11952,  Matt Benjamin)
* rgw: implement offline resharding command (issue#17745, pr#12227,  Yehuda=
 Sadeh, Orit Wasserman, weiqiaomiao)
* rgw: swift: ranged request on a DLO provides wrong values in Content-Rang=
e HTTP header (issue#13452, pr#11951,  Radoslaw Zarzynski)
* rgw: the value of total_time is wrong in the result of 'radosgw-admin log=
 show' opt (issue#17598, pr#11899,  weiqiaomiao)
* tests: Cannot clone ceph/s3-tests.git (missing branch) (issue#18384, pr#1=
2744,  Orit Wasserman)
* tests: Cannot reserve CentOS 7.2 smithi machines (issue#18401, pr#12762, =
 Nathan Cutler)
* tests: OSDs commit suicide in rbd suite when testing on btrfs (issue#1839=
7, pr#12758,  Nathan Cutler)
* tests: Workunits needlessly wget from git.ceph.com (issue#18336, issue#18=
271, issue#18388, pr#12685,  Sage Weil, Nathan Cutler)
* tests: cephfs test failures (ceph.com/qa is broken, should be download.ce=
ph.com/qa) (issue#18574, pr#13022,  John Spray)
* tests: merge ceph-qa-suite (pr#12455,  Sage Weil)
* tests: objecter_requests workunit fails on wip branches (issue#18393, pr#=
12759,  Sage Weil)
* tests: populate mnt_point in qa/tasks/ceph.py (issue#18383, pr#12743,  Na=
than Cutler)
* tests: qemu/tests/qemu-iotests/077 fails in dumpling, hammer, and jewel (=
issue#10773, pr#12423,  Jason Dillaman)
* tests: run fs/thrash on xfs instead of btrfs (issue#17151, pr#13039,  Nat=
han Cutler)
* tests: update Ubuntu image url after ceph.com refactor (issue#18542, pr#1=
2957,  Jason Dillaman)
* tests: update rbd/singleton/all/formatted-output.yaml to support ceph-ci =
* (issue#18440, pr#12824 *,  Venky Shankar, Nathan Cutler)
* tools: add a tool to rebuild mon store from OSD (issue#17179, issue#17400=
, pr#11125,  Kefu Chai, xie xingguo)
* tools: ceph-objectstore-tool crashes if --journal-path <a-directory> (iss=
ue#17307, pr#11929,  Kefu Chai)
* tools: ceph-objectstore-tool: add a way to split filestore directories of=
fline (issue#17220, pr#11253,  Josh Durgin)
* tools: crushtool --compile generates output despite missing item (issue#1=
7306, pr#11931,  Kefu Chai)

For more detailed information, read the release notes[1] & download the cha=
ngelog[2]

Getting Ceph
=2D-----------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-0.94.10.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://docs.ceph.com/docs/master/install/install-cep=
h-deploy
* Release sha1: b1e0532418e4631af01acbc0cedd426f1905f4af

[1]: http://ceph.com/releases/v0-94-10-hammer-released
[2]: http://docs.ceph.com/docs/master/_downloads/v0.94.10.txt

=2D-
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton, =
HRB 21284 (AG N=C3=BCrnberg)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJYrWtYAAoJEPnwZB8bZe1fQl0H/2//QNXeX10BPTpVCIlDUAAQ
Q353YqSjXZEvwZ5SCx0bJzieo2oB9mHtAMQmikbX9Q3AepL0SHFEYpyoZ/oX0slU
4arpsgykk4BZKC//iLgTfKEORAV9JUXvo/i+/Cv4MveOg3ua7UeL2x8Ribiok/U2
KkAIRxlr++Md06/HZMbVB0gywKdH+VB46EiWlePffj0G7Fwy1736QMO2Y2kyvLwz
hu/imfCmkYbzUSwsMY5zl2eG0X+8LA80JrQvyuVSlKMirBkz26WgFu96HIg56NVG
9Cod8WxV0RLfIXOnpHuY1gVcRXac4qRSaFhEXAmYoM/9TDivWrswiJLCbNH+cJU=
=QZqH
-----END PGP SIGNATURE-----
--=-=-=--

--===============1378875394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1378875394==--
