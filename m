From: Casey Bodley <cbodley@redhat.com>
Subject: Re: the program of cross region replication base on rgw multisite
Date: Mon, 31 Jul 2017 16:46:37 -0400
Message-ID: <64eab016-5288-74be-6725-423c558a3584@redhat.com>
References: <2A5F56AE-EE95-47FC-A999-C8ECCBBDF432@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34279 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbdGaUql (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jul 2017 16:46:41 -0400
Received: by mail-qk0-f182.google.com with SMTP id u139so93112341qka.1
        for <ceph-devel@vger.kernel.org>; Mon, 31 Jul 2017 13:46:41 -0700 (PDT)
In-Reply-To: <2A5F56AE-EE95-47FC-A999-C8ECCBBDF432@gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yiming xie <platoxym@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I'd love to see support for CRR, and it sounds like you're off to a good 
start! Comments inline below:

On 07/31/2017 04:09 AM, yiming xie wrote:
> Hi cbodley:
>
>  I want to implement cross region replication(CRR) base on rgw 
> multisite fremework，
> but I saw the PR (bucket sync enable/disable)：
> https://github.com/ceph/ceph/pull/15801
> https://github.com/ceph/ceph/pull/10995
>
> This program implements the start and stop of bucket sync in a 
> zonegroup by starting/stopping bilog
> I think there is a confic between 'bucket sync enable/disable' and 'CRR'‘
>
> If the bucket sync status is disable, the bucket can't be replicated 
> to the other zonggroup.because this bucket
> have no bilog update.

You're right that 'bucket sync disable' would prevent cross-zonegroup 
replication because it turns off the bi logging. I think we'd want to 
keep that feature as it is though, so admins can explicitly make buckets 
'private' and stop paying the cost of bi logging.

For its interaction with CRR, I think it's okay for a 'disabled' bucket 
to return an error like 400 Bad Request to the Put Bucket Replication 
operation [1]. Similarly, if a bucket is already configured for CRR, the 
'bucket sync disable' command should not allow you to disable bi logging.

> My idea is the bucket has two synchronization states: one is sync in a 
> zonegroup， the other is cross-region

I have a feeling that most users would want the ability to do both, 
right? Have all buckets continue to sync within the zonegroup, and allow 
specially-configured buckets to sync to a different zonegroup. Can you 
think of a compelling reason to enable CRR, but still disable sync 
within the zonegroup?

> When the user sets the sync status of the bucket, the record bilog is 
> not changed. Only in sync module this layer, to determine its state, 
> if state is disable, then directly return to 0, if state is enable, 
> then excute the replication logic.
>
> I think this idea is simple, and there is no conflict between 
> intra-area replication and cross-regional replication.
>
> Do you think this program can be accepted by the community?
> Or do you think there is a better program to implement crr?
>
> Expect your reply, thank you!

I don't think that a sync module is the right away to tackle this 
project. That would require a) setting up an extra zone in each 
zonegroup to run that sync module, b) observing -all- sync activity and 
filtering based on the bucket's replication configuration, and c) 
exporting objects to their target zonegroup. The gateway in that zone 
would end up doing a lot of extra work, especially if only a few of its 
buckets were set up for CRR.

Instead, I would look at adding a new kind of 'data changes log' (or 
datalog), which is how each zone tells other zones which buckets have 
changed. For example, if zone B is syncing from zone A in the same 
zonegroup, zone B will read zone A's datalog. For each bucket entry in 
that log, it will read that bucket's bi log from zone A to decide which 
objects it needs to fetch.

For CRR-enabled buckets, we could write their changes to a separate 
datalog that is specific to the zonegroup it is replicating to. Each 
zonegroup would then read this log from each other zonegroup, and only 
see entries for the buckets that are configured to replicate there. That 
means you could reuse most of the existing logic to read and process the 
datalog (RGWDataSyncShardCR in rgw_data_sync.cc) to sync these buckets.

Consider a three-zonegroup configuration with a primary zonegroup zg1, 
and secondary zonegroups zg2 and zg3. For normal buckets, zg1 would 
write changes to its local datalog. For buckets configured with CRR to 
zg2, it would write changes both to its local datalog (so other local 
zones could sync), in addition to its 'datalog-for-zg2'.

So when zg2 runs sync, it also reads from the datalog-for-zg2 on zg1, 
and only sees the buckets that are replicating to zg2. Similarly, zg3 
would read from a different datalog-for-zg3 on zg1, which only contains 
the buckets that are replicating to zg3.

Does that make sense?

Casey

[1] 
http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTreplication.html
