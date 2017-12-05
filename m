From: Sage Weil <sweil@redhat.com>
Subject: Re: osd: fine-grained statistics for object space usage
Date: Tue, 5 Dec 2017 21:37:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712052136150.14468@piezo.novalocal>
References: <201711300849388246138@zte.com.cn> <alpine.DEB.2.11.1711300304240.8333@piezo.novalocal> <CAJ4mKGb8uFJ738YU9BKT3S3h7ePhVFbLkz+KyEQn+e2S8BbArQ@mail.gmail.com> <alpine.DEB.2.11.1711302125440.12766@piezo.novalocal> <d277e426-90a4-593b-fdbd-8ba19919de43@suse.de>
 <alpine.DEB.2.11.1712011427180.2819@piezo.novalocal> <bebb571e-2eab-48f3-0ea6-bb3470074a47@suse.de> <alpine.DEB.2.11.1712041424370.22619@piezo.novalocal> <CAJ4mKGa3RxHMrEWrZeMsYpMxYiVqiyrrFHO9_pGJJJ4kK970dw@mail.gmail.com> <72707128-ae25-2881-fd43-e8cd2b607d4e@suse.de>
 <CAJ4mKGYC5bbNhGG=AFPzV2MUxpoD-4xEAMK4=Q0sCCJu0uY0Xw@mail.gmail.com> <alpine.DEB.2.11.1712052123570.22619@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751421AbdLEViB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 5 Dec 2017 16:38:01 -0500
In-Reply-To: <alpine.DEB.2.11.1712052123570.22619@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Igor Fedotov <ifedotov@suse.de>, ceph-devel <ceph-devel@vger.kernel.org>, Xie Xingguo <xie.xingguo@zte.com.cn>

On Tue, 5 Dec 2017, Sage Weil wrote:
> Can we figure out what problem the complex approach solves that the simple 
> approach doesn't?  I think the values are something like:
> 
>                           master     pool-proposal    2pc-pg-update
>  per-object sparseness      x             ?                ?
>  per-pg sparseness                                         x
>  per-pool sparseness                      x                x
> 
> I put ? because for a single object we can just query the backend with 
> a stat equivalent (like the fiemap ObjectStore method).  This is what, 
> say, rbd or cephfs would need to get a st_blocks value.
> 
> For a 'ceph df' column, the pool summation is what you need--not a pg 
> value.
> 
> Is there another user of this information I'm missing?
> 
> AFAICS the only real benefit to the 2pc complexity is a value that remains 
> perfectly accurate during backfill etc, whereas the pool-level summation 
> will drift slightly in that case.  Doesn't seem worth it to me?

I should add though that I'm not sure how well the pool-level stats will 
work out.  I think for BlueStore it means a new key, one per pool, with a 
summing merge operator.  We already do this for the overall store stats; 
this will either supplement that (2 small keys) or replace it (we can add 
the pool values up to get the overall value) so that there ar ethe same 
number of updates but they're spread over per-pool keys?

sage

