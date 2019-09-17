From: Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: v14.2.4 Nautilus released
Date: Tue, 17 Sep 2019 16:16:22 +0200
Message-ID: <87ef0fc8jt.fsf@suse.com>
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

This is the fourth release in the Ceph Nautilus stable release series. Its sole
purpose is to fix a regression that found its way into the previous release.

Notable Changes
---------------
The ceph-volume in Nautilus v14.2.3 was found to contain a serious
regression, described in https://tracker.ceph.com/issues/41660, which
prevented deployment tools like ceph-ansible, DeepSea, Rook, etc. from
deploying/removing OSDs.

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-14.2.3.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* Release git sha1: 75f4de193b3ea58512f204623e6c5a16e6c1e1ba

--
Abhishek Lekshmanan
SUSE Software Solutions Germany GmbH
_______________________________________________
Ceph-announce mailing list -- ceph-announce-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-announce-leave-a8pt6IJUokc@public.gmane.org
