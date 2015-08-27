From: Sage Weil <sage@redhat.com>
Subject: v0.94.3 Hammer released
Date: Thu, 27 Aug 2015 08:33:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508270828030.10019@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-832912314-1440689582=:10019"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56382 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbbH0PdD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Aug 2015 11:33:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-announce@ceph.com, ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-832912314-1440689582=:10019
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This Hammer point release fixes a critical (though rare) data corruption=20
bug that could be triggered when logs are rotated via SIGHUP. It also=20
fixes a range of other important bugs in the OSD, monitor, RGW, RGW, and=20
CephFS.

All v0.94.x Hammer users are strongly encouraged to upgrade.

UPGRADING

* The=C2=A0pg=C2=A0ls-by-{pool,primary,osd}=C2=A0commands and=C2=A0pg=C2=A0=
ls=C2=A0now take the=20
  argument=C2=A0recovering=C2=A0instead of=C2=A0recovery=C2=A0in order to=
 include the=20
  recovering pgs in the listed pgs.

NOTABLE CHANGES

* librbd: aio calls may block (issue#11770,=C2=A0pr#4875, Jason Dillaman)
* osd: make the all osd/filestore thread pool suicide timeouts separately=
=20
  configurable (issue#11701,=C2=A0pr#5159, Samuel Just)
* mon: ceph fails to compile with boost 1.58 (issue#11982,=C2=A0pr#5122, =
Kefu=20
  Chai)
* tests: TEST_crush_reject_empty must not run a mon=20
  (issue#12285,11975,=C2=A0pr#5208, Kefu Chai
* osd: FAILED assert(!old_value.deleted()) in=20
  upgrade:giant-x-hammer-distro-basic-multi run (issue#11983,=C2=A0pr#512=
1,=20
  Samuel Just)
* build/ops: linking ceph to tcmalloc causes segfault on SUSE SLE11-SP3=20
  (issue#12368,=C2=A0pr#5265, Thorsten Behrens)
* common: utf8 and old gcc breakage on RHEL6.5 (issue#7387,=C2=A0pr#4687,=
 Kefu=20
  Chai)
* crush: take crashes due to invalid arg (issue#11740,=C2=A0pr#4891, Sage=
=20
  Weil)
* rgw: need conversion tool to handle fixes following #11974=20
  (issue#12502,=C2=A0pr#5384, Yehuda Sadeh)
* rgw: Swift API: support for 202 Accepted response code on container=20
  creation (issue#12299,=C2=A0pr#5214, Radoslaw Zarzynski)
* common: Log::reopen_log_file: take m_flush_mutex (issue#12520,=C2=A0pr#=
5405,=20
  Samuel Just)
* rgw: Properly respond to the Connection header with Civetweb=20
  (issue#12398,=C2=A0pr#5284, Wido den Hollander)
* rgw: multipart list part response returns incorrect field=20
  (issue#12399,=C2=A0pr#5285, Henry Chang)
* build/ops: ceph.spec.in: 95-ceph-osd.rules, mount.ceph, and=20
  mount.fuse.ceph not installed properly on SUSE (issue#12397,=C2=A0pr#52=
83,=20
  Nathan Cutler)
* rgw: radosgw-admin dumps user info twice (issue#12400,=C2=A0pr#5286, gu=
ce)
* doc: fix doc build (issue#12180,=C2=A0pr#5095, Kefu Chai)
* tests: backport 11493 fixes, and test, preventing ec cache pools=20
  (issue#12314,=C2=A0pr#4961, Samuel Just)
* rgw: does not send Date HTTP header when civetweb frontend is used=20
  (issue#11872,=C2=A0pr#5228, Radoslaw Zarzynski)
* mon: pg ls is broken (issue#11910,=C2=A0pr#5160, Kefu Chai)
* librbd: A client opening an image mid-resize can result in the object=20
  map being invalidated (issue#12237,=C2=A0pr#5279, Jason Dillaman)
* doc: missing man pages for ceph-create-keys, ceph-disk-*=20
  (issue#11862,=C2=A0pr#4846, Nathan Cutler)
* tools: ceph-post-file fails on rhel7 (issue#11876,=C2=A0pr#5038, Sage W=
eil)
* build/ops: rcceph script is buggy (issue#12090,=C2=A0pr#5028, Owen Syng=
e)
* rgw: Bucket header is enclosed by quotes (issue#11874,=C2=A0pr#4862, Wi=
do=20
  den Hollander)
* build/ops: packaging: add SuSEfirewall2 service files=20
  (issue#12092,=C2=A0pr#5030, Tim Serong)
* rgw: Keystone PKI token expiration is not enforced=20
  (issue#11722,=C2=A0pr#4884,Anton Aksola)
* build/ops: debian/control: ceph-common (>> 0.94.2) must be >=3D 0.94.2-=
2=20
  (issue#12529,11998,=C2=A0pr#5417, Loic Dachary)
* mon: Clock skew causes missing summary and confuses Calamari=20
  (issue#11879,=C2=A0pr#4868, Thorsten Behrens)
* rgw: rados objects wronly deleted (issue#12099,=C2=A0pr#5117, wuxingyi)
  tests: kernel_untar_build fails on EL7 (issue#12098,=C2=A0pr#5119, Greg=
=20
  Farnum)
* fs: Fh ref count will leak if readahead does not need to do read from=20
  osd (issue#12319,=C2=A0pr#5427, Zhi Zhang)
* mon: OSDMonitor: allow addition of cache pool with non-empty snaps with=
=20
  co... (issue#12595,=C2=A0pr#5252, Samuel Just)
* mon: MDSMonitor: handle MDSBeacon messages properly=20
  (issue#11979,=C2=A0pr#5123, Kefu Chai)
* tools: ceph-disk: get_partition_type fails on /dev/cciss...=20
  (issue#11760,=C2=A0pr#4892, islepnev)
* build/ops: max files open limit for OSD daemon is too low=20
  (issue#12087,=C2=A0pr#5026, Owen Synge)
* mon: add an 'osd crush tree' command (issue#11833,=C2=A0pr#5248, Kefu=20
  Chai)
* mon: mon crashes when 'ceph osd tree 85 --format json'=20
  (issue#11975,=C2=A0pr#4936, Kefu Chai)
* build/ops: ceph / ceph-dbg steal ceph-objecstore-tool from ceph-test /=20
  ceph-test-dbg (issue#11806,=C2=A0pr#5069, Loic Dachary)
* rgw: DragonDisk fails to create directories via S3: MissingContentLengt=
h=20
  (issue#12042,=C2=A0pr#5118, Yehuda Sadeh)
* build/ops: /usr/bin/ceph from ceph-common is broken without installing=20
  ceph (issue#11998,=C2=A0pr#5206, Ken Dreyer)
* build/ops: systemd: Increase max files open limit for OSD daemon=20
  (issue#11964,=C2=A0pr#5040, Owen Synge)
* build/ops: rgw/logrotate.conf calls service with wrong init script name=
=20
  (issue#12044,=C2=A0pr#5055, wuxingyi)
* common: OPT_INT option interprets 3221225472 as -1073741824, and crashe=
s=20
  in Throttle::Throttle() (issue#11738,=C2=A0pr#4889, Kefu Chai)
* doc: doc/release-notes: v0.94.2 (issue#11492,=C2=A0pr#4934, Sage Weil)
* common: admin_socket: close socket descriptor in destructor=20
  (issue#11706,=C2=A0pr#4657, Jon Bernard)
* rgw: Object copy bug (issue#11755,=C2=A0pr#4885, Javier M. Mellid)
* rgw: empty json response when getting user quota (issue#12245,=C2=A0pr#=
5237,=20
  wuxingyi)
* fs: cephfs Dumper tries to load whole journal into memory at once=20
  (issue#11999,=C2=A0pr#5120, John Spray)
* rgw: Fix tool for #11442 does not correctly fix objects created via=20
  multipart uploads (issue#12242,=C2=A0pr#5229, Yehuda Sadeh)
* rgw: Civetweb RGW appears to report full size of object as downloaded=20
  when only partially downloaded (issue#12243,=C2=A0pr#5231, Yehuda Sadeh=
)
* osd: stuck incomplete (issue#12362,=C2=A0pr#5269, Samuel Just)
* osd: start_flush: filter out removed snaps before determining snapc's=20
  (issue#11911,=C2=A0pr#4899, Samuel Just)
* librbd: internal.cc: 1967: FAILED assert(watchers.size() =3D=3D 1)=20
  (issue#12239,=C2=A0pr#5243, Jason Dillaman)
* librbd: new QA client upgrade tests (issue#12109,=C2=A0pr#5046, Jason=20
  Dillaman)
* librbd: [ FAILED ] TestLibRBD.ExclusiveLockTransition=20
  (issue#12238,=C2=A0pr#5241, Jason Dillaman)
* rgw: Swift API: XML document generated in response for GET on account=20
  does not contain account name (issue#12323,=C2=A0pr#5227, Radoslaw Zarz=
ynski)
* rgw: keystone does not support chunked input (issue#12322,=C2=A0pr#5226=
,=20
  Herv=C3=A9 Rousseau)
* mds: MDS is crashed (mds/CDir.cc: 1391: FAILED assert(!is_complete()))=20
  (issue#11737,=C2=A0pr#4886, Yan, Zheng)
* cli: ceph: cli interactive mode does not understand quotes=20
  (issue#11736,=C2=A0pr#4776, Kefu Chai)
* librbd: add valgrind memory checks for unit tests=20
  (issue#12384,=C2=A0pr#5280,Zhiqiang Wang)
* build/ops: admin/build-doc: script fails silently under certain=20
  circumstances (issue#11902,=C2=A0pr#4877, John Spray)
* osd: Fixes for rados ops with snaps (issue#11908,=C2=A0pr#4902, Samuel =
Just)
* build/ops: ceph.spec.in: ceph-common subpackage def needs tweaking for=20
  SUSE/openSUSE (issue#12308,=C2=A0pr#4883, Nathan Cutler)
* fs: client: reference counting 'struct Fh' (issue#12088,=C2=A0pr#5222,=20
  Yan, Zheng)
* build/ops: ceph.spec: update OpenSUSE BuildRequires=20
  (issue#11611,=C2=A0pr#4667, Loic Dachary)

For more detailed information, see=C2=A0the=C2=A0complete=C2=A0change:

  http://docs.ceph.com/docs/master/_downloads/v0.94.3.txt

GETTING CEPH

* Git at=C2=A0git://github.com/ceph/ceph.git
* Tarball at=C2=A0http://ceph.com/download/ceph-0.94.3.tar.gz
* For packages, see=C2=A0http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see=C2=A0http://ceph.com/docs/master/install/install-c=
eph-deploy
--557981400-832912314-1440689582=:10019--
