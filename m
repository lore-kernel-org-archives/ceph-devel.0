From: juncheng bai <baijuncheng@unitedstack.com>
Subject: [RFD] how to save the status of object for the cloned image
Date: Wed, 17 Jun 2015 17:36:07 +0800
Message-ID: <55813F87.7010106@unitedstack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpbgbr1.qq.com ([54.207.19.206]:59250 "EHLO smtpbgbr1.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbbFQJgP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jun 2015 05:36:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi.

For cloned image, it is stateless about the object. when the write
offset is smaller than the parent_ovelap,it need to call
rbd_img_obj_exists_submit to check the object status every time.

I want to save the status of the object which it is within the scope
of parent_overlap.

The rbd client io unit is object, so i design that use idr to save
the status. The id of object is equal to write_offset >> obj_order.
In the idr, said object already exists. And the idr can provide a
quick query.

In this way, don't need the server do anything, but need query again
when remap.

Looking forward to your opinion.

Cheers.
----
juncheng bai



