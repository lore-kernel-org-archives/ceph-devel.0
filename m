From: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Subject: Tuning radosgw for constant uniform high load.
Date: Fri, 26 May 2017 14:18:45 +0300
Message-ID: <59054d80-97de-328d-8e94-5048b7cf9776@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35174 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967424AbdEZLSt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 26 May 2017 07:18:49 -0400
Received: by mail-lf0-f65.google.com with SMTP id 99so739009lfu.2
        for <ceph-devel@vger.kernel.org>; Fri, 26 May 2017 04:18:48 -0700 (PDT)
Received: from [172.20.8.234] ([86.57.155.118])
        by smtp.gmail.com with ESMTPSA id d188sm118714lfg.69.2017.05.26.04.18.45
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 May 2017 04:18:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,


We are designing ceph+rgw setup for constant uniform high load.

We prefer higher throughput than lower latency so seems that we do not 
need asynchronous features, especially garbage collection.

Currently we observing issue that after amount of time rgw's gc becoming 
very very slow (removing 1 rados object per second for example)

on one rgw, than on another and so forth,

but while s3 delete operations proceeding completes fast clients 
continue creating and removing objects,

then pool quotas starting overflowing.

Partially this issue can be eliminated by running 10-th of additional 
'radosgw-admin gc process',

but we assume that is workaround but not common approach.


Profiling on our load model that RGWGC::process() take about 30%-40% of CPU,

and while seems that CPU consuming level is ok, in real time it took 
much more.

For example deleting buckets with radosgw-admin with --bypass-gc option 
and without --inconsistent-index option

takes 3 times less real time than deleting all objects via s3 and wait 
while gc finish his work

(with rgw_gc_processor_period value much less than total time of deletion).



I've used code from rgw_remove_bucket_bypass_gc() in RGWDeleteObj::execute()

instead of calling RGWRados::Object::Delete::delete_obj()

and measured time consumed by RGWDeleteObj::execute() + RGWGC::process()

on the same tasks and without gc consumed time is 3 times lower.

At first look seems that bucket index stay consistent without gc.



So, while I'm not yet completely understand operations required to 
perform to delete object my questions:

1) rgw_remove_bucket_bypass_gc() is called from radosgw-admin.

    Is it safe to call it from rgw itself?

2) rgw_remove_bucket_bypass_gc() uses librados::IoCtx::aio_operate(), 
while RGWGC::process() uses librados::IoCtx::operate().

    So maybe making gc multithread can speed-up it, is there any 
constraints that prevents make gc multithreaded?





Thanks in advance,
Aleksei Gutikov
