From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: recovery scheduling
Date: Thu, 26 Oct 2017 16:15:24 +0200
Message-ID: <CAJ4mKGadG=2mV4t_w-yTdEXT8mxAUGbhBdJCQTcq-NzyEgy9OA@mail.gmail.com>
References: <alpine.DEB.2.11.1710252222360.22592@piezo.us.to> <625e213f-dada-b0c6-86e0-46f69c2a7e18@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:54540 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932255AbdJZOPZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Oct 2017 10:15:25 -0400
Received: by mail-io0-f175.google.com with SMTP id e89so5660212ioi.11
        for <ceph-devel@vger.kernel.org>; Thu, 26 Oct 2017 07:15:25 -0700 (PDT)
In-Reply-To: <625e213f-dada-b0c6-86e0-46f69c2a7e18@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 26, 2017 at 12:40 AM, Josh Durgin <jdurgin@redhat.com> wrote:
> On 10/25/2017 03:26 PM, Sage Weil wrote:
>>
>> As I'm watching the mgr balancer module optimizing the layout on the lab
>> cluster I'm seeing a lot of cases where the recovery scheduling in
>> luminous is broken.  For example,
>>
>>      pgs:     63895/153086292 objects degraded (0.042%)
>>               1439665/153086292 objects misplaced (0.940%)
>>               12166 active+clean
>>               198   active+remapped+backfill_wait
>>               97    active+remapped+backfilling
>>               10    active+undersized+degraded+remapped+backfill_wait
>>               6     active+recovery_wait+degraded
>>               2     active+recovery_wait+degraded+remapped
>>               1     active+undersized+degraded+remapped+backfilling
>>
>> It is "wrong" that any PGs would be in recovery_wait (a high priority
>> log-based recovery activity) when there is a ton of backfill going on.
>> I've fixed this in master with a few rounds of recovery preemption PRs,
>> and shaken out a few other issues in the process, but can't backport it to
>> luminous without burning a feature bit.
>>
>> I just took an inventory and we have 12 bits available, and I just marked
>> 8 more deprecated that we can remove after the O release.
>>
>> So... I think it's worth burning one on this.  Any objections?
>
>
> That seems reasonable. I don't have any further backports needing a
> feature bit in mind currently.

Likewise, this seems like something we need to do; I don't have
anything of my own needing a feature bit to backport. Only thing I can
think of is if we needed something to fix the OSDMap stuff for Kraken,
but I believe that's done and didn't.
-Greg

>
> Josh
