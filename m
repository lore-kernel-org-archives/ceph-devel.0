From: deanraccoon <deanraccoon@gmail.com>
Subject: [doc] Adding/Removing OSD is not thorough
Date: Fri, 10 Oct 2014 15:15:56 +0800
Message-ID: <CAHz-cgHnNSzsFfURmw9y=TqRx+7=A=sTGii5PP-7puJA9e6ULw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:63916 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbaJJHQS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 03:16:18 -0400
Received: by mail-wg0-f41.google.com with SMTP id b13so3181356wgh.24
        for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 00:16:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear list,

When I tried to add OSD manually,  following the
http://ceph.com/docs/v0.78/rados/operations/add-or-rm-osds/.


It said:

ssh {new-osd-host}
ceph-osd -i {osd-num} --mkfs --mkkey

But It won't create the empty  sysvinit file as ceph-deploy does in centos.

If we do not have sysvinit file or added OSD information to ceph.conf,
/etc/init.d/ceph can not start the OSD.


1.  this solution is very easy.
 change the document a bit, remind the user to create
sysvinit file in /var/lib/ceph/osd/ceph-{osd-num}/ for centos.

Or

2.  add new options in  ceph-osd command(such as ceph-osd -i {osd-num}
--mkfs --mkkey  --mkstart ),

and change the document accordingly.

any ideas?


----

Dongmao Zhang
