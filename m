From: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Subject: Small objects in erasure-coded pool
Date: Mon, 20 Nov 2017 19:19:24 +0300
Message-ID: <01518dce-fc15-0def-958a-c916564effd6@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36311 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdKTQT2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Nov 2017 11:19:28 -0500
Received: by mail-lf0-f42.google.com with SMTP id k66so10765501lfg.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Nov 2017 08:19:28 -0800 (PST)
Received: from [172.20.9.184] ([86.57.155.118])
        by smtp.gmail.com with ESMTPSA id f10sm2627428ljf.3.2017.11.20.08.19.26
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 08:19:26 -0800 (PST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello,

We tried to store large amount of small objects (about 5KB, at least 
bigger than 4k and smaller than 8k) in rgw that utilize ec pool 
xxx.rgw.buckets.data on ssds.

osd_pool_erasure_code_stripe_unit=4096
And we expected that data+xattrs will occupy for each object in that 
case max 12k. Maybe some fragmentation occurs, but we did not delete 
anything.

Actually we faced space occupied by each object (from "MAX AVAIL" field 
from ceph df) is about 64k.
Is that expected?
What configuration option (maybe in bluestore) can improve this, 
bluestore_min_alloc_size_ssd?

-- 

Best regards,
Aleksei Gutikov
Software Engineer | synesis.ru | Minsk. BY
