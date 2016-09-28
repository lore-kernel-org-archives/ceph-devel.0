From: Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: v10.2.3 Jewel Released
Date: Wed, 28 Sep 2016 15:58:11 +0200
Message-ID: <8737kknn2k.fsf@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0759911715=="
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

--===============0759911715==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This point release fixes several important bugs in RBD mirroring, RGW multi=
-site, CephFS, and RADOS.

We recommend that all v10.2.x users upgrade.

Notable changes in this release include:
* build/ops: 60-ceph-partuuid-workaround-rules still needed by debian jessi=
e (udev 215-17) (#16351, runsisi, Loic Dachary)
* build/ops: ceph Resource Agent does not work with systemd (#14828, Nathan=
 Cutler)
* build/ops: ceph-base requires parted (#16095, Ken Dreyer)
* build/ops: ceph-osd-prestart.sh contains Upstart-specific code (#15984, N=
athan Cutler)
* build/ops: mount.ceph: move from ceph-base to ceph-common and add symlink=
 in /sbin for SUSE (#16598, #16645, Nathan Cutler, Dan Hor=C3=A1k, Ricardo =
Dias, Kefu Chai)
* build/ops: need rocksdb commit 7ca731b12ce for ppc64le build (#17092, Nat=
han Cutler)
* build/ops: rpm: OBS needs ExclusiveArch (#16936, Michel Normand)
* cli: ceph command line tool chokes on ceph =E2=80=93w (the dash is unicod=
e 'en dash' &ndash, copy-paste to reproduce) (#12287, Oleh Prypin, Kefu Cha=
i)
* common: expose buffer const_iterator symbols (#16899, Noah Watkins)
* common: global-init: fixup chown of the run directory along with log and =
asok files (#15607, Karol Mroz)
* fs: ceph-fuse: link to libtcmalloc or jemalloc (#16655, Yan, Zheng)
* fs: client: crash in unmount when fuse_use_invalidate_cb is enabled (#161=
37, Yan, Zheng)
* fs: client: fstat cap release (#15723, Yan, Zheng, Noah Watkins)
* fs: essential backports for OpenStack Manila (#15406, #15614, #15615, Joh=
n Spray, Ramana Raja, Xiaoxi Chen)
* fs: fix double-unlock on shutdown (#17126, Greg Farnum)
* fs: fix mdsmap print_summary with standby replays (#15705, John Spray)
* fs: fuse mounted file systems fails SAMBA CTDB ping_pong rw test with v9.=
0.2 (#12653, #15634, Yan, Zheng)
* librados: Add cleanup message with time to rados bench output (#15704, Vi=
khyat Umrao)
* librados: Missing export for rados_aio_get_version in src/include/rados/l=
ibrados.h (#15535, Jim Wright)
* librados: osd: bad flags can crash the osd (#16012, Sage Weil)
* librbd: Close journal and object map before flagging exclusive lock as re=
leased (#16450, Jason Dillaman)
* librbd: Crash when utilizing advisory locking API functions (#16364, Jaso=
n Dillaman)
* librbd: ExclusiveLock object leaked when switching to snapshot (#16446, J=
ason Dillaman)
* librbd: FAILED assert(object_no < m_object_map.size()) (#16561, Jason Dil=
laman)
* librbd: Image removal doesn't necessarily clean up all rbd_mirroring entr=
ies (#16471, Jason Dillaman)
* librbd: Object map/fast-diff invalidated if journal replays the same snap=
 remove event (#16350, Jason Dillaman)
* librbd: Timeout sending mirroring notification shouldn't result in failur=
e (#16470, Jason Dillaman)
* librbd: Whitelist EBUSY error from snap unprotect for journal replay (#16=
445, Jason Dillaman)
* librbd: cancel all tasks should wait until finisher is done (#16517, Haom=
ai Wang)
* librbd: delay acquiring lock if image watch has failed (#16923, Jason Dil=
laman)
* librbd: fix missing return statement if failed to get mirror image state =
(#16600, runsisi)
* librbd: flag image as updated after proxying maintenance op (#16404, Jaso=
n Dillaman)
* librbd: mkfs.xfs slow performance with discards and object map (#16707, #=
16689, Jason Dillaman)
* librbd: potential use after free on refresh error (#16519, Mykola Golub)
* librbd: rbd-nbd does not properly handle resize notifications (#15715, My=
kola Golub)
* librbd: the option 'rbd_cache_writethrough_until_flush=3Dtrue' dosn't wor=
k (#16740, #16386, #16708, #16654, #16478, Mykola Golub, xinxin shu, Xiaowe=
i Chen, Jason Dillaman)
* mds:  tell command blocks forever with async messenger (TestVolumeClient.=
test_evict_client failure) (#16288, Douglas Fuller)
* mds: Confusing MDS log message when shut down with stalled journaler read=
s (#15689, John Spray)
* mds: Deadlock on shutdown active rank while busy with metadata IO (#16042=
, Patrick Donnelly)
* mds: Failing file operations on kernel based cephfs mount point leaves un=
accessible file behind on hammer 0.94.7 (#16013, Yan, Zheng)
* mds: Fix shutting down mds timed-out due to deadlock (#16396, Zhi Zhang)
* mds: MDSMonitor fixes (#16136, xie xingguo)
* mds: MDSMonitor::check_subs() is very buggy (#16022, Yan, Zheng)
* mds: Session::check_access() is buggy (#16358, Yan, Zheng)
* mds: StrayManager.cc: 520: FAILED assert(dnl->is_primary()) (#15920, Yan,=
 Zheng)
* mds: enforce a dirfrag limit on entries (#16164, Patrick Donnelly)
* mds: fix SnapRealm::have_past_parents_open() (#16299, Yan, Zheng)
* mds: fix getattr starve setattr (#16154, Yan, Zheng)
* mds: wrongly treat symlink inode as normal file/dir when symlink inode is=
 stale on kcephfs (#15702, Zhi Zhang)
* mon: "mon metadata" fails when only one monitor exists (#15866, John Spra=
y, Kefu Chai)
* mon: Monitor: validate prefix on handle_command() (#16297, You Ji)
* mon: OSDMonitor: drop pg temps from not the current primary (#16127, Samu=
el Just)
* mon: prepare_pgtemp needs to only update up_thru if newer than the existi=
ng one (#16185, Samuel Just)
* msgr: AsyncConnection::lockmsg/async lockdep cycle: AsyncMessenger::lock,=
 MDSDaemon::mds_lock, AsyncConnection::lock (#16237, Haomai Wang)
* msgr: async messenger mon crash (#16378, #16418, Haomai Wang)
* msgr: backports of all asyncmsgr fixes to jewel (#15503, #15372, Yan Jun,=
 Haomai Wang, Piotr Da=C5=82ek)
* msgr: msg/async: connection race hang (#15849, Haomai Wang)
* osd: FileStore: umount hang because sync thread doesn't exit (#15695, Kef=
u Chai)
* osd: Fixes for list-inconsistent-* (#15766, #16192, #15719, David Zafman)
* osd: New pools have bogus stuck inactive/unclean HEALTH_ERR messages unti=
l they are first active and clean (#14952, Sage Weil)
* osd: OSD crash with Hammer to Jewel Upgrade: void FileStore::init_temp_co=
llections() (#16672, David Zafman)
* osd: OSD failed to subscribe skipped osdmaps after ceph osd pause (#17023=
, Kefu Chai)
* osd: ObjectCacher split BufferHead read fix (#16002, Greg Farnum)
* osd: ReplicatedBackend doesn't increment stats on pull, only push (#16277=
, Kefu Chai)
* osd: Scrub error: 0/1 pinned (#15952, Samuel Just)
* osd: crash adding snap to purged_snaps in ReplicatedPG::WaitingOnReplicas=
 (#15943, Samuel Just)
* osd: partprobe intermittent issues during ceph-disk prepare (#15176, Mari=
us Vollmer, Loic Dachary)
* osd: saw valgrind issues in ReplicatedPG::new_repop (#16801, Kefu Chai)
* osd: sparse_read on ec pool should return extends with correct offset (#1=
6138, kofiliu)
* osd:sched_time not actually randomized (#15890, xie xingguo)
* rbd: ImageReplayer::is_replaying does not include flush state  (#16970, J=
ason Dillaman)
* rbd: Journal duplicate op detection can cause lockdep error (#16363, Jaso=
n Dillaman)
* rbd: Journal needs to handle duplicate maintenance op tids (#16362, Jason=
 Dillaman)
* rbd: Unable to disable journaling feature if in unexpected mirror state (=
#16348, Jason Dillaman)
* rbd: bashism in src/rbdmap  (#16608, Jason Dillaman)
* rbd: doc: format 2 now is the default image format (#17026, Chengwei Yang)
* rbd: hen journaling is enabled, a flush request shouldn't flush the cache=
 (#15761, Yuan Zhou)
* rbd: possible race condition during journal transition from replay to rea=
dy (#16198, Jason Dillaman)
* rbd: qa/workunits/rbd: respect RBD_CREATE_ARGS environment variable (#162=
89, Mykola Golub)
* rbd: rbd-mirror should disable proxied maintenance ops for non-primary im=
age (#16411, Jason Dillaman)
* rbd: rbd-mirror: FAILED assert(m_local_image_ctx->object_map !=3D nullptr=
) (#16558, Jason Dillaman)
* rbd: rbd-mirror: FAILED assert(m_on_update_status_finish =3D=3D nullptr) =
(#16956, Jason Dillaman)
* rbd: rbd-mirror: FAILED assert(m_state =3D=3D STATE_STOPPING) (#16980, Ja=
son Dillaman)
* rbd: rbd-mirror: ensure replay status formatter has completed before stop=
ping replay (#16352, Jason Dillaman)
* rbd: rbd-mirror: include local pool id in resync throttle unique key (#16=
536, #15239, #16488, #16491, #16329, #15108, #15670, Ricardo Dias, Jason Di=
llaman)
* rbd: rbd-mirror: potential race condition accessing local image journal  =
(#16230, Jason Dillaman)
* rbd: rbd-mirror: reduce memory footprint during journal replay (#16321, #=
16489, #16622, #16539, #16223, #16349, Mykola Golub, Jason Dillaman)
* rgw: A query on a static large object fails with 404 error (#16015, Rados=
law Zarzynski)
* rgw: Add zone rename to radosgw_admin (#16934, Shilpa Jagannath)
* rgw: Bucket index shards orphaned after bucket delete (#16412, Orit Wasse=
rman)
* rgw: Bug when using port 443s in rgw. (#16548, Pritha Srivastava)
* rgw: Fallback to Host header for bucket name. (#15975, Robin H. Johnson)
* rgw: Fix civetweb IPv6 (#16928, Robin H. Johnson)
* rgw: Increase log level for messages occuring while running rgw admin com=
mand (#16935, Shilpa Jagannath)
* rgw: No Last-Modified, Content-Size and X-Object-Manifest headers if no s=
egments in DLO manifest (#15812, Radoslaw Zarzynski)
* rgw: RGWPeriodPuller tries to pull from itself (#16939, Casey Bodley)
* rgw: Set Access-Control-Allow-Origin to a Asterisk if allowed in a rule (=
#15348, Wido den Hollander)
* rgw: Swift API returns double space usage and objects of account metadata=
 (#16188, Albert Tu)
* rgw: account/container metadata not actually present in a request are del=
eted during POST through Swift API (#15977, #15779, Radoslaw Zarzynski)
* rgw: add socket backlog setting for via ceph.conf (#16406, Feng Guo)
* rgw: add tenant support to multisite sync (#16469, #16121, #16665, Yehuda=
 Sadeh, Josh Durgin, Casey Bodley, Pritha Srivastava)
* rgw: add_zone only clears master_zone if --master=3Dfalse (#15901, Casey =
Bodley)
* rgw: aws4 parsing issue (#15940, #15939, Yehuda Sadeh)
* rgw: aws4: add STREAMING-AWS4-HMAC-SHA256-PAYLOAD support (#16146, Radosl=
aw Zarzynski, Javier M. Mellid)
* rgw: backport merge of static sites fixes (#15555, #15532, #15531, Robin =
H. Johnson)
* rgw: can set negative max_buckets on RGWUserInfo (#14534, Yehuda Sadeh)
* rgw: cleanup radosgw-admin temp command as it was deprecated (#16023, Vik=
hyat Umrao)
* rgw: comparing return code to ERR_NOT_MODIFIED in rgw_rest_s3.cc (needs m=
inus sign) (#16327, Nathan Cutler)
* rgw: custom metadata aren't camelcased in Swift's responses (#15902, Rado=
slaw Zarzynski)
* rgw: data sync stops after getting error in all data log sync shards (#16=
530, Yehuda Sadeh)
* rgw: default zone and zonegroup cannot be added to a realm (#16839, Casey=
 Bodley)
* rgw: document multi tenancy (#16635, Pete Zaitcev)
* rgw: don't unregister request if request is not connected to manager (#15=
911, Yehuda Sadeh)
* rgw: failed to create bucket after upgrade from hammer to jewel (#16627, =
Orit Wasserman)
* rgw: fix ldap bindpw parsing (#16286, Matt Benjamin)
* rgw: fix multi-delete query param parsing. (#16618, Robin H. Johnson)
* rgw: improve support for Swift's object versioning. (#15925, Radoslaw Zar=
zynski)
* rgw: initial slashes are not properly handled in Swift's BulkDelete (#159=
48, Radoslaw Zarzynski)
* rgw: master: build failures with boost > 1.58 (#16392, #16391, Abhishek L=
ekshmanan)
* rgw: multisite segfault on ~RGWRealmWatcher if realm was deleted (#16817,=
 Casey Bodley)
* rgw: multisite sync races with deletes (#16222, #16464, #16220, #16143, Y=
ehuda Sadeh, Casey Bodley)
* rgw: multisite: preserve zone's extra pool (#16712, Abhishek Lekshmanan)
* rgw: object expirer's hints might be trimmed without processing in some c=
ircumstances (#16705, #16684, Radoslaw Zarzynski)
* rgw: radosgw-admin failure for user create after upgrade from hammer to j=
ewel (#15937, Orit Wasserman, Abhishek Lekshmanan)
* rgw: radosgw-admin: EEXIST messages for create operations (#15720, Abhish=
ek Lekshmanan)
* rgw: radosgw-admin: inconsistency in uid/email handling (#13598, Matt Ben=
jamin)
* rgw: realm pull fails when using apache frontend (#15846, Orit Wasserman)
* rgw: retry on bucket sync errors (#16108, Yehuda Sadeh)
* rgw: s3website: x-amz-website-redirect-location header returns malformed =
HTTP response (#15531, Robin H. Johnson)
* rgw: segfault in RGWOp_MDLog_Notify (#16666, Casey Bodley)
* rgw: segmentation fault on error_repo in data sync (#16603, Casey Bodley)
* rgw: selinux denials in RGW (#16126, Boris Ranto)
* rgw: support size suffixes for --max-size in radosgw-admin command (#1600=
4, Vikhyat Umrao)
* rgw: updating CORS/ACLs might not work in some circumstances (#15976, Rad=
oslaw Zarzynski)
* rgw: use zone endpoints instead of zonegroup endpoints (#16834, Casey Bod=
ley)
* tests: improve rbd-mirror test case coverage (#16197, Mykola Golub, Jason=
 Dillaman)
* tests: rados/test.sh workunit timesout on OpenStack (#15403, Loic Dachary)
* tools: ceph-disk: Accept bcache devices as data disks (#13278, Peter Saba=
ini)
* tools: src/script/subman fails with KeyError: 'nband' (#16961, Loic Dacha=
ry, Ali Maredia)

For more detailed information refer to the complete changelog[1] and the
release notes[2]

Getting Ceph
=2D-----------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-10.2.3.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-dep=
loy

[1]: http://docs.ceph.com/docs/master/_downloads/v10.2.3.txt
[2]: http://docs.ceph.com/docs/master/release-notes/#v10-2-3-jewel

Regards,
Abhishek
=2D-
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton, =
HRB 21284 (AG N=C3=BCrnberg)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX68xzAAoJEPnwZB8bZe1fWOUH/0PJts/EzgabC7bdDHpOgqh8
Fpk+YqXxp5qRztOrFu0m4ibksp8mhVmejqOfxM+W1BILyrMFswuiwhgPzuBMsbFq
NsyeiLvDJh8+yjcHq7rYz4sienQied12yi1niy9L6f0hD2e6cywSFm2yBNVhO+Ns
GWNp4AJiNuuJYNh9aR7YOqKvI6/KWMvmq6Jqzz08KNs/E+PHaxks7GQELCI1bvWR
yTalhVdCyfANkKahtxqpEiuJuYqx2cW4D2onOBozELohgGsZYxyi48M9j0p2KQUt
NYgz+utVuRf/nm+7VL7eY75kpdI7t7AG2uFJh+L14pN20hxLcHcBE3xGjMVO38w=
=4gan
-----END PGP SIGNATURE-----
--=-=-=--

--===============0759911715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0759911715==--
