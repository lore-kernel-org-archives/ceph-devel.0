From: Martin Fick <mogulguy@yahoo.com>
Subject: Re: Replacing DRBD use with RBD
Date: Wed, 5 May 2010 13:59:13 -0700 (PDT)
Message-ID: <290088.71767.qm@web36106.mail.mud.yahoo.com>
References: <hrsibo$29c$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from web36106.mail.mud.yahoo.com ([66.163.179.220]:27337 "HELO
	web36106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758168Ab0EEU7O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 May 2010 16:59:14 -0400
In-Reply-To: <hrsibo$29c$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Alex Elsayed <eternaleye@gmail.com>

--- On Wed, 5/5/10, Alex Elsayed <eternaleye@gmail.com> wrote:

Sorry about the accidental off-list reply, thanks 
for replying on list...
 

> I would recommend benchmarking to have empirical results
> rather than going with my presumptions, 

Or my presumptions, :) agreed.

> but in Ceph the metadata servers cache the metadata and
> the OSDs journal writes, so any writes which fit in the
> journal will be quite fast.

Yes, but the kernel will do that also (albeit differently)
for local file systems even if the block device is remote.

> Also, RBD has no way of knowing what reads/writes are
> 'small' in the RBD block device, because it works by splitting
> the disk image into 4MB chunks and deals with those.

Good point. I assume that is tunable, at least by editing
the rbd driver, no?


> This is an advantage in the container virtualization case
> because you can (say) mount the entire Ceph FS on the 
> host and treat the containers simply run the containers 
> from a very basic LXC or other container config, 
> treating the Ceph filesystem as just another directory 
> tree from the point of view of the container.
> This simplifies your container config, and gives the 
> advantages I named earlier (online resize, etc).

Hmm, while some of those are good advantages (and
some may not be depending on your mindset), I am missing
the main point as the why this is different than with
"real VMs" except for maybe your claim of "not being 
usual" ...

 
> Ceph has POSIX (or as close as possible) semantics,
> matching local filesystems, and provides more features
> than any local FS except BtrFS, which is similarly 
> under heavy development.

Perhaps it has many of the features that you want,
but there are many things that many other FSs can
do (good and bad depending again on your mindset),
that ceph cannot and will likely never be able to
do.  For example, can it be case insensitive such
as a DOS FS?


> RBD is actually a rather recent addition - the first
> mailing list message about it was on March 7th, 2010,
> whereas Ceph has been in development since 2007.

True, I guess I meant that using the OSDs will likely
always be simpler and more stable than using them 
through ceph.

Thanks,

-Martin



      
