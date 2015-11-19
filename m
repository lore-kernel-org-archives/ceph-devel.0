From: Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: v0.80.11 Firefly released
Date: Thu, 19 Nov 2015 14:08:31 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511191404500.3880@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-945544031-1447970819=:3880"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-ID: <alpine.DEB.2.00.1511191408120.4075-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-945544031-1447970819=:3880
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <alpine.DEB.2.00.1511191408121.4075-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

This is a bugfix release for Firefly.  This Firefly 0.80.x is nearing
its planned end of life in January 2016 it may also be the last.

We recommend that all Firefly users upgrade.

For more detailed information, see the complete changelog at

  http://docs.ceph.com/docs/master/_downloads/v0.80.11.txt

Notable Changes
---------------

* build/ops: /etc/init.d/radosgw restart does not work correctly (#11140,=
 Dmitry Yatsushkevich)
* build/ops: Fix -Wno-format and -Werror=3Dformat-security options clash =
 (#13417, Boris Ranto)
* build/ops: ceph-common needs python-argparse on older distros, but does=
n't require it (#12034, Nathan Cutler)
* build/ops: ceph.spec.in running fdupes unnecessarily (#12301, Nathan Cu=
tler)
* build/ops: ceph.spec.in: 50-rbd.rules conditional is wrong (#12166, Nat=
han Cutler)
* build/ops: ceph.spec.in: useless %py_requires breaks SLE11-SP3 build (#=
12351, Nathan Cutler)
* build/ops: fedora21 has junit, not junit4  (#10728, Ken Dreyer, Loic Da=
chary)
* build/ops: upstart: configuration is too generous on restarts (#11798, =
Sage Weil)
* common: Client admin socket leaks file descriptors (#11535, Jon Bernard=
)
* common: FileStore calls syncfs(2) even it is not supported (#12512, Dan=
ny Al-Gaaf, Kefu Chai, Jianpeng Ma)
* common: HeartBeat: include types (#13088, Sage Weil)
* common: Malformed JSON command output when non-ASCII strings are presen=
t  (#7387, Kefu Chai, Tim Serong)
* common: Memory leak in Mutex.cc, pthread_mutexattr_init without pthread=
_mutexattr_destroy (#11762, Ketor Meng)
* common: Thread:pthread_attr_destroy(thread_attr) when done with it (#12=
570, Piotr Da=C5?ek, Zheng Qiankun)
* common: ThreadPool add/remove work queue methods not thread safe (#1266=
2, Jason Dillaman)
* common: buffer: critical bufferlist::zero bug (#12252, Haomai Wang)
* common: log: take mutex while opening fd (#12465, Samuel Just)
* common: recursive lock of md_config_t (0) (#12614, Josh Durgin)
* crush: take crashes due to invalid arg (#11602, Sage Weil)
* doc: backport v0.80.10 release notes to firefly (#11090, Loic Dachary, =
Sage Weil)
* doc: update docs to point to download.ceph.com (#13162, Alfredo Deza)
* fs: MDSMonitor: handle MDSBeacon messages properly (#11590, Kefu Chai)
* fs: client nonce collision due to unshared pid namespaces (#13032, Josh=
 Durgin, Sage Weil)
* librbd: Objectcacher setting max object counts too low (#7385, Jason Di=
llaman)
* librbd: aio calls may block (#11056, Haomai Wang, Sage Weil, Jason Dill=
aman)
* librbd: internal.cc: 1967: FAILED assert(watchers.size() =3D=3D 1) (#12=
176, Jason Dillaman)
* mon: Clock skew causes missing summary and confuses Calamari (#11877, T=
horsten Behrens)
* mon: EC pools are not allowed as cache pools, disallow in the mon (#116=
50, Samuel Just)
* mon: Make it more difficult to delete pools in firefly (#11800, Sage We=
il)
* mon: MonitorDBStore: get_next_key() only if prefix matches (#11786, Joa=
o Eduardo Luis)
* mon: PaxosService: call post_refresh() instead of post_paxos_update() (=
#11470, Joao Eduardo Luis)
* mon: add a cache layer over MonitorDBStore (#12638, Kefu Chai)
* mon: adding exsting pool as tier with --force-nonempty clobbers removed=
_snaps (#11493, Sage Weil, Samuel Just)
* mon: ceph fails to compile with boost 1.58 (#11576, Kefu Chai)
* mon: does not check for IO errors on every transaction (#13089, Sage We=
il)
* mon: get pools health'info have error (#12402, renhwztetecs)
* mon: increase globalid default for firefly (#13255, Sage Weil)
* mon: pgmonitor: wrong at/near target max=E2?? reporting (#12401, huangj=
un)
* mon: register_new_pgs() should check ruleno instead of its index (#1221=
0, Xinze Chi)
* mon: scrub error (osdmap encoding mismatch?) upgrading from 0.80 to ~0.=
80.2 (#8815, #8674, #9064, Sage Weil, Zhiqiang Wang, Samuel Just)
* mon: the output is wrong when runing ceph osd reweight (#12251, Joao Ed=
uardo Luis)
* objecter: can get stuck in redirect loop if osdmap epoch =3D=3D last_fo=
rce_op_resend (#11026, Jianpeng Ma, Sage Weil)
* objecter: pg listing can deadlock when throttling is in use (#9008, Gua=
ng Yang)
* objecter: resend linger ops on split (#9806, Josh Durgin, Samuel Just)
* osd: Cleanup boost optionals for boost 1.56 (#9983, William A. Kenningt=
on III)
* osd: LibRadosTwoPools[EC]PP.PromoteSnap failure (#10052, Sage Weil)
* osd: Mutex Assert from PipeConnection::try_get_pipe (#12437, David Zafm=
an)
* osd: PG stuck with remapped (#9614, Guang Yang)
* osd: PG::handle_advance_map: on_pool_change after handling the map chan=
ge (#12809, Samuel Just)
* osd: PGLog: split divergent priors as well (#11069, Samuel Just)
* osd: PGLog::proc_replica_log: correctly handle case where entries betwe=
en olog.head and log.tail were split out (#11358, Samuel Just)
* osd: WBThrottle::clear_object: signal on cond when we reduce throttle v=
alues (#12223, Samuel Just)
* osd: cache full mode still skips young objects (#10006, Xinze Chi, Zhiq=
iang Wang)
* osd: crash creating/deleting pools (#12429, John Spray)
* osd: explicitly specify OSD features in MOSDBoot (#10911, Sage Weil)
* osd: is_new_interval() fixes (#11771, #10399, Samuel Just, Jason Dillam=
an)
* osd: make the all osd/filestore thread pool suicide timeouts separately=
 configurable (#11439, Samuel Just)
* osd: object creation by write cannot use an offset on an erasure coded =
pool (#11507, Jianpeng Ma, Loic Dachary)
* osd: os/FileJournal: Fix journal write fail, align for direct io (#1294=
3, Xie Rui)
* osd: osd/PGLog.cc: 732: FAILED assert(log.log.size() =3D=3D log_keys_de=
bug.size()) (#12652, Sage Weil)
* osd: read on chunk-aligned xattr not handled (#12309, Sage Weil)
* rgw: Change variable length array of std::strings (not legal in C++) to=
 std::vector<std::string> (#12467, Daniel J. Hofmann)
* rgw: Civetweb RGW appears to report full size of object as downloaded w=
hen only partially downloaded (#11851, Yehuda Sadeh)
* rgw: Keystone PKI token expiration is not enforced (#11367, Anton Aksol=
a)
* rgw: Object copy bug (#11639, Javier M. Mellid)
* rgw: RGW returns requested bucket name raw in "Bucket" response header =
(#11860, #12537, Yehuda Sadeh, Wido den Hollander)
* rgw: Swift API: response for PUT on /container does not contain the man=
datory Content-Length header when FCGI is used (#11036, Radoslaw Zarzynsk=
i)
* rgw: content length parsing calls strtol() instead of strtoll() (#10701=
, Yehuda Sadeh)
* rgw: delete bucket does not remove .bucket.meta file (#11149, Orit Wass=
erman)
* rgw: doesn't return 'x-timestamp' in header which is used by 'View Deta=
ils' of OpenStack (#8911, Yehuda Sadeh)
* rgw: init some manifest fields when handling explicit objs (#11455, Yeh=
uda Sadeh)
* rgw: logfile does not get chowned properly (#12073, Thorsten Behrens)
* rgw: logrotate.conf calls service with wrong init script name (#12043, =
wuxingyi)
* rgw: quota not respected in POST object (#11323, Sergey Arkhipov)
* rgw: swift smoke test fails on TestAccountUTF8 (#11091, #11438, #12939,=
 #12157, #12158, #12363, Radoslaw Zarzynski, Orit Wasserman, Robin H. Joh=
nson)
* rgw: use correct objv_tracker for bucket instance (#11416, Yehuda Sadeh=
)
* tests: ceph-fuse crash in test_client_recovery (#12673, Loic Dachary)
* tests: kernel_untar_build fails on EL7 (#11758, Greg Farnum)
* tests: qemu workunit refers to apt-mirror.front.sepia.ceph.com (#13420,=
 Yuan Zhou, Sage Weil)
* tools:  src/ceph-disk : disk zap sgdisk invocation (#11143, Thorsten Be=
hrens, Owen Synge)
* tools: ceph-disk: sometimes the journal symlink is not created (#10146,=
 Dan van der Ster)
* tools: ceph-disk: support NVMe device partitions (#11612, Ilja Slepnev)
* tools: ceph-post-file fails on rhel7 (#11836, Joseph McDonald, Sage Wei=
l)
* tools: ceph_argparse_flag has no regular 3rd parameter (#11543, Thorste=
n Behrens)
* tools: use a new disk as journal disk,ceph-disk prepare fail (#10983, L=
oic Dachary)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-0.80.11.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-d=
eploy
--557981400-945544031-1447970819=:3880
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-945544031-1447970819=:3880--
