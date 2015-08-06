From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: OSD sometimes stuck in init phase
Date: Thu, 6 Aug 2015 20:52:26 +0800
Message-ID: <CACJqLyZOmgnY6OTNWu9Or7ZvLxv8_wUX8ZgUtEd0d8n8s3RHpg@mail.gmail.com>
References: <BA2282FCE1654C43BF189535A964CC9F273279B3@G4W3218.americas.hpqcorp.net>
	<CACJqLyYCf_QBXjxAProirc3RqhYQh8Z7mDamZe7aVKwEozYtpw@mail.gmail.com>
	<BA2282FCE1654C43BF189535A964CC9F27327A40@G4W3218.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33787 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbbHFMw1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 08:52:27 -0400
Received: by pabyb7 with SMTP id yb7so30380364pab.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2015 05:52:26 -0700 (PDT)
In-Reply-To: <BA2282FCE1654C43BF189535A964CC9F27327A40@G4W3218.americas.hpqcorp.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Gurjar, Unmesh" <unmesh.gurjar@hp.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Don't find something strange.

Could you paste your ceph.conf? And restart this osd with
debug_osd=20/20, debug_filestore=20/20 :-)

On Thu, Aug 6, 2015 at 8:09 PM, Gurjar, Unmesh <unmesh.gurjar@hp.com> wrote:
> Thanks for quick response Haomai! Please find the backtrace here [1].
>
> [1] - http://paste.openstack.org/show/411139/
>
> Regards,
> Unmesh G.
> IRC: unmeshg
>
>> -----Original Message-----
>> From: Haomai Wang [mailto:haomaiwang@gmail.com]
>> Sent: Thursday, August 06, 2015 5:31 PM
>> To: Gurjar, Unmesh
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: OSD sometimes stuck in init phase
>>
>> Could you print your all thread callback via "thread apply all bt"?
>>
>> On Thu, Aug 6, 2015 at 7:52 PM, Gurjar, Unmesh <unmesh.gurjar@hp.com>
>> wrote:
>> > Hi,
>> >
>> > On a Ceph Firefly cluster (version [1]), OSDs are configured to use separate
>> data and journal disks (using the ceph-disk utility). It is observed, that few OSDs
>> start-up fine (are 'up' and 'in' state); however, others are stuck in the 'init
>> creating/touching snapmapper object' phase. Below is a OSD start-up log
>> snippet:
>> >
>> > 2015-08-06 08:58:02.491537 7fd312df97c0  1 journal _open
>> > /var/lib/ceph/osd/ceph-0/journal fd 21: 1073741824 bytes, block size
>> > 4096 bytes, directio = 1, aio = 1
>> > 2015-08-06 08:58:02.498447 7fd312df97c0  1 journal _open
>> > /var/lib/ceph/osd/ceph-0/journal fd 21: 1073741824 bytes, block size
>> > 4096 bytes, directio = 1, aio = 1
>> > 2015-08-06 08:58:02.498720 7fd312df97c0  2 osd.0 0 boot
>> > 2015-08-06 08:58:02.498865 7fd312df97c0 10 osd.0 0 read_superblock
>> > sb(2645bbf6-16d0-4c42-8835-8ba9f5c95a1d osd.0
>> > a821146f-0742-4724-b4ca-39ea4ccc298d e0 [0,0] lci=[0,0])
>> > 2015-08-06 08:58:02.498937 7fd312df97c0 10 osd.0 0 init
>> > creating/touching snapmapper object
>> >
>> > The log statement is inaccurate though, since it is actually doing init
>> operation for the 'infos' object (as can be observed from source [2]).
>> >
>> > Upon debugging further, the thread seems to be waiting to acquire the
>> 'ObjectStore::apply_transaction::my_lock' mutex. Below is the debug trace:
>> >
>> > (gdb) where
>> > #0  0x00007fd3122b708f in pthread_cond_wait@@GLIBC_2.3.2 () from
>> > /lib/x86_64-linux-gnu/libpthread.so.0
>> > #1  0x00007fd313132bf4 in
>> > ObjectStore::apply_transactions(ObjectStore::Sequencer*,
>> > std::list<ObjectStore::Transaction*,
>> > std::allocator<ObjectStore::Transaction*> >&, Context*) ()
>> > #2  0x00007fd313097d08 in
>> > ObjectStore::apply_transaction(ObjectStore::Transaction&, Context*) ()
>> > #3  0x00007fd313076790 in OSD::init() ()
>> > #4  0x00007fd3130233a7 in main ()
>> >
>> > In a few cases, upon restarting the stuck OSD (service), it successfully
>> completes the 'init' phase and reaches the 'up' and 'in' state!
>> >
>> > Any help is greatly appreciated. Please let me know if any more details are
>> required for root causing.
>> >
>> > [1] - 0.80.7 (6c0127fcb58008793d3c8b62d925bc91963672a3)
>> > [2] -  https://github.com/ceph/ceph/blob/firefly/src/osd/OSD.cc#L1211
>> >
>> > Regards,
>> > Unmesh G.
>> > IRC: unmeshg
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> > in the body of a message to majordomo@vger.kernel.org More majordomo
>> > info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat



-- 
Best Regards,

Wheat
