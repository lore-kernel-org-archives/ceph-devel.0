From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Trouble with paxos service for large PG count
Date: Tue, 2 Apr 2013 13:16:28 -0600
Message-ID: <515B2E8C.5090001@sandia.gov>
References: <5159F899.4090001@sandia.gov> <515AFC5F.4000705@inktank.com>
 <515B20F8.5060203@sandia.gov>
 <CAGgG2xTdTOWvaPAK2FnxpzC1fsok50_HXXSgayEoD3J8SK6k3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:39340 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932283Ab3DBTRz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 15:17:55 -0400
In-Reply-To: <CAGgG2xTdTOWvaPAK2FnxpzC1fsok50_HXXSgayEoD3J8SK6k3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Luis <joao.luis@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/02/2013 12:28 PM, Joao Luis wrote:
> Right.  I'll push a patch to bump that sort of output to 30 when I get home.

Thanks - but FWIW, I don't think it's the root cause of my
issue -- more below....
> 
> If you're willing, try reducing the paxos debug level to 0 and let us know
> if those delays in the proposal go away.

When I started debugging why I couldn't start new filesystems, several
days ago, I wasn't using any debugging.  It took me until last Friday
to track the issue into paxos, which is when I turned on its debugging.

Also, I've added the following bits of debug output:

diff --git a/src/mon/Paxos.cc b/src/mon/Paxos.cc
index bf3eb92..70a8b5d 100644
--- a/src/mon/Paxos.cc
+++ b/src/mon/Paxos.cc
@@ -494,6 +494,8 @@ void Paxos::begin(bufferlist& v)
   MonitorDBStore::Transaction t;
   t.put(get_name(), last_committed+1, new_value);
 
+  utime_t tstart = ceph_clock_now(g_ceph_context);
+
   dout(30) << __func__ << " transaction dump:\n";
   JSONFormatter f(true);
   t.dump(&f);
@@ -506,7 +508,14 @@ void Paxos::begin(bufferlist& v)
   f.flush(*_dout);
   *_dout << dendl;
 
+  dout(10) <<  __func__ << " - JSON formatting, debug_tx decode took "
+           << ceph_clock_now(g_ceph_context) - tstart << dendl;
+
+  tstart = ceph_clock_now(g_ceph_context);
   get_store()->apply_transaction(t);
+  dout(10) <<  __func__ << " - get_store()->apply_transaction took "
+           << ceph_clock_now(g_ceph_context) - tstart << dendl;
+
 
   if (mon->get_quorum().size() == 1) {
     // we're alone, take it easy
diff --git a/src/mon/PaxosService.cc b/src/mon/PaxosService.cc
index a66c5ec..808ce62 100644
--- a/src/mon/PaxosService.cc
+++ b/src/mon/PaxosService.cc
@@ -158,6 +158,8 @@ void PaxosService::propose_pending()
   encode_pending(&t);
   have_pending = false;
 
+  utime_t tstart = ceph_clock_now(g_ceph_context);
+
   dout(30) << __func__ << " transaction dump:\n";
   JSONFormatter f(true);
   t.dump(&f);
@@ -166,6 +168,9 @@ void PaxosService::propose_pending()
 
   t.encode(bl);
 
+  dout(10) <<  __func__ << " - JSON formatting, encode took "
+           << ceph_clock_now(g_ceph_context) - tstart << dendl;
+
   // apply to paxos
   proposing.set(1);
   paxos->propose_new_value(bl, new C_Committed(this));


which produces this:

2013-04-02 13:04:22.311743 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(pgmap) propose_pending
2013-04-02 13:04:22.426810 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(pgmap) propose_pending - JSON formatting, encode took 0.000170
2013-04-02 13:04:22.426874 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos active c 1..3) queue_proposal bl 19775198 bytes; ctx = 0x11e81f0
2013-04-02 13:04:22.426999 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued 4 19775198 bytes
2013-04-02 13:04:22.427003 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued list_proposals 1 in queue:
2013-04-02 13:07:51.190312 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) begin for 4 19775198 bytes
2013-04-02 13:07:51.190860 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos updating c 1..3) begin - JSON formatting, debug_tx decode took 0.000002
2013-04-02 13:07:51.402134 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos updating c 1..3) begin - get_store()->apply_transaction took 0.211275
2013-04-02 13:07:51.402178 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos updating c 1..3) commit 4
2013-04-02 13:07:51.635113 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos active c 1..4) finish_queued_proposal finishing proposal
2013-04-02 13:07:51.635152 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos active c 1..4) finish_queued_proposal finish it (proposal = 0x1261340)
2013-04-02 13:07:51.635159 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos active c 1..4) finish_queued_proposal proposal took 209.208162 to finish
2013-04-02 13:07:51.635193 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(pgmap) _active


I thought I was timing the same JSON formatting in propose_pending()
and begin(), but they take much different amounts of time.
I don't understand why yet.....

Also, I just noticed the elapsed time between these two lines:

2013-04-02 13:04:22.427003 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued list_proposals 1 in queue:
2013-04-02 13:07:51.190312 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) begin for 4 19775198 bytes

It accounts for nearly the whole of the delay that finish_queued_proposal()
is reporting.  Why did begin() take so long to start, I wonder ???

-- Jim


> 
>   -Joao


