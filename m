From: Karol Jurak <karol.jurak@gmail.com>
Subject: Journal too small
Date: Thu, 17 May 2012 12:59:55 +0200
Message-ID: <201205171259.55967.karol.jurak@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:61575 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761674Ab2EQLAJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 07:00:09 -0400
Received: by wibhm6 with SMTP id hm6so4282809wib.1
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 04:00:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

During an ongoing recovery in one of my clusters a couple of OSDs 
complained about too small journal. For instance:

2012-05-12 13:31:04.034144 7f491061d700  1 journal check_for_full at 
863363072 : JOURNAL FULL 863363072 >= 1048571903 (max_size 1048576000 
start 863363072)
2012-05-12 13:31:04.034680 7f491061d700  0 journal JOURNAL TOO SMALL: item 
1693745152 > journal 1048571904 (usable)

I was under the impression that the OSDs stopped participating in recovery 
after this event. (ceph -w showed that the number of PGs in state 
active+clean no longer increased.) They resumed recovery after I enlarged 
their journals (stop osd, --flush-journal, --mkjournal, start osd).

How serious is such situation? Do the OSDs know how to handle it 
correctly? Or could this result in some data loss or corruption? After the 
recovery finished (ceph -w showed that all PGs are in active+clean state) 
I noticed that a few rbd images were corrupted.

The cluster runs v0.46. The OSDs use ext4. I'm pretty sure that during the 
recovery no clients were accessing the cluster.

Best regards,
Karol
