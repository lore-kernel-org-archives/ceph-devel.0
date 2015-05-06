From: Steve Capper <steve.capper@linaro.org>
Subject: Re: Effects of varying page size on OSD writes
Date: Wed, 6 May 2015 16:19:01 +0100
Message-ID: <CAPvkgC2=s-z68PPcb+n8sB3hK0S1=ezE2C11Wv=rB-1ybgZpPw@mail.gmail.com>
References: <CAPvkgC1psL7xc8V_n+tzHoWdgLviyYw7T3m_Lg5Ej-kaMzYB7w@mail.gmail.com>
	<CAC6JEv9SrAt-q-Q2mTDGjbiW+WqnUfnEZRJi7HNBcBoU3CgBvg@mail.gmail.com>
	<alpine.DEB.2.00.1505041024080.24939@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33801 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbbEFPTC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 May 2015 11:19:02 -0400
Received: by iedfl3 with SMTP id fl3so18324838ied.1
        for <ceph-devel@vger.kernel.org>; Wed, 06 May 2015 08:19:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1505041024080.24939@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <greg@gregs42.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 4 May 2015 at 18:29, Sage Weil <sage@newdream.net> wrote:
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

Thanks Sage,
I'm coding up/testing a patch for this.

Cheers,
-- 
Steve
