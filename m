From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Problem with "rados cppool"
Date: Tue, 25 Sep 2012 08:20:36 -0700
Message-ID: <CAC-hyiEJRXZMVJAGCOj-GGT=400jNb0mWQRKo8_1k2JScWDRNQ@mail.gmail.com>
References: <CAMQoE_002d1m2gqPTaeH_DV+GGmJHTPmXZ-Sz4V-9u5RUaYZ3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53177 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756653Ab2IYPUh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 11:20:37 -0400
Received: by eaac11 with SMTP id c11so2319653eaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Sep 2012 08:20:36 -0700 (PDT)
In-Reply-To: <CAMQoE_002d1m2gqPTaeH_DV+GGmJHTPmXZ-Sz4V-9u5RUaYZ3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guilhem LETTRON <guilhem.lettron@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Sep 25, 2012 at 6:24 AM, Guilhem LETTRON
<guilhem.lettron@gmail.com> wrote:
> Hi,
>
> I use ceph in production with radosgw.
> I just see a configuration problem with my radosgw pool, the number of
> pgs is really too low.
>
> To correct, I want to copy all my data to a new pool with "rados
> cppool" and switch between the old and the new pool.
>
> The problem : when I try to copy, I have an error where rados can't
> find find a file
>
> # rados cppool ys-streaming ys-streaming-new
> ys-streaming:12_91923020c45da5e68e93657ff93674a31d22b498.eot =>
> ys-streaming-new:12_91923020c45da5e68e93657ff93674a31d22b498.eot
> [...]
> ys-streaming:18__shadow_8d9bfdc60d1e5b57bddce191da38e8d30cc25c90.png._IoNls-xb2dyaQ9uzHaE6IRzWpaWg1zx(@18_8d9bfdc60d1e5b57bddce191da38e8d30cc25c90.png)
> => ys-streaming-new:18__shadow_8d9bfdc60d1e5b57bddce191da38e8d30cc25c90.png._IoNls-xb2dyaQ9uzHaE6IRzWpaWg1zx(@18_8d9bfdc60d1e5b57bddce191da38e8d30cc25c90.png)
> error copying object: No such file or directory
> error copying pool ys-streaming => ys-streaming-new: No such file or directory
>
> Here is the full log : https://gist.github.com/cc27ae5a8c2d178501bc
>
> What can I do to fix it ? (or to increase the number of PGs)
>
Not sure what's happening here, --debug-ms=1 might help shedding some
light on the issue . In any case, currently you cannot just copy the
rgw data pool, so even if you succeeded in doing that you'd end up
with a problematic pool (bucket index won't work correctly). One
solution is to use 'radosgw-admin pool add' on the new pool and 'pool
rm' on the old pool.
That will make it so that new buckets will get the new pool for data placement.
For actually being able to migrate the pools, there's an opened issue
#2366, which I think we have a relatively trivial fix, so I'll put it
on the queue for 0.54.

Yehuda
