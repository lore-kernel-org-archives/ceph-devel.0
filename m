From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: fix protocol feature mismatch failure path
Date: Thu, 27 Dec 2012 16:33:31 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212271632530.22449@cobra.newdream.net>
References: <1356653240-23146-1-git-send-email-sage@inktank.com> <50DCE810.2030405@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44382 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab2L1Adc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Dec 2012 19:33:32 -0500
In-Reply-To: <50DCE810.2030405@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 27 Dec 2012, Alex Elder wrote:
> On 12/27/2012 06:07 PM, Sage Weil wrote:
> > We should not set con->state to CLOSED here; that happens in ceph_fault()
> > in the caller, where it first asserts that the state is not yet CLOSED.
> 
> I'm not seeing the code path you're talking about.
> Do you mean in the LOSSYTX case?

It's when the feature bits don't match.  It calls this, sets CLOSED< and 
then returns -1 and con_work() calls ceph_fault().

> 
> (I don't doubt you're right, I'm just trying to follow
> along at home.)
> 
> > Avoids a BUG when the features don't match.
> 
> Is this related to the crashes reported here?
>     http://tracker.newdream.net/issues/3657
> 
> > Signed-off-by: Sage Weil <sage@inktank.com>
> > ---
> >  net/ceph/messenger.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > index 4d111fd..24a5c86 100644
> > --- a/net/ceph/messenger.c
> > +++ b/net/ceph/messenger.c
> > @@ -1508,9 +1508,9 @@ static int process_banner(struct ceph_connection *con)
> >  
> >  static void fail_protocol(struct ceph_connection *con)
> >  {
> > +	dout("fail_protocol %p\n", con);
> >  	reset_connection(con);
> >  	BUG_ON(con->state != CON_STATE_NEGOTIATING);
> 
> Since fail_protocol becomes essentially a trivial wrapper
> for reset_connection(), I think it should just go away
> and call reset_connection() directly.  The assertion that
> it's in NEGOTIATING state is not very useful at the moment;
> fail_protocol() is only called from process_connect(),
> and that's only called from try_read when the state
> is NEGOTIATING.

Good point.  I'll clean that up!


> 
> 					-Alex
> 
> > -	con->state = CON_STATE_CLOSED;
> >  }
> >  
> >  static int process_connect(struct ceph_connection *con)
> > 
> 
> 
