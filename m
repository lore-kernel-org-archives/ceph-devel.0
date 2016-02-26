From: Sage Weil <sage@redhat.com>
Subject: v9.2.1 Infernalis released
Date: Fri, 26 Feb 2016 10:46:05 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602261044500.3289@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1220648611-1456501565=:3289"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47460 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932768AbcBZPqf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Feb 2016 10:46:35 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1220648611-1456501565=:3289
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

This Infernalis point release fixes several packagins and init script=20
issues, enables the librbd objectmap feature by default, a few librbd=20
bugs, and a range of miscellaneous bug fixes across the system.

We recommend that all infernalis v9.2.0 users upgrade.

For more detailed information, see the complete changelog:

  http://docs.ceph.com/docs/master/_downloads/v9.2.1.txt

Notable Changes
---------------

* build/ops: Ceph daemon failed to start, because the service name was alre=
ady used. (#13474, Chuanhong Wang)
* build/ops: ceph upstart script rbdmap.conf incorrectly processes paramete=
rs (#13214, Sage Weil)
* build/ops: libunwind package missing on CentOS 7 (#13997, Loic Dachary)
* build/ops: rbd-replay-* moved from ceph-test-dbg to ceph-common-dbg as we=
ll (#13785, Loic Dachary)
* build/ops: systemd/ceph-disk@.service assumes /bin/flock (#13975, Loic Da=
chary)
* build/ops: systemd: no rbdmap systemd unit file (#13374, Boris Ranto)
* common: auth/cephx: large amounts of log are produced by osd (#13610, Qia=
nkun Zheng)
* common: log: Log.cc: Assign LOG_DEBUG priority to syslog calls (#13993, B=
rad Hubbard)
* crush: crash if we see CRUSH_ITEM_NONE in early rule step (#13477, Sage W=
eil)
* fs: Ceph file system is not freeing space (#13777, Yan, Zheng, John Spray=
)
* fs: Ceph-fuse won't start correctly when the option log_max_new in ceph.c=
onf set to zero (#13443, Wenjun Huang)
* fs: Segmentation fault accessing file using fuse mount (#13714, Yan, Zhen=
g)
* librbd: Avoid re-writing old-format image header on resize (#13674, Jason=
 Dillaman)
* librbd: ImageWatcher shouldn't block the notification thread (#14373, Jas=
on Dillaman)
* librbd: QEMU hangs after creating snapshot and stopping VM (#13726, Jason=
 Dillaman)
* librbd: Verify self-managed snapshot functionality on image create (#1363=
3, Jason Dillaman)
* librbd: [ FAILED ] TestLibRBD.SnapRemoveViaLockOwner (#14164, Jason Dilla=
man)
* librbd: enable feature objectmap (#13558, xinxin shu)
* librbd: fix merge-diff for >2GB diff-files (#14030, Jason Dillaman)
* librbd: flattening an rbd image with active IO can lead to hang (#14092, =
#14483, Jason Dillaman)
* mds: fix client capabilities during reconnect (client.XXXX isn't respondi=
ng to mclientcaps warning) (#11482, Yan, Zheng)
* mon: Ceph Pools' MAX AVAIL is 0 if some OSDs' weight is 0 (#13840, Chengy=
uan Li)
* mon: should not set isvalid =3D true when cephx_verify_authorizer retur..=
=2E (#13525, Ruifeng Yang)
* objecter: pool op callback may hang forever. (#13642, xie xingguo)
* objecter: potential null pointer access when do pool_snap_list. (#13639, =
xie xingguo)
* osd: FileStore: potential memory leak if getattrs fails. (#13597, xie xin=
gguo)
* osd: OSD::build_past_intervals_parallel() shall reset primary and up_prim=
ary when begin a new past_interval. (#13471, xiexingguo)
* osd: call on_new_interval on newly split child PG (#13962, Sage Weil)
* osd: ceph-disk list fails on /dev/cciss!c0d0 (#13970, #14230, Loic Dachar=
y)
* osd: ceph-disk: use blkid instead of sgdisk -i (#14080, Loic Dachary, Ily=
a Dryomov)
* osd: fix race condition during send_failures (#13821, Sage Weil)
* osd: osd/PG.cc: 288: FAILED assert(info.last_epoch_started >=3D info.hist=
ory.last_epoch_started) (#14015, David Zafman)
* osd: pgs stuck inconsistent after infernalis upgrade (#13862, David Zafma=
n)
* rbd: TaskFinisher::cancel should remove event from SafeTimer (#14476, Dou=
glas Fuller)
* rbd: cls_rbd: object_map_save should enable checksums (#14280, Douglas Fu=
ller)
* rbd: misdirected op in rbd balance-reads test (#13491, Jason Dillaman)
* rbd: pure virtual method called (#13636, Jason Dillaman)
* rbd: rbd clone issue (#13553, xinxin shu)
* rbd: rbd-replay does not check for EOF and goes to endless loop (#14452, =
Mykola Golub)
* rbd: unknown argument --quiet in udevadm settle (#13560, Jason Dillaman)
* rgw: init script reload doesn't work on EL7 (#13709, Herv=E9 Rousseau)
* rgw: radosgw-admin --help doesn't show the orphans find command (#14516, =
Yehuda Sadeh)
* tests: ceph-disk workunit uses configobj (#14004, Loic Dachary)
* tests: fsx failed to compile (#14384, Greg Farnum)
* tests: notification slave needs to wait for master (#13810, Jason Dillama=
n)
* tests: rebuild exclusive lock test should acquire exclusive lock (#14121,=
 Jason Dillaman)
* tests: testprofile must be removed before it is re-created (#13664, Loic =
Dachary)
* tests: verify it is possible to reuse an OSD id (#13988, Loic Dachary)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-9.2.1.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-dep=
loy
--8323329-1220648611-1456501565=:3289--
