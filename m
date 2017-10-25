From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: recovery scheduling
Date: Wed, 25 Oct 2017 15:40:15 -0700
Message-ID: <625e213f-dada-b0c6-86e0-46f69c2a7e18@redhat.com>
References: <alpine.DEB.2.11.1710252222360.22592@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36623 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbdJYWkQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Oct 2017 18:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27EB6A7E3
        for <ceph-devel@vger.kernel.org>; Wed, 25 Oct 2017 22:40:16 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.11.1710252222360.22592@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, gfarnum@redhat.com
Cc: ceph-devel@vger.kernel.org

On 10/25/2017 03:26 PM, Sage Weil wrote:
> As I'm watching the mgr balancer module optimizing the layout on the lab
> cluster I'm seeing a lot of cases where the recovery scheduling in
> luminous is broken.  For example,
> 
>      pgs:     63895/153086292 objects degraded (0.042%)
>               1439665/153086292 objects misplaced (0.940%)
>               12166 active+clean
>               198   active+remapped+backfill_wait
>               97    active+remapped+backfilling
>               10    active+undersized+degraded+remapped+backfill_wait
>               6     active+recovery_wait+degraded
>               2     active+recovery_wait+degraded+remapped
>               1     active+undersized+degraded+remapped+backfilling
> 
> It is "wrong" that any PGs would be in recovery_wait (a high priority
> log-based recovery activity) when there is a ton of backfill going on.
> I've fixed this in master with a few rounds of recovery preemption PRs,
> and shaken out a few other issues in the process, but can't backport it to
> luminous without burning a feature bit.
> 
> I just took an inventory and we have 12 bits available, and I just marked
> 8 more deprecated that we can remove after the O release.
> 
> So... I think it's worth burning one on this.  Any objections?

That seems reasonable. I don't have any further backports needing a
feature bit in mind currently.

Josh
