From: Casier David <casierdavid@gmail.com>
Subject: Re: Perfomance CPU and IOPS
Date: Sun, 24 May 2015 17:55:26 +0200
Message-ID: <5561F46E.5000309@gmail.com>
References: <5561B444.6060108@gmail.com> <5561BF64.5080509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35137 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbbEXP4O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 May 2015 11:56:14 -0400
Received: by wgfl8 with SMTP id l8so55325923wgf.2
        for <ceph-devel@vger.kernel.org>; Sun, 24 May 2015 08:56:12 -0700 (PDT)
Received: from [192.168.1.97] (84.197.151.77.rev.sfr.net. [77.151.197.84])
        by mx.google.com with ESMTPSA id gw7sm7691689wib.15.2015.05.24.08.56.11
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2015 08:56:12 -0700 (PDT)
In-Reply-To: <5561BF64.5080509@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


> Which locks do you think could be safely removed?
I'm still trying to learn the code

Why there are as many threads in SimpleMessenger ?

Other way : why not 1 ceph-osd/server and multi drives/ceph-osd (without 
soft RAID 0) ?
Sample :
  - /var/lib/ceph/osd/ceph-server/drive1/current
  - /var/lib/ceph/osd/ceph-server/drive2/current

ceph osd drive set drive1 down
ceph osd drive migrate drive1 drive2
ceph osd drive remove drive1
ceph osd drive set drive2 up

On 24/05/2015 14:09, Mark Nelson wrote:
>
>
> On 05/24/2015 06:21 AM, Casier David wrote:
>> Hello everybody,
>> I have some suggestions to improve the Ceph performance with in case of
>> using Rados Block Device.
>>
>> On FileStore :
>>   - Remove all metadata in HDD and used omap on SSD. This reduce IOPS
>> and increases throughput.
>
> This may matter more now that we've been removing other bottlenecks. 
> In the past when we've tested this with filestore on spinning disks it 
> hasn't made a huge difference.  Having said that Sam recently 
> committed a change that should make it safer to use leveldb/rocksdb on 
> alternate disks:
>
> https://github.com/ceph/ceph/pull/4718
>
>>   - Remove journal, thread "sync_entry", and write directly in
>> queue_transaction.
>>
>> To compensate journal, you could use Cache Tier Ceph.
>
> Cache teiring isn't really a good solution for general Ceph workloads 
> right now.  The overhead of object promotions (4MB be default) into 
> the cache tier is just too heavy when the hot/cold distribution is not 
> highly skewed.
>
> Instead I'd suggest reading up on Sage's newstore project:
>
> http://www.spinics.net/lists/ceph-devel/msg22712.html
> https://wiki.ceph.com/Planning/Blueprints/Infernalis/NewStore_%28new_osd_backend%29 
>
>
> Specifically note that the WAL is used during overwrites but for full 
> object writes we can simply write out the new object using libaio and 
> remove the old one.
>
> Here's our latest performance results vs filestore.  The biggest area 
> we need to improve is large object object partial overwrites on fast 
> devices (ie SSDs):
>
> http://nhm.ceph.com/newstore/8c8c5903_rbd_rados_tests.pdf
>
> We may be able to split objects up into ~512k fragments to help deal 
> with large partial object overwites.  It may also be that we could 
> help the rocksdb folks change the way the WAL works (dedicated portion 
> of the disk like Ceph journals rather than log files that get 
> created/deleted on the disk)
>
>>
>> ceph-osd must be with less Thread and Lock.
>> With 1 OSD for 1 HDD, i think Lock is necessary only for scrub, recovery
>> or other background job.
>> And only one thread with the use of libaio.
>
> Which locks do you think could be safely removed?
>
>>
>> I think Ceph-OSD should be very light.
>> Potentially with direct writing aftergiven the transmitted data to other
>> OSD from map.
>> In this case, a lot of ceph-osd could work on the same server.
>>
>> Actually, i work on the repository https://www.github.com/dcasier/ceph.
>> You could see start works on FileStore.*
>> But potentially not safe.
>
> I'd highly suggest getting feedback from Sam/Sage before going too far 
> down this rabbit hole. :)
>
>>
>> David.
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html

