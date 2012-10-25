From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: avoid NULL kref_put when osd reset races with
 alloc_msg
Date: Thu, 25 Oct 2012 08:50:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210250849470.26996@cobra.newdream.net>
References: <1351120829-12219-1-git-send-email-sage@inktank.com> <50894C9E.1090705@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59327 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946073Ab2JYPuP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 11:50:15 -0400
In-Reply-To: <50894C9E.1090705@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 25 Oct 2012, Alex Elder wrote:
> On 10/24/2012 06:20 PM, Sage Weil wrote:
> > The ceph_on_in_msg_alloc() method drops con->mutex while it allocates a
> > message.  If that races with a timeout that resends a zillion messages and
> > resets the connection, and the ->alloc_msg() method returns a NULL message,
> > it will call ceph_msg_put(NULL) and BUG.
> 
> The fix is the right thing to do, but your explanation is wrong.
> If msg is null at that point, it's because con->ops->alloc_msg()
> failed, and has nothing to do with the mutex state.
> 
> So yes, the returned pointer should be checked for null before
> dropping a reference, but that's all there is to it...
> 
> Perhaps it's the zillion messages that are leading to the
> message allocation failure somehow.

Right, fixed that up.
 
> > Fix by only calling put if msg is non-NULL.
> > 
> > Fixes http://tracker.newdream.net/issues/3142
> 
> Is that the right bug number?

Nope!  Sigh.

> > Signed-off-by: Sage Weil <sage@inktank.com>
> 
> Please fix the explanation, but otherwise this looks good.
> 
> Reviewed-by: Alex Elder <elder@inktank.com>

Thanks!  Repushed to the testing branch.
sage


> 
> >  net/ceph/messenger.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > index 66f6f56..1041114 100644
> > --- a/net/ceph/messenger.c
> > +++ b/net/ceph/messenger.c
> > @@ -2742,7 +2742,8 @@ static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
> >  		msg = con->ops->alloc_msg(con, hdr, skip);
> >  		mutex_lock(&con->mutex);
> >  		if (con->state != CON_STATE_OPEN) {
> > -			ceph_msg_put(msg);
> > +			if (msg)
> > +				ceph_msg_put(msg);
> >  			return -EAGAIN;
> >  		}
> >  		con->in_msg = msg;
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
