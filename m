From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Bug 19198: Double the memory caused by page alignment
Date: Fri, 30 Jun 2017 16:32:30 +0300
Message-ID: <72854a7f-2441-b940-c10f-b71cb65600d6@mirantis.com>
References: <39ba1efe-0c32-249a-8bea-183a1eab13b2@suse.com>
 <alpine.DEB.2.11.1706291920450.3424@piezo.novalocal>
 <3822b2e0-69b2-1213-ff9e-bb5f576dc43f@suse.com>
 <alpine.DEB.2.11.1706292117250.3424@piezo.novalocal>
 <ff5f4540-a99c-a7ab-db5c-02ee3e289f0d@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34183 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdF3Ncd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jun 2017 09:32:33 -0400
Received: by mail-lf0-f48.google.com with SMTP id l13so70436478lfl.1
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jun 2017 06:32:32 -0700 (PDT)
In-Reply-To: <ff5f4540-a99c-a7ab-db5c-02ee3e289f0d@suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mohamad Gebai <mgebai@suse.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

AFAIR I observed the issue for tcmalloc as well. There is a 
corresponding note in the ticket..


On 30.06.2017 0:32, Mohamad Gebai wrote:
> On 06/29/2017 05:18 PM, Sage Weil wrote:
>> On Thu, 29 Jun 2017, Mohamad Gebai wrote:
>>> Also, preloading libtcmalloc makes this behavior disappear (at least for
>>> this program), which confirms further the hypothesis, since tcmalloc
>>> does larger allocations internally.
>> What do you mean by that last paragraph?  We should be linking against
>> tcmalloc in ceph.  But you see that using tcmalloc avoids the problem in
>> the reproducer?
>>
> Yes, that's exactly it. That's why I'm asking about the pattern usage,
> so I can try to reproduce it in Ceph. I'll try fio as you suggested and
> follow up. If you have any thoughts in the mean time, please let me know.
>
> Mohamad
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

