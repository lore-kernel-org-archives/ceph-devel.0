From: Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: v14.2.3 Nautilus released
Date: Wed, 04 Sep 2019 15:45:54 +0200
Message-ID: <87v9u8dvjh.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-announce-bounces-a8pt6IJUokc@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-announce-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-announce-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-announce-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-announce-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-announce-leave-a8pt6IJUokc@public.gmane.org>
To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, dev-a8pt6IJUokc@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


This is the third bug fix release of Ceph Nautilus release series. This
release fixes a security issue. We recommend all Nautilus users upgrade
to this release. For upgrading from older releases of ceph, general
guidelines for upgrade to nautilus must be followed

Notable Changes
---------------
* CVE-2019-10222 - Fixed a denial of service vulnerability where an
  unauthenticated client of Ceph Object Gateway could trigger a crash from an
  uncaught exception
* Nautilus-based librbd clients can now open images on Jewel clusters.
* The RGW `num_rados_handles` has been removed. If you were using a value of
  `num_rados_handles` greater than 1, multiply your current
  `objecter_inflight_ops` and `objecter_inflight_op_bytes` parameters by the
  old `num_rados_handles` to get the same throttle behavior.
* The secure mode of Messenger v2 protocol is no longer experimental with this
  release. This mode is now the preferred mode of connection for monitors.
* "osd_deep_scrub_large_omap_object_key_threshold" has been lowered to detect an
  object with large number of omap keys more easily.

For a detailed changelog please refer to the official release notes 
entry at the ceph blog: https://ceph.io/releases/v14-2-3-nautilus-released/

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-14.2.3.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* Release git sha1: 0f776cf838a1ae3130b2b73dc26be9c95c6ccc39

-- 
Abhishek Lekshmanan
SUSE Software Solutions Germany GmbH
_______________________________________________
Ceph-announce mailing list -- ceph-announce-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-announce-leave-a8pt6IJUokc@public.gmane.org
