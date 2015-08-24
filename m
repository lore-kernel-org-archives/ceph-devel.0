From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Kernel RBD Readahead
Date: Tue, 25 Aug 2015 00:19:17 +0300
Message-ID: <CAOi1vP8V2wknnzS5Rx7reAaQiZk9XHOjRc7o2ZmVQWZyhbCWuQ@mail.gmail.com>
References: <3dc364a7.9Ro.9Gf.13.ic3ciX@mailjet.com>
	<CAOi1vP8Tvcdh8Xy+eJKJdoHWDO2=OmVXqfxH9KzoJQQE645Rww@mail.gmail.com>
	<590a725d.9Ro.9Gf.1M.icIth1@mailjet.com>
	<CAOi1vP9=47yYPpJVwSUnZmoK1jv81s_4TmoaxJ=MxMtQ3-7nXQ@mail.gmail.com>
	<CAOi1vP-zmOCAfWQVS2JknOX7QyKwHy8REeHkpKrAYcUJPwJ8Rw@mail.gmail.com>
	<bd4da65e.9Ro.9Gf.13.idFHtU@mailjet.com>
	<CAOi1vP-5bF6zCCaddvpF-TeMs66CLq6KtOL-_POJ6Ayxi-V6EA@mail.gmail.com>
	<b1744442.9Ro.9Gf.1X.idQDIl@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35242 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbbHXVTT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Aug 2015 17:19:19 -0400
Received: by lbcbn3 with SMTP id bn3so87727589lbc.2
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2015 14:19:17 -0700 (PDT)
In-Reply-To: <b1744442.9Ro.9Gf.1X.idQDIl@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Aug 24, 2015 at 11:11 PM, Nick Fisk <nick@fisk.me.uk> wrote:
>
>
>
>
>> -----Original Message-----
>> From: Ilya Dryomov [mailto:idryomov@gmail.com]
>> Sent: 24 August 2015 18:19
>> To: Nick Fisk <nick@fisk.me.uk>
>> Cc: Ceph Development <ceph-devel@vger.kernel.org>
>> Subject: Re: Kernel RBD Readahead
>>
>> On Mon, Aug 24, 2015 at 7:00 PM, Nick Fisk <nick@fisk.me.uk> wrote:
>> >> -----Original Message-----
>> >> From: Ilya Dryomov [mailto:idryomov@gmail.com]
>> >> Sent: 24 August 2015 16:07
>> >> To: Nick Fisk <nick@fisk.me.uk>
>> >> Cc: Ceph Development <ceph-devel@vger.kernel.org>
>> >> Subject: Re: Kernel RBD Readahead
>> >>
>> >> On Mon, Aug 24, 2015 at 5:43 PM, Ilya Dryomov <idryomov@gmail.com=
>
>> >> wrote:
>> >> > On Sun, Aug 23, 2015 at 10:23 PM, Nick Fisk <nick@fisk.me.uk> w=
rote:
>> >> >>> -----Original Message-----
>> >> >>> From: Ilya Dryomov [mailto:idryomov@gmail.com]
>> >> >>> Sent: 23 August 2015 18:33
>> >> >>> To: Nick Fisk <nick@fisk.me.uk>
>> >> >>> Cc: Ceph Development <ceph-devel@vger.kernel.org>
>> >> >>> Subject: Re: Kernel RBD Readahead
>> >> >>>
>> >> >>> On Sat, Aug 22, 2015 at 11:45 PM, Nick Fisk <nick@fisk.me.uk>=
 wrote:
>> >> >>> > Hi Ilya,
>> >> >>> >
>> >> >>> > I was wondering if I could just get your thoughts on a matt=
er I
>> >> >>> > have run into?
>> >> >>> >
>> >> >>> > Its surrounding read performance of the RBD kernel client a=
nd
>> >> >>> > blk-mq, mainly when doing large single threaded reads. Duri=
ng
>> >> >>> > testing performance seems to be limited to around 40MB/s, w=
hich
>> >> >>> > is probably fairly similar to what you would expect to get =
from
>> >> >>> > a single OSD. This is to be expected as an RBD is just a lo=
ng
>> >> >>> > chain of objects each on a different OSD which is being rea=
d
>> >> >>> > through in order
>> >> one at a time.
>> >> >>> >
>> >> >>> > In theory readahead should make up for this by making the R=
BD
>> >> >>> > client read from several OSD=E2=80=99s ahead of the current=
 required
>> >> >>> > block. However from what I can see it seems that setting a
>> >> >>> > readahead value higher than max_sectors_kb doesn=E2=80=99t =
appear to
>> >> >>> > have any effect, meaning that readahead is limited to each
>> >> >>> > object that is
>> >> currently being read.
>> >> >>> > Would you be able to confirm if this is correct and if this=
 is by
>> design?
>> >> >>>
>> >> >>> [CCing ceph-devel]
>> >> >>>
>> >> >>> Certainly not by design.  rbd is just a block device driver, =
so
>> >> >>> if the kernel submits a readahead read, it will obey and carr=
y it out in
>> full.
>> >> >>> The readahead is driven by the VM in pages, it doesn't care a=
bout
>> >> >>> rbd object boundaries and such.
>> >> >>>
>> >> >>> That said, one problem is in the VM subsystem, where readahea=
ds
>> >> >>> get capped at 512 pages (=3D 2M).  If you do a simple single
>> >> >>> threaded read test, you'll see 4096 sector (=3D 2M) I/Os inst=
ead of
>> object size I/Os:
>> >> >>>
>> >> >>>     $ rbd info foo | grep order
>> >> >>>             order 24 (16384 kB objects)
>> >> >>>     $ blockdev --getra /dev/rbd0
>> >> >>>     32768
>> >> >>>     $ dd if=3D/dev/rbd0 of=3D/dev/null bs=3D32M
>> >> >>>     # avgrq-sz is 4096.00
>> >> >>>
>> >> >>> This was introduced in commit 6d2be915e589 ("mm/readahead.c: =
fix
>> >> >>> readahead failure for memoryless NUMA nodes and limit readahe=
ad
>> >> >>> pages") [1], which went into 3.15.  The hard limit was Linus'
>> >> >>> suggestion,
>> >> apparently.
>> >> >>>
>> >> >>> #define MAX_READAHEAD   ((512*4096)/PAGE_CACHE_SIZE)
>> >> >>> /*
>> >> >>>  * Given a desired number of PAGE_CACHE_SIZE readahead pages,
>> >> return
>> >> >>> a
>> >> >>>  * sensible upper limit.
>> >> >>>  */
>> >> >>> unsigned long max_sane_readahead(unsigned long nr) {
>> >> >>>         return min(nr, MAX_READAHEAD); }
>> >> >>>
>> >> >>> This limit used to be dynamic and depended on the number of f=
ree
>> >> >>> pages in the system.  There has been an attempt to bring that
>> >> >>> behaviour back [2], but it didn't go very far as far as getti=
ng
>> >> >>> into mainline.  It looks like Red Hat and Oracle are shipping=
 [2]
>> >> >>> in some of their kernels though.  If you apply it, you'll see
>> >> >>> 32768 sector (=3D 16M)
>> >> I/Os in the above test, which is how it should be.
>> >> >>>
>> >> >>> [1]
>> >> >>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.g=
it/c
>> >> >>> omm it/?id=3D6d 2be915e589b58cb11418cbe1f22ff90732b6ac
>> >> >>> [2] http://thread.gmane.org/gmane.linux.kernel/1893680
>> >> >>>
>> >> >>> One thing we should be doing is setting read_ahead_kb to obje=
ct
>> >> >>> size, the default 128k doesn't really cut it for rbd.  I'll s=
end
>> >> >>> a patch for
>> >> that.
>> >> >>>
>> >> >>> Thanks,
>> >> >>>
>> >> >>>                 Ilya
>> >> >>
>> >> >>
>> >> >> Thanks for your response.
>> >> >>
>> >> >> I do see the IO's being limited to 4096 sectors in the 4.1 ker=
nel
>> >> >> and so that
>> >> is likely to be partly the cause of the poor performance I am see=
ing.
>> >> However I tried a 3.14 kernel and saw the same level performance,=
 but
>> >> this time the IO's were limited to 1024 sectors. The queue depth =
was
>> >> at around 8 so I guess this means its submitting 8*512kb IO's up =
to
>> >> the max_sectors_kb limit of 4096KB. From the OSD point of view, t=
his
>> >> will still be accessing 1 OSD at a time.
>> >> >>
>> >> >> Maybe I'm expecting the wrong results but I was expecting that
>> >> >> either 1
>> >> of these 2 scenarios would happen.
>> >> >>
>> >> >> 1. Kernel submits a large enough IO to satisfy the readahead
>> >> >> value,
>> >> max_sectors_kb would need to be higher than the object size
>> >> (currently not
>> >> possible) and the RADOS layer would be responsible for doing the
>> >> parallel reads to the OSD's to satisfy it.
>> >> >>
>> >> >> 2. Kernel recognises that the readahead is bigger than the
>> >> max_sectors_kb value and submits several IO's in parallel to the =
RBD
>> >> device to satisfy the readahead request. Ie 32MB readahead would
>> >> submit 8x4MB IO's in parallel.
>> >> >>
>> >> >> Please let me know if I have got the wrong idea here. But in m=
y
>> >> >> head
>> >> either solution should improve sequential reads by a large amount=
,
>> >> with the 2nd possibly slightly better as you are only waiting on =
the
>> >> 1st OSD to respond to complete the request.
>> >> >>
>> >> >> Thanks for including the Ceph-Devel list, unfortunately despit=
e
>> >> >> several
>> >> attempts I have not been able to post to this list after subscrib=
ing,
>> >> please can you forward any correspondence if you think it would b=
e
>> useful to share.
>> >> >
>> >> > Did you remember to set max_sectors_kb to max_hw_sectors_kb?  T=
he
>> >> > block layer in 3.14 leaves max_sectors_kb at 512, even when
>> >> > max_hw_sectors_kb is set to a much bigger value by the driver. =
 If
>> >> > you adjust it, you should be able to see object size requests, =
at
>> >> > least sometimes.  Note that you definitely won't see them all t=
he
>> >> > time due to max_segments limitation, which was lifted only rece=
ntly.
>> >
>> > Yes I made sure I have checked this on all Kernels I have tested.
>> >
>> >>
>> >> I just realized that what I wrote is true for O_DIRECT reads.  Fo=
r
>> >> page cache driven reads, which is what we are discussing, the
>> >> max_segments limitation is killer - 128 pages =3D 512k.  The fix =
was a
>> >> one-liner, but I don't think it was submitted for stable.
>> >
>> > I'm also seeing this, which is probably not helping, but see below=
 :-)
>> >
>> >>
>> >> The other thing is that 3.14.21+ kernels are just as screwed
>> >> readahead wise as 3.15+, as the offending commit was backported. =
 So
>> >> even if I submit the max_segments one-liner to stable and it make=
s it
>> >> to say 3.14.52, we will still get only 4096 sector page cache I/O=
s, just like
>> you got on 4.1.
>> >>
>> >
>> > Yes, this was the problem, apologies I should have checked to see =
if the
>> patch was back ported. I tried an older 3.14 release and I am now se=
eing up
>> to 200MB/s, a massive improvement. Queue depths are hovering around =
the
>> 50 mark which is what I would expect. I suspect with the max_segment=
s fix it
>> would possibly go faster as the requests to the OSD would be larger.
>> >
>> > In that thread you linked, Linus asked for a real work example whe=
re that
>> commit was causing problems, here is one.
>> >
>> > "Using a Ceph RBD as a staging area before trying to stream to tap=
e, which
>> needs to average around 150-200MB/s to be suitable"
>> >
>> > Where do we go from here to try and get the behaviour modified
>> upstream?
>>
>> Can you describe your use case in more detail, in a cut & pasteable =
way?
>
> Sure,
>
> I'm using a Ceph kernel mounted RBD volume as a staging area for the =
Bacula backup software before writing the data to a FC connected LTO6 t=
ape drive. The staging area is required as I cannot source data from th=
e  backup clients fast enough to satisfy the tape drive speed. The Tape=
 drive requires a steady data input stream of around 160MB/s to be able=
 to run smoothly at max speed. Using kernels with the pre-readhead limi=
t I observe read speeds exceeding 200MB/s, after the readahead commit t=
his speed drops to around 40MB/s. Backups are taking 4x as long as expe=
cted and I suspect tape+drive life may be reduced as the drive frequent=
ly buffer underruns and stop/starts.

So, before bringing this up on LKML, I wanted to get some more numbers,
and thought about tests with md raid - it sets a custom (larger) reada
window size to compensate for striping.  It was only after I set it up
that I stumbled upon [1].  This is another attempt at bringing us back,
trigged by md raid performance regression.  The patch gets rid of all
NUMA node stuff altogether and Linus seems to be on board.

One question I have after looking at md is whether rbd should set reada
window size to 1x object size or 2x object size.  I'm inclined towards
the former in order to not over do it, but I'd interested in numbers.
Nick, since you have this beefy setup, can you share your results for
4M and 8M max_readahead_kb, assuming you are using default 4M object
size?

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg959637=
=2Ehtml

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
