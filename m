From: Patrick Hahn <skorgu@gmail.com>
Subject: Re: cephfs survey results
Date: Tue, 4 Nov 2014 13:16:34 -0500
Message-ID: <CAJWqenD1MScdG6U+6rT2nLViSFpxinuzj5oBpTv3rugKoHqmaw@mail.gmail.com>
References: <alpine.DEB.2.00.1411030649070.15135@cobra.newdream.net> <CA+z5DszyU+vDYWnLmvecZ9P6U=9uWOB28Eg7E7=vLtuUQz8Q4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:49442 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbaKDSQ4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 13:16:56 -0500
Received: by mail-la0-f47.google.com with SMTP id gd6so1371709lab.6
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 10:16:54 -0800 (PST)
In-Reply-To: <CA+z5DszyU+vDYWnLmvecZ9P6U=9uWOB28Eg7E7=vLtuUQz8Q4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-users@ceph.com

On Mon, Nov 3, 2014 at 6:36 PM, Blair Bethwaite
<blair.bethwaite@gmail.com> wrote:
> On 4 November 2014 01:50, Sage Weil <sage@newdream.net> wrote:
>> In the Ceph session at the OpenStack summit someone asked what the CephFS
>> survey results looked like.
>
> Thanks Sage, that was me!
>
>>  Here's the link:
>>
>>         https://www.surveymonkey.com/results/SM-L5JV7WXL/
>>
>> In short, people want
>>
>> fsck
>> multimds
>> snapshots
>> quotas
>
> TBH I'm a bit surprised by a couple of these and hope maybe you guys
> will apply a certain amount of filtering on this...
>
> fsck and quotas were there for me, but multimds and snapshots are what
> I'd consider "icing" features - they're nice to have but not on the
> critical path to using cephfs instead of e.g. nfs in a production
> setting. I'd have thought stuff like small file performance and
> gateway support was much more relevant to uptake and
> positive/pain-free UX. Interested to hear others rationale here.

For the use case we're looking at cephfs for at $dayjob we really need
snapshots. I think anyone building a cheap-and-deep cluster for
archival storage would like to be more than one errant rm -rf away
from a *very* long weekend.

Thanks,
-- 
Patrick Hahn
