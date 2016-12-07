From: Abhishek L <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: 10.2.4 Jewel released
Date: Wed, 07 Dec 2016 13:21:23 +0100
Message-ID: <877f7c3p6k.fsf@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2102301176=="
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

--===============2102301176==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This point release fixes several important bugs in RBD mirroring, RGW
multi-site, CephFS, and RADOS.

We recommend that all v10.2.x users upgrade. Also note the following when u=
pgrading from hammer

Upgrading from hammer
=2D--------------------

When the last hammer OSD in a cluster containing jewel MONs is
upgraded to jewel, as of 10.2.4 the jewel MONs will issue this
warning: "all OSDs are running jewel or later but the
'require_jewel_osds' osdmap flag is not set" and change the
cluster health status to HEALTH_WARN.

This is a signal for the admin to do "ceph osd set require_jewel_osds" - by
doing this, the upgrade path is complete and no more pre-Jewel OSDs may be =
added
to the cluster.


Notable Changes
=2D--------------
* build/ops: aarch64: Compiler-based detection of crc32 extended CPU type i=
s broken (issue#17516 , pr#11492 , Alexander Graf)
* build/ops: allow building RGW with LDAP disabled (issue#17312 , pr#11478 =
, Daniel Gryniewicz)
* build/ops: backport 'logrotate: Run as root/ceph' (issue#17381 , pr#11201=
 , Boris Ranto)
* build/ops: ceph installs stuff in %_udevrulesdir but does not own that di=
rectory (issue#16949 , pr#10862 , Nathan Cutler)
* build/ops: ceph-osd-prestart.sh fails confusingly when data directory doe=
s not exist (issue#17091 , pr#10812 , Nathan Cutler)
* build/ops: disable LTTng-UST in openSUSE builds (issue#16937 , pr#10794 ,=
 Michel Normand)
* build/ops: i386 tarball gitbuilder failure on master (issue#16398 , pr#10=
855 , Vikhyat Umrao, Kefu Chai)
* build/ops: include more files in "make dist" tarball (issue#17560 , pr#11=
431 , Ken Dreyer)
* build/ops: incorrect value of CINIT_FLAG_DEFER_DROP_PRIVILEGES (issue#166=
63 , pr#10278 , Casey Bodley)
* build/ops: remove SYSTEMD_RUN from initscript (issue#7627 , issue#16441 ,=
 issue#16440 , pr#9872 , Vladislav Odintsov)
* build/ops: systemd: add install section to rbdmap.service file (issue#175=
41 , pr#11158 , Jelle vd Kooij)
* common: Enable/Disable of features is allowed even the features are alrea=
dy enabled/disabled (issue#16079 , pr#11460 , Lu Shi)
* common: Log.cc: Assign LOG_INFO priority to syslog calls (issue#15808 , p=
r#11231 , Brad Hubbard)
* common: Proxied operations shouldn't result in error messages if replayed=
 (issue#16130 , pr#11461 , Vikhyat Umrao)
* common: Request exclusive lock if owner sends -ENOTSUPP for proxied maint=
enance op (issue#16171 , pr#10784 , Jason Dillaman)
* common: msgr/async: Messenger thread long time lock hold risk (issue#1575=
8 , pr#10761 , Wei Jin)
* doc: fix description for rsize and rasize (issue#17357 , pr#11171 , Andre=
as Gerstmayr)
* filestore: can get stuck in an unbounded loop during scrub (issue#17859 ,=
 pr#12001 , Sage Weil)
* fs: Failure in snaptest-git-ceph.sh (issue#17172 , pr#11419 , Yan, Zheng)
* fs: Log path as well as ino when detecting metadata damage (issue#16973 ,=
 pr#11418 , John Spray)
* fs: client: FAILED assert(root_ancestor->qtree =3D=3D __null) (issue#1606=
6 , issue#16067 , pr#10107 , Yan, Zheng)
* fs: client: add missing client_lock for get_root (issue#17197 , pr#10921 =
, Patrick Donnelly)
* fs: client: fix shutdown with open inodes (issue#16764 , pr#10958 , John =
Spray)
* fs: client: nlink count is not maintained correctly (issue#16668 , pr#108=
77 , Jeff Layton)
* fs: multimds: allow_multimds not required when max_mds is set in ceph.con=
f at startup (issue#17105 , pr#10997 , Patrick Donnelly)
* librados: memory leaks from ceph::crypto (WITH_NSS) (issue#17205 , pr#114=
09 , Casey Bodley)
* librados: modify Pipe::connect() to return the error code (issue#15308 , =
pr#11193 , Vikhyat Umrao)
* librados: remove new setxattr overload to avoid breaking the C++ ABI (iss=
ue#18058 , pr#12207 , Josh Durgin)
* librbd: cannot disable journaling or remove non-mirrored, non-primary ima=
ge (issue#16740 , pr#11337 , Jason Dillaman)
* librbd: discard after write can result in assertion failure (issue#17695 =
, pr#11644 , Jason Dillaman)
* librbd::Operations: update notification failed: (2) No such file or direc=
tory (issue#17549 , pr#11420 , Jason Dillaman)
* mds: Crash in Client::_invalidate_kernel_dcache when reconnecting during =
unmount (issue#17253 , pr#11414 , Yan, Zheng)
* mds: Duplicate damage table entries (issue#17173 , pr#11412 , John Spray)
* mds: Failure in dirfrag.sh (issue#17286 , pr#11416 , Yan, Zheng)
* mds: Failure in snaptest-git-ceph.sh (issue#17271 , pr#11415 , Yan, Zheng)
* mon: Ceph Status - Segmentation Fault (issue#16266 , pr#11408 , Brad Hubb=
ard)
* mon: Display full flag in ceph status if full flag is set (issue#15809 , =
pr#9388 , Vikhyat Umrao)
* mon: Error EINVAL: removing mon.a at 172.21.15.16:6789/0, there will be 1=
 monitors (issue#17725 , pr#12267 , Joao Eduardo Luis)
* mon: OSDMonitor: only reject MOSDBoot based on up_from if inst matches (i=
ssue#17899 , pr#12067 , Samuel Just)
* mon: OSDMonitor: Missing nearfull flag set (issue#17390 , pr#11272 , Igor=
 Podoski)
* mon: Upgrading 0.94.6 -> 0.94.9 saturating mon node networking (issue#173=
65 , issue#17386 , pr#11679 , Sage Weil, xie xingguo)
* mon: ceph mon Segmentation fault after set crush_ruleset ceph 10.2.2 (iss=
ue#16653 , pr#10861 , song baisen)
* mon: crash: crush/CrushWrapper.h: 940: FAILED assert(successful_detach) (=
issue#16525 , pr#10496 , Kefu Chai)
* mon: don't crash on invalid standby_for_fscid (issue#17466 , pr#11389 , J=
ohn Spray)
* mon: fix missing osd metadata (again) (issue#17685 , pr#11642 , John Spra=
y)
* mon: osdmonitor: decouple adjust_heartbeat_grace and min_down_reporters (=
issue#17055 , pr#10757 , Zengran Zhang)
* mon: the %USED of ceph df is wrong (issue#16933 , pr#10860 , Kefu Chai)
* osd: condition OSDMap encoding on features (issue#18015 , pr#12167 , Sage=
 Weil)
* osd: PG::_update_calc_stats wrong for CRUSH_ITEM_NONE up set items (issue=
#16998 , pr#10883 , Samuel Just)
* osd: PG::choose_acting valgrind error or ./common/hobject.h: 182: FAILED =
assert(!max || (*this =3D=3D hobject_t(hobject_t::get_max()))) (issue#13967=
 , pr#10885 , Tao Chang)
* osd: Potential crash during journal::Replay shut down (issue#16433 , pr#1=
0645 , Jason Dillaman)
* osd: add peer_addr in heartbeat_check log message (issue#15762 , pr#9739 =
, Vikhyat Umrao, Sage Weil)
* osd: adjust scrub boundary to object without SnapSet (issue#17470 , pr#11=
311 , Samuel Just)
* osd: ceph osd df does not show summarized info correctly if one or more O=
SDs are out (issue#16706 , pr#10759 , xie xingguo)
* osd: journal: do not prematurely flag object recorder as closed (issue#17=
590 , pr#11634 , Jason Dillaman)
* osd: mark_all_unfound_lost() leaves unapplied changes (issue#16156 , pr#1=
0886 , Samuel Just)
* osd: segfault in ObjectCacher::FlusherThread (issue#16610 , pr#10864 , Ya=
n, Zheng)
* qa: remove EnumerateObjects from librados upgrade tests (pr#11728 , Josh =
Durgin)
* rbd: Disabling pool mirror mode with registered peers results orphaned mi=
rrored images (issue#16984 , pr#10857 , Jason Dillaman)
* rbd: ImageWatcher: use after free within C_UnwatchAndFlush (issue#17289 ,=
 issue#17254 , pr#11466 , Jason Dillaman)
* rbd: Prevent the creation of a clone from a non-primary mirrored image (i=
ssue#16449 , pr#10650 , Mykola Golub)
* rbd: RBD should restrict mirror enable/disable actions on parents/clones =
(issue#16056 , pr#11459 , zhuangzeqiang)
* rbd: TestJournalReplay: sporadic assert(m_state =3D=3D STATE_READY || m_s=
tate =3D=3D STATE_STOPPING) failure (issue#17566 , pr#11590 , Jason Dillama=
n)
* rbd: bench io-size should not be larger than image size (issue#16967 , pr=
#10796 , Jason Dillaman)
* rbd: ceph 10.2.2 rbd status on image format 2 returns (2) No such file or=
 directory (issue#16887 , pr#10652 , Jason Dillaman)
* rbd: helgrind: TestLibRBD.TestIOPP potential deadlock closing an image wi=
th read-ahead enabled (issue#17198 , pr#11463 , Jason Dillaman)
* rbd: image.stat() call in librbdpy fails sometimes (issue#17310 , pr#1146=
4 , Jason Dillaman)
* rbd: krbd qa scripts and concurrent.sh test fix (issue#17223 , pr#11018 ,=
 Ilya Dryomov)
* rbd: krbd-related CLI patches (issue#17554 , pr#11400 , Ilya Dryomov)
* rbd: mirror: improve resiliency of stress test case (issue#16855 , issue#=
16555 , issue#14738 , issue#15259 , issue#17446 , issue#17355 , issue#16538=
 , issue#16974 , issue#17283 , issue#17317 , issue#17416 , issue#16227 , pr=
#11433 , Mykola Golub, Ricardo Dias, Jason Dillaman)
* rbd: rbd-nbd IO hang (issue#16921 , pr#11467 , Jason Dillaman)
* rbd: update_features API needs to support backwards/forward compatibility=
 (issue#17330 , pr#11462 , Jason Dillaman)
* rgw: COPY broke multipart files uploaded under dumpling (issue#16435 , pr=
#10866 , Yehuda Sadeh)
* rgw: Config parameter rgw keystone make new tenants in radosgw multitenan=
cy does not work (issue#17293 , pr#11473 , SirishaGuduru)
* rgw: Do not archive metadata by default (issue#17256 , pr#11321 , Pavan R=
allabhandi, Matt Benjamin)
* rgw: ERROR: got unexpected error when trying to read object: -2 (issue#17=
111 , pr#11472 , Yang Honggang)
* rgw: Modification for TEST S3 ACCESS section in INSTALL CEPH OBJECT GATEW=
AY page (issue#15603 , pr#11475 , la-sguduru)
* rgw: RGW loses realm/period/zonegroup/zone data: period overwritten if so=
mewhere in the cluster is still running Hammer (issue#17371 , pr#11519 , Or=
it Wasserman)
* rgw: RGWDataSyncCR fails on errors from RGWListBucketIndexesCR (issue#170=
73 , pr#11330 , Casey Bodley)
* rgw: S3 object versioning fails when applied on a non-master zone (issue#=
16494 , pr#11367 , Yehuda Sadeh)
* rgw: add orphan options to radosgw-admin --help and man page (issue#17281=
 , issue#17280 , pr#11139 , Ken Dreyer, Thomas Serlin)
* rgw: back off bucket sync on failures, don't store marker (issue#16742 , =
pr#11021 , Yehuda Sadeh)
* rgw: combined LDAP backports (issue#17544 , issue#17185 , pr#11332 , Hara=
ld Klein, Matt Benjamin)
* rgw: cors auto memleak (issue#16564 , pr#10656 , Yan Jun)
* rgw: default quota fixes (issue#16410 , pr#10832 , Pavan Rallabhandi, Dan=
iel Gryniewicz)
* rgw: doc: description of multipart part entity is wrong (issue#17504 , pr=
#11342 , weiqiaomiao)
* rgw: don't loop forever when reading data from 0 sized segment. (issue#17=
692 , pr#11626 , Marcus Watts)
* rgw: fix put_acls for objects starting and ending with underscore (issue#=
17625 , pr#11669 , Orit Wasserman)
* rgw: fix regression with handling double underscore (issue#17443 , issue#=
16856 , pr#11563 , Yehuda Sadeh, Orit Wasserman)
* rgw: handle empty POST condition (issue#17635 , pr#11662 , Yehuda Sadeh)
* rgw: metadata sync can skip markers for failed/incomplete entries (issue#=
16759 , pr#10657 , Yehuda Sadeh)
* rgw: nfs backports (issue#17393 , issue#17311 , issue#17367 , issue#17319=
 , issue#17321 , issue#17322 , issue#17323 , issue#17325 , issue#17326 , is=
sue#17327 , pr#11335 , Min Chen, Yan Jun, Weibing Zhang, Matt Benjamin)
* rgw: period commit loses zonegroup changes: region_map converted repeated=
ly (issue#17051 , pr#10890 , Casey Bodley)
* rgw: period commit return error when the current period has a zonegroup w=
hich doesn't have a master zone (issue#17110 , pr#10867 , weiqiaomiao)
* rgw: radosgw daemon core when reopen logs (issue#17036 , pr#10868 , weiqi=
aomiao)
* rgw: rgw file uses too much CPU in gc/idle thread (issue#16976 , pr#10889=
 , Matt Benjamin)
* rgw: s3tests-test-readwrite failing with 500 (issue#16930 , pr#11471 , Ye=
huda Sadeh)
* rgw: upgrade from old multisite to new multisite fails (issue#16751 , pr#=
10891 , Orit Wasserman)
* rgw:response information is error when geting token of swift account (iss=
ue#15195 , pr#11474 , Qiankun Zheng)
* rgw:user email can modify to empty when it has values (issue#13286 , pr#1=
1469 , Yehuda Sadeh, Weijun Duan)
* tests: ceph-disk must ignore debug monc (issue#17607 , pr#11548 , Loic Da=
chary)
* tests: fix TestClsRbd.mirror_image failure in upgrade:jewel-x-master-dist=
ro-basic-vps (issue#16529 , pr#10888 , Jason Dillaman)
* tests: scsi_debug fails /dev/disk/by-partuuid (issue#17100 , pr#11411 , L=
oic Dachary)
* tests: test/ceph_test_msgr: do not use Message::middle for holding transi=
ent=E2=80=A6 (issue#17365 , issue#17728 , issue#16955 , pr#11742 , Haomai W=
ang, Kefu Chai, Michal Jarzabek, Sage Weil)
* tools: Missing comma in ceph-create-keys causes concatenation of argument=
s (issue#17815 , pr#11822 , Patrick Donnelly)
* tools: add a tool to rebuild mon store from OSD (issue#17179 , issue#1740=
0 , pr#11126 , Kefu Chai, xie xingguo)
* tools: ceph-create-keys: sometimes blocks forever if mds allow is set (is=
sue#16255 , pr#11417 , John Spray)
* tools: ceph-disk should timeout when a lock cannot be acquired (issue#165=
80 , pr#10758 , Loic Dachary)
* tools: ceph-disk: expected systemd unit failures are confusing (issue#159=
90 , pr#10884 , Boris Ranto)
* tools: ceph-disk: using a regular file as a journal fails (issue#16280 , =
issue#17662 , pr#11657 , Jayashree Candadai, Anirudha Bose, Loic Dachary, S=
hylesh Kumar)
* tools: ceph-objectstore-tool crashes if --journal-path <a-directory> (iss=
ue#17307 , pr#11407 , Kefu Chai)
* tools: ceph-objectstore-tool: add a way to split filestore directories of=
fline (issue#17220 , pr#11252 , Josh Durgin)
* tools: ceph-post-file: use new ssh key (issue#14267 , pr#11746 , David Ga=
lloway)

For more detailed information refer to the complete changelog[1] and the
release notes[2]

Getting Ceph
=2D-----------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-10.2.4.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-dep=
loy

[1]: http://docs.ceph.com/docs/master/_downloads/v10.2.4.txt
[2]: http://docs.ceph.com/docs/master/release-notes/#v10-2-4-jewel

Best,
=2D-
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton, =
HRB 21284 (AG N=C3=BCrnberg)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJYR/7LAAoJEPnwZB8bZe1f9N8H+wSegqu7yVzD5PT4EafeK7em
DrtboAwW3D1xzhOn4kliZJZWpEDEXUSq7sxmSPNYGcl99PIYRiUGF86Upq6gUxfF
Wu6qc61QbBFEYIFW77FFAbrDuTQsnftD11hFGd4ksgxirvE1ZCbsCBYtYKZMbbsJ
NCgumCjBy2h5aV7v+Eyh+/F0FQBc6J8n9W2FENo7Ne4I22MoFhyn9GhO57MoIbMj
ee8TR+inYED+4wIpdlzlX6I/Py7yQnAqqG6ajSPkNm/Np5tJqqMzrbukwmRRvUO9
EhRbEgKbo7JOauUKyNIdW1jMVF38E/rCnb/7ucG3N1FhReZtxD3HlQpdaa9OaaQ=
=WpgL
-----END PGP SIGNATURE-----
--=-=-=--

--===============2102301176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2102301176==--
