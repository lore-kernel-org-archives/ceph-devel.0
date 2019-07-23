From: Nathan Cutler <ncutler-AlSwsSmVLrQ@public.gmane.org>
Subject: v14.2.2 Nautilus released
Date: Tue, 23 Jul 2019 12:57:18 +0200
Message-ID: <20190723105718.4rajxxcegzptw7y7@wilbur.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org, dev-a8pt6IJUokc@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is the second bug fix release of Ceph Nautilus release series. We
recommend all Nautilus users upgrade to this release. For upgrading from older
releases of ceph, general guidelines for upgrade to nautilus must be followed.

Notable Changes
---------------

* The no{up,down,in,out} related commands have been revamped. There are now 2
  ways to set the no{up,down,in,out} flags: the old 'ceph osd [un]set <flag>'
  command, which sets cluster-wide flags; and the new 'ceph osd [un]set-group
  <flags> <who>' command, which sets flags in batch at the granularity of any
  crush node, or device class.

* radosgw-admin introduces two subcommands that allow the managing of
  expire-stale objects that might be left behind after a bucket reshard in
  earlier versions of RGW. One subcommand lists such objects and the other
  deletes them. Read the troubleshooting section of the dynamic resharding docs
  for details.

* Earlier Nautilus releases (14.2.1 and 14.2.0) have an issue where deploying a
  single new (Nautilus) BlueStore OSD on an upgraded cluster (i.e. one that was
  originally deployed pre-Nautilus) breaks the pool utilization stats reported
  by ceph df. Until all OSDs have been reprovisioned or updated (via
  ceph-bluestore-tool repair), the pool stats will show values that are lower
  than the true value. This is resolved in 14.2.2, such that the cluster only
  switches to using the more accurate per-pool stats after all OSDs are 14.2.2
  (or later), are BlueStore, and (if they were created prior to Nautilus) have
  been updated via the repair function.

* The default value for mon_crush_min_required_version has been changed from
  firefly to hammer, which means the cluster will issue a health warning if
  your CRUSH tunables are older than hammer. There is generally a small (but
  non-zero) amount of data that will move around by making the switch to hammer
  tunables.

  If possible, we recommend that you set the oldest allowed client to hammer or
  later. You can tell what the current oldest allowed client is with:

      ceph osd dump | grep min_compat_client

  If the current value is older than hammer, you can tell whether it is safe to
  make this change by verifying that there are no clients older than hammer
  current connected to the cluster with:

      ceph features

  The newer straw2 CRUSH bucket type was introduced in hammer, and ensuring
  that all clients are hammer or newer allows new features only supported for
  straw2 buckets to be used, including the crush-compat mode for the Balancer.

For a detailed changelog please refer to the official release notes 
entry at the ceph blog: https://ceph.com/releases/v14-2-2-nautilus-released/


Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-14.2.2.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* Release git sha1: 4f8fa0a0024755aae7d95567c63f11d6862d55be
