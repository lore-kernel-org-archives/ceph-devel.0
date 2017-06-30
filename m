From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Bug 19198: Double the memory caused by page alignment
Date: Fri, 30 Jun 2017 17:55:26 +0300
Message-ID: <e248a9c3-052a-cd77-1c77-cb0ec3e812ee@mirantis.com>
References: <39ba1efe-0c32-249a-8bea-183a1eab13b2@suse.com>
 <alpine.DEB.2.11.1706291920450.3424@piezo.novalocal>
 <3822b2e0-69b2-1213-ff9e-bb5f576dc43f@suse.com>
 <alpine.DEB.2.11.1706292117250.3424@piezo.novalocal>
 <ff5f4540-a99c-a7ab-db5c-02ee3e289f0d@suse.com>
 <72854a7f-2441-b940-c10f-b71cb65600d6@mirantis.com>
 <214435da-9714-7929-00a0-3e9235c6d833@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36164 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdF3Oz3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jun 2017 10:55:29 -0400
Received: by mail-lf0-f54.google.com with SMTP id h22so71737483lfk.3
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jun 2017 07:55:28 -0700 (PDT)
In-Reply-To: <214435da-9714-7929-00a0-3e9235c6d833@suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mohamad Gebai <mgebai@suse.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Mohamad,

I'm in the process of moving my workplace at the moment.

Will double-check when completed.


But AFAIR the scenario was pretty trivial - build Ceph with ALLOCATOR 
configured to tcmalloc and run an UT with the diff from the ticket.


Thanks,

Igor


On 30.06.2017 16:41, Mohamad Gebai wrote:
> Hi Igor,
>
> On 06/30/2017 09:32 AM, Igor Fedotov wrote:
>> AFAIR I observed the issue for tcmalloc as well. There is a
>> corresponding note in the ticket..
> Yes I did see the note, but I wasn't able to reproduce the issue with
> Ceph so I couldn't confirm the status with regard to tcmalloc + Ceph.
> I'm about to try the workload that Sage suggested. If you have some
> instructions on how to reproduce the problem, it would be great!
>
> Mohamad
>

