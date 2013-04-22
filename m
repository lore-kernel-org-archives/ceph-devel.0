From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] rbd: revalidate_disk upon rbd resize
Date: Mon, 22 Apr 2013 10:14:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304221014410.15710@cobra.newdream.net>
References: <1365774766-29899-1-git-send-email-laurent@ksperis.com> <516C37D5.1090804@inktank.com> <51756F11.6050708@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34679 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab3DVROv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 13:14:51 -0400
In-Reply-To: <51756F11.6050708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Laurent Barbe <laurent@ksperis.com>, ceph-devel@vger.kernel.org

On Mon, 22 Apr 2013, Alex Elder wrote:
> On 04/15/2013 12:24 PM, Alex Elder wrote:
> > On 04/12/2013 08:52 AM, Laurent Barbe wrote:
> >> If rbd disk is open and rbd resize is done, new size is not visible by
> >> filesystem.
> >> Like is done in virtio-blk and dm driver, revalidate_disk() permits to
> >> update the bd_inode size.
> >>
> >> Signed-off-by: Laurent Barbe <laurent@ksperis.com>
> > 
> > This one looks good (too).  And this time I've tested
> > it just to be sure I get no lockdep warnings.  Unless
> > I see any strangeness in my sanity testing (which I
> > don't expect) I'll commit this to the testing branch
> > later today.  Thanks a lot.
> > 
> > Reviewed-by: Alex Elder <elder@inktank.com>
> 
> I have committed this to the "testing" branch of the
> ceph-client git repository.

Is this the one that had the lockdep issue?

sage
