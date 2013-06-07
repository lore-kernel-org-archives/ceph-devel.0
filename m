From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH 5/5] rbd: take a little credit
Date: Fri, 07 Jun 2013 10:48:59 -0700
Message-ID: <65662dc2-4726-49b4-b05c-7505a97c68eb@email.android.com>
References: <51A94BC0.4080703@inktank.com> <51A94C71.8020100@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:52052 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756200Ab3FGSPH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jun 2013 14:15:07 -0400
In-Reply-To: <51A94C71.8020100@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com> 

Alex Elder <elder@inktank.com> wrote:
>Add a name to the list of authors.
>
>Signed-off-by: Alex Elder <elder@inktank.com>
>---
> drivers/block/rbd.c |    1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>index 107e1e5..cb88a9a 100644
>--- a/drivers/block/rbd.c
>+++ b/drivers/block/rbd.c
>@@ -5287,6 +5287,7 @@ static void __exit rbd_exit(void)
> module_init(rbd_init);
> module_exit(rbd_exit);
>
>+MODULE_AUTHOR("Alex Elder <elder@inktank.com>");
> MODULE_AUTHOR("Sage Weil <sage@newdream.net>");
> MODULE_AUTHOR("Yehuda Sadeh <yehuda@hq.newdream.net>");
> MODULE_DESCRIPTION("rados block device");


