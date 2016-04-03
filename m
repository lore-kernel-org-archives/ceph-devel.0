From: Haomai Wang <haomaiwang@gmail.com>
Subject: BlueStore IOContext Isolation
Date: Mon, 4 Apr 2016 02:48:10 +0800
Message-ID: <CACJqLyYoTxih4sBdDRO3SXdQHZZUzrC+opbw-5ii6DguVG1JdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34594 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcDCSsL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Apr 2016 14:48:11 -0400
Received: by mail-vk0-f50.google.com with SMTP id e185so156167415vkb.1
        for <ceph-devel@vger.kernel.org>; Sun, 03 Apr 2016 11:48:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi sage,

I have a few questions regards to bluestore want to confirm from
design view, I mean some cases is true for current kerneldevice impl,
but it doesn't required by BlueStore(upper layer):

1. Two IOContext need to share data for buffer ops? and what about
read_buffered. like:

IOContext a, b;
bdev->aio_write(a, 0, 100, true)
bdev->read(b, 0, 100, true)
bdev->read_buffered(0, 100)

b could read data from another "a" which haven't call bdev->flush().
or this overlap case is guard by BlueStore already?

2. Is it possible exists single IOContext overlap ops? like:

IOContext a;
bdev->aio_write(a, 0, 100, true)
bdev->read(a, 0, 50, true)

OR
IOContext a;
bdev->aio_write(a, 0, 100, false)
bdev->read(a, 0, 50, false)

read op need to aware of the inflight write ops from the same
IOContext? or bluestore will prevent this?




-- 
Best Regards,

Wheat
