From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH 2/2] libceph: fix handle_timeout() racing with
 con_work()/try_write()
Date: Thu, 12 May 2011 15:32:34 -0600
Message-ID: <1305235954-9860-2-git-send-email-jaschut@sandia.gov>
References: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:50858 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932859Ab1ELVdY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2011 17:33:24 -0400
In-Reply-To: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>

Under heavy write load, ceph OSDs get messages from clients with bad
message tags.  The result is that client/OSD connection stalls
for a while until the connection state gets sorted out.

The client-side sequence of events that has this result is as follows:

Due to the heavy write load, message processing is backed up, and
a client begins timing out its messages to an OSD.  This timeout
mechanism is intended to recover lost connections, so it causes the
connection to be closed and reopened in an attempt to recover contact
with the OSD.

All ceph socket operations are performed on a workqueue via ceph's
con_work() function.  handle_timeout(), via __reset_osd(), signals
via ceph_connection state that the connection should be closed
and reopened.  However, if there is a message send in progress
when __reset_osd() is called, the ceph_connection state is not
correctly updated, with the result that upon reconnect, information
about the in-progress message is lost, and data that is interpreted
as a message tag is incorrectly sent.

Fix this by causing try_write() to notice that it needs to do
nothing until the connection socket has been closed.  This gives
the appropriate con_work() calls that close/reopen the socket
time to occur correctly.

Here's an annotated debug log of the erroneous sequence:

[ 2381.368370] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 29 nref 1
[ 2381.368374] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91c600 out_kvec_bytes 0
[ 2381.368959] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0

>> con_work()/try_write() made progress on a message

[ 2381.716677] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 29 nref 1
[ 2381.716681] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91c600 out_kvec_bytes 0
[ 2381.717434] libceph:   messenger.c:509  : prepare_write_message ffff8801955c0030 msg ffff88018f91d6c0 seq 5 type 42 len 128+0+524288 128 pgs
[ 2381.717522] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 191
[ 2381.718982] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0

>> con_work()/try_write() finished previous message and started on next message

[ 2388.650373] libceph:   messenger.c:2159 : ----- ffff88015410a300 to osd20 42=osd_op len 128+0+524288 -----
[ 2388.664280] libceph:   messenger.c:2159 : ----- ffff880154116d80 to osd20 42=osd_op len 128+0+524288 -----
[ 2388.664905] libceph:   messenger.c:2159 : ----- ffff8801541176c0 to osd20 42=osd_op len 128+0+524288 -----
[ 2388.669632] libceph:   messenger.c:2159 : ----- ffff88015411bb40 to osd20 42=osd_op len 128+0+524288 -----

>> ceph_con_send() queues more work to connection

[ 2392.366919] libceph:  tid 447 timed out on osd20, will reset osd
[ 2392.366922] libceph:  osd_client.c:725  : __reset_osd ffff8801955c0000 osd20
[ 2392.366926] libceph:   messenger.c:349  : con_close ffff8801955c0030 peer 172.17.40.27:6800

>> A message times out, __reset_osd signals that connection should be closed; work
>> queued to connection is discarded.

[ 2392.366934] libceph:   messenger.c:369  : con_open ffff8801955c0030 172.17.40.27:6800

>> __reset_osd signals that connection should be opened.

[ 2392.367237] libceph:   messenger.c:2159 : ----- ffff88018f91c600 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367242] libceph:   messenger.c:2159 : ----- ffff88018f91d6c0 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367247] libceph:   messenger.c:2159 : ----- ffff88018f920a80 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367251] libceph:   messenger.c:2159 : ----- ffff88018f924d80 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367256] libceph:   messenger.c:2159 : ----- ffff88018f926480 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367260] libceph:   messenger.c:2159 : ----- ffff88018f92f240 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367265] libceph:   messenger.c:2159 : ----- ffff88018f930d80 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367269] libceph:   messenger.c:2159 : ----- ffff88018be14f00 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367274] libceph:   messenger.c:2159 : ----- ffff88018be1b3c0 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367279] libceph:   messenger.c:2159 : ----- ffff88018be210c0 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367283] libceph:   messenger.c:2159 : ----- ffff88018d9c69c0 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367288] libceph:   messenger.c:2159 : ----- ffff88018d85f9c0 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367293] libceph:   messenger.c:2159 : ----- ffff88018daf2300 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367297] libceph:   messenger.c:2159 : ----- ffff88018f8b6600 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367302] libceph:   messenger.c:2159 : ----- ffff88018be28840 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367307] libceph:   messenger.c:2159 : ----- ffff880154105240 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367311] libceph:   messenger.c:2159 : ----- ffff88015410a300 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367316] libceph:   messenger.c:2159 : ----- ffff88015410f0c0 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367320] libceph:   messenger.c:2159 : ----- ffff880154116d80 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367325] libceph:   messenger.c:2159 : ----- ffff8801541176c0 to osd20 42=osd_op len 128+0+524288 -----
[ 2392.367329] libceph:   messenger.c:2159 : ----- ffff88015411bb40 to osd20 42=osd_op len 128+0+524288 -----

>> Outstanding work is requeued to connection.

[ 2397.376206] libceph:   messenger.c:2230 : con_keepalive ffff8801955c0030
[ 2402.384140] libceph:   messenger.c:2230 : con_keepalive ffff8801955c0030
[ 2407.395283] libceph:   messenger.c:2230 : con_keepalive ffff8801955c0030
[ 2411.207412] libceph:   messenger.c:2177 : con_revoke ffff8801955c0030 msg ffff88018f91c600 - was on queue

[ 2411.217092] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 8220 nref 1
[ 2411.225536] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg           (null) out_kvec_bytes 0
[ 2411.235555] libceph:   messenger.c:509  : prepare_write_message ffff8801955c0030 msg ffff88018f91d6c0 seq 1 type 42 len 128+0+524288 128 pgs
[ 2411.256874] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 191
[ 2411.267280] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0

>> con_work()/try_write() start again on new message.
>> Note that con_work() did not notice that the connection was marked to
>> be closed/reopened!  This is where things went bad.
>> Note the connection state: 8220 = 0x201c, and 0x2000 is OPENING.

[ 2412.643178] libceph:   messenger.c:1969 : con_work ffff8801955c0030 OPENING
[ 2412.643182] libceph:   messenger.c:292  : con_close_socket on ffff8801955c0030 sock ffff8801825a8c00
[ 2412.643197] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2076 sk_state = 4

>> con_work() notices that connection should be closed/reopened

[ 2412.643206] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 28 nref 1
[ 2412.643210] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 0
[ 2412.643214] libceph:   messenger.c:665  : prepare_write_connect ffff8801955c0030 cseq=0 gseq=84 proto=24
[ 2412.643218] libceph:   messenger.c:1725 : try_write initiating connect on ffff8801955c0030 new state 26
[ 2412.643281] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0
[ 2412.643300] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 26 sk_state = 1

>> con_work()/try_write() attempts to reopen connection, since con->sock is NULL.
>> Note that prepare_write_connect() just overwrote the part of the kvec that
>> had the message tag that prepare_write_message() set up above.

[ 2415.582538] libceph:   messenger.c:2159 : ----- ffff88018d892480 to osd20 42=osd_op len 128+0+524288 -----
[ 2417.921405] libceph:   messenger.c:2230 : con_keepalive ffff8801955c0030
[ 2418.046863] libceph:   messenger.c:2159 : ----- ffff8801542d8480 to osd20 42=osd_op len 128+0+524288 -----
[ 2418.129434] libceph:   messenger.c:2159 : ----- ffff8801542d8d80 to osd20 42=osd_op len 128+0+524288 -----

>> more work is queued

[ 2418.219923] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 30 nref 1
[ 2418.219955] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 200
[ 2418.220388] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0

>> try_write() tries again to send the current message after connection was reopened.
>> since connection was reopened, we need to call prepare_write_message() again to
>> send correct message tag, but that didn't happen.

[ 2418.220517] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 30 sk_state = 8
[ 2418.223341] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2078 sk_state = 7
[ 2419.611777] libceph:   messenger.c:2159 : ----- ffff8801542d96c0 to osd20 42=osd_op len 128+0+524288 -----
[ 2419.620907] libceph:   messenger.c:2159 : ----- ffff8801542e1840 to osd20 42=osd_op len 128+0+524288 -----
[ 2419.638112] libceph:   messenger.c:2159 : ----- ffff880154355240 to osd20 42=osd_op len 128+0+524288 -----
[ 2423.040109] libceph:   messenger.c:2230 : con_keepalive ffff8801955c0030
[ 2424.572798] libceph: osd20 172.17.40.27:6800 connection failed

>> client closed connection since it had bad tag

[ 2424.578852] libceph:   messenger.c:1997 : fault ffff8801955c0030 state 30 to peer 172.17.40.27:6800
[ 2424.587903] libceph:   messenger.c:292  : con_close_socket on ffff8801955c0030 sock ffff880195fbb300
[ 2424.597059] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2078 sk_state = 7
[ 2425.380053] libceph:   messenger.c:2034 : fault queued ffff8801955c0030 delay 500
[ 2425.387544] libceph:  osd_client.c:725  : __reset_osd ffff8801955c0000 osd20
[ 2428.814245] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 30 nref 1
[ 2428.822518] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 0
[ 2428.832532] libceph:   messenger.c:665  : prepare_write_connect ffff8801955c0030 cseq=0 gseq=128 proto=24
[ 2428.842125] libceph:   messenger.c:1725 : try_write initiating connect on ffff8801955c0030 new state 26
[ 2428.851583] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0
[ 2428.859178] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 26 sk_state = 1
[ 2432.083976] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 30 nref 1
[ 2432.092250] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 200
[ 2432.103263] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 30 sk_state = 8
[ 2432.119307] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2078 sk_state = 7
[ 2432.149668] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret -32
[ 2432.157419] libceph: osd20 172.17.40.27:6800 connection failed
[ 2432.163266] libceph:   messenger.c:1997 : fault ffff8801955c0030 state 2078 to peer 172.17.40.27:6800
[ 2432.172487] libceph:   messenger.c:292  : con_close_socket on ffff8801955c0030 sock ffff8801825ecc00
[ 2432.181636] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2078 sk_state = 7
[ 2432.204310] libceph:   messenger.c:2038 : fault failed to queue ffff8801955c0030 delay 1000, backoff
[ 2432.213462] libceph:  osd_client.c:725  : __reset_osd ffff8801955c0000 osd20
[ 2435.234571] libceph:   messenger.c:1945 : con_work ffff8801955c0030 backing off
[ 2435.241907] libceph:   messenger.c:1948 : con_work ffff8801955c0030 backoff 1000
[ 2439.455722] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 30 nref 1
[ 2439.464052] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 0
[ 2439.474054] libceph:   messenger.c:665  : prepare_write_connect ffff8801955c0030 cseq=0 gseq=168 proto=24
[ 2439.483636] libceph:   messenger.c:1725 : try_write initiating connect on ffff8801955c0030 new state 26
[ 2439.493061] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0
[ 2439.500653] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 26 sk_state = 1
[ 2442.678598] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 30 nref 1
[ 2442.686871] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 200
[ 2442.697121] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0
[ 2442.704825] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 30 sk_state = 8
[ 2442.720849] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2078 sk_state = 7
[ 2444.582650] libceph: osd20 172.17.40.27:6800 connection failed
[ 2444.588700] libceph:   messenger.c:1997 : fault ffff8801955c0030 state 30 to peer 172.17.40.27:6800
[ 2444.597750] libceph:   messenger.c:292  : con_close_socket on ffff8801955c0030 sock ffff8801825a8900
[ 2444.606904] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2078 sk_state = 7
[ 2444.629552] libceph:   messenger.c:2034 : fault queued ffff8801955c0030 delay 2000
[ 2444.637143] libceph:  osd_client.c:725  : __reset_osd ffff8801955c0000 osd20
[ 2449.541286] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 30 nref 1
[ 2449.549601] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 0
[ 2449.569187] libceph:   messenger.c:1725 : try_write initiating connect on ffff8801955c0030 new state 26
[ 2449.578620] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0
[ 2449.586212] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 26 sk_state = 1
[ 2452.647790] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 30 nref 1
[ 2452.656069] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 200
[ 2452.667104] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 30 sk_state = 8
[ 2452.683145] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2078 sk_state = 7
[ 2452.713468] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret -32
[ 2452.721233] libceph: osd20 172.17.40.27:6800 connection failed
[ 2452.727079] libceph:   messenger.c:1997 : fault ffff8801955c0030 state 2078 to peer 172.17.40.27:6800
[ 2452.736314] libceph:   messenger.c:292  : con_close_socket on ffff8801955c0030 sock ffff8801825ec900
[ 2452.745447] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2078 sk_state = 7
[ 2452.768128] libceph:   messenger.c:2038 : fault failed to queue ffff8801955c0030 delay 4000, backoff
[ 2452.777264] libceph:  osd_client.c:725  : __reset_osd ffff8801955c0000 osd20
[ 2455.493705] libceph:   messenger.c:1945 : con_work ffff8801955c0030 backing off
[ 2455.501031] libceph:   messenger.c:1948 : con_work ffff8801955c0030 backoff 4000
[ 2458.132179] libceph:   messenger.c:2230 : con_keepalive ffff8801955c0030
[ 2462.134769] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 30 nref 1
[ 2462.143086] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 0
[ 2462.153099] libceph:   messenger.c:665  : prepare_write_connect ffff8801955c0030 cseq=0 gseq=242 proto=24
[ 2462.162670] libceph:   messenger.c:1725 : try_write initiating connect on ffff8801955c0030 new state 26
[ 2462.172102] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0
[ 2462.179695] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 26 sk_state = 1
[ 2464.284217] libceph:   messenger.c:1708 : try_write start ffff8801955c0030 state 30 nref 1
[ 2464.292489] libceph:   messenger.c:1712 : try_write ffff8801955c0030 out_msg ffff88018f91d6c0 out_kvec_bytes 200
[ 2464.303138] libceph:   messenger.c:1790 : try_write done on ffff8801955c0030 ret 0
[ 2464.310771] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 30 sk_state = 8
[ 2464.326802] libceph:   messenger.c:162  : ceph_state_change ffff8801955c0030 state = 2078 sk_state = 7
[ 2466.903694] libceph: osd20 172.17.40.27:6800 connection failed
[ 2466.909735] libceph:   messenger.c:1997 : fault ffff8801955c0030 state 30 to peer 172.17.40.27:6800

>> four more iterations of reconnecting, then sending bad message tag.
---
 net/ceph/messenger.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index db12abc..657a2de 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1707,6 +1707,12 @@ static int try_write(struct ceph_connection *con)
 	dout("try_write start %p state %lu nref %d\n", con, con->state,
 	     atomic_read(&con->nref));
 
+	if (test_bit(OPENING, &con->state)) {
+		dout("try_write %p raced ceph_con_open, won - retry\n", con);
+		ret = 0;
+		goto out;
+	}
+
 more:
 	dout("try_write %p out_msg %p out_kvec_bytes %d\n",
 	     con, con->out_msg, con->out_kvec_bytes);
-- 
1.6.6


