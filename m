From: Sage Weil <sage@newdream.net>
Subject: Re: Effects of varying page size on OSD writes
Date: Mon, 4 May 2015 10:29:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505041024080.24939@cobra.newdream.net>
References: <CAPvkgC1psL7xc8V_n+tzHoWdgLviyYw7T3m_Lg5Ej-kaMzYB7w@mail.gmail.com> <CAC6JEv9SrAt-q-Q2mTDGjbiW+WqnUfnEZRJi7HNBcBoU3CgBvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42964 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbbEDR3K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 May 2015 13:29:10 -0400
In-Reply-To: <CAC6JEv9SrAt-q-Q2mTDGjbiW+WqnUfnEZRJi7HNBcBoU3CgBvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Steve Capper <steve.capper@linaro.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sorry, I missed this earlier.

On Mon, 4 May 2015, Gregory Farnum wrote:
> On Fri, May 1, 2015 at 7:54 AM, Steve Capper <steve.capper@linaro.org> wrote:
> > Hello,
> > Whilst testing Ceph 0.94.1 on 64-bit ARM hardware, I noticed that
> > switching the kernel PAGE_SIZE from 4KB to 64KB caused an increase by
> > a factor of ~6 in the total amount of data written to disk (according
> > to blktrace) by the OSD when running the RBD bench-write test (with
> > --io-pattern rand, --io-size=4096, --num-threads=16, --io-total=$((50
> > << 20))).
> >
> > Delving into the source, it is apparent that the FileJournal code uses
> > the current page size for the block size. I was wondering why
> > something like the block device sector size wasn't used instead? Is
> > there a mmap somewhere that I missed, or are fewer larger blocks
> > better for most use cases? (The use case above may be overly
> > contrived?).
> 
> This isn't an area of the kernel I know much about, but doesn't the
> page cache work in memory page size, regardless of what the disk is
> doing? FileJournal/FileStore are definitely trying to be friendly to
> what the page cache is up to.

Yeah, although the actual O_DIRECT requirement is that we align to the 
block size, not necessarily page size.  I'm just so used to them both 
being 4k and didn't realize anyone used other pages sizes in practice.

We could definitely change this, but it's milding involved.  The buffer.h 
helpers like is_n_page_aligned() and so forth should be changed to take an 
alignment argument, and we should pull that from the journal device 
instead of assuming it's the page size...

FWIW, one other 4k assumption currently baked in is that when you do an 
encode a data type to a bufferlist we allocate a page-sized buffer to 
append to.  4k is reasonablish (e.g., smallish and minimally stressful to 
the allocator) but 64k may be less so...

sage
