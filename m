From: Bobby <italienisch1987-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: multiple BLK-MQ queues for Ceph's RADOS Block Device (RBD) and CephFS
Date: Mon, 13 Jul 2020 20:40:40 +0200
Message-ID: <CA+xD70OJhkhH=+5W7M8NM54VPh42FmbD3O0yqKe1p-+=yd9zXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: ceph-users <ceph-users-a8pt6IJUokc@public.gmane.org>, dev <dev-a8pt6IJUokc@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-qa-a8pt6IJUokc@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

I have a question regarding support for multiple BLK-MQ queues for Ceph's
RADOS Block Device (RBD). The below given link says that the driver has
been using the BLK-MQ interface for a while but not actually multiple
queues until now with having a queue per-CPU. A change to not hold onto
caps that aren't actually needed.  These improvements and more can be found
as part of the Ceph changes for Linux 5.7, which should be released as
stable in early June.

https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.7-Ceph-Performance

My question is: Is it possible that through Ceph FS (Filesystem in User
Space) I can develop a multi-queue driver for Ceph? Asking because this way
I can avoid kernel space. (
https://docs.ceph.com/docs/nautilus/start/quick-cephfs/)

Looking forward for some help

BR
Bobby
_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
