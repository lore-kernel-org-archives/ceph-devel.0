From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Consistency problem with multiple rgws
Date: Wed, 21 Dec 2016 11:48:13 -0500
Message-ID: <a880457a-54a1-e296-a164-94e252841e7f@redhat.com>
References: <2b1658523debcec-00007.Richmail.00098135627749810422@139.com>
 <9193cf3c-3970-56d9-759a-c160626fb27a@redhat.com>
 <CAHjSqib6CQUK0RuBaPBPS75jpG7CzOmOQ3zw+zraDxziqZQcFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:32776 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbcLUQsR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2016 11:48:17 -0500
Received: by mail-qt0-f178.google.com with SMTP id p16so208706648qta.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Dec 2016 08:48:16 -0800 (PST)
In-Reply-To: <CAHjSqib6CQUK0RuBaPBPS75jpG7CzOmOQ3zw+zraDxziqZQcFg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sw zhang <zhangsw1001@gmail.com>
Cc: yehuda <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, =?UTF-8?B?6YOt5Y2g5Lic?= <guozhandong@cmss.chinamobile.com>, lvshuhua <lvshuhua@cmss.chinamobile.com>


On 12/16/2016 02:36 AM, sw zhang wrote:
> Hi,
> I test it again today that each zone has one RGW with config
> 'rgw_num_rados_handles=2'. I use cosbench to  upload 50,000 object ,
> each object is 4M,
> the number of workers is 10.
> After the data sync is finished(I use the command 'radosgw-admin
> bucket sync status --bucket=<name>' and 'radosgw-admin sync status' to
> check that)
> Below is the bucket stats result:
>
> Master zone:
> [root@ceph36 ~]# radosgw-admin bucket stats --bucket=shard23
> {
>      "bucket": "shard23",
>      "pool": "master.rgw.buckets.data",
>      "index_pool": "master.rgw.buckets.index",
>      "id": "cc3594b6-6282-421a-a3d5-3f7f3fa7efd0.702243.1",
>      "marker": "cc3594b6-6282-421a-a3d5-3f7f3fa7efd0.702243.1",
>      "owner": "zsw-test",
>      "ver": "0#50039,1#49964",
>      "master_ver": "0#0,1#0",
>      "mtime": "2016-12-16 10:58:56.174049",
>      "max_marker": "0#00000050038.56144.3,1#00000049963.56109.3",
>      "usage": {
>          "rgw.main": {
>              "size_kb": 195300782,
>              "size_kb_actual": 195388276,
>              "num_objects": 50000
>          }
>      },
>      "bucket_quota": {
>          "enabled": false,
>          "max_size_kb": -1,
>          "max_objects": -1
>      }
> }
>
> Slave zone:
> [root@ceph05 ~]# radosgw-admin bucket stats --bucket=shard23
> {
>      "bucket": "shard23",
>      "pool": "slave.rgw.buckets.data",
>      "index_pool": "slave.rgw.buckets.index",
>      "id": "cc3594b6-6282-421a-a3d5-3f7f3fa7efd0.702243.1",
>      "marker": "cc3594b6-6282-421a-a3d5-3f7f3fa7efd0.702243.1",
>      "owner": "zsw-test",
>      "ver": "0#51172,1#51070",
>      "master_ver": "0#0,1#0",
>      "mtime": "2016-12-16 10:58:56.174049",
>      "max_marker": "0#00000051171.112193.3,1#00000051069.79607.3",
>      "usage": {
>          "rgw.main": {
>              "size_kb": 194769532,
>              "size_kb_actual": 194856788,
>              "num_objects": 49861
>          }
>      },
>      "bucket_quota": {
>          "enabled": false,
>          "max_size_kb": -1,
>          "max_objects": -1
>      }
> }
>
> We can see that in slave zone, object number in bucket stats is less
> than master. But if I use s3cmd to list the bucket in slave zone, the
> result is right:
> [root@ceph05 ~]# s3cmd ls s3://shard23 | wc -l
> 50000
>
> And after I list the bucket with s3cmd, I use the bucket stats in
> slave zone again:
> [root@ceph05 ~]# radosgw-admin bucket stats --bucket=shard23
> {
>      "bucket": "shard23",
>      "pool": "slave.rgw.buckets.data",
>      "index_pool": "slave.rgw.buckets.index",
>      "id": "cc3594b6-6282-421a-a3d5-3f7f3fa7efd0.702243.1",
>      "marker": "cc3594b6-6282-421a-a3d5-3f7f3fa7efd0.702243.1",
>      "owner": "zsw-test",
>      "ver": "0#51182,1#51079",
>      "master_ver": "0#0,1#0",
>      "mtime": "2016-12-16 10:58:56.174049",
>      "max_marker": "0#00000051181.112203.9,1#00000051078.79616.9",
>      "usage": {
>          "rgw.main": {
>              "size_kb": 194769532,
>              "size_kb_actual": 194856788,
>              "num_objects": 50000
>          }
>      },
>      "bucket_quota": {
>          "enabled": false,
>          "max_size_kb": -1,
>          "max_objects": -1
>      }
> }
>
> We can see that the num_objects is right now. (According to the code ,
> list bucket will send the 'dir_suggest_changes' request to the osd. I
> think this is why the number is right now.)
> If each zone have two rgw with config 'rgw_num_rados_handles=1', the
> difference between the bucket stats is smaller, from 10 to 40.
> If each zone have one rgw with config 'rgw_num_rados_handles=1', the
> bucket stats are same.
> My colleague and I have tested that multi times in two different
> clusters(Ceph version is jewel), and this problem nearly occurs every
> time.
>
Thanks for the extra info, I'll look into this. Could you please open a 
ticket at http://tracker.ceph.com/projects/rgw/issues/new and include 
this output?

> 2016-12-16 0:05 GMT+08:00 Casey Bodley <cbodley@redhat.com>:
>> Hi,
>>
>> On 12/15/2016 02:55 AM, 18896724396 wrote:
>>
>> Hi,
>> We have two RGWs in master zone and two RGWs in slave zone. We use cosbench
>> to upload 50,000 objs to a single bucket. After the data sync is finished,
>> the bucket stats is not the same between master and slave zone.
>>
>> The data sync may take a while with that many objects. How are you verifying
>> that data sync finished? Have you tried 'radosgw-admin bucket sync status
>> --bucket=<name>'?
>>
>> Then we test the same case with one RGW in master zone and slave zone, the
>> stats is also not same. At last we test with one RGW and modify the config
>> rgw_num_rados_handles to 1(we set it 2 before), and this time the stats is
>> same and correct. Though multiple RGWs still have the problem.
>> According to the code, I find that when we update bucket index, rgw will
>> call cls_rgw_bucket_complete_op to update the bucket stats and at last osd
>> will call rgw_bucket_complete_op. In this function, osd first read the
>> bucket header, and then update the stats, last it write the head back. So I
>> think two concurrent request to update the stats may lead to the consistency
>> problem. And maybe some other operation also have the same problem. How
>> could we solve the consistency problem?
>>
>> The osd guarantees that two operations in the same placement group won't run
>> concurrently, so this kind of logic in cls should be safe. How far off are
>> the bucket stats? Can you share some example output?
>>
>>
>> Best regards.
>> Zhang Shaowen
>>
>>
>> Thanks,
>> Casey

