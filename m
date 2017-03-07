From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bluestore prefer wal size
Date: Mon, 6 Mar 2017 22:34:32 -0600
Message-ID: <9d62613f-215e-5f8f-52e2-2acea96035d5@redhat.com>
References: <alpine.DEB.2.11.1702011533340.3660@piezo.novalocal>
 <001001d27cbd$cee2a9f0$6ca7fdd0$@fisk.me.uk>
 <bb0bdeb6.AEMAHeJMfMsAAAAAAAAAAFklQUsAADNJBWwAAAAAAACRXwBYklNO@mailjet.com>
 <alpine.DEB.2.11.1702012137240.3654@piezo.novalocal>
 <45ba3843.AEEAHxSt8JAAAAAAAAAAAFklQUsAADNJBWwAAAAAAACRXwBYkldP@mailjet.com>
 <alpine.DEB.2.11.1702012147430.3654@piezo.novalocal>
 <alpine.DEB.2.11.1702012211300.3654@piezo.novalocal>
 <00bb01d27d45$21a48050$64ed80f0$@fisk.me.uk>
 <d0caeb89.AEUAHScduCcAAAAAAAAAAFPDZXcAADNJBWwAAAAAAACRXwBYk0Zd@mailjet.com>
 <c46b5c16-340e-7d9c-b7d9-ad8a21b22b6f@redhat.com>
 <002101d27d99$5e266ad0$1a734070$@fisk.me.uk>
 <5ed3f3b2.ADsAAGRwZ_AAAAAAAAAAAFPDZXcAADNJBWwAAAAAAACRXwBYlFIS@mailjet.com>
 <9e79a955-99d9-4cd7-df27-d18a36921a0d@redhat.com>
 <ba5b6d21.ADsAAGSJJ-oAAAAAAAAAAFJy4NwAADNJBWwAAAAAAACRXwBYlKUc@mailjet.com>
 <alpine.DEB.2.11.1703051956410.24356@piezo.novalocal>
 <a2725b53-1f31-76d3-b8cb-93983bd3bf71@redhat.com>
 <alpine.DEB.2.11.1703061752210.24356@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754148AbdCGEmN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Mar 2017 23:42:13 -0500
In-Reply-To: <alpine.DEB.2.11.1703061752210.24356@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Nick Fisk <nick@fisk.me.uk>, ceph-devel@vger.kernel.org



On 03/06/2017 11:53 AM, Sage Weil wrote:
> On Mon, 6 Mar 2017, Mark Nelson wrote:
>> On 03/06/2017 08:59 AM, Sage Weil wrote:
>>> On Fri, 3 Feb 2017, Nick Fisk wrote:
>>>> Hi Mark,
>>>>
>>>>> -----Original Message-----
>>>>> From: Mark Nelson [mailto:mnelson@redhat.com]
>>>>> Sent: 03 February 2017 15:20
>>>>> To: nick@fisk.me.uk; 'Sage Weil' <sage@newdream.net>
>>>>> Cc: ceph-devel@vger.kernel.org
>>>>> Subject: Re: bluestore prefer wal size
>>>>>
>>>>> Hi Nick,
>>>>>
>>>>> So I'm still catching up to your testing, but last night I ran through a
>>>>> number of tests with a single OSD, a single client, and iodepth=1 fio
>>>>> rbd tests:
>>>>>
>>>>> https://drive.google.com/uc?export=download&id=0B2gTBZrkrnpZWE85OFI3Q2xQZ00
>>>>>
>>>>> I tested HDD, HDD+NVMe, and NVMe configurations looking at filestore,
>>>>> bluestore with 1k and 16k prefer wal sizes.  I believe I'm
>>>>> seeing similar results to what you saw.  On NVMe we are pretty similar
>>>>> likely due to the raw backend throughput the NVMe drives can
>>>>> maintain but on HDD, bluestore is doing quite a bit worse than filestore
>>>>> for this specific use case.  During the bluestore HDD tests, I
>>>>> watched disk access and it appears we are saturating the disk with small
>>>>> writes despite the low client performance.  I'll be digging into
>>>>> this more today but I wanted to send out an update to let you know I
>>>>> believe I've reproduced your results and am looking into it.
>>>>
>>>> Glad to hear that you can reproduce. After debugging that IF statement,
>>>> I think I'm at the point where I am out of my depth. But if there is
>>>> anything I can do, let me know.
>>>
>>> I finally got my dev box HDD sorted out and retested this.  The IOPS were
>>> being halved because bluestore was triggering a rocksdb commit (and the
>>> associated latency) just to retire the WAL record.  I rebased and fixed it
>>> so that the WAL entries are deleted lazily (in the next commit round) and
>>> it's 2x faster than before.  I'm getting ~110 IOPS with rados bench 4k
>>> writes with queue depth 1 (6TB 7200rpm WD black).  That's in the
>>> neighborhood of what I'd expect from a spinner... it's basically seeking
>>> back and forth between two write positions (the rocksdb log and the new
>>> object data where the allocator position is).  We could probably bring
>>> this up a bit by making the WAL work be batched on HDD (build up several
>>> IOs worth and dispatch it all at once to reduce seeks).  That'll take a
>>> bit more work, though.
>
> I've made this change too, and now I get about 400 IOPS out of a straight
> HDD (no SSD).  Much better!  I set up the tunables so that it does the
> batching behavior only for HDD and not for SSD; we may want to revisit
> that decision later.
>
>>> With WAL on an NVMe, I get about ~450 IOPS.
>>>
>>> Want to give it a try?
>>
>> What's the branch?
>
> wip-bluestore-prefer-wal-size

Got a chance to give it a quick shot, but it's consistently stuck 
creating PGs and eventually the monitor marks OSDs down due to no osd or 
PG stats.  I'll give it a try with a single OSD cluster tomorrow.

>
> sage
