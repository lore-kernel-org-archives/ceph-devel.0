From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/2] libceph: fix handle_timeout() racing with
 con_work()/try_write()
Date: Mon, 16 May 2011 10:57:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105161033150.12367@cobra.newdream.net>
References: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
 <1305235954-9860-2-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41940 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977Ab1EPR4r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2011 13:56:47 -0400
In-Reply-To: <1305235954-9860-2-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

Hi Jim,

Finally had some time to look at this closely.  This is great work 
nailing down the misbehavior.  Here's what confuses me:  

- con_work takes con->mutex and does (almost) everything under the 
protection of that lock.
- con_close and con_open both take it as well when they twiddle with state
- therefore, after the close/open are called by __reset_osd(), the next 
call into con_work should see the OPENING bit is set.

Of course, it doesn't.  See below...

> [ 2392.366919] libceph:  tid 447 timed out on osd20, will reset osd
> [ 2392.366922] libceph:  osd_client.c:725  : __reset_osd ffff8801955c0000 osd20
> [ 2392.366926] libceph:   messenger.c:349  : con_close ffff8801955c0030 peer 172.17.40.27:6800
> 
> >> A message times out, __reset_osd signals that connection should be closed; work
> >> queued to connection is discarded.
> 
> [ 2392.366934] libceph:   messenger.c:369  : con_open ffff8801955c0030 172.17.40.27:6800
> 
> >> __reset_osd signals that connection should be opened.
> 
> [ 2392.367237] libceph:   messenger.c:2159 : ----- ffff88018f91c600 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367242] libceph:   messenger.c:2159 : ----- ffff88018f91d6c0 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367247] libceph:   messenger.c:2159 : ----- ffff88018f920a80 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367251] libceph:   messenger.c:2159 : ----- ffff88018f924d80 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367256] libceph:   messenger.c:2159 : ----- ffff88018f926480 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367260] libceph:   messenger.c:2159 : ----- ffff88018f92f240 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367265] libceph:   messenger.c:2159 : ----- ffff88018f930d80 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367269] libceph:   messenger.c:2159 : ----- ffff88018be14f00 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367274] libceph:   messenger.c:2159 : ----- ffff88018be1b3c0 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367279] libceph:   messenger.c:2159 : ----- ffff88018be210c0 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367283] libceph:   messenger.c:2159 : ----- ffff88018d9c69c0 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367288] libceph:   messenger.c:2159 : ----- ffff88018d85f9c0 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367293] libceph:   messenger.c:2159 : ----- ffff88018daf2300 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367297] libceph:   messenger.c:2159 : ----- ffff88018f8b6600 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367302] libceph:   messenger.c:2159 : ----- ffff88018be28840 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367307] libceph:   messenger.c:2159 : ----- ffff880154105240 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367311] libceph:   messenger.c:2159 : ----- ffff88015410a300 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367316] libceph:   messenger.c:2159 : ----- ffff88015410f0c0 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367320] libceph:   messenger.c:2159 : ----- ffff880154116d80 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367325] libceph:   messenger.c:2159 : ----- ffff8801541176c0 to osd20 42=osd_op len 128+0+524288 -----
> [ 2392.367329] libceph:   messenger.c:2159 : ----- ffff88015411bb40 to osd20 42=osd_op len 128+0+524288 -----
> 
> >> Outstanding work is requeued to connection.
> 
> [ 2397.376206] libceph:   messenger.c:2230 : con_keepalive ffff8801955c0030
> [ 2402.384140] libceph:   messenger.c:2230 : con_keepalive ffff8801955c0030
> [ 2407.395283] libceph:   messenger.c:2230 : con_keepalive ffff8801955c0030
> [ 2411.207412] libceph:   messenger.c:2177 : con_revoke ffff8801955c0030 msg ffff88018f91c600 - was on queue

Not sure why the first message was revoked... but that shouldn't matter...
 
> [ 2411.217092] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 8220 nref 1
> [ 2411.225536] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg           (null) out_kvec_bytes 0
> [ 2411.235555] libceph:   messenger.c:509  : prepare_write_message ffff8801955c0030 msg ffff88018f91d6c0 seq 1 type 42 len 128+0+524288 128 pgs
> [ 2411.256874] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 191
> [ 2411.267280] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0

This picks up the second resent message.  But and OPENING is set.. so how 
is it that we were in try_write but we didn't pass through the OPENING 
test in con_work?

> >> con_work()/try_write() start again on new message.
> >> Note that con_work() did not notice that the connection was marked to
> >> be closed/reopened!  This is where things went bad.
> >> Note the connection state: 8220 = 0x201c, and 0x2000 is OPENING.
> 
> [ 2412.643178] libceph:   messenger.c:1969 : con_work ffff8801955c0030 OPENING
> [ 2412.643182] libceph:   messenger.c:292  : con_close_socket on ffff8801955c0030 sock ffff8801825a8c00
> [ 2412.643197] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2076 sk_state = 4

Ok, now we see it, but this should have executed before we ever got to 
try_write!

There are a handful of places that drop and re-take con->mutex... I think 
it has to be one of those.  They are:

- prepare_connect_authorizer (before calling ->prepare_authorizer 
callback)
- fail_protocol (before calling ->bad_proto callback)
- process_connect RESETSESSION case (before calling ->reset callback)
- process_message (before calling ->dispatch callback)

I think after retaking the lock in each of these cases we need to test for 
the CLOSED or OPENING bits and, if set, bail out so that con_work can 
restart.

Does that make sense?  Can you confirm which case of lock droppage inside 
con_work is at fault?  (Maybe adding a printk at the top of con_work after 
taking the lock too would make it more clear what's going on; currently it 
only prints in all the random test_bit cases).

I'm thinking something like the below... does that seem reasonable?  I 
only did the prepare_authorizer case to start, but the others should be 
fixed up too.  Compile tested only.

BTW, I looked at the second patch too.  Messages should only be requeued 
for non-lossy connections, and that's done in ceph_fault by the 
list_splice call.  The current out_msg is placed on the out_sent list when 
we first start, so it is already included in that set.  I don't think any 
special casing is needed there.

Thanks for hunting this down!
sage


diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index e15a82c..544d52c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -598,7 +598,7 @@ static void prepare_write_keepalive(struct ceph_connection *con)
  * Connection negotiation.
  */
 
-static void prepare_connect_authorizer(struct ceph_connection *con)
+static int prepare_connect_authorizer(struct ceph_connection *con)
 {
 	void *auth_buf;
 	int auth_len = 0;
@@ -612,6 +612,10 @@ static void prepare_connect_authorizer(struct ceph_connection *con)
 					 con->auth_retry);
 	mutex_lock(&con->mutex);
 
+	if (test_bit(CLOSED, &con->state) ||
+	    test_bit(OPENING, &con->state))
+		return -EAGAIN;
+
 	con->out_connect.authorizer_protocol = cpu_to_le32(auth_protocol);
 	con->out_connect.authorizer_len = cpu_to_le32(auth_len);
 
@@ -619,6 +623,7 @@ static void prepare_connect_authorizer(struct ceph_connection *con)
 	con->out_kvec[con->out_kvec_left].iov_len = auth_len;
 	con->out_kvec_left++;
 	con->out_kvec_bytes += auth_len;
+	return 0;
 }
 
 /*
@@ -640,9 +645,9 @@ static void prepare_write_banner(struct ceph_messenger *msgr,
 	set_bit(WRITE_PENDING, &con->state);
 }
 
-static void prepare_write_connect(struct ceph_messenger *msgr,
-				  struct ceph_connection *con,
-				  int after_banner)
+static int prepare_write_connect(struct ceph_messenger *msgr,
+				 struct ceph_connection *con,
+				 int after_banner)
 {
 	unsigned global_seq = get_global_seq(con->msgr, 0);
 	int proto;
@@ -683,7 +688,7 @@ static void prepare_write_connect(struct ceph_messenger *msgr,
 	con->out_more = 0;
 	set_bit(WRITE_PENDING, &con->state);
 
-	prepare_connect_authorizer(con);
+	return prepare_connect_authorizer(con);
 }
 
 
@@ -1216,6 +1221,7 @@ static int process_connect(struct ceph_connection *con)
 	u64 sup_feat = con->msgr->supported_features;
 	u64 req_feat = con->msgr->required_features;
 	u64 server_feat = le64_to_cpu(con->in_reply.features);
+	int r;
 
 	dout("process_connect on %p tag %d\n", con, (int)con->in_tag);
 
@@ -1250,7 +1256,9 @@ static int process_connect(struct ceph_connection *con)
 			return -1;
 		}
 		con->auth_retry = 1;
-		prepare_write_connect(con->msgr, con, 0);
+		r = prepare_write_connect(con->msgr, con, 0);
+		if (r < 0)
+			return r;
 		prepare_read_connect(con);
 		break;
 
@@ -1938,6 +1946,7 @@ static void con_work(struct work_struct *work)
 {
 	struct ceph_connection *con = container_of(work, struct ceph_connection,
 						   work.work);
+	int ret;
 
 	mutex_lock(&con->mutex);
 	if (test_and_clear_bit(BACKOFF, &con->state)) {
@@ -1958,6 +1967,7 @@ static void con_work(struct work_struct *work)
 		dout("con_work %p STANDBY\n", con);
 		goto done;
 	}
+restart:
 	if (test_bit(CLOSED, &con->state)) { /* e.g. if we are replaced */
 		dout("con_work CLOSED\n");
 		con_close_socket(con);
@@ -1969,18 +1979,32 @@ static void con_work(struct work_struct *work)
 		con_close_socket(con);
 	}
 
-	if (test_and_clear_bit(SOCK_CLOSED, &con->state) ||
-	    try_read(con) < 0 ||
-	    try_write(con) < 0) {
-		mutex_unlock(&con->mutex);
-		ceph_fault(con);     /* error/fault path */
-		goto done_unlocked;
-	}
+	if (test_and_clear_bit(SOCK_CLOSED, &con->state))
+		goto fault;
+
+	ret = try_read(con);
+	if (ret == -EAGAIN)
+		goto restart;
+	if (ret < 0)
+		goto fault;
+
+	ret = try_write(con);
+	if (ret == -EAGAIN)
+		goto restart;
+	if (ret < 0)
+		goto fault;
 
 done:
 	mutex_unlock(&con->mutex);
 done_unlocked:
 	con->ops->put(con);
+	return;
+
+
+fault:
+	mutex_unlock(&con->mutex);
+	ceph_fault(con);
+	goto done_unlocked;	
 }
 
 
