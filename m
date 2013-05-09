From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Use-after-free error in rbd_add()
Date: Thu, 9 May 2013 16:42:01 -0600
Message-ID: <CAErSpo79gvppE0xb6c1OB65ia6vSO-f8KunH4wrF_EGP2DdD4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:59880 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756685Ab3EIWmW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 May 2013 18:42:22 -0400
Received: by mail-ob0-f176.google.com with SMTP id wc20so3465578obb.7
        for <ceph-devel@vger.kernel.org>; Thu, 09 May 2013 15:42:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

I think b536f69a3a5 "rbd: set up devices only for mapped images"
introduced a use-after-free error in rbd_add():

@@ -4964,9 +4960,12 @@ static ssize_t rbd_add(struct bus_type *bus,
        if (rc < 0)
                goto err_out_rbd_dev;

-       return count;
+       rc = rbd_dev_device_setup(rbd_dev);
+       if (!rc)
+               return count;
+
+       rbd_dev_image_release(rbd_dev);
 err_out_rbd_dev:
-       kfree(rbd_dev->header_name);
        rbd_dev_destroy(rbd_dev);

If rbd_dev_device_setup() returns an error, we call
rbd_dev_image_release(), which ultimately kfrees rbd_dev.  Then we
call rbd_dev_destroy(), which references fields in the already-freed
rbd_dev struct before kfreeing it again.

Found by Coverity (CID 1020653).

Bjorn
