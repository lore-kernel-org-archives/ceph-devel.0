From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] FileJournal: stop using sync_file_range
Date: Thu, 3 Nov 2011 18:55:33 -0400
Message-ID: <20111103225533.GA8535@infradead.org>
References: <20111103214508.GA19234@infradead.org>
 <CAORUGqCLXcL0L_8_M+RLAXsmB5x5Wnwj7hNsF-wvSix8C=OGaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:59631
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751349Ab1KCWze (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 18:55:34 -0400
Content-Disposition: inline
In-Reply-To: <CAORUGqCLXcL0L_8_M+RLAXsmB5x5Wnwj7hNsF-wvSix8C=OGaA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Nov 03, 2011 at 03:48:15PM -0700, Tommi Virtanen wrote:
> On Thu, Nov 3, 2011 at 14:45, Christoph Hellwig <hch@infradead.org> wrote:
> One clarification here that came up in a conversation: the code quoted
> was explicitly inside if (is_bdev), that is, it is only used when the
> journal was on a raw block device. That should make a lot of the
> metadata & block allocation irrelevant.
> 
> We're still very interested in hearing what are the real world barrier
> / write cache flush guarantees from all the syscalls; the
> documentation doesn't guarantee much, even for fsync.. from fsync(2):
> 
>        If the underlying hard disk has write caching enabled, then the
> data may not really be on
>        permanent storage when fsync() / fdatasync() return.

It should make it to disk, but various filesystems have QOI issues and
never flush a disk cache.  This is different from sync_file_range, which
is implemented entirely inside the VM and has no chance at all to flush
the cache (or filesystem metadata).

Note that a block device might also have metadata for block allocations
to flush - a prominent example is the device mapper thin provisioning
target just merged in Linus' tree that relies on flushes to commit its
metadata.  Another example is any kind of sparse VM image file when
seen from the guest.  In both cases the metadata obviously hides behind
the concept of cache flushes and isn't directly visible.
