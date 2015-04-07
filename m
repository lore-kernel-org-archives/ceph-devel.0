From: "O'Reilly, Dan" <Daniel.OReilly-EYjPQcvs5+o@public.gmane.org>
Subject: Re: v0.94 Hammer released
Date: Tue, 7 Apr 2015 15:00:04 -0600
Message-ID: <72F29FF8CF6F4A439821624088377AF2011C7BFD77@MER2-EXCH07A2.echostar.com>
References: <alpine.DEB.2.00.1504071349220.31599@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1504071349220.31599-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: 'Sage Weil' <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-announce-Qp0mS5GaXlQ@public.gmane.org" <ceph-announce-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Where are the RPM repos for HAMMER?

Dan O'Reilly
UNIX Systems Administration

9601 S. Meridian Blvd.
Englewood, CO 80112
720-514-6293



-----Original Message-----
From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Sage Weil
Sent: Tuesday, April 07, 2015 2:55 PM
To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org; ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
Subject: [ceph-users] v0.94 Hammer released

This major release is expected to form the basis of the next long-term stable series.  It is intended to supercede v0.80.x Firefly.

Highlights since Giant include:

* RADOS Performance: a range of improvements have been made in the
  OSD and client-side librados code that improve the throughput on
  flash backends and improve parallelism and scaling on fast machines.
* Simplified RGW deployment: the ceph-deploy tool now has a new
  'ceph-deploy rgw create HOST' command that quickly deploys a
  instance of the S3/Swift gateway using the embedded Civetweb server.
  This is vastly simpler than the previous Apache-based deployment.
  There are a few rough edges (e.g., around SSL support) but we
  encourage users to try the new method:

    http://ceph.com/docs/master/start/quick-ceph-deploy/#add-an-rgw-instance

* RGW object versioning: RGW now supports the S3 object versioning
  API, which preserves old version of objects instead of overwriting
  them.
* RGW bucket sharding: RGW can now shard the bucket index for large
  buckets across, improving performance for very large buckets.
* RBD object maps: RBD now has an object map function that tracks
  which parts of the image are allocating, improving performance for
  clones and for commands like export and delete.
* RBD mandatory locking: RBD has a new mandatory locking framework
  (still disabled by default) that adds additional safeguards to
  prevent multiple clients from using the same image at the same time.
* RBD copy-on-read: RBD now supports copy-on-read for image clones,
  improving performance for some workloads.
* CephFS snapshot improvements: Many many bugs have been fixed with
  CephFS snapshots.  Although they are still disabled by default,
  stability has improved significantly.
* CephFS Recovery tools: We have built some journal recovery and
  diagnostic tools. Stability and performance of single-MDS systems is
  vastly improved in Giant, and more improvements have been made now
  in Hammer.  Although we still recommend caution when storing
  important data in CephFS, we do encourage testing for non-critical
  workloads so that we can better guage the feature, usability,
  performance, and stability gaps.
* CRUSH improvements: We have added a new straw2 bucket algorithm
  that reduces the amount of data migration required when changes are
  made to the cluster.
* RADOS cache tiering: A series of changes have been made in the
  cache tiering code that improve performance and reduce latency.
* Experimental RDMA support: There is now experimental support the RDMA
  via the Accelio (libxio) library.
* New administrator commands: The 'ceph osd df' command shows
  pertinent details on OSD disk utilizations.  The 'ceph pg ls ...'
  command makes it much simpler to query PG states while diagnosing
  cluster issues.

Other highlights since Firefly include:

* CephFS: we have fixed a raft of bugs in CephFS and built some
  basic journal recovery and diagnostic tools.  Stability and
  performance of single-MDS systems is vastly improved in Giant.
  Although we do not yet recommend CephFS for production deployments,
  we do encourage testing for non-critical workloads so that we can
  better guage the feature, usability, performance, and stability
  gaps.
* Local Recovery Codes: the OSDs now support an erasure-coding scheme
  that stores some additional data blocks to reduce the IO required to
  recover from single OSD failures.
* Degraded vs misplaced: the Ceph health reports from 'ceph -s' and
  related commands now make a distinction between data that is
  degraded (there are fewer than the desired number of copies) and
  data that is misplaced (stored in the wrong location in the
  cluster).  The distinction is important because the latter does not
  compromise data safety.
* Tiering improvements: we have made several improvements to the
  cache tiering implementation that improve performance.  Most
  notably, objects are not promoted into the cache tier by a single
  read; they must be found to be sufficiently hot before that happens.
* Monitor performance: the monitors now perform writes to the local
  data store asynchronously, improving overall responsiveness.
* Recovery tools: the ceph-objectstore-tool is greatly expanded to
  allow manipulation of an individual OSDs data store for debugging
  and repair purposes.  This is most heavily used by our QA
  infrastructure to exercise recovery code.

I would like to take this opportunity to call out the amazing growth in contributors to Ceph beyond the core development team from Inktank.
Hammer features major new features and improvements from Intel, UnitedStack, Yahoo, UbuntuKylin, CohortFS, Mellanox, CERN, Deutsche Telekom, Mirantis, and SanDisk.

Dedication
----------

This release is dedicated in memoriam to Sandon Van Ness, aka Houkouonchi, who unexpectedly passed away a few weeks ago.  Sandon was responsible for maintaining the large and complex Sepia lab that houses the Ceph project's build and test infrastructure.  His efforts have made an important impact on our ability to reliably test Ceph with a relatively small group of people.  He was a valued member of the team and we will miss him.  H is also for Houkouonchi.

Upgrading
---------

* If your existing cluster is running a version older than v0.80.x
  Firefly, please first upgrade to the latest Firefly release before
  moving on to Giant.  We have not tested upgrades directly from
  Emperor, Dumpling, or older releases.

  We *have* tested:

   * Firefly to Hammer
   * Firefly to Giant to Hammer
   * Dumpling to Firefly to Hammer

* Please upgrade daemons in the following order:

   #. Monitors
   #. OSDs
   #. MDSs and/or radosgw

  Note that the relative ordering of OSDs and monitors should not matter, but
  we primarily tested upgrading monitors first.

* The ceph-osd daemons will perform a disk-format upgrade improve the
  PG metadata layout and to repair a minor bug in the on-disk format.
  It may take a minute or two for this to complete, depending on how
  many objects are stored on the node; do not be alarmed if they do
  not marked "up" by the cluster immediately after starting.

* If upgrading from v0.93, set
   osd enable degraded writes = false

  on all osds prior to upgrading.  The degraded writes feature has
  been reverted due to 11155.

* The LTTNG tracing in librbd and librados is disabled in the release packages
  until we find a way to avoid violating distro security policies when linking
  libust.


For more information
--------------------

  http://ceph.com/docs/master/release-notes/#v0-94-hammer

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.94.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy


_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
