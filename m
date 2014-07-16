From: Samuel Just <sam.just@inktank.com>
Subject: Re: v0.80.4 Firefly released
Date: Wed, 16 Jul 2014 16:41:32 -0700
Message-ID: <CA+4uBUYTu9LsgfuBvz7_S5QYb3ySwOdfPcvDTK-Ym6usEQ=0-g@mail.gmail.com>
References: <alpine.DEB.2.00.1407151634250.21336@cobra.newdream.net>
	<20140716092226.GA23561@infradead.org>
	<CAPYLRziqpnjHbViaFw2MtXcYKiCDE9wz8qaqiQjAJGDoUbG7cg@mail.gmail.com>
	<20140716223150.GE4453@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:43505 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbaGPXld (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jul 2014 19:41:33 -0400
Received: by mail-qg0-f49.google.com with SMTP id j107so1280370qga.8
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jul 2014 16:41:32 -0700 (PDT)
In-Reply-To: <20140716223150.GE4453@dastard>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Christoph Hellwig <hch@infradead.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, xfs@oss.sgi.com

[Apologies for the repost, attachment was too big]

Sorry for the delay.  I've been trying to put together a simpler
reproducer since no one wants to debug a filesystem based on rbd
symptoms :).  It doesn't appear to be related to using extsize on a
non-empty file. The linked archive below has a reproducer
(xfs_extsize_reproducer.cc), an input op sequence (trimmed-ops.in),
the resulting file and what it should be (test, test.correct), and a
summary (notes.txt).

http://filedump.ceph.com/samuelj/reproducer.tgz

I think this probably is fixed in the commit mentioned above (xfs: Use
preallocation for inodes with extsz hints).

Thanks!
-Sam

On Wed, Jul 16, 2014 at 3:31 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Jul 16, 2014 at 10:26:23AM -0700, Gregory Farnum wrote:
>> On Wed, Jul 16, 2014 at 2:22 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> > On Tue, Jul 15, 2014 at 04:45:59PM -0700, Sage Weil wrote:
>> >> This Firefly point release fixes an potential data corruption problem
>> >> when ceph-osd daemons run on top of XFS and service Firefly librbd
>> >> clients.  A recently added allocation hint that RBD utilizes triggers
>> >> an XFS bug on some kernels (Linux 3.2, and likely others) that leads
>> >> to data corruption and deep-scrub errors (and inconsistent PGs).  This
>> >> release avoids the situation by disabling the allocation hint until we
>> >> can validate which kernels are affected and/or are known to be safe to
>> >> use the hint on.
>> >
>> > I've not really seen an report for that on the XFS list, could it be
>> > that you're running into the issue fixed by
>> >
>> >  "xfs: Use preallocation for inodes with extsz hints"
>> >
>> > (commit aff3a9edb7080f69f07fe76a8bd089b3dfa4cb5d)?
>>
>> Sam reported the issue we're seeing in "consequences of
>> XFS_IOC_FSSETXATTR on non-empty file?",
>
> Assuming you've created an extent size hint with a file with delayed
> allocation on it and no blocks, then that's more than likely the
> same issue. The above commit uses preallocation to allocate
> unwritten extents rather than delayed allocation for files with
> extent size hints because delayed allocation doesn't write zeros
> over ranges in the allocated extents that don't have dirty data over
> them.
>
> Moral of the story: any time you get what appears to be data
> corruption in the underlying data store, you should report it to the
> relevant filesystem list rather than try to work around it....
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
