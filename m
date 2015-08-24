From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Kernel RBD Readahead
Date: Mon, 24 Aug 2015 20:18:37 +0300
Message-ID: <CAOi1vP-5bF6zCCaddvpF-TeMs66CLq6KtOL-_POJ6Ayxi-V6EA@mail.gmail.com>
References: <3dc364a7.9Ro.9Gf.13.ic3ciX@mailjet.com>
	<CAOi1vP8Tvcdh8Xy+eJKJdoHWDO2=OmVXqfxH9KzoJQQE645Rww@mail.gmail.com>
	<590a725d.9Ro.9Gf.1M.icIth1@mailjet.com>
	<CAOi1vP9=47yYPpJVwSUnZmoK1jv81s_4TmoaxJ=MxMtQ3-7nXQ@mail.gmail.com>
	<CAOi1vP-zmOCAfWQVS2JknOX7QyKwHy8REeHkpKrAYcUJPwJ8Rw@mail.gmail.com>
	<bd4da65e.9Ro.9Gf.13.idFHtU@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36331 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbbHXRSj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Aug 2015 13:18:39 -0400
Received: by lbbpu9 with SMTP id pu9so84238481lbb.3
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2015 10:18:37 -0700 (PDT)
In-Reply-To: <bd4da65e.9Ro.9Gf.13.idFHtU@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Aug 24, 2015 at 7:00 PM, Nick Fisk <nick@fisk.me.uk> wrote:
>> -----Original Message-----
>> From: Ilya Dryomov [mailto:idryomov@gmail.com]
>> Sent: 24 August 2015 16:07
>> To: Nick Fisk <nick@fisk.me.uk>
>> Cc: Ceph Development <ceph-devel@vger.kernel.org>
>> Subject: Re: Kernel RBD Readahead
>>
>> On Mon, Aug 24, 2015 at 5:43 PM, Ilya Dryomov <idryomov@gmail.com>
>> wrote:
>> > On Sun, Aug 23, 2015 at 10:23 PM, Nick Fisk <nick@fisk.me.uk> wrot=
e:
>> >>> -----Original Message-----
>> >>> From: Ilya Dryomov [mailto:idryomov@gmail.com]
>> >>> Sent: 23 August 2015 18:33
>> >>> To: Nick Fisk <nick@fisk.me.uk>
>> >>> Cc: Ceph Development <ceph-devel@vger.kernel.org>
>> >>> Subject: Re: Kernel RBD Readahead
>> >>>
>> >>> On Sat, Aug 22, 2015 at 11:45 PM, Nick Fisk <nick@fisk.me.uk> wr=
ote:
>> >>> > Hi Ilya,
>> >>> >
>> >>> > I was wondering if I could just get your thoughts on a matter =
I
>> >>> > have run into?
>> >>> >
>> >>> > Its surrounding read performance of the RBD kernel client and
>> >>> > blk-mq, mainly when doing large single threaded reads. During
>> >>> > testing performance seems to be limited to around 40MB/s, whic=
h is
>> >>> > probably fairly similar to what you would expect to get from a
>> >>> > single OSD. This is to be expected as an RBD is just a long ch=
ain
>> >>> > of objects each on a different OSD which is being read through=
 in order
>> one at a time.
>> >>> >
>> >>> > In theory readahead should make up for this by making the RBD
>> >>> > client read from several OSD=E2=80=99s ahead of the current re=
quired
>> >>> > block. However from what I can see it seems that setting a
>> >>> > readahead value higher than max_sectors_kb doesn=E2=80=99t app=
ear to have
>> >>> > any effect, meaning that readahead is limited to each object t=
hat is
>> currently being read.
>> >>> > Would you be able to confirm if this is correct and if this is=
 by design?
>> >>>
>> >>> [CCing ceph-devel]
>> >>>
>> >>> Certainly not by design.  rbd is just a block device driver, so =
if
>> >>> the kernel submits a readahead read, it will obey and carry it o=
ut in full.
>> >>> The readahead is driven by the VM in pages, it doesn't care abou=
t
>> >>> rbd object boundaries and such.
>> >>>
>> >>> That said, one problem is in the VM subsystem, where readaheads =
get
>> >>> capped at 512 pages (=3D 2M).  If you do a simple single threade=
d read
>> >>> test, you'll see 4096 sector (=3D 2M) I/Os instead of object siz=
e I/Os:
>> >>>
>> >>>     $ rbd info foo | grep order
>> >>>             order 24 (16384 kB objects)
>> >>>     $ blockdev --getra /dev/rbd0
>> >>>     32768
>> >>>     $ dd if=3D/dev/rbd0 of=3D/dev/null bs=3D32M
>> >>>     # avgrq-sz is 4096.00
>> >>>
>> >>> This was introduced in commit 6d2be915e589 ("mm/readahead.c: fix
>> >>> readahead failure for memoryless NUMA nodes and limit readahead
>> >>> pages") [1], which went into 3.15.  The hard limit was Linus' su=
ggestion,
>> apparently.
>> >>>
>> >>> #define MAX_READAHEAD   ((512*4096)/PAGE_CACHE_SIZE)
>> >>> /*
>> >>>  * Given a desired number of PAGE_CACHE_SIZE readahead pages,
>> return
>> >>> a
>> >>>  * sensible upper limit.
>> >>>  */
>> >>> unsigned long max_sane_readahead(unsigned long nr) {
>> >>>         return min(nr, MAX_READAHEAD); }
>> >>>
>> >>> This limit used to be dynamic and depended on the number of free
>> >>> pages in the system.  There has been an attempt to bring that
>> >>> behaviour back [2], but it didn't go very far as far as getting =
into
>> >>> mainline.  It looks like Red Hat and Oracle are shipping [2] in =
some
>> >>> of their kernels though.  If you apply it, you'll see 32768 sect=
or (=3D 16M)
>> I/Os in the above test, which is how it should be.
>> >>>
>> >>> [1]
>> >>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/=
comm
>> >>> it/?id=3D6d 2be915e589b58cb11418cbe1f22ff90732b6ac
>> >>> [2] http://thread.gmane.org/gmane.linux.kernel/1893680
>> >>>
>> >>> One thing we should be doing is setting read_ahead_kb to object
>> >>> size, the default 128k doesn't really cut it for rbd.  I'll send=
 a patch for
>> that.
>> >>>
>> >>> Thanks,
>> >>>
>> >>>                 Ilya
>> >>
>> >>
>> >> Thanks for your response.
>> >>
>> >> I do see the IO's being limited to 4096 sectors in the 4.1 kernel=
 and so that
>> is likely to be partly the cause of the poor performance I am seeing=
=2E However
>> I tried a 3.14 kernel and saw the same level performance, but this t=
ime the
>> IO's were limited to 1024 sectors. The queue depth was at around 8 s=
o I
>> guess this means its submitting 8*512kb IO's up to the max_sectors_k=
b limit
>> of 4096KB. From the OSD point of view, this will still be accessing =
1 OSD at a
>> time.
>> >>
>> >> Maybe I'm expecting the wrong results but I was expecting that ei=
ther 1
>> of these 2 scenarios would happen.
>> >>
>> >> 1. Kernel submits a large enough IO to satisfy the readahead valu=
e,
>> max_sectors_kb would need to be higher than the object size (current=
ly not
>> possible) and the RADOS layer would be responsible for doing the par=
allel
>> reads to the OSD's to satisfy it.
>> >>
>> >> 2. Kernel recognises that the readahead is bigger than the
>> max_sectors_kb value and submits several IO's in parallel to the RBD=
 device
>> to satisfy the readahead request. Ie 32MB readahead would submit 8x4=
MB
>> IO's in parallel.
>> >>
>> >> Please let me know if I have got the wrong idea here. But in my h=
ead
>> either solution should improve sequential reads by a large amount, w=
ith the
>> 2nd possibly slightly better as you are only waiting on the 1st OSD =
to respond
>> to complete the request.
>> >>
>> >> Thanks for including the Ceph-Devel list, unfortunately despite s=
everal
>> attempts I have not been able to post to this list after subscribing=
, please can
>> you forward any correspondence if you think it would be useful to sh=
are.
>> >
>> > Did you remember to set max_sectors_kb to max_hw_sectors_kb?  The
>> > block layer in 3.14 leaves max_sectors_kb at 512, even when
>> > max_hw_sectors_kb is set to a much bigger value by the driver.  If=
 you
>> > adjust it, you should be able to see object size requests, at leas=
t
>> > sometimes.  Note that you definitely won't see them all the time d=
ue
>> > to max_segments limitation, which was lifted only recently.
>
> Yes I made sure I have checked this on all Kernels I have tested.
>
>>
>> I just realized that what I wrote is true for O_DIRECT reads.  For p=
age cache
>> driven reads, which is what we are discussing, the max_segments limi=
tation
>> is killer - 128 pages =3D 512k.  The fix was a one-liner, but I don'=
t think it was
>> submitted for stable.
>
> I'm also seeing this, which is probably not helping, but see below :-=
)
>
>>
>> The other thing is that 3.14.21+ kernels are just as screwed readahe=
ad wise
>> as 3.15+, as the offending commit was backported.  So even if I subm=
it the
>> max_segments one-liner to stable and it makes it to say 3.14.52, we =
will still
>> get only 4096 sector page cache I/Os, just like you got on 4.1.
>>
>
> Yes, this was the problem, apologies I should have checked to see if =
the patch was back ported. I tried an older 3.14 release and I am now s=
eeing up to 200MB/s, a massive improvement. Queue depths are hovering a=
round the 50 mark which is what I would expect. I suspect with the max_=
segments fix it would possibly go faster as the requests to the OSD wou=
ld be larger.
>
> In that thread you linked, Linus asked for a real work example where =
that commit was causing problems, here is one.
>
> "Using a Ceph RBD as a staging area before trying to stream to tape, =
which needs to average around 150-200MB/s to be suitable"
>
> Where do we go from here to try and get the behaviour modified upstre=
am?

Can you describe your use case in more detail, in a cut & pasteable
way?

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
