From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Kernel RBD Readahead
Date: Mon, 24 Aug 2015 17:43:51 +0300
Message-ID: <CAOi1vP9=47yYPpJVwSUnZmoK1jv81s_4TmoaxJ=MxMtQ3-7nXQ@mail.gmail.com>
References: <3dc364a7.9Ro.9Gf.13.ic3ciX@mailjet.com>
	<CAOi1vP8Tvcdh8Xy+eJKJdoHWDO2=OmVXqfxH9KzoJQQE645Rww@mail.gmail.com>
	<590a725d.9Ro.9Gf.1M.icIth1@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:36394 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772AbbHXOny convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Aug 2015 10:43:54 -0400
Received: by labia3 with SMTP id ia3so14568181lab.3
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2015 07:43:52 -0700 (PDT)
In-Reply-To: <590a725d.9Ro.9Gf.1M.icIth1@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Aug 23, 2015 at 10:23 PM, Nick Fisk <nick@fisk.me.uk> wrote:
>> -----Original Message-----
>> From: Ilya Dryomov [mailto:idryomov@gmail.com]
>> Sent: 23 August 2015 18:33
>> To: Nick Fisk <nick@fisk.me.uk>
>> Cc: Ceph Development <ceph-devel@vger.kernel.org>
>> Subject: Re: Kernel RBD Readahead
>>
>> On Sat, Aug 22, 2015 at 11:45 PM, Nick Fisk <nick@fisk.me.uk> wrote:
>> > Hi Ilya,
>> >
>> > I was wondering if I could just get your thoughts on a matter I ha=
ve
>> > run into?
>> >
>> > Its surrounding read performance of the RBD kernel client and blk-=
mq,
>> > mainly when doing large single threaded reads. During testing
>> > performance seems to be limited to around 40MB/s, which is probabl=
y
>> > fairly similar to what you would expect to get from a single OSD. =
This
>> > is to be expected as an RBD is just a long chain of objects each o=
n a
>> > different OSD which is being read through in order one at a time.
>> >
>> > In theory readahead should make up for this by making the RBD clie=
nt
>> > read from several OSD=E2=80=99s ahead of the current required bloc=
k. However
>> > from what I can see it seems that setting a readahead value higher
>> > than max_sectors_kb doesn=E2=80=99t appear to have any effect, mea=
ning that
>> > readahead is limited to each object that is currently being read.
>> > Would you be able to confirm if this is correct and if this is by =
design?
>>
>> [CCing ceph-devel]
>>
>> Certainly not by design.  rbd is just a block device driver, so if t=
he kernel
>> submits a readahead read, it will obey and carry it out in full.
>> The readahead is driven by the VM in pages, it doesn't care about rb=
d object
>> boundaries and such.
>>
>> That said, one problem is in the VM subsystem, where readaheads get
>> capped at 512 pages (=3D 2M).  If you do a simple single threaded re=
ad test,
>> you'll see 4096 sector (=3D 2M) I/Os instead of object size I/Os:
>>
>>     $ rbd info foo | grep order
>>             order 24 (16384 kB objects)
>>     $ blockdev --getra /dev/rbd0
>>     32768
>>     $ dd if=3D/dev/rbd0 of=3D/dev/null bs=3D32M
>>     # avgrq-sz is 4096.00
>>
>> This was introduced in commit 6d2be915e589 ("mm/readahead.c: fix
>> readahead failure for memoryless NUMA nodes and limit readahead page=
s")
>> [1], which went into 3.15.  The hard limit was Linus' suggestion, ap=
parently.
>>
>> #define MAX_READAHEAD   ((512*4096)/PAGE_CACHE_SIZE)
>> /*
>>  * Given a desired number of PAGE_CACHE_SIZE readahead pages, return=
 a
>>  * sensible upper limit.
>>  */
>> unsigned long max_sane_readahead(unsigned long nr) {
>>         return min(nr, MAX_READAHEAD);
>> }
>>
>> This limit used to be dynamic and depended on the number of free pag=
es in
>> the system.  There has been an attempt to bring that behaviour back =
[2], but
>> it didn't go very far as far as getting into mainline.  It looks lik=
e Red Hat and
>> Oracle are shipping [2] in some of their kernels though.  If you app=
ly it, you'll
>> see 32768 sector (=3D 16M) I/Os in the above test, which is how it s=
hould be.
>>
>> [1]
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D6d
>> 2be915e589b58cb11418cbe1f22ff90732b6ac
>> [2] http://thread.gmane.org/gmane.linux.kernel/1893680
>>
>> One thing we should be doing is setting read_ahead_kb to object size=
, the
>> default 128k doesn't really cut it for rbd.  I'll send a patch for t=
hat.
>>
>> Thanks,
>>
>>                 Ilya
>
>
> Thanks for your response.
>
> I do see the IO's being limited to 4096 sectors in the 4.1 kernel and=
 so that is likely to be partly the cause of the poor performance I am =
seeing. However I tried a 3.14 kernel and saw the same level performanc=
e, but this time the IO's were limited to 1024 sectors. The queue depth=
 was at around 8 so I guess this means its submitting 8*512kb IO's up t=
o the max_sectors_kb limit of 4096KB. From the OSD point of view, this =
will still be accessing 1 OSD at a time.
>
> Maybe I'm expecting the wrong results but I was expecting that either=
 1 of these 2 scenarios would happen.
>
> 1. Kernel submits a large enough IO to satisfy the readahead value, m=
ax_sectors_kb would need to be higher than the object size (currently n=
ot possible) and the RADOS layer would be responsible for doing the par=
allel reads to the OSD's to satisfy it.
>
> 2. Kernel recognises that the readahead is bigger than the max_sector=
s_kb value and submits several IO's in parallel to the RBD device to sa=
tisfy the readahead request. Ie 32MB readahead would submit 8x4MB IO's =
in parallel.
>
> Please let me know if I have got the wrong idea here. But in my head =
either solution should improve sequential reads by a large amount, with=
 the 2nd possibly slightly better as you are only waiting on the 1st OS=
D to respond to complete the request.
>
> Thanks for including the Ceph-Devel list, unfortunately despite sever=
al attempts I have not been able to post to this list after subscribing=
, please can you forward any correspondence if you think it would be us=
eful to share.

Did you remember to set max_sectors_kb to max_hw_sectors_kb?  The block
layer in 3.14 leaves max_sectors_kb at 512, even when max_hw_sectors_kb
is set to a much bigger value by the driver.  If you adjust it, you
should be able to see object size requests, at least sometimes.  Note
that you definitely won't see them all the time due to max_segments
limitation, which was lifted only recently.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
