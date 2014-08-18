From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.84 released
Date: Mon, 18 Aug 2014 12:14:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408181213200.6987@cobra.newdream.net>
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

The next Ceph development release is here!  This release contains several 
meaty items, including some MDS improvements for journaling, the ability 
to remove the CephFS file system (and name it), several mon cleanups with 
tiered pools, several OSD performance branches, a new "read forward" RADOS 
caching mode, a prototype Kinetic OSD backend, and various radosgw 
improvements (especially with the new standalone civetweb frontend).  And 
there are a zillion OSD bug fixes. Things are looking pretty good for the 
Giant release that is coming up in the next month.

Upgrading
---------

* The *_kb perf counters on the monitor have been removed.  These are
  replaced with a new set of *_bytes counters (e.g., cluster_osd_kb is
  replaced by cluster_osd_bytes).

* The rd_kb and wr_kb fields in the JSON dumps for pool stats (accessed via
  the 'ceph df detail -f json-pretty' and related commands) have been replaced
  with corresponding *_bytes fields.  Similarly, the 'total_space', 'total_used',
  and 'total_avail' fields are replaced with 'total_bytes', 
  'total_used_bytes', and 'total_avail_bytes' fields.

* The 'rados df --format=json' output 'read_bytes' and 'write_bytes'
  fields were incorrectly reporting ops; this is now fixed.

* The 'rados df --format=json' output previously included 'read_kb' and
  'write_kb' fields; these have been removed.  Please use 'read_bytes' and
  'write_bytes' instead (and divide by 1024 if appropriate).

Notable Changes
---------------

* ceph-conf: flush log on exit (Sage Weil)
* ceph-dencoder: refactor build a bit to limit dependencies (Sage Weil, 
  Dan Mick)
* ceph.spec: split out ceph-common package, other fixes (Sandon Van Ness)
* ceph_test_librbd_fsx: fix RNG, make deterministic (Ilya Dryomov)
* cephtool: refactor and improve CLI tests (Joao Eduardo Luis)
* client: improved MDS session dumps (John Spray)
* common: fix dup log messages (#9080, Sage Weil)
* crush: include new tunables in dump (Sage Weil)
* crush: only require rule features if the rule is used (#8963, Sage Weil)
* crushtool: send output to stdout, not stderr (Wido den Hollander)
* fix i386 builds (Sage Weil)
* fix struct vs class inconsistencies (Thorsten Behrens)
* hadoop: update hadoop tests for Hadoop 2.0 (Haumin Chen)
* librbd, ceph-fuse: reduce cache flush overhead (Haomai Wang)
* librbd: fix error path when opening image (#8912, Josh Durgin)
* mds: add file system name, enabled flag (John Spray)
* mds: boot refactor, cleanup (John Spray)
* mds: fix journal conversion with standby-replay (John Spray)
* mds: separate inode recovery queue (John Spray)
* mds: session ls, evict commands (John Spray)
* mds: submit log events in async thread (Yan, Zheng)
* mds: use client-provided timestamp for user-visible file metadata (Yan, 
  Zheng)
* mds: validate journal header on load and save (John Spray)
* misc build fixes for OS X (John Spray)
* misc integer size cleanups (Kevin Cox)
* mon: add get-quota commands (Joao Eduardo Luis)
* mon: do not create file system by default (John Spray)
* mon: fix 'ceph df' output for available space (Xiaoxi Chen)
* mon: fix bug when no auth keys are present (#8851, Joao Eduardo Luis)
* mon: fix compat version for MForward (Joao Eduardo Luis)
* mon: restrict some pool properties to tiered pools (Joao Eduardo Luis)
* msgr: misc locking fixes for fast dispatch (#8891, Sage Weil)
* osd: add 'dump_reservations' admin socket command (Sage Weil)
* osd: add READFORWARD caching mode (Luis Pabon)
* osd: add header cache for KeyValueStore (Haomai Wang)
* osd: add prototype KineticStore based on Seagate Kinetic (Josh Durgin)
* osd: allow map cache size to be adjusted at runtime (Sage Weil)
* osd: avoid refcounting overhead by passing a few things by ref (Somnath 
  Roy)
* osd: avoid sharing PG info that is not durable (Samuel Just)
* osd: clear slow request latency info on osd up/down (Sage Weil)
* osd: fix PG object listing/ordering bug (Guang Yang)
* osd: fix PG stat errors with tiering (#9082, Sage Weil)
* osd: fix bug with long object names and rename (#8701, Sage Weil)
* osd: fix cache full -> not full requeueing (#8931, Sage Weil)
* osd: fix gating of messages from old OSD instances (Greg Farnum)
* osd: fix memstore bugs with collection_move_rename, lock ordering (Sage 
  Weil)
* osd: improve locking for KeyValueStore (Haomai Wang)
* osd: make tiering behave if hit_sets aren't enabled (Sage Weil)
* osd: mark pools with incomplete clones (Sage Weil)
* osd: misc locking fixes for fast dispatch (Samuel Just, Ma Jianpeng)
* osd: prevent old rados clients from using tiered pools (#8714, Sage 
  Weil)
* osd: reduce OpTracker overhead (Somnath Roy)
* osd: set configurable hard limits on object and xattr names (Sage Weil, 
  Haomai Wang)
* osd: trim old EC objects quickly; verify on scrub (Samuel Just)
* osd: work around GCC 4.8 bug in journal code (Matt Benjamin)
* rados bench: fix arg order (Kevin Dalley)
* rados: fix {read,write}_ops values for df output (Sage Weil)
* rbd: add rbdmap pre- and post post- hooks, fix misc bugs (Dmitry 
  Smirnov)
* rbd: improve option default behavior (Josh Durgin)
* rgw: automatically align writes to EC pool (#8442, Yehuda Sadeh)
* rgw: fix crash on swift CORS preflight request (#8586, Yehuda Sadeh)
* rgw: fix memory leaks (Andrey Kuznetsov)
* rgw: fix multipart upload (#8846, Silvain Munaut, Yehuda Sadeh)
* rgw: improve -h (Abhishek Lekshmanan)
* rgw: improve delimited listing of bucket, misc fixes (Yehuda Sadeh)
* rgw: misc civetweb fixes (Yehuda Sadeh)
* rgw: powerdns backend for global namespaces (Wido den Hollander)
* systemd: initial systemd config files (Federico Simoncelli)

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.84.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
