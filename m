From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Kernel RBD Readahead
Date: Sun, 23 Aug 2015 20:33:22 +0300
Message-ID: <CAOi1vP8Tvcdh8Xy+eJKJdoHWDO2=OmVXqfxH9KzoJQQE645Rww@mail.gmail.com>
References: <3dc364a7.9Ro.9Gf.13.ic3ciX@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35336 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbbHWRdY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Aug 2015 13:33:24 -0400
Received: by lbcbn3 with SMTP id bn3so67604504lbc.2
        for <ceph-devel@vger.kernel.org>; Sun, 23 Aug 2015 10:33:23 -0700 (PDT)
In-Reply-To: <3dc364a7.9Ro.9Gf.13.ic3ciX@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Aug 22, 2015 at 11:45 PM, Nick Fisk <nick@fisk.me.uk> wrote:
> Hi Ilya,
>
> I was wondering if I could just get your thoughts on a matter I have =
run
> into?
>
> Its surrounding read performance of the RBD kernel client and blk-mq,=
 mainly
> when doing large single threaded reads. During testing performance se=
ems to
> be limited to around 40MB/s, which is probably fairly similar to what=
 you
> would expect to get from a single OSD. This is to be expected as an R=
BD is
> just a long chain of objects each on a different OSD which is being r=
ead
> through in order one at a time.
>
> In theory readahead should make up for this by making the RBD client =
read
> from several OSD=E2=80=99s ahead of the current required block. Howev=
er from what I
> can see it seems that setting a readahead value higher than max_secto=
rs_kb
> doesn=E2=80=99t appear to have any effect, meaning that readahead is =
limited to each
> object that is currently being read. Would you be able to confirm if =
this is
> correct and if this is by design?

[CCing ceph-devel]

Certainly not by design.  rbd is just a block device driver, so if the
kernel submits a readahead read, it will obey and carry it out in full.
The readahead is driven by the VM in pages, it doesn't care about rbd
object boundaries and such.

That said, one problem is in the VM subsystem, where readaheads get
capped at 512 pages (=3D 2M).  If you do a simple single threaded read
test, you'll see 4096 sector (=3D 2M) I/Os instead of object size I/Os:

    $ rbd info foo | grep order
            order 24 (16384 kB objects)
    $ blockdev --getra /dev/rbd0
    32768
    $ dd if=3D/dev/rbd0 of=3D/dev/null bs=3D32M
    # avgrq-sz is 4096.00

This was introduced in commit 6d2be915e589 ("mm/readahead.c: fix
readahead failure for memoryless NUMA nodes and limit readahead pages")
[1], which went into 3.15.  The hard limit was Linus' suggestion,
apparently.

#define MAX_READAHEAD   ((512*4096)/PAGE_CACHE_SIZE)
/*
 * Given a desired number of PAGE_CACHE_SIZE readahead pages, return a
 * sensible upper limit.
 */
unsigned long max_sane_readahead(unsigned long nr)
{
        return min(nr, MAX_READAHEAD);
}

This limit used to be dynamic and depended on the number of free pages
in the system.  There has been an attempt to bring that behaviour back
[2], but it didn't go very far as far as getting into mainline.  It
looks like Red Hat and Oracle are shipping [2] in some of their kernels
though.  If you apply it, you'll see 32768 sector (=3D 16M) I/Os in the
above test, which is how it should be.

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D6d2be915e589b58cb11418cbe1f22ff90732b6ac
[2] http://thread.gmane.org/gmane.linux.kernel/1893680

One thing we should be doing is setting read_ahead_kb to object size,
the default 128k doesn't really cut it for rbd.  I'll send a patch for
that.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
