From: Sage Weil <sweil@redhat.com>
Subject: Re: file journal fadvise
Date: Sun, 30 Nov 2014 19:26:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411301922220.352@cobra.newdream.net>
References: <alpine.DEB.2.00.1411301013490.352@cobra.newdream.net> <CALurOm2tEV=RqN21eFJvfU1zTtJkbz2gHDCk_Ntsy4oz9iwHoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34381 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460AbaLAD0Y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 30 Nov 2014 22:26:24 -0500
In-Reply-To: <CALurOm2tEV=RqN21eFJvfU1zTtJkbz2gHDCk_Ntsy4oz9iwHoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?wu29qMXz?= <majianpeng@gmail.com>
Cc: mnelson@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 1 Dec 2014, ??? wrote:
> Hi sage:
>  For fadvise_random it only change the file readahead. I think it make
> no sense for xfs
> Becasue xfs don't like btrfs, the journal write always on old place(at
> first allocated). We only can make those place contiguous.

I'm thinking of the OSD journal, which can be a regular file.  I guess it 
would probably be an allocator mode, set via a XFS_XFLAG_* flag passed to 
an ioctl, which makes the delayed allocation especially unconcerned with 
keeping blocks contiguous.  It would need to be combined with the discard 
ioctl so that any journal write can be allocated wherever it is most 
convenient (hopefully contiguous to some other write).

sage


> 
> Thanks!
> Jianpeng
> 
> 2014-12-01 2:46 GMT+08:00 Sage Weil <sweil@redhat.com>:
> > Currently, when an OSD journal is stored as a file, we preallocate it as a
> > large contiguous extent.  That means that for every journal write we're
> > seeking back to wherever the journal is.  That possibly not ideal for
> > writes.  For reads it's great, but that's the last thing we care about
> > optimizing (we only read the journal after a failure, which is very rare).
> >
> > I wonder if we would do better if we:
> >
> >  1- trim/discard the old journal contents,
> >  2- posix_fadvise RANDOM
> >
> > I'm not sure what the XFS behavior is in this case, but ideally it seems
> > what we want it to do is write the journal wherever on disk it is most
> > convenient... ideally contiguous with some other write that it is already
> > doing.  If fadvise random doesn't do that, perhaps there is another
> > allocator hint we can give it that will get us that behavior...
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
