From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: rocksdb optimization regression (bluestore perf regression)
Date: Thu, 3 Nov 2016 19:01:55 +0300
Message-ID: <25965474-3493-53f7-26f8-6d0686abe8f1@mirantis.com>
References: <ea832d2a-96f4-7334-9d34-40d21740df6f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34741 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756871AbcKCQB7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2016 12:01:59 -0400
Received: by mail-qk0-f179.google.com with SMTP id q130so62900338qke.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2016 09:01:58 -0700 (PDT)
In-Reply-To: <ea832d2a-96f4-7334-9d34-40d21740df6f@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Mark,

thanks for update.

I've Just made a brief try.

Performance is much better now but numbers I can see with my old branch 
are still unreachable.

Approx х2 times slower ( it was ~10х slower before) for random 4K r/w 
using FIO against standalone bluestore instance.


Thanks,

Igor


On 03.11.2016 17:59, Mark Nelson wrote:
> Mostly this is for Igor and Somnath:
>
> It looks like the regression was indeed caused by lack of O2 
> optimization for rocksdb in master after 418bfd7.  The following PR 
> appears to resolve the performance regression in my tests:
>
> https://github.com/ceph/ceph/pull/11767
>
> Mark
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

