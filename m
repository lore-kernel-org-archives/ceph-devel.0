From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: rbd resize option
Date: Wed, 11 May 2016 12:08:56 +0530
Message-ID: <CANA9Uk7jeNXg6ykZZSPDG09zd9GmRkShrqfxEiEZ4K-pD_k33w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36365 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbcEKGi5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 02:38:57 -0400
Received: by mail-vk0-f49.google.com with SMTP id s184so45098204vkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2016 23:38:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@ceph.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hello,
I wanted to resize an image using 'rbd' resize option, but it should
be have data loss.
For ex: I have image with 100 GB size (thin provisioned). and this
image has data of 10GB only. Here I wanted to resize this image to
11GB, so that 10GB data is safe and its resized.

Can I do the above resize safely.?

If I tried to resize to 5GB, is rbd throughs an error saying that your
data is going loss, something like that???

Any inputs here are appriciated.

Thanks
Swami
