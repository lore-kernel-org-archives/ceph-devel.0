From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.80 Firefly released
Date: Tue, 6 May 2014 18:05:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

We did it!  Firefly v0.80 is built and pushed out to the ceph.com 
repositories.

This release will form the basis for our long-term supported release
Firefly, v0.80.x.  The big new features are support for erasure coding
and cache tiering, although a broad range of other features, fixes,
and improvements have been made across the code base.  Highlights include:

* *Erasure coding*: support for a broad range of erasure codes for lower
  storage overhead and better data durability.
* *Cache tiering*: support for creating 'cache pools' that store hot,
  recently accessed objects with automatic demotion of colder data to
  a base tier.  Typically the cache pool is backed by faster storage
  devices like SSDs.
* *Primary affinity*: Ceph now has the ability to skew selection of
  OSDs as the "primary" copy, which allows the read workload to be
  cheaply skewed away from parts of the cluster without migrating any
  data.
* *Key/value OSD backend* (experimental): An alternative storage backend
  for Ceph OSD processes that puts all data in a key/value database like
  leveldb.  This provides better performance for workloads dominated by
  key/value operations (like radosgw bucket indices).
* *Standalone radosgw* (experimental): The radosgw process can now run
  in a standalone mode without an apache (or similar) web server or
  fastcgi.  This simplifies deployment and can improve performance.

We expect to maintain a series of stable releases based on v0.80
Firefly for as much as a year.  In the meantime, development of Ceph
continues with the next release, Giant, which will feature work on the
CephFS distributed file system, more alternative storage backends
(like RocksDB and f2fs), RDMA support, support for pyramid erasure
codes, and additional functionality in the block device (RBD) like
copy-on-read and multisite mirroring.

This release is the culmination of a huge collective effort by about 100 
different contributors.  Thank you everyone who has helped to make this 
possible!

Upgrade Sequencing
------------------

* If your existing cluster is running a version older than v0.67
  Dumpling, please first upgrade to the latest Dumpling release before
  upgrading to v0.80 Firefly.  Please refer to the :ref:`Dumpling upgrade`
  documentation.

* Upgrade daemons in the following order:

    1. Monitors
    2. OSDs
    3. MDSs and/or radosgw

  If the ceph-mds daemon is restarted first, it will wait until all
  OSDs have been upgraded before finishing its startup sequence.  If
  the ceph-mon daemons are not restarted prior to the ceph-osd
  daemons, they will not correctly register their new capabilities
  with the cluster and new features may not be usable until they are
  restarted a second time.

* Upgrade radosgw daemons together.  There is a subtle change in behavior
  for multipart uploads that prevents a multipart request that was initiated
  with a new radosgw from being completed by an old radosgw.

Notable changes since v0.79
---------------------------

* ceph-fuse, libcephfs: fix several caching bugs (Yan, Zheng)
* ceph-fuse: trim inodes in response to mds memory pressure (Yan, Zheng)
* librados: fix inconsistencies in API error values (David Zafman)
* librados: fix watch operations with cache pools (Sage Weil)
* librados: new snap rollback operation (David Zafman)
* mds: fix respawn (John Spray)
* mds: misc bugs (Yan, Zheng)
* mds: misc multi-mds fixes (Yan, Zheng)
* mds: use shared_ptr for requests (Greg Farnum)
* mon: fix peer feature checks (Sage Weil)
* mon: require 'x' mon caps for auth operations (Joao Luis)
* mon: shutdown when removed from mon cluster (Joao Luis)
* msgr: fix locking bug in authentication (Josh Durgin)
* osd: fix bug in journal replay/restart (Sage Weil)
* osd: many many many bug fixes with cache tiering (Samuel Just)
* osd: track omap and hit_set objects in pg stats (Samuel Just)
* osd: warn if agent cannot enable due to invalid (post-split) stats (Sage Weil)
* rados bench: track metadata for multiple runs separately (Guang Yang)
* rgw: fixed subuser modify (Yehuda Sadeh)
* rpm: fix redhat-lsb dependency (Sage Weil, Alfredo Deza)

For the complete release notes, please see:

   http://ceph.com/docs/master/release-notes/#v0-80-firefly


Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.80.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
