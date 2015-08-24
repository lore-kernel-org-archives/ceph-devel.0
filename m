From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Kernel RBD Readahead
Date: Mon, 24 Aug 2015 18:06:58 +0300
Message-ID: <CAOi1vP-zmOCAfWQVS2JknOX7QyKwHy8REeHkpKrAYcUJPwJ8Rw@mail.gmail.com>
References: <3dc364a7.9Ro.9Gf.13.ic3ciX@mailjet.com>
	<CAOi1vP8Tvcdh8Xy+eJKJdoHWDO2=OmVXqfxH9KzoJQQE645Rww@mail.gmail.com>
	<590a725d.9Ro.9Gf.1M.icIth1@mailjet.com>
	<CAOi1vP9=47yYPpJVwSUnZmoK1jv81s_4TmoaxJ=MxMtQ3-7nXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33033 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbbHXPHA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Aug 2015 11:07:00 -0400
Received: by lbbsx3 with SMTP id sx3so81737278lbb.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2015 08:06:58 -0700 (PDT)
In-Reply-To: <CAOi1vP9=47yYPpJVwSUnZmoK1jv81s_4TmoaxJ=MxMtQ3-7nXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Aug 24, 2015 at 5:43 PM, Ilya Dryomov <idryomov@gmail.com> wrot=
e:
> On Sun, Aug 23, 2015 at 10:23 PM, Nick Fisk <nick@fisk.me.uk> wrote:
>>> -----Original Message-----
>>> From: Ilya Dryomov [mailto:idryomov@gmail.com]
>>> Sent: 23 August 2015 18:33
>>> To: Nick Fisk <nick@fisk.me.uk>
>>> Cc: Ceph Development <ceph-devel@vger.kernel.org>
>>> Subject: Re: Kernel RBD Readahead
>>>
>>> On Sat, Aug 22, 2015 at 11:45 PM, Nick Fisk <nick@fisk.me.uk> wrote=
:
>>> > Hi Ilya,
>>> >
>>> > I was wondering if I could just get your thoughts on a matter I h=
ave
>>> > run into?
>>> >
>>> > Its surrounding read performance of the RBD kernel client and blk=
-mq,
>>> > mainly when doing large single threaded reads. During testing
>>> > performance seems to be limited to around 40MB/s, which is probab=
ly
>>> > fairly similar to what you would expect to get from a single OSD.=
 This
>>> > is to be expected as an RBD is just a long chain of objects each =
on a
>>> > different OSD which is being read through in order one at a time.
>>> >
>>> > In theory readahead should make up for this by making the RBD cli=
ent
>>> > read from several OSD=E2=80=99s ahead of the current required blo=
ck. However
>>> > from what I can see it seems that setting a readahead value highe=
r
>>> > than max_sectors_kb doesn=E2=80=99t appear to have any effect, me=
aning that
>>> > readahead is limited to each object that is currently being read.
>>> > Would you be able to confirm if this is correct and if this is by=
 design?
>>>
>>> [CCing ceph-devel]
>>>
>>> Certainly not by design.  rbd is just a block device driver, so if =
the kernel
>>> submits a readahead read, it will obey and carry it out in full.
>>> The readahead is driven by the VM in pages, it doesn't care about r=
bd object
>>> boundaries and such.
>>>
>>> That said, one problem is in the VM subsystem, where readaheads get
>>> capped at 512 pages (=3D 2M).  If you do a simple single threaded r=
ead test,
>>> you'll see 4096 sector (=3D 2M) I/Os instead of object size I/Os:
>>>
>>>     $ rbd info foo | grep order
>>>             order 24 (16384 kB objects)
>>>     $ blockdev --getra /dev/rbd0
>>>     32768
>>>     $ dd if=3D/dev/rbd0 of=3D/dev/null bs=3D32M
>>>     # avgrq-sz is 4096.00
>>>
>>> This was introduced in commit 6d2be915e589 ("mm/readahead.c: fix
>>> readahead failure for memoryless NUMA nodes and limit readahead pag=
es")
>>> [1], which went into 3.15.  The hard limit was Linus' suggestion, a=
pparently.
>>>
>>> #define MAX_READAHEAD   ((512*4096)/PAGE_CACHE_SIZE)
>>> /*
>>>  * Given a desired number of PAGE_CACHE_SIZE readahead pages, retur=
n a
>>>  * sensible upper limit.
>>>  */
>>> unsigned long max_sane_readahead(unsigned long nr) {
>>>         return min(nr, MAX_READAHEAD);
>>> }
>>>
>>> This limit used to be dynamic and depended on the number of free pa=
ges in
>>> the system.  There has been an attempt to bring that behaviour back=
 [2], but
>>> it didn't go very far as far as getting into mainline.  It looks li=
ke Red Hat and
>>> Oracle are shipping [2] in some of their kernels though.  If you ap=
ply it, you'll
>>> see 32768 sector (=3D 16M) I/Os in the above test, which is how it =
should be.
>>>
>>> [1]
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D6d
>>> 2be915e589b58cb11418cbe1f22ff90732b6ac
>>> [2] http://thread.gmane.org/gmane.linux.kernel/1893680
>>>
>>> One thing we should be doing is setting read_ahead_kb to object siz=
e, the
>>> default 128k doesn't really cut it for rbd.  I'll send a patch for =
that.
>>>
>>> Thanks,
>>>
>>>                 Ilya
>>
>>
>> Thanks for your response.
>>
>> I do see the IO's being limited to 4096 sectors in the 4.1 kernel an=
d so that is likely to be partly the cause of the poor performance I am=
 seeing. However I tried a 3.14 kernel and saw the same level performan=
ce, but this time the IO's were limited to 1024 sectors. The queue dept=
h was at around 8 so I guess this means its submitting 8*512kb IO's up =
to the max_sectors_kb limit of 4096KB. From the OSD point of view, this=
 will still be accessing 1 OSD at a time.
>>
>> Maybe I'm expecting the wrong results but I was expecting that eithe=
r 1 of these 2 scenarios would happen.
>>
>> 1. Kernel submits a large enough IO to satisfy the readahead value, =
max_sectors_kb would need to be higher than the object size (currently =
not possible) and the RADOS layer would be responsible for doing the pa=
rallel reads to the OSD's to satisfy it.
>>
>> 2. Kernel recognises that the readahead is bigger than the max_secto=
rs_kb value and submits several IO's in parallel to the RBD device to s=
atisfy the readahead request. Ie 32MB readahead would submit 8x4MB IO's=
 in parallel.
>>
>> Please let me know if I have got the wrong idea here. But in my head=
 either solution should improve sequential reads by a large amount, wit=
h the 2nd possibly slightly better as you are only waiting on the 1st O=
SD to respond to complete the request.
>>
>> Thanks for including the Ceph-Devel list, unfortunately despite seve=
ral attempts I have not been able to post to this list after subscribin=
g, please can you forward any correspondence if you think it would be u=
seful to share.
>
> Did you remember to set max_sectors_kb to max_hw_sectors_kb?  The blo=
ck
> layer in 3.14 leaves max_sectors_kb at 512, even when max_hw_sectors_=
kb
> is set to a much bigger value by the driver.  If you adjust it, you
> should be able to see object size requests, at least sometimes.  Note
> that you definitely won't see them all the time due to max_segments
> limitation, which was lifted only recently.

I just realized that what I wrote is true for O_DIRECT reads.  For page
cache driven reads, which is what we are discussing, the max_segments
limitation is killer - 128 pages =3D 512k.  The fix was a one-liner, bu=
t
I don't think it was submitted for stable.

The other thing is that 3.14.21+ kernels are just as screwed readahead
wise as 3.15+, as the offending commit was backported.  So even if
I submit the max_segments one-liner to stable and it makes it to say
3.14.52, we will still get only 4096 sector page cache I/Os, just like
you got on 4.1.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
