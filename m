From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Trouble with paxos service for large PG count
Date: Mon, 1 Apr 2013 15:14:01 -0600
Message-ID: <5159F899.4090001@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:42797 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756420Ab3DAVOj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Apr 2013 17:14:39 -0400
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1FA85D2D258
	for <ceph-devel@vger.kernel.org>; Mon,  1 Apr 2013 15:14:28 -0600 (MDT)
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Mon, 1 Apr 2013 15:14:17 -0600
Received: from mail.sandia.gov (exch01.sandia.gov [134.253.103.1] (may
 be forged)) by mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id
 r31LE2x5005853 for <ceph-devel@vger.kernel.org>; Mon, 1 Apr 2013
 15:14:02 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I've been having trouble starting a new file system
created using the current next branch (most recently,
commit 3b5f663f11).

I believe the trouble is related to how long it takes paxos to
process a pgmap proposal.

For a configuration with 1 mon, 1 mds, and 576 osds, using
pg_bits = 3 and debug paxos = 10, if I start just the monitor,
here's what I get when paxos processes the first non-trivial
pgmap proposal:

2013-04-01 14:04:16.330735 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(pgmap) propose_pending
2013-04-01 14:04:16.358973 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos active c 1..3) queue_proposal bl 4943990 bytes; ctx = 0x11e81f0
2013-04-01 14:04:16.359021 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued 4 4943990 bytes
2013-04-01 14:04:16.359025 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued list_proposals 1 in queue:
2013-04-01 14:04:28.096284 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) begin for 4 4943990 bytes
2013-04-01 14:04:28.164876 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos updating c 1..3) commit 4
2013-04-01 14:04:28.226789 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos active c 1..4) finish_queued_proposal finishing proposal
2013-04-01 14:04:28.226885 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos active c 1..4) finish_queued_proposal finish it (proposal = 0x1260f50)
2013-04-01 14:04:28.226892 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos active c 1..4) finish_queued_proposal proposal took 11.867914 to finish
2013-04-01 14:04:28.226941 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(pgmap) _active

When I redo the test with pg_bits = 4 (27696 PGs total) I get this:

2013-04-01 14:25:16.993255 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(pgmap) propose_pending
2013-04-01 14:25:17.051729 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos active c 1..3) queue_proposal bl 9887726 bytes; ctx = 0x11e81f0
2013-04-01 14:25:17.051882 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued 4 9887726 bytes
2013-04-01 14:25:17.051888 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued list_proposals 1 in queue:
2013-04-01 14:26:08.185143 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) begin for 4 9887726 bytes
2013-04-01 14:26:08.296351 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos updating c 1..3) commit 4
2013-04-01 14:26:08.408900 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos active c 1..4) finish_queued_proposal finishing proposal
2013-04-01 14:26:08.408928 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos active c 1..4) finish_queued_proposal finish it (proposal = 0x1260f50)
2013-04-01 14:26:08.408931 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos active c 1..4) finish_queued_proposal proposal took 51.357088 to finish
2013-04-01 14:26:08.408974 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(pgmap) _active

and at pg_bits = 5 (55392 PGs total) I get this:

2013-04-01 14:36:15.385280 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(pgmap) propose_pending
2013-04-01 14:36:15.500292 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos active c 1..3) queue_proposal bl 19775198 bytes; ctx = 0x11e81f0
2013-04-01 14:36:15.500433 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued 4 19775198 bytes
2013-04-01 14:36:15.500438 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued list_proposals 1 in queue:
2013-04-01 14:39:43.645062 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) begin for 4 19775198 bytes
2013-04-01 14:39:43.875099 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos updating c 1..3) commit 4
2013-04-01 14:39:44.086097 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos active c 1..4) finish_queued_proposal finishing proposal
2013-04-01 14:39:44.086128 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos active c 1..4) finish_queued_proposal finish it (proposal = 0x1260f50)
2013-04-01 14:39:44.086136 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos active c 1..4) finish_queued_proposal proposal took 208.585710 to finish
2013-04-01 14:39:44.086156 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(pgmap) _active

For this last configuration, after collecting the above
I waited a bit, started all the OSDs, waited a bit longer,
then collected this:

2013-04-01 14:54:37.364686 7ffff328d700 10 mon.cs31@0(leader).paxosservice(pgmap) propose_pending
2013-04-01 14:54:37.433641 7ffff328d700  5 mon.cs31@0(leader).paxos(paxos active c 1..27) queue_proposal bl 10629660 bytes; ctx = 0x11ece50
2013-04-01 14:54:37.433750 7ffff328d700  5 mon.cs31@0(leader).paxos(paxos preparing update c 1..27) propose_queued 28 10629660 bytes
2013-04-01 14:54:37.433755 7ffff328d700 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..27) propose_queued list_proposals 1 in queue:
2013-04-01 14:55:38.684532 7ffff328d700 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..27) begin for 28 10629660 bytes
2013-04-01 14:55:38.814528 7ffff328d700 10 mon.cs31@0(leader).paxos(paxos updating c 1..27) commit 28
2013-04-01 14:55:38.937087 7ffff328d700 10 mon.cs31@0(leader).paxos(paxos active c 1..28) finish_queued_proposal finishing proposal
2013-04-01 14:55:38.937120 7ffff328d700 10 mon.cs31@0(leader).paxos(paxos active c 1..28) finish_queued_proposal finish it (proposal = 0x1c6e3c0)
2013-04-01 14:55:38.937124 7ffff328d700 10 mon.cs31@0(leader).paxos(paxos active c 1..28) finish_queued_proposal proposal took 61.503375 to finish
2013-04-01 14:55:38.937168 7ffff328d700 10 mon.cs31@0(leader).paxosservice(pgmap) _active

It looks like finish_queued_proposal processing time is scaling
quadratically with the proposal length for pgmaps.

FWIW, I don't believe I saw any issues of this sort for
versions 0.58 and earlier.

Please let me know if there is any other information I can
provide that will help to help fix this.

Thanks -- Jim

