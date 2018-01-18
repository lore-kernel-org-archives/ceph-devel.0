From: Casey Bodley <cbodley@redhat.com>
Subject: Re: questions about multisite sync qos
Date: Thu, 18 Jan 2018 12:12:24 -0500
Message-ID: <95c1ffdd-f03f-de0f-5561-6756d6a824af@redhat.com>
References: <CAEv+sP4NsCGJFKAx_0e+VmXqNv5ENVPXJT3_BW9Uvz=Mp7JpQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34458 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753975AbeARRM1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jan 2018 12:12:27 -0500
Received: by mail-oi0-f49.google.com with SMTP id a70so16209322oib.1
        for <ceph-devel@vger.kernel.org>; Thu, 18 Jan 2018 09:12:27 -0800 (PST)
In-Reply-To: <CAEv+sP4NsCGJFKAx_0e+VmXqNv5ENVPXJT3_BW9Uvz=Mp7JpQw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tianshan Qu <qutianshan@gmail.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi, (and cc ceph-devel)

On 01/18/2018 12:32 AM, Tianshan Qu wrote:
> Hi:
>
> Do we have any design about control the sync process?
>
> For now we have 128 data log shards, with at most 20 bucket shards
> concurrent and 20 objects each. My considers:
>
> 1.The oldest data maybe lagging, if 20 bucket shards has continuous
> data, it will always do the sync.
> A solution is sync 1k objects each time, and then back into a list
> type waiting queue will simply fix the problem.
>
> 2.We may need a bucket level priority sync, some data maybe hot some
> maybe cold, so the hot one should be first, and maybe a configurable
> policy.
> still with the queue and control the sync objects number with
> different priority, will somehow archive the goal.

The 'datalog notify' feature offers some help to prioritize the hot 
bucket shards. RGWDataNotifier will periodically broadcast a datalog 
notify message to other zones telling them which shards have changed 
recently. Then RGWDataSyncShardCR::incremental_sync() will start sync 
for those shards under /* process out of band updates */. These 
out-of-band updates (along with the error retries) are allowed to exceed 
the 20-shard spawn_window, though we do wait until we're under that 
window again before checking for new notifications.

So you're right that there's still potential for starvation if we get 20 
bucket shards that are continuously busy, and I think it's a good idea 
to add a ~1000 object limit to bucket sync. We could use something 
similar to the error_repo to queue these unfinished buckets for later, 
but there are still some problems we'd have to solve there:

- How to schedule/prioritize between the different datalog sources 
(datalog notify, error_repo, datalog, and unfinished buckets)?
- If this is a queue with a timestamp as the index, can we prevent 
duplicate entries?
- Can we remove a bucket shard from this queue if we processed it 
through another source (like 'datalog notify') already?
- Can we make any guarantees about bounds on its size?

> 3.Another observation is list bucket bilogs will eat all connections
> another side in small cluster, as rocksdb is busy with list, each
> connection will stuck much time. Adjust the config will easy the
> problem, but if we have some global control with cmd can adjust that
> will be better,  and I think RGWDataSyncEnv is a good place to do the
> work.

Are you referring to the frontend threads being saturated with sync 
requests? That is definitely an issue, and it's one thing that we're 
trying to solve with the beast frontend. It also gives us the ability to 
do some qos, which could provide some fairness between sync and normal 
client requests.

Outside of the frontend, there's also more that we could do in multisite 
to share/reuse/throttle these sync connections instead of generating a 
new one for each request.

> Any advice will be appreciated.
> Thank you!

