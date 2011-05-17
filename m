From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH 2/2] libceph: fix handle_timeout() racing with
 con_work()/try_write()
Date: Tue, 17 May 2011 16:32:19 -0600
Message-ID: <4DD2F773.30508@sandia.gov>
References: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
 <1305235954-9860-2-git-send-email-jaschut@sandia.gov>
 <Pine.LNX.4.64.1105161033150.12367@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:33132 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695Ab1EQWcw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2011 18:32:52 -0400
In-Reply-To: <Pine.LNX.4.64.1105161033150.12367@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

Sage Weil wrote:
> Hi Jim,

> This picks up the second resent message.  But and OPENING is set.. so how 
> is it that we were in try_write but we didn't pass through the OPENING 
> test in con_work?
> 
>>>> con_work()/try_write() start again on new message.
>>>> Note that con_work() did not notice that the connection was marked to
>>>> be closed/reopened!  This is where things went bad.
>>>> Note the connection state: 8220 = 0x201c, and 0x2000 is OPENING.
>> [ 2412.643178] libceph:   messenger.c:1969 : con_work ffff8801955c0030 OPENING
>> [ 2412.643182] libceph:   messenger.c:292  : con_close_socket on ffff8801955c0030 sock ffff8801825a8c00
>> [ 2412.643197] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2076 sk_state = 4
> 
> Ok, now we see it, but this should have executed before we ever got to 
> try_write!
> 
> There are a handful of places that drop and re-take con->mutex... I think 
> it has to be one of those.  They are:
> 
> - prepare_connect_authorizer (before calling ->prepare_authorizer 
> callback)
> - fail_protocol (before calling ->bad_proto callback)
> - process_connect RESETSESSION case (before calling ->reset callback)
> - process_message (before calling ->dispatch callback)
> 
> I think after retaking the lock in each of these cases we need to test for 
> the CLOSED or OPENING bits and, if set, bail out so that con_work can 
> restart.
> 
> Does that make sense?  Can you confirm which case of lock droppage inside 
> con_work is at fault?  (Maybe adding a printk at the top of con_work after 
> taking the lock too would make it more clear what's going on; currently it 
> only prints in all the random test_bit cases).

So I've got logs now that show that connection state changes
across a call to process_message.  That seems like it proves
the concept.

> 
> I'm thinking something like the below... does that seem reasonable?  I 
> only did the prepare_authorizer case to start, but the others should be 
> fixed up too.  Compile tested only.
> 

Is there any reason not to fix all the cases at once, in try_read?
It's less code, but far away from where the mutex dropping occurs,
so we add a comment:

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index a9bd424..11d6a61 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1816,10 +1820,19 @@ static int try_read(struct ceph_connection *con)
  	dout("try_read start on %p state %lu\n", con, con->state);

  more:
  	dout("try_read %p state %lu tag %d in_base_pos %d\n", con,
  	     con->state, (int)con->in_tag, con->in_base_pos);
+
+	/* process_connect, process_message need to drop con->mutex,
+	 * so connection state might have changed on us.  Check it,
+	 * leave if necessary so new state can be processed.
+	 */
+	if (test_bit(CLOSED, &con->state) ||
+	    test_bit(OPENING, &con->state))
+		goto out;
+
  	if (test_bit(CONNECTING, &con->state)) {
  		if (!test_bit(NEGOTIATING, &con->state)) {
  			dout("try_read %p connecting\n", con);
  			ret = read_partial_banner(con);
  			if (ret <= 0)


What am I missing?

-- Jim


