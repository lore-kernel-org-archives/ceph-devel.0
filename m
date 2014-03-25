From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 12:43:57 -0500
Message-ID: <5331C05D.1060008@ieee.org>
References: <1395736765.2823.29.camel@localhost>		 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>		 <53316D18.7040103@ieee.org>		 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>		 <53317BC2.9010700@ieee.org>		 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>	 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>	 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:51813 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005AbaCYRni (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 13:43:38 -0400
Received: by mail-ve0-f170.google.com with SMTP id pa12so985617veb.1
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 10:43:38 -0700 (PDT)
In-Reply-To: <1395767705.9967.5.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

Please try applying this, on top of the previous patch.
If you can then reproduce the problem we'll have a bunch
of new information about the particular request that's
leading to the failure.  That might tell us what more we
can do to find the root cause.  Thank you.

					-Alex

PS  I hope my mailer doesn't botch the long lines.  It might.

---
 drivers/block/rbd.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2132,7 +2132,30 @@ static void rbd_img_obj_callback(struct
 	spin_lock_irq(&img_request->completion_lock);
 	if (which > img_request->next_completion)
 		goto out;
-	rbd_assert(which == img_request->next_completion);
+	if (which != img_request->next_completion) {
+		printk("%s: bad image object request information:\n", __func__);
+		printk("obj_request %p\n", obj_request);
+		printk("    ->object_name <%s>\n", obj_request->object_name);
+		printk("    ->offset %llu\n", obj_request->offset);
+		printk("    ->length %llu\n", obj_request->length);
+		printk("    ->type 0x%x\n", (u32)obj_request->type);
+		printk("    ->flags 0x%lx\n", obj_request->flags);
+		printk("    ->which %u\n", obj_request->which);
+		printk("    ->xferred %llu\n", obj_request->xferred);
+		printk("    ->result %d\n", obj_request->result);
+
+		printk("img_request %p\n", img_request);
+		printk("    ->snap 0x%016llx\n", img_request->snap_id);
+		printk("    ->offset %llu\n", img_request->offset);
+		printk("    ->length %llu\n", img_request->length);
+		printk("    ->flags 0x%lx\n", img_request->flags);
+		printk("    ->obj_request_count %u\n",
+			img_request->obj_request_count);
+		printk("    ->next_completion %u\n",
+			img_request->next_completion);
+		printk("    ->xferred %llu\n", img_request->xferred);
+		printk("    ->result %d\n", img_request->result);
+	}

 	for_each_obj_request_from(img_request, obj_request) {
 		rbd_assert(more);
