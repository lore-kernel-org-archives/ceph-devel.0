From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.89 released
Date: Thu, 4 Dec 2014 09:17:00 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412040916100.23830@cobra.newdream.net>
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
To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is the second development release since Giant.  The big items
include the first batch of scrub patchs from Greg for CephFS, a rework
in the librados object listing API to properly handle namespaces, and
a pile of bug fixes for RGW.  There are also several smaller issues
fixed up in the performance area with buffer alignment and memory
copies, osd cache tiering agent, and various CephFS fixes.

Upgrading
---------

* New ability to list all objects from all namespaces can fail or
  return incomplete results when not all OSDs have been upgraded.
  Features rados --all ls, rados cppool, rados export, rados
  cache-flush-evict-all and rados cache-try-flush-evict-all can also
  fail or return incomplete results.

Notable Changes
---------------

* buffer: add list::get_contiguous (Sage Weil)
* buffer: avoid rebuild if buffer already contiguous (Jianpeng Ma)
* ceph-disk: improved systemd support (Owen Synge)
* ceph-disk: set guid if reusing journal partition (Dan van der Ster)
* ceph-fuse, libcephfs: allow xattr caps in inject_release_failure (#9800 
  John Spray)
* ceph-fuse, libcephfs: fix I_COMPLETE_ORDERED checks (#9894 Yan, Zheng)
* ceph-fuse: fix dentry invalidation on 3.18+ kernels (#9997 Yan, Zheng)
* crush: fix detach_bucket (#10095 Sage Weil)
* crush: fix several bugs in adjust_item_weight (Rongze Zhu)
* doc: add dumpling to firefly upgrade section (#7679 John Wilkins)
* doc: document erasure coded pool operations (#9970 Loic Dachary)
* doc: file system osd config settings (Kevin Dalley)
* doc: key/value store config reference (John Wilkins)
* doc: update openstack docs for Juno (Sebastien Han)
* fix cluster logging from non-mon daemons (Sage Weil)
* init-ceph: check for systemd-run before using it (Boris Ranto)
* librados: fix infinite loop with skipped map epochs (#9986 Ding Dinghua)
* librados: fix iterator operator= bugs (#10082 David Zafman, Yehuda 
  Sadeh)
* librados: fix null deref when pool DNE (#9944 Sage Weil)
* librados: fix timer race from recent refactor (Sage Weil)
* libradosstriper: fix shutdown hang (Dongmao Zhang)
* librbd: don't close a closed parent in failure path (#10030 Jason 
  Dillaman)
* librbd: fix diff test (#10002 Josh Durgin)
* librbd: fix locking for readahead (#10045 Jason Dillaman)
* librbd: refactor unit tests to use fixtures (Jason Dillaman)
* many many coverity cleanups (Danny Al-Gaaf)
* mds: a whole bunch of initial scrub infrastructure (Greg Farnum)
* mds: fix compat_version for MClientSession (#9945 John Spray)
* mds: fix reply snapbl (Yan, Zheng)
* mon: allow adding tiers to fs pools (#10135 John Spray)
* mon: fix MDS health status from peons (#10151 John Spray)
* mon: fix caching for min_last_epoch_clean (#9987 Sage Weil)
* mon: fix error output for add_data_pool (#9852 Joao Eduardo Luis)
* mon: include entity name in audit log for forwarded requests (#9913 Joao 
  Eduardo Luis)
* mon: paxos: allow reads while proposing (#9321 #9322 Joao Eduardo Luis)
* msgr: asyncmessenger: add kqueue support (#9926 Haomai Wang)
* osd, librados: revamp PG listing API to handle namespaces (#9031 #9262 
  #9438 David Zafman)
* osd, mon: send intiial pg create time from mon to osd (#9887 David 
  Zafman)
* osd: allow whiteout deletion in cache pool (Sage Weil)
* osd: cache pool: ignore min flush age when cache is full (Xinze Chi)
* osd: erasure coding: allow bench.sh to test ISA backend (Yuan Zhou)
* osd: erasure-code: encoding regression tests, corpus (#9420 Loic 
  Dachary)
* osd: fix journal shutdown race (Sage Weil)
* osd: fix object age eviction (Zhiqiang Wang)
* osd: fix object atime calculation (Xinze Chi)
* osd: fix past_interval display bug (#9752 Loic Dachary)
* osd: journal: fix alignment checks, avoid useless memmove (Jianpeng Ma)
* osd: journal: update committed_thru after replay (#6756 Samuel Just)
* osd: keyvaluestore_dev: optimization (Chendi Xue)
* osd: make misdirected op checks robust for EC pools (#9835 Sage Weil)
* osd: removed some dead code (Xinze Chi)
* qa: parallelize make check (Loic Dachary)
* qa: tolerate nearly-full disk for make check (Loic Dachary)
* rgw: create subuser if needed when creating user (#10103 Yehuda Sadeh)
* rgw: fix If-Modified-Since (VRan Liu)
* rgw: fix content-length update (#9576 Yehuda Sadeh)
* rgw: fix disabling of max_size quota (#9907 Dong Lei)
* rgw: fix incorrect len when len is 0 (#9877 Yehuda Sadeh)
* rgw: fix object copy content type (#9478 Yehuda Sadeh)
* rgw: fix user stags in get-user-info API (#9359 Ray Lv)
* rgw: remove swift user manifest (DLO) hash calculation (#9973 Yehuda 
  Sadeh)
* rgw: return timestamp on GET/HEAD (#8911 Yehuda Sadeh)
* rgw: set ETag on object copy (#9479 Yehuda Sadeh)
* rgw: update bucket index on attr changes, for multi-site sync (#5595 
  Yehuda Sadeh)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.89.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
