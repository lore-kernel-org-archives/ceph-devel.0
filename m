From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/2] libceph: fix handle_timeout() racing with
 con_work()/try_write()
Date: Tue, 17 May 2011 16:27:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105171613120.30781@cobra.newdream.net>
References: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
 <1305235954-9860-2-git-send-email-jaschut@sandia.gov>
 <Pine.LNX.4.64.1105161033150.12367@cobra.newdream.net> <4DD2F773.30508@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47549 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab1EQX0Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2011 19:26:16 -0400
In-Reply-To: <4DD2F773.30508@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Tue, 17 May 2011, Jim Schutt wrote:
> Hi Sage,
> 
> Sage Weil wrote:
> > Hi Jim,
> 
> > This picks up the second resent message.  But and OPENING is set.. so how is
> > it that we were in try_write but we didn't pass through the OPENING test in
> > con_work?
> > 
> > > > > con_work()/try_write() start again on new message.
> > > > > Note that con_work() did not notice that the connection was marked to
> > > > > be closed/reopened!  This is where things went bad.
> > > > > Note the connection state: 8220 = 0x201c, and 0x2000 is OPENING.
> > > [ 2412.643178] libceph:   messenger.c:1969 : con_work ffff8801955c0030
> > > OPENING
> > > [ 2412.643182] libceph:   messenger.c:292  : con_close_socket on
> > > ffff8801955c0030 sock ffff8801825a8c00
> > > [ 2412.643197] libceph:   messenger.c:162  : ceph_state_change
> > > ffff8801955c0030 state = 2076 sk_state = 4
> > 
> > Ok, now we see it, but this should have executed before we ever got to
> > try_write!
> > 
> > There are a handful of places that drop and re-take con->mutex... I think it
> > has to be one of those.  They are:
> > 
> > - prepare_connect_authorizer (before calling ->prepare_authorizer callback)
> > - fail_protocol (before calling ->bad_proto callback)
> > - process_connect RESETSESSION case (before calling ->reset callback)
> > - process_message (before calling ->dispatch callback)
> > 
> > I think after retaking the lock in each of these cases we need to test for
> > the CLOSED or OPENING bits and, if set, bail out so that con_work can
> > restart.
> > 
> > Does that make sense?  Can you confirm which case of lock droppage inside
> > con_work is at fault?  (Maybe adding a printk at the top of con_work after
> > taking the lock too would make it more clear what's going on; currently it
> > only prints in all the random test_bit cases).
> 
> So I've got logs now that show that connection state changes
> across a call to process_message.  That seems like it proves
> the concept.
> 
> > 
> > I'm thinking something like the below... does that seem reasonable?  I only
> > did the prepare_authorizer case to start, but the others should be fixed up
> > too.  Compile tested only.
> > 
> 
> Is there any reason not to fix all the cases at once, in try_read?
> It's less code, but far away from where the mutex dropping occurs,
> so we add a comment:

That covers the process_message and process_connect cases, provided you 
also set ret properly, and do the con_close_socket work that the con_work 
checks would have done.  e.g.,

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index e15a82c..7ef9eb0 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1810,6 +1810,21 @@ static int try_read(struct ceph_connection *con)
 more:
        dout("try_read tag %d in_base_pos %d\n", (int)con->in_tag,
             con->in_base_pos);
+
+       /*
+        * process_connect and process_message drop and re-take
+        * con->mutex.  make sure we handle a racing close or reopen.
+        */
+       if (test_bit(CLOSED, &con->state)) {
+               ret = -EAGAIN;
+               goto out;
+       }
+       if (test_bit(OPENING, &con->state)) {
+               con_close_socket(con);
+               ret = 0;  /* so we continue to try_write */
+               goto out;
+       }
+
        if (test_bit(CONNECTING, &con->state)) {
                if (!test_bit(NEGOTIATING, &con->state)) {
                        dout("try_read connecting\n");

It's a little bit unweildly because we repeat the checks at the top of 
con_work, though.  It is probably cleaner to always fall back to that case 
by doing CLOSED|OPENING bit checks and bailing with -EAGAIN any time we 
retake con->mutex, and then checking try_read/write return values like the 
patch from yesterday does.  That way we only react to the bits in one 
place.

Have you verified that this fixes the problem for you?  It makes sense the 
race is over ->dispatch, since that is a somewhat long-running call.

sage



> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index a9bd424..11d6a61 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1816,10 +1820,19 @@ static int try_read(struct ceph_connection *con)
>  	dout("try_read start on %p state %lu\n", con, con->state);
> 
>  more:
>  	dout("try_read %p state %lu tag %d in_base_pos %d\n", con,
>  	     con->state, (int)con->in_tag, con->in_base_pos);
> +
> +	/* process_connect, process_message need to drop con->mutex,
> +	 * so connection state might have changed on us.  Check it,
> +	 * leave if necessary so new state can be processed.
> +	 */
> +	if (test_bit(CLOSED, &con->state) ||
> +	    test_bit(OPENING, &con->state))
> +		goto out;
> +
>  	if (test_bit(CONNECTING, &con->state)) {
>  		if (!test_bit(NEGOTIATING, &con->state)) {
>  			dout("try_read %p connecting\n", con);
>  			ret = read_partial_banner(con);
>  			if (ret <= 0)
> 
> 
> What am I missing?
> 
> -- Jim
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
