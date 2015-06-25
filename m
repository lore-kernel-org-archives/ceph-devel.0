From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/3] rbd: queue_depth map option
Date: Thu, 25 Jun 2015 12:11:17 +0300
Message-ID: <1435223480-35238-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:33965 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbbFYJLj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 05:11:39 -0400
Received: by lagx9 with SMTP id x9so41037255lag.1
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 02:11:38 -0700 (PDT)
Received: from localhost.localdomain ([109.110.66.238])
        by mx.google.com with ESMTPSA id ew11sm7055678lac.31.2015.06.25.02.11.36
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 02:11:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

See 3/3.  I'll patch rbd cli tool once this is in.

Thanks,

                Ilya


Ilya Dryomov (3):
  rbd: terminate rbd_opts_tokens with Opt_err
  rbd: store rbd_options in rbd_device
  rbd: queue_depth map option

 drivers/block/rbd.c | 59 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

-- 
1.9.3

