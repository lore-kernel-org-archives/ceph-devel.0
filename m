From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/2] rbd: tear down watch request if rbd_dev_device_setup() fails
Date: Mon, 16 Dec 2013 22:05:33 +0200
Message-ID: <1387224335-902-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:36952 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab3LPUGX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 15:06:23 -0500
Received: by mail-ea0-f180.google.com with SMTP id f15so2475506eak.11
        for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 12:06:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Hello,

Currently, if rbd_dev_device_setup() fails, we don't tear down our
watch request.  Looks like this bug was introduced by 1f3ef78861ac,
which moved a tear down call while fixing something else.  Fix it.

These patches can be pulled from wip-rbd-unwatch branch of
ceph-client.git.

Thanks,

                Ilya


Ilya Dryomov (2):
  rbd: introduce rbd_dev_header_unwatch_sync() and switch to it
  rbd: tear down watch request if rbd_dev_device_setup() fails

 drivers/block/rbd.c |   41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

-- 
1.7.10.4

