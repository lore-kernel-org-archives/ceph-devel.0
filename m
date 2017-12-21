From: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Subject: rgw: possibility to put several small S3 objects into single rados
 object
Date: Thu, 21 Dec 2017 19:35:26 +0300
Message-ID: <094c2abd-b861-3fcd-7b5c-176d23beed0c@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:45202 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdLUQfa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Dec 2017 11:35:30 -0500
Received: by mail-lf0-f54.google.com with SMTP id f13so28580687lff.12
        for <ceph-devel@vger.kernel.org>; Thu, 21 Dec 2017 08:35:29 -0800 (PST)
Received: from [172.20.9.184] ([86.57.155.118])
        by smtp.gmail.com with ESMTPSA id g80sm4223749ljf.89.2017.12.21.08.35.27
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2017 08:35:27 -0800 (PST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all.

While rgw bucket index, theoretically, with reasonable latency can 
handle up to 10M objects (100 shards of 100k each),
and rgw user's bucket index can handle, theoretically again, up to 100k 
buckets.

Radosgw can split huge s3 objects into several rados objects.
Can it on the other hand put several small files into one rados object?

Is there any design restrictions that will not allow to implement it?
For example add offset field to index omap record and manage pool of
opened containter objects for parallel small put requests.

Main advantage, as I understand, would be significant decrease of the 
rados re-balancing time in case of large amount of small s3 objects.
And, also, smaller space overhead.

Or, maybe it is possible to store small pieces of data in omap?
As I understand space overhead would be much smaller in this case.
And what about backfilling and remapping for omap?


Thanks

-- 

Best regards,
Aleksei Gutikov
Software Engineer | synesis.ru | Minsk. BY
