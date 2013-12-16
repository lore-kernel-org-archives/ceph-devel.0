From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/7] rbd: implement single-major device number allocation scheme
Date: Mon, 16 Dec 2013 19:16:26 +0200
Message-ID: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:64133 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab3LPRRU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 12:17:20 -0500
Received: by mail-ee0-f43.google.com with SMTP id c13so2366540eek.2
        for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 09:17:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

[ This has already been merged into testing branch of ceph-client.git,
but wasn't posted on any mailing list.  Correcting this oversight now. ]

Hello,

This series adds support for single-major device number allocation
scheme, which is needed to break through the limit of ~230 rbd images
mapped at once.  See individual commit messages for details.

Fixes: http://tracker.ceph.com/issues/5048

Thanks,

                Ilya


Ilya Dryomov (7):
  rbd: rbd_device::dev_id is an int, format it as such
  rbd: tweak "loaded" message and module description
  rbd: refactor rbd_init() a bit
  rbd: switch to ida for rbd id assignments
  rbd: add 'minor' sysfs rbd device attribute
  rbd: wire up is_visible() sysfs callback for rbd bus
  rbd: add support for single-major device number allocation scheme

 Documentation/ABI/testing/sysfs-bus-rbd |   26 ++++
 drivers/block/rbd.c                     |  237 +++++++++++++++++++++----------
 2 files changed, 190 insertions(+), 73 deletions(-)

-- 
1.7.10.4

