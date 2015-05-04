From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Effects of varying page size on OSD writes
Date: Mon, 4 May 2015 17:12:33 -0400
Message-ID: <CANP1eJFxcL_Ea0y8ocSs=yJaZ9Yh6t3WovfXHAoy8kqUCe+sJQ@mail.gmail.com>
References: <CAPvkgC1psL7xc8V_n+tzHoWdgLviyYw7T3m_Lg5Ej-kaMzYB7w@mail.gmail.com>
	<CAC6JEv9SrAt-q-Q2mTDGjbiW+WqnUfnEZRJi7HNBcBoU3CgBvg@mail.gmail.com>
	<alpine.DEB.2.00.1505041024080.24939@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36415 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbbEDVMf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 May 2015 17:12:35 -0400
Received: by lbbqq2 with SMTP id qq2so114238781lbb.3
        for <ceph-devel@vger.kernel.org>; Mon, 04 May 2015 14:12:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1505041024080.24939@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <greg@gregs42.com>, Steve Capper <steve.capper@linaro.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, May 4, 2015 at 1:29 PM, Sage Weil <sage@newdream.net> wrote:
> Sorry, I missed this earlier.
>
> On Mon, 4 May 2015, Gregory Farnum wrote:
>> On Fri, May 1, 2015 at 7:54 AM, Steve Capper <steve.capper@linaro.org> wrote:
>> > Hello,
>> > Whilst testing Ceph 0.94.1 on 64-bit ARM hardware, I noticed that
>> > switching the kernel PAGE_SIZE from 4KB to 64KB caused an increase by
>> > a factor of ~6 in the total amount of data written to disk (according
>> > to blktrace) by the OSD when running the RBD bench-write test (with
>> > --io-pattern rand, --io-size=4096, --num-threads=16, --io-total=$((50
>> > << 20))).
>> >
>> > Delving into the source, it is apparent that the FileJournal code uses
>> > the current page size for the block size. I was wondering why
>> > something like the block device sector size wasn't used instead? Is
>> > there a mmap somewhere that I missed, or are fewer larger blocks
>> > better for most use cases? (The use case above may be overly
>> > contrived?).

I believe this (64k) is also the case on most common PPC64 systems. I
only bring this up because I saw this recent commit:
https://github.com/ceph/ceph/commit/da7f6835b15370ce0120a64f7ac3359f3ba4729b

>>
>> This isn't an area of the kernel I know much about, but doesn't the
>> page cache work in memory page size, regardless of what the disk is
>> doing? FileJournal/FileStore are definitely trying to be friendly to
>> what the page cache is up to.
>
> Yeah, although the actual O_DIRECT requirement is that we align to the
> block size, not necessarily page size.  I'm just so used to them both
> being 4k and didn't realize anyone used other pages sizes in practice.
>
> We could definitely change this, but it's milding involved.  The buffer.h
> helpers like is_n_page_aligned() and so forth should be changed to take an
> alignment argument, and we should pull that from the journal device
> instead of assuming it's the page size...
>
> FWIW, one other 4k assumption currently baked in is that when you do an
> encode a data type to a bufferlist we allocate a page-sized buffer to
> append to.  4k is reasonablish (e.g., smallish and minimally stressful to
> the allocator) but 64k may be less so...
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
