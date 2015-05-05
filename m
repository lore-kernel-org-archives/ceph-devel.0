From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: v9.0.0 released
Date: Tue, 5 May 2015 16:08:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505051603120.29888@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is the first development release for the Infernalis cycle, and the 
first Ceph release to sport a version number from the new numbering 
scheme.  The "9" indicates this is the 9th release cycle--I (for 
Infernalis) is the 9th letter.  The first "0" indicates this is a 
development release ("1" will mean release candidate and "2" will mean 
stable release), and the final "0" indicates this is the first such 
development release.

A few highlights include:

* a new 'ceph daemonperf' command to watch perfcounter stats in realtime
* reduced MDS memory usage
* many MDS snapshot fixes
* librbd can now store options in the image itself
* many fixes for RGW Swift API support
* OSD performance improvements
* many doc updates and misc bug fixes

Notable Changes
---------------

* aarch64: add optimized version of crc32c (Yazen Ghannam, Steve Capper)
* auth: reinit NSS after fork() (#11128 Yan, Zheng)
* build: disable LTTNG by default (#11333 Josh Durgin)
* build: fix ppc build (James Page)
* build: install-deps: support OpenSUSE (Loic Dachary)
* build: misc cmake fixes (Matt Benjamin)
* ceph-disk: follow ceph-osd hints when creating journal (#9580 Sage Weil)
* ceph-disk: handle re-using existing partition (#10987 Loic Dachary)
* ceph-disk: improve parted output parsing (#10983 Loic Dachary)
* ceph-disk: make suppression work for activate-all and activate-journal 
  (Dan van der Ster)
* ceph-disk: misc fixes (Alfredo Deza)
* ceph-fuse, libcephfs: don't clear COMPLETE when trimming null (Yan, 
  Zheng)
* ceph-fuse, libcephfs: hold exclusive caps on dirs we "own" (#11226 Greg 
  Farnum)
* ceph-fuse: do not require successful remount when unmounting (#10982 
  Greg Farnum)
* ceph: new 'ceph daemonperf' command (John Spray, Mykola Golub)
* common: PriorityQueue tests (Kefu Chai)
* common: add descriptions to perfcounters (Kiseleva Alyona)
* common: fix LTTNG vs fork issue (Josh Durgin)
* crush: fix has_v4_buckets (#11364 Sage Weil)
* crushtool: fix order of operations, usage (Sage Weil)
* debian: minor package reorg (Ken Dreyer)
* doc: docuemnt object corpus generation (#11099 Alexis Normand)
* doc: fix gender neutrality (Alexandre Maragone)
* doc: fix install doc (#10957 Kefu Chai)
* doc: fix sphinx issues (Kefu Chai)
* doc: mds data structure docs (Yan, Zheng)
* doc: misc updates (Nilamdyuti Goswami, Vartika Rai, Florian Haas, Loic 
  Dachary, Simon Guinot, Andy Allan, Alistair Israel, Ken Dreyer, Robin 
  Rehu, Lee Revell, Florian Marsylle, Thomas Johnson, Bosse Klykken, 
  Travis Rhoden, Ian Kelling)
* doc: swift tempurls (#10184 Abhishek Lekshmanan)
* doc: switch doxygen integration back to breathe (#6115 Kefu Chai)
* erasure-code: update ISA-L to 2.13 (Yuan Zhou)
* gmock: switch to submodule (Danny Al-Gaaf, Loic Dachary)
* hadoop: add terasort test (Noah Watkins)
* java: fix libcephfs bindings (Noah Watkins)
* libcephfs,ceph-fuse: fix request resend on cap reconnect (#10912 Yan, 
  Zheng)
* librados: define C++ flags from C constants (Josh Durgin)
* librados: fix last_force_resent handling (#11026 Jianpeng Ma)
* librados: fix memory leak from C_TwoContexts (Xiong Yiliang)
* librados: fix striper when stripe_count = 1 and stripe_unit != 
  object_size (#11120 Yan, Zheng)
* librados: op perf counters (John Spray)
* librados: pybind: fix write() method return code (Javier Guerra)
* libradosstriper: fix leak (Danny Al-Gaaf)
* librbd: add purge_on_error cache behavior (Jianpeng Ma)
* librbd: misc aio fixes (#5488 Jason Dillaman)
* librbd: misc rbd fixes (#11478 #11113 #11342 #11380 Jason Dillaman, 
  Zhiqiang Wang)
* librbd: readahead fixes (Zhiqiang Wang)
* librbd: store metadata, including config options, in image (Haomai Wang)
* mds: add 'damaged' state to MDSMap (John Spray)
* mds: add nicknames for perfcounters (John Spray)
* mds: disable problematic rstat propagation into snap parents (Yan, 
  Zheng)
* mds: fix mydir replica issue with shutdown (#10743 John Spray)
* mds: fix out-of-order messages (#11258 Yan, Zheng)
* mds: fix shutdown with strays (#10744 John Spray)
* mds: fix snapshot fixes (Yan, Zheng)
* mds: fix stray handling (John Spray)
* mds: flush immediately in do_open_truncate (#11011 John Spray)
* mds: improve dump methods (John Spray)
* mds: misc journal cleanups and fixes (#10368 John Spray)
* mds: new SessionMap storage using omap (#10649 John Spray)
* mds: reduce memory consumption (Yan, Zheng)
* mds: throttle purge stray operations (#10390 John Spray)
* mds: tolerate clock jumping backwards (#11053 Yan, Zheng)
* misc coverity fixes (Danny Al-Gaaf)
* mon: do not deactivate last mds (#10862 John Spray)
* mon: make osd get pool 'all' only return applicable fields (#10891 
  Michal Jarzabek)
* mon: warn on bogus cache tier config (Jianpeng Ma)
* msg/async: misc bug fixes and updates (Haomai Wang)
* msg/simple: fix connect_seq assert (Haomai Wang)
* msg/xio: misc fixes (#10735 Matt Benjamin, Kefu Chai, Danny Al-Gaaf, 
  Raju Kurunkad, Vu Pham)
* msg: unit tests (Haomai Wang)
* objectcacher: misc bug fixes (Jianpeng Ma)
* os/filestore: enlarge getxattr buffer size (Jianpeng Ma)
* osd: EIO injection (David Zhang)
* osd: add misc perfcounters (Xinze Chi)
* osd: add simple sleep injection in recovery (Sage Weil)
* osd: allow SEEK_HOLE/SEEK_DATA for sparse read (Zhiqiang Wang)
* osd: avoid dup omap sets for in pg metadata (Sage Weil)
* osd: clean up some constness, privateness (Kefu Chai)
* osd: erasure-code: drop entries according to LRU (Andreas-Joachim 
  Peters)
* osd: fix negative degraded stats during backfill (Guang Yang)
* osd: misc fixes (Ning Yao, Kefu Chai, Xinze Chi, Zhiqiang Wang, Jianpeng 
  Ma)
* pybind: pep8 cleanups (Danny Al-Gaaf)
* qa: fix filelock_interrupt.py test (Yan, Zheng)
* qa: improve ceph-disk tests (Loic Dachary)
* qa: improve docker build layers (Loic Dachary)
* rados: translate erno to string in CLI (#10877 Kefu Chai)
* rbd: accept map options config option (Ilya Dryomov)
* rbd: cli: fix arg parsing with --io-pattern (Dmitry Yatsushkevich)
* rbd: fix error messages (#2862 Rajesh Nambiar)
* rbd: update rbd man page (Ilya Dryomov)
* rbd: update xfstests tests (Douglas Fuller)
* rgw: add X-Timestamp for Swift containers (#10938 Radoslaw Zarzynski)
* rgw: add missing headers to Swift container details (#10666 Ahmad 
  Faheem, Dmytro Iurchenko)
* rgw: add stats to headers for account GET (#10684 Yuan Zhou)
* rgw: do not prefecth data for HEAD requests (Guang Yang)
* rgw: don't clobber bucket/object owner when setting ACLs (#10978 Yehuda 
  Sadeh)
* rgw: don't use rgw_socket_path if frontend is configured (#11160 Yehuda 
  Sadeh)
* rgw: enforce Content-Lenth for POST on Swift cont/obj (#10661 Radoslaw 
  Zarzynski)
* rgw: fix handling empty metadata items on Swift container (#11088 
  Radoslaw Zarzynski)
* rgw: fix log rotation (Wuxingyi)
* rgw: generate Date header for civetweb (#10873 Radoslaw Zarzynski)
* rgw: make init script wait for radosgw to stop (#11140 Dmitry 
  Yatsushkevich)
* rgw: make quota/gc threads configurable (#11047 Guang Yang)
* rgw: pass in civetweb configurables (#10907 Yehuda Sadeh)
* rgw: rectify 202 Accepted in PUT response (#11148 Radoslaw Zarzynski)
* rgw: remove meta file after deleting bucket (#11149 Orit Wasserman)
* rgw: swift: allow setting attributes with COPY (#10662 Ahmad Faheem, 
  Dmytro Iurchenko)
* rgw: swift: fix metadata handling on copy (#10645 Radoslaw Zarzynski)
* rgw: swift: send Last-Modified header (#10650 Radoslaw Zarzynski)
* rgw: update keystone cache with token info (#11125 Yehuda Sadeh)
* rgw: update to latest civetweb, enable config for IPv6 (#10965 Yehuda 
  Sadeh)
* rocksdb: update to latest (Xiaoxi Chen)
* rpm: loosen ceph-test dependencies (Ken Dreyer)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-9.0.0.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
