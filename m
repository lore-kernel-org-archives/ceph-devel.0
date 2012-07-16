From: "Guan Jun He" <gjhe@suse.com>
Subject: kernel hanged when try to remove a rbd device
Date: Mon, 16 Jul 2012 05:43:57 -0600
Message-ID: <50048B1D020000160000EB3E@soto.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soto.provo.novell.com ([137.65.250.214]:33952 "EHLO
	soto.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab2GPLoG convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:2:1>);
	Mon, 16 Jul 2012 07:44:06 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org

Hi,

 kernel hanged when try to remove a rbd device, detail steps are:

    Create a rbd image and map it to client;
then stop ceph cluster through '/etc/init.d/ceph -a stop';

then in client side, run command 'echo id > /sys/bus/rbd/remove',and
this command can not return. Checking dmesg, seems like it enters an
endless loop, try to re-connect osds and mons;

Then press keys 'CTRL + C' to send an INT signal to 
'echo id > /sys/bus/rbd/remove',then kernel hanged.

Can I use rados in this way?


with the following patch, kernel will not hang, but ,this patch is not
good as well, for there is transaction has not been finished, if just
delete it, maybe the data will be inconsistent.

But, seems like there is no way to stop this transaction safely,I mean
cancel this transaction(avoid data inconsistence) and tell it's caller
that this transaction has been failed and has been canceled.
(well,If any one know there is a way/or many ways,please tell
me,thanks).
Also, if there are plans to do these things, I'am very glad to join in
and do some work.

Or, are there any other resolving plans?

thanks a lot for your reply!


Signed-off-by: Guanjun He <heguanbo@gmail.com>
---
 net/ceph/osd_client.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 1ffebed..4dba062 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -688,11 +688,20 @@ static void __remove_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
 
 static void remove_all_osds(struct ceph_osd_client *osdc)
 {
+	struct list_head *pos, *q;
+	struct ceph_osd_request *req;
+
 	dout("__remove_old_osds %p\n", osdc);
 	mutex_lock(&osdc->request_mutex);
 	while (!RB_EMPTY_ROOT(&osdc->osds)) {
 		struct ceph_osd *osd = rb_entry(rb_first(&osdc->osds),
 						struct ceph_osd, o_node);
+		list_for_each_safe(pos, q, &osd->o_requests) {
+			req = list_entry(pos, struct ceph_osd_request,
+							r_osd_item);
+			list_del(pos);
+			__unregister_request(osdc, req);
+			kfree(req);
+		}
 		__remove_osd(osdc, osd);
 	}
 	mutex_unlock(&osdc->request_mutex);

-- 
best,
Guanjun <gjhe@suse.com>

