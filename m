From: Sage Weil <sweil@redhat.com>
Subject: Re: file journal fadvise
Date: Mon, 1 Dec 2014 11:23:35 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412011122020.3471@cobra.newdream.net>
References: <alpine.DEB.2.00.1411301013490.352@cobra.newdream.net> <CALurOm2tEV=RqN21eFJvfU1zTtJkbz2gHDCk_Ntsy4oz9iwHoA@mail.gmail.com> <alpine.DEB.2.00.1411301922220.352@cobra.newdream.net> <547CBEFA.3000204@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48419 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310AbaLATXk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 1 Dec 2014 14:23:40 -0500
In-Reply-To: <547CBEFA.3000204@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mnelson@redhat.com
Cc: =?GB2312?B?wu29qMXz?= <majianpeng@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 1 Dec 2014, Mark Nelson wrote:
> On 11/30/2014 09:26 PM, Sage Weil wrote:
> > On Mon, 1 Dec 2014, ??? wrote:
> > > Hi sage:
> > >   For fadvise_random it only change the file readahead. I think it make
> > > no sense for xfs
> > > Becasue xfs don't like btrfs, the journal write always on old place(at
> > > first allocated). We only can make those place contiguous.
> > 
> > I'm thinking of the OSD journal, which can be a regular file.  I guess it
> > would probably be an allocator mode, set via a XFS_XFLAG_* flag passed to
> > an ioctl, which makes the delayed allocation especially unconcerned with
> > keeping blocks contiguous.  It would need to be combined with the discard
> > ioctl so that any journal write can be allocated wherever it is most
> > convenient (hopefully contiguous to some other write).
> > 
> > sage
> 
> Hi Sage,
> 
> Could you quick write down the steps you are thinking we'd take to implement
> this?  I'm concerned about the amount of overhead this could cause but I want
> to make sure I'm thinking about it correctly. Especially when trim happens and
> what you think/expect to happens at the FS and device levels.

1- set journal_discard = true
2- add journal_preallocate = true config option, set it to false, and make 
the fallocate(2) call on journal create conditional on that.
3- test with defaults (discard = false, preallocate = true) and 
compare it to discard = true + preallocate = false (with file journal).
4- possibly add a call to set extsize to something small on the journal 
file.  Or give xfs some other appropriate hint, if one exists.

sage

> 
> Mark
> 
> > 
> > 
> > > 
> > > Thanks!
> > > Jianpeng
> > > 
> > > 2014-12-01 2:46 GMT+08:00 Sage Weil <sweil@redhat.com>:
> > > > Currently, when an OSD journal is stored as a file, we preallocate it as
> > > > a
> > > > large contiguous extent.  That means that for every journal write we're
> > > > seeking back to wherever the journal is.  That possibly not ideal for
> > > > writes.  For reads it's great, but that's the last thing we care about
> > > > optimizing (we only read the journal after a failure, which is very
> > > > rare).
> > > > 
> > > > I wonder if we would do better if we:
> > > > 
> > > >   1- trim/discard the old journal contents,
> > > >   2- posix_fadvise RANDOM
> > > > 
> > > > I'm not sure what the XFS behavior is in this case, but ideally it seems
> > > > what we want it to do is write the journal wherever on disk it is most
> > > > convenient... ideally contiguous with some other write that it is
> > > > already
> > > > doing.  If fadvise random doesn't do that, perhaps there is another
> > > > allocator hint we can give it that will get us that behavior...
> > > > 
> > > > sage
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
