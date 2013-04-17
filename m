From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: change how "safe" callback is used
Date: Wed, 17 Apr 2013 10:41:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304171033280.30041@cobra.newdream.net>
References: <516C28DA.5000702@inktank.com> <alpine.DEB.2.00.1304162018590.23771@cobra.newdream.net> <516EA486.8040704@inktank.com> <alpine.DEB.2.00.1304170830480.28750@cobra.newdream.net> <516EDBC7.6080008@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35214 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965148Ab3DQRlA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 13:41:00 -0400
In-Reply-To: <516EDBC7.6080008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zheng.z.yan@intel.com>

On Wed, 17 Apr 2013, Alex Elder wrote:
> On 04/17/2013 10:35 AM, Sage Weil wrote:
> >>> > > This might not get called if we initially map to no osd... and later, if 
> >>> > > the request gets kicked, it isn't called then.
> >> > 
> >> > You're right, we need to hook into the place a request gets
> >> > actually sent for the first time.  That may require a small
> >> > rearrangement of code to make that point accessible.
> > I think this is slightly misinterpreting the purpose of the 'unsafe' list.  
> > That list is used for fsync(fd) so that we wait for any pending requests.  
> > That is really writes from the perspective of the syscall/user/vfs, not 
> > the backend writes to the osd.  If we have a write that is not sent yet 
> > because the osd is down and fsync that fd, we still want to wait until 
> > some osd comes online and the write actually happens.  The 'unsafe' start 
> > is when ceph_sync_write() is called... not the when the request is sent 
> > to the backend.
> 
> I'd argue that the notion of a request being unsafe is an osd
> request concept--more general than just this one file system
> case.  It is useful to know that we've issued something that
> might change osd state, and then to know the state change is
> durable.  That aligns well with what is needed here:  you want
> to wait until you know the write request is durable (even if
> you don't care whether the request has been sent or not).
> 
> >From the perspective of the caller of ceph_sync_write(), it
> doesn't matter that it's the osd is deciding when it's safe or
> not.  ceph_sync_write() waits for the osd request to complete
> before returning.  Once it returns, the unsafe period is
> over (and may have never even existed if there was an error).

Oh, I think we're both wrong.  :)

Once ceph_sync_write() returns, the request has gotten an ack, so it has 
been sent, but we maybe haven't gotten the COMMIT yet, and it should be on 
the unsafe list.  You're right that it doesn't need to be on the unsafe 
list before ceph_sync_write() returns, since fsync(2) doesn't need to wait 
for a write(2) that hasn't returned yet.

In that case, I think your v2 patch is correct.

Reviewed-by: Sage Weil <sage@inktank.com>


> If sync_write_wait() should wait for something beyond just
> the durability of writes then it should be waiting something
> different than osd request completions.
> 
> I hope I'm not off base here.
> 
> My second version does the "request is unsafe" callback
> exactly once, when it actually gets sent the first time
> rather than when the request gets started.
> 
> 					-Alex
> 
> 
> > That being the case, it will become unsafe exactly once, and safe again 
> > exactly once (on success, or abort).
> 
> 
