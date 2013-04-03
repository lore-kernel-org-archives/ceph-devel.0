From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Trouble getting a new file system to start, for v0.59 and newer
Date: Wed, 3 Apr 2013 09:46:12 -0600
Message-ID: <515C4EC4.5040602@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:37730 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758296Ab3DCPqr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 11:46:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Joao,

I alluded in an earlier thread about an issue I've been recently
having with starting a new filesystem, which I thought I had
tracked into the paxos subsystem.  I believe I started having
this trouble when I started testing v0.59, and it's still there
in v0.60.

The basic configuration is 1 mon, 1 mds, 576 OSDs.  Some time
after starting the mon and the OSDs, PG creation progress stops.

I'm finding this in my OSD logs, which I've been thinking is
suggestive of why OSDs stop making progress:

# cat osd.0.log | grep "acked PGStats"
2013-04-02 15:40:28.944178 7ffff387a700  1 osd.0 2 mon hasn't acked PGStats in 30.034349 seconds, reconnecting elsewhere
2013-04-02 15:42:24.570963 7ffff387a700  1 osd.0 14 mon hasn't acked PGStats in 30.072959 seconds, reconnecting elsewhere
2013-04-02 15:43:22.664921 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.570739 seconds, reconnecting elsewhere
2013-04-02 15:43:52.672461 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.007379 seconds, reconnecting elsewhere
2013-04-02 15:44:22.680691 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.007095 seconds, reconnecting elsewhere
2013-04-02 15:44:52.688936 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.007221 seconds, reconnecting elsewhere
2013-04-02 15:45:22.702066 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.012264 seconds, reconnecting elsewhere
2013-04-02 15:45:52.711134 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.007957 seconds, reconnecting elsewhere
2013-04-02 15:46:22.719845 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.007859 seconds, reconnecting elsewhere
2013-04-02 15:46:52.729475 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.008756 seconds, reconnecting elsewhere


I also thought paxos might be implicated because I noticed the auth
paxos service appears to stop making progress.  The mon is getting
lots of auth paxos service messages from all the OSDs:

# cat mon.cs31.log  | grep paxos | grep "dispatch auth" | head -1
2013-04-02 15:38:59.995457 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(auth) dispatch auth(proto 0 30 bytes epoch 1) v1 from client.? 172.17.131.29:0/52585

# cat mon.cs31.log  | grep paxos | grep "dispatch auth" | wc -l 
8802

but at some point the auth paxos service appears to stop making progress:

# cat mon.cs31.log  | grep paxos | grep -v "dispatch auth" | grep auth
2013-04-02 15:38:42.895202 7ffff7fbe780 10 mon.cs31@0(probing).paxosservice(auth) restart
2013-04-02 15:38:42.905705 7ffff7fbe780 10 mon.cs31@0(probing).paxosservice(auth) restart
2013-04-02 15:38:59.182158 7ffff7fbe780 10 mon.cs31@0(probing).paxosservice(auth) restart
2013-04-02 15:38:59.192809 7ffff7fbe780 10 mon.cs31@0(probing).paxosservice(auth) restart
2013-04-02 15:38:59.290602 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(auth) election_finished
2013-04-02 15:38:59.290608 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(auth) _active
2013-04-02 15:38:59.300707 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(auth) scrub
2013-04-02 15:38:59.308260 7ffff7fbe780  7 mon.cs31@0(leader).paxosservice(auth) _active creating new pending
2013-04-02 15:38:59.329153 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(auth) propose_pending
2013-04-02 15:38:59.390988 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(auth) _active
2013-04-02 15:38:59.421164 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(auth) scrub
2013-04-02 15:38:59.427781 7ffff7fbe780  7 mon.cs31@0(leader).paxosservice(auth) _active creating new pending
2013-04-02 15:38:59.448001 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(auth) election_finished
2013-04-02 15:38:59.448027 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(auth) _active
2013-04-02 15:38:59.453691 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(auth) scrub
2013-04-02 15:38:59.459446 7ffff7fbe780  7 mon.cs31@0(leader).paxosservice(auth) _active creating new pending
2013-04-02 15:38:59.500315 7ffff328d700 10 mon.cs31@0(leader).paxosservice(auth) propose_pending
2013-04-02 15:38:59.569638 7ffff328d700 10 mon.cs31@0(leader).paxosservice(auth) _active
2013-04-02 15:38:59.593526 7ffff328d700 10 mon.cs31@0(leader).paxosservice(auth) scrub
2013-04-02 15:38:59.599250 7ffff328d700  7 mon.cs31@0(leader).paxosservice(auth) _active creating new pending
2013-04-02 15:39:39.390156 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(auth) propose_pending
2013-04-02 15:39:39.435906 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(auth) _active
2013-04-02 15:39:39.456743 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(auth) scrub
2013-04-02 15:39:39.462498 7ffff2a8c700  7 mon.cs31@0(leader).paxosservice(auth) _active creating new pending

even as it continues to receive auth paxos service messages:

# cat mon.cs31.log  | grep paxos | grep -A 200000 "15:39:39.462498" | grep "dispatch auth" | wc -l
8799

for some time:

# cat mon.cs31.log  | grep paxos | grep "dispatch auth" | tail -2
2013-04-02 15:46:56.090494 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(auth) dispatch auth(proto 0 28 bytes epoch 1) v1 from osd.379 172.17.131.47:6819/219107
2013-04-02 15:46:56.127352 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(auth) dispatch auth(proto 0 28 bytes epoch 1) v1 from osd.311 172.17.131.44:6823/184079

Is that all expected behavior for the auth paxos service?  

To try to learn more about PGStat messages not getting acked, I caused
Pipe:writer() and Pipe:reader() to log messages at a lower log level as
they are sent and received, so I could see that vs. dispatch
at debug ms 2.  Here's what the mon thinks is OSD 0's PGStat interaction:

# cat mon.cs31.log | grep "172.17.131.32:6800" | grep stats'
2013-04-02 15:39:58.923546 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x12a1400 sd=20 :6789 s=2 pgs=1 cs=1 l=1).reader got message 13 0x82ca800 pg_stats(2139 pgs tid 1 v 2) v1
2013-04-02 15:40:03.927889 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x12a1400 sd=20 :6789 s=2 pgs=1 cs=1 l=1).reader got message 15 0x88f5280 pg_stats(2139 pgs tid 2 v 2) v1
2013-04-02 15:40:08.936064 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x12a1400 sd=20 :6789 s=2 pgs=1 cs=1 l=1).reader got message 17 0x88f5000 pg_stats(2139 pgs tid 3 v 2) v1
2013-04-02 15:40:13.943312 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x12a1400 sd=20 :6789 s=2 pgs=1 cs=1 l=1).reader got message 19 0x8e35780 pg_stats(2139 pgs tid 4 v 2) v1
2013-04-02 15:40:18.949530 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x12a1400 sd=20 :6789 s=2 pgs=1 cs=1 l=1).reader got message 21 0x8e35500 pg_stats(2139 pgs tid 5 v 2) v1
2013-04-02 15:40:23.953961 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x12a1400 sd=20 :6789 s=2 pgs=1 cs=1 l=1).reader got message 23 0x8e35280 pg_stats(2139 pgs tid 6 v 2) v1
2013-04-02 15:40:42.812586 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 5 0x9178500 pg_stats(2139 pgs tid 7 v 2) v1
2013-04-02 15:40:42.824276 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 7 0x9178a00 pg_stats(2139 pgs tid 8 v 2) v1
2013-04-02 15:40:42.833998 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 9 0x9178780 pg_stats(2139 pgs tid 9 v 3) v1
2013-04-02 15:40:42.839129 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 10 0x917d000 pg_stats(2139 pgs tid 10 v 3) v1
2013-04-02 15:40:43.289351 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 5 ==== pg_stats(2139 pgs tid 7 v 2) v1 ==== 780831+0+0 (3242785419 0 0) 0x9178500 con 0x8ef77a0
2013-04-02 15:40:43.289361 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(2139 pgs tid 7 v 2) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:40:44.346624 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 11 0x9178f00 pg_stats(2139 pgs tid 11 v 3) v1
2013-04-02 15:40:49.347796 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 12 0x9178c80 pg_stats(2139 pgs tid 12 v 3) v1
2013-04-02 15:40:50.974070 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(2139 pgs tid 7) v1 -- ?+0 0x94efc40 con 0x8ef77a0
2013-04-02 15:40:50.975214 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 9 0x94efc40pg_stats_ack(2139 pgs tid 7) v1
2013-04-02 15:40:52.148791 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 7 ==== pg_stats(2139 pgs tid 8 v 2) v1 ==== 780831+0+0 (767410827 0 0) 0x9178a00 con 0x8ef77a0
2013-04-02 15:40:52.148798 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(2139 pgs tid 8 v 2) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:40:52.184327 7ffff2a8c700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(2139 pgs tid 0) v1 -- ?+0 0x95101c0 con 0x8ef77a0
2013-04-02 15:40:52.184887 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 12 0x95101c0pg_stats_ack(2139 pgs tid 0) v1
2013-04-02 15:40:54.355489 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 13 0x917d500 pg_stats(2139 pgs tid 13 v 3) v1
2013-04-02 15:40:59.366894 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 15 0x12a1400 pg_stats(2139 pgs tid 14 v 3) v1
2013-04-02 15:41:04.369893 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 16 0x88f5000 pg_stats(2139 pgs tid 15 v 3) v1
2013-04-02 15:41:09.383145 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 17 0x8572580 pg_stats(2139 pgs tid 16 v 3) v1
2013-04-02 15:41:10.331005 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 9 ==== pg_stats(2139 pgs tid 9 v 3) v1 ==== 780831+0+0 (2102719063 0 0) 0x9178780 con 0x8ef77a0
2013-04-02 15:41:10.331015 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(2139 pgs tid 9 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:14.386773 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 18 0x917df00 pg_stats(2139 pgs tid 17 v 3) v1
2013-04-02 15:41:18.238008 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(2139 pgs tid 9) v1 -- ?+0 0x887db00 con 0x8ef77a0
2013-04-02 15:41:18.239168 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 15 0x887db00pg_stats_ack(2139 pgs tid 9) v1
2013-04-02 15:41:19.393287 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 19 0x917dc80 pg_stats(1688 pgs tid 18 v 3) v1
2013-04-02 15:41:24.402543 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 20 0x917da00 pg_stats(1688 pgs tid 19 v 3) v1
2013-04-02 15:41:29.409268 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 22 0x917d780 pg_stats(1688 pgs tid 20 v 3) v1
2013-04-02 15:41:32.417687 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 10 ==== pg_stats(2139 pgs tid 10 v 3) v1 ==== 780831+0+0 (1002730769 0 0) 0x917d000 con 0x8ef77a0
2013-04-02 15:41:32.417694 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(2139 pgs tid 10 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:34.412255 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 24 0x9178500 pg_stats(1688 pgs tid 21 v 3) v1
2013-04-02 15:41:39.515106 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(2139 pgs tid 10) v1 -- ?+0 0x8bdaf40 con 0x8ef77a0
2013-04-02 15:41:39.516862 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 16 0x8bdaf40pg_stats_ack(2139 pgs tid 10) v1
2013-04-02 15:41:41.428677 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 27 0x7436400 pg_stats(1956 pgs tid 22 v 4) v1
2013-04-02 15:41:46.433146 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 29 0x7436180 pg_stats(1956 pgs tid 23 v 4) v1
2013-04-02 15:41:51.436995 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 31 0x7435f00 pg_stats(1956 pgs tid 24 v 4) v1
2013-04-02 15:41:53.051925 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 11 ==== pg_stats(2139 pgs tid 11 v 3) v1 ==== 780831+0+0 (676901400 0 0) 0x9178f00 con 0x8ef77a0
2013-04-02 15:41:53.051937 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(2139 pgs tid 11 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.102194 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 12 ==== pg_stats(2139 pgs tid 12 v 3) v1 ==== 780831+0+0 (998884584 0 0) 0x9178c80 con 0x8ef77a0
2013-04-02 15:41:53.102201 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(2139 pgs tid 12 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.154485 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 13 ==== pg_stats(2139 pgs tid 13 v 3) v1 ==== 780831+0+0 (1067499060 0 0) 0x917d500 con 0x8ef77a0
2013-04-02 15:41:53.154492 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(2139 pgs tid 13 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.177214 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 15 ==== pg_stats(2139 pgs tid 14 v 3) v1 ==== 780831+0+0 (2843573366 0 0) 0x12a1400 con 0x8ef77a0
2013-04-02 15:41:53.177220 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(2139 pgs tid 14 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.183387 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 16 ==== pg_stats(2139 pgs tid 15 v 3) v1 ==== 780831+0+0 (886357047 0 0) 0x88f5000 con 0x8ef77a0
2013-04-02 15:41:53.183393 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(2139 pgs tid 15 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.188461 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 17 ==== pg_stats(2139 pgs tid 16 v 3) v1 ==== 780831+0+0 (4068350826 0 0) 0x8572580 con 0x8ef77a0
2013-04-02 15:41:53.188467 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(2139 pgs tid 16 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.191039 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 18 ==== pg_stats(2139 pgs tid 17 v 3) v1 ==== 780831+0+0 (3808505220 0 0) 0x917df00 con 0x8ef77a0
2013-04-02 15:41:53.191044 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(2139 pgs tid 17 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.195468 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 19 ==== pg_stats(1688 pgs tid 18 v 3) v1 ==== 616216+0+0 (786716567 0 0) 0x917dc80 con 0x8ef77a0
2013-04-02 15:41:53.195474 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(1688 pgs tid 18 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.197490 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 20 ==== pg_stats(1688 pgs tid 19 v 3) v1 ==== 616216+0+0 (1691256403 0 0) 0x917da00 con 0x8ef77a0
2013-04-02 15:41:53.197495 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(1688 pgs tid 19 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.203550 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 22 ==== pg_stats(1688 pgs tid 20 v 3) v1 ==== 616216+0+0 (2465465593 0 0) 0x917d780 con 0x8ef77a0
2013-04-02 15:41:53.203556 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(1688 pgs tid 20 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.205756 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 24 ==== pg_stats(1688 pgs tid 21 v 3) v1 ==== 616216+0+0 (4004343678 0 0) 0x9178500 con 0x8ef77a0
2013-04-02 15:41:53.205762 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(1688 pgs tid 21 v 3) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.208096 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 27 ==== pg_stats(1956 pgs tid 22 v 4) v1 ==== 716960+0+0 (2541888992 0 0) 0x7436400 con 0x8ef77a0
2013-04-02 15:41:53.208102 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(1956 pgs tid 22 v 4) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.210496 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 29 ==== pg_stats(1956 pgs tid 23 v 4) v1 ==== 716960+0+0 (3133069244 0 0) 0x7436180 con 0x8ef77a0
2013-04-02 15:41:53.210502 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(1956 pgs tid 23 v 4) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:53.212759 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 31 ==== pg_stats(1956 pgs tid 24 v 4) v1 ==== 716960+0+0 (584283437 0 0) 0x7435f00 con 0x8ef77a0
2013-04-02 15:41:53.212764 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(1956 pgs tid 24 v 4) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:41:54.480038 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(2139 pgs tid 11) v1 -- ?+0 0x95ab800 con 0x8ef77a0
2013-04-02 15:41:54.480618 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(2139 pgs tid 12) v1 -- ?+0 0x9554b40 con 0x8ef77a0
2013-04-02 15:41:54.481098 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 32 0x95ab800pg_stats_ack(2139 pgs tid 11) v1
2013-04-02 15:41:54.481564 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(2139 pgs tid 13) v1 -- ?+0 0x95539c0 con 0x8ef77a0
2013-04-02 15:41:54.482128 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 33 0x9554b40pg_stats_ack(2139 pgs tid 12) v1
2013-04-02 15:41:54.483234 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 34 0x95539c0pg_stats_ack(2139 pgs tid 13) v1
2013-04-02 15:41:54.484486 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(2139 pgs tid 14) v1 -- ?+0 0x883f000 con 0x8ef77a0
2013-04-02 15:41:54.485222 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(2139 pgs tid 15) v1 -- ?+0 0x883e3c0 con 0x8ef77a0
2013-04-02 15:41:54.485378 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 35 0x883f000pg_stats_ack(2139 pgs tid 14) v1
2013-04-02 15:41:54.486164 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(2139 pgs tid 16) v1 -- ?+0 0x8bdbb80 con 0x8ef77a0
2013-04-02 15:41:54.486358 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 36 0x883e3c0pg_stats_ack(2139 pgs tid 15) v1
2013-04-02 15:41:54.487053 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(2139 pgs tid 17) v1 -- ?+0 0x8bdb480 con 0x8ef77a0
2013-04-02 15:41:54.487436 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 37 0x8bdbb80pg_stats_ack(2139 pgs tid 16) v1
2013-04-02 15:41:54.488260 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(1688 pgs tid 18) v1 -- ?+0 0x8bdd400 con 0x8ef77a0
2013-04-02 15:41:54.488398 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 38 0x8bdb480pg_stats_ack(2139 pgs tid 17) v1
2013-04-02 15:41:54.489004 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(1688 pgs tid 19) v1 -- ?+0 0x8bdd080 con 0x8ef77a0
2013-04-02 15:41:54.489306 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 39 0x8bdd400pg_stats_ack(1688 pgs tid 18) v1
2013-04-02 15:41:54.489996 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(1688 pgs tid 20) v1 -- ?+0 0x88601c0 con 0x8ef77a0
2013-04-02 15:41:54.490083 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 40 0x8bdd080pg_stats_ack(1688 pgs tid 19) v1
2013-04-02 15:41:54.490442 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(1688 pgs tid 21) v1 -- ?+0 0x8865e80 con 0x8ef77a0
2013-04-02 15:41:54.490837 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 41 0x88601c0pg_stats_ack(1688 pgs tid 20) v1
2013-04-02 15:41:54.491416 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(1956 pgs tid 22) v1 -- ?+0 0x8bddb00 con 0x8ef77a0
2013-04-02 15:41:54.491807 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 42 0x8865e80pg_stats_ack(1688 pgs tid 21) v1
2013-04-02 15:41:54.492195 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(1956 pgs tid 23) v1 -- ?+0 0x8bde900 con 0x8ef77a0
2013-04-02 15:41:54.492728 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 43 0x8bddb00pg_stats_ack(1956 pgs tid 22) v1
2013-04-02 15:41:54.493313 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(1956 pgs tid 24) v1 -- ?+0 0x8bde580 con 0x8ef77a0
2013-04-02 15:41:54.493707 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 44 0x8bde900pg_stats_ack(1956 pgs tid 23) v1
2013-04-02 15:41:54.494585 7ffff1a8a700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).writer sending message 45 0x8bde580pg_stats_ack(1956 pgs tid 24) v1
2013-04-02 15:42:00.522781 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 36 0x7435c80 pg_stats(108 pgs tid 25 v 7) v1
2013-04-02 15:42:05.525728 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 38 0x7435a00 pg_stats(108 pgs tid 26 v 7) v1
2013-04-02 15:42:10.530772 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 39 0x7435780 pg_stats(108 pgs tid 27 v 8) v1
2013-04-02 15:42:15.565118 7fffa94ed700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917fa80 sd=596 :6789 s=2 pgs=2 cs=1 l=1).reader got message 42 0x1fa52080 pg_stats(108 pgs tid 28 v 11) v1
2013-04-02 15:42:33.891896 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 4 0x1fa52080 pg_stats(108 pgs tid 30 v 14) v1
2013-04-02 15:42:33.892425 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 5 0x7435780 pg_stats(108 pgs tid 31 v 14) v1
2013-04-02 15:42:33.893026 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 9 0x1fb1fa80 pg_stats(108 pgs tid 32 v 16) v1
2013-04-02 15:42:34.574255 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 11 0x1fb1fd00 pg_stats(108 pgs tid 33 v 16) v1
2013-04-02 15:42:39.575512 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 12 0x1b4aaf80 pg_stats(108 pgs tid 34 v 16) v1
2013-04-02 15:42:48.310568 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 4 ==== pg_stats(108 pgs tid 30 v 14) v1 ==== 40520+0+0 (2643097968 0 0) 0x1fa52080 con 0x8519760
2013-04-02 15:42:48.310576 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(108 pgs tid 30 v 14) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:42:48.589731 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(108 pgs tid 30) v1 -- ?+0 0x8863d40 con 0x8519760
2013-04-02 15:42:48.589885 7fffa8659700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).writer sending message 5 0x8863d40pg_stats_ack(108 pgs tid 30) v1
2013-04-02 15:42:50.439778 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 5 ==== pg_stats(108 pgs tid 31 v 14) v1 ==== 40520+0+0 (3699058855 0 0) 0x7435780 con 0x8519760
2013-04-02 15:42:50.439786 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(108 pgs tid 31 v 14) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:42:50.439869 7ffff2a8c700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(108 pgs tid 0) v1 -- ?+0 0xc26abc0 con 0x8519760
2013-04-02 15:42:50.439926 7fffa8659700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).writer sending message 6 0xc26abc0pg_stats_ack(108 pgs tid 0) v1
2013-04-02 15:42:50.442425 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 14 0x2dc3c00 pg_stats(108 pgs tid 35 v 17) v1
2013-04-02 15:42:50.540570 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 15 0x154a8780 pg_stats(108 pgs tid 36 v 18) v1
2013-04-02 15:42:51.087764 7ffff2a8c700  1 -- 172.17.131.31:6789/0 <== osd.0 172.17.131.32:6800/217031 9 ==== pg_stats(108 pgs tid 32 v 16) v1 ==== 40520+0+0 (3609079067 0 0) 0x1fb1fa80 con 0x8519760
2013-04-02 15:42:51.087770 7ffff2a8c700 10 mon.cs31@0(leader).paxosservice(pgmap) dispatch pg_stats(108 pgs tid 32 v 16) v1 from osd.0 172.17.131.32:6800/217031
2013-04-02 15:42:52.092802 7ffff328d700  1 -- 172.17.131.31:6789/0 --> 172.17.131.32:6800/217031 -- pg_stats_ack(108 pgs tid 32) v1 -- ?+0 0x1c62db00 con 0x8519760
2013-04-02 15:42:52.092869 7fffa8659700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).writer sending message 13 0x1c62db00pg_stats_ack(108 pgs tid 32) v1
2013-04-02 15:42:54.594268 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 19 0x154a8280 pg_stats(108 pgs tid 37 v 20) v1
2013-04-02 15:43:22.177993 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 20 0x154a8000 pg_stats(108 pgs tid 38 v 20) v1
2013-04-02 15:43:22.304697 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 22 0x88f6400 pg_stats(108 pgs tid 39 v 20) v1
2013-04-02 15:43:22.354425 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 23 0x181b9400 pg_stats(108 pgs tid 40 v 20) v1
2013-04-02 15:43:22.417111 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 25 0xb42d780 pg_stats(108 pgs tid 41 v 20) v1
2013-04-02 15:43:22.454599 7fffa91ea700  2 -- 172.17.131.31:6789/0 >> 172.17.131.32:6800/217031 pipe(0x917eb80 sd=6 :6789 s=2 pgs=3 cs=1 l=1).reader got message 26 0xb42f300 pg_stats(108 pgs tid 42 v 20) v1

Here is OSD 0's idea of its PGStat interaction with the mon:

# cat osd.0.log | grep -i stats
2013-04-02 15:39:58.909877 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 1 v 2) v1 -- ?+0 0x1748500 con 0x16098c0
2013-04-02 15:39:58.918630 7ffff7fba700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748000 sd=27 :45108 s=2 pgs=8 cs=1 l=1).writer sending message 13 0x1748500pg_stats(2139 pgs tid 1 v 2) v1
2013-04-02 15:40:03.915544 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 2 v 2) v1 -- ?+0 0x1748780 con 0x16098c0
2013-04-02 15:40:03.922304 7ffff7fba700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748000 sd=27 :45108 s=2 pgs=8 cs=1 l=1).writer sending message 15 0x1748780pg_stats(2139 pgs tid 2 v 2) v1
2013-04-02 15:40:08.920874 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 3 v 2) v1 -- ?+0 0x1748500 con 0x16098c0
2013-04-02 15:40:08.929491 7ffff7fba700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748000 sd=27 :45108 s=2 pgs=8 cs=1 l=1).writer sending message 17 0x1748500pg_stats(2139 pgs tid 3 v 2) v1
2013-04-02 15:40:13.928781 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 4 v 2) v1 -- ?+0 0x1748a00 con 0x16098c0
2013-04-02 15:40:13.937503 7ffff7fba700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748000 sd=27 :45108 s=2 pgs=8 cs=1 l=1).writer sending message 19 0x1748a00pg_stats(2139 pgs tid 4 v 2) v1
2013-04-02 15:40:18.936302 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 5 v 2) v1 -- ?+0 0x1748780 con 0x16098c0
2013-04-02 15:40:18.944744 7ffff7fba700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748000 sd=27 :45108 s=2 pgs=8 cs=1 l=1).writer sending message 21 0x1748780pg_stats(2139 pgs tid 5 v 2) v1
2013-04-02 15:40:23.941554 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 6 v 2) v1 -- ?+0 0x1748500 con 0x16098c0
2013-04-02 15:40:23.949853 7ffff7fba700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748000 sd=27 :45108 s=2 pgs=8 cs=1 l=1).writer sending message 23 0x1748500pg_stats(2139 pgs tid 6 v 2) v1
2013-04-02 15:40:28.944178 7ffff387a700  1 osd.0 2 mon hasn't acked PGStats in 30.034349 seconds, reconnecting elsewhere
2013-04-02 15:40:42.798689 7fffe485c700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 7 v 2) v1 -- ?+0 0x1748a00 con 0x1609e40
2013-04-02 15:40:42.798728 7fffe485c700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 8 v 2) v1 -- ?+0 0x1748000 con 0x1609e40
2013-04-02 15:40:42.798813 7fffe485c700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 9 v 3) v1 -- ?+0 0x1748500 con 0x1609e40
2013-04-02 15:40:42.798833 7fffe485c700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 10 v 3) v1 -- ?+0 0x1748780 con 0x1609e40
2013-04-02 15:40:42.804039 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 5 0x1748a00pg_stats(2139 pgs tid 7 v 2) v1
2013-04-02 15:40:42.815140 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 7 0x1748000pg_stats(2139 pgs tid 8 v 2) v1
2013-04-02 15:40:42.825539 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 9 0x1748500pg_stats(2139 pgs tid 9 v 3) v1
2013-04-02 15:40:42.833093 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 10 0x1748780pg_stats(2139 pgs tid 10 v 3) v1
2013-04-02 15:40:44.332101 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 11 v 3) v1 -- ?+0 0x1749180 con 0x1609e40
2013-04-02 15:40:44.340297 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 11 0x1749180pg_stats(2139 pgs tid 11 v 3) v1
2013-04-02 15:40:49.338071 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 12 v 3) v1 -- ?+0 0x1748a00 con 0x1609e40
2013-04-02 15:40:49.342361 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 12 0x1748a00pg_stats(2139 pgs tid 12 v 3) v1
2013-04-02 15:40:50.977357 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 9 0x164fe00 pg_stats_ack(2139 pgs tid 7) v1
2013-04-02 15:40:50.977597 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 9 ==== pg_stats_ack(2139 pgs tid 7) v1 ==== 62035+0+0 (726597769 0 0) 0x164fe00 con 0x1609e40
2013-04-02 15:40:52.187136 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 12 0x164f380 pg_stats_ack(2139 pgs tid 0) v1
2013-04-02 15:40:52.187290 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 12 ==== pg_stats_ack(2139 pgs tid 0) v1 ==== 62035+0+0 (726597769 0 0) 0x164f380 con 0x1609e40
2013-04-02 15:40:54.344074 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 13 v 3) v1 -- ?+0 0x1748000 con 0x1609e40
2013-04-02 15:40:54.348415 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 13 0x1748000pg_stats(2139 pgs tid 13 v 3) v1
2013-04-02 15:40:59.351607 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 14 v 3) v1 -- ?+0 0x1748500 con 0x1609e40
2013-04-02 15:40:59.359988 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 15 0x1748500pg_stats(2139 pgs tid 14 v 3) v1
2013-04-02 15:41:04.359122 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 15 v 3) v1 -- ?+0 0x1748780 con 0x1609e40
2013-04-02 15:41:04.364092 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 16 0x1748780pg_stats(2139 pgs tid 15 v 3) v1
2013-04-02 15:41:09.366106 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 16 v 3) v1 -- ?+0 0x1749400 con 0x1609e40
2013-04-02 15:41:09.374543 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 17 0x1749400pg_stats(2139 pgs tid 16 v 3) v1
2013-04-02 15:41:14.371889 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(2139 pgs tid 17 v 3) v1 -- ?+0 0x1748a00 con 0x1609e40
2013-04-02 15:41:14.380211 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 18 0x1748a00pg_stats(2139 pgs tid 17 v 3) v1
2013-04-02 15:41:18.240897 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 15 0x164fe00 pg_stats_ack(2139 pgs tid 9) v1
2013-04-02 15:41:18.241056 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 15 ==== pg_stats_ack(2139 pgs tid 9) v1 ==== 62035+0+0 (198780535 0 0) 0x164fe00 con 0x1609e40
2013-04-02 15:41:19.380719 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(1688 pgs tid 18 v 3) v1 -- ?+0 0x1749180 con 0x1609e40
2013-04-02 15:41:19.387148 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 19 0x1749180pg_stats(1688 pgs tid 18 v 3) v1
2013-04-02 15:41:24.389573 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(1688 pgs tid 19 v 3) v1 -- ?+0 0x1748780 con 0x1609e40
2013-04-02 15:41:24.396022 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 20 0x1748780pg_stats(1688 pgs tid 19 v 3) v1
2013-04-02 15:41:29.396986 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(1688 pgs tid 20 v 3) v1 -- ?+0 0x1748500 con 0x1609e40
2013-04-02 15:41:29.403403 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 22 0x1748500pg_stats(1688 pgs tid 20 v 3) v1
2013-04-02 15:41:34.401630 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(1688 pgs tid 21 v 3) v1 -- ?+0 0x1748000 con 0x1609e40
2013-04-02 15:41:34.407929 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 24 0x1748000pg_stats(1688 pgs tid 21 v 3) v1
2013-04-02 15:41:39.519241 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 16 0x164d5c0 pg_stats_ack(2139 pgs tid 10) v1
2013-04-02 15:41:39.519384 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 16 ==== pg_stats_ack(2139 pgs tid 10) v1 ==== 62035+0+0 (162752886 0 0) 0x164d5c0 con 0x1609e40
2013-04-02 15:41:41.416252 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(1956 pgs tid 22 v 4) v1 -- ?+0 0x174be80 con 0x1609e40
2013-04-02 15:41:41.423974 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 27 0x174be80pg_stats(1956 pgs tid 22 v 4) v1
2013-04-02 15:41:46.421537 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(1956 pgs tid 23 v 4) v1 -- ?+0 0x174bc00 con 0x1609e40
2013-04-02 15:41:46.429102 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 29 0x174bc00pg_stats(1956 pgs tid 23 v 4) v1
2013-04-02 15:41:51.425198 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(1956 pgs tid 24 v 4) v1 -- ?+0 0x174b980 con 0x1609e40
2013-04-02 15:41:51.433005 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 31 0x174b980pg_stats(1956 pgs tid 24 v 4) v1
2013-04-02 15:41:54.483344 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 32 0x4732bc0 pg_stats_ack(2139 pgs tid 11) v1
2013-04-02 15:41:54.483470 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 32 ==== pg_stats_ack(2139 pgs tid 11) v1 ==== 62035+0+0 (162752886 0 0) 0x4732bc0 con 0x1609e40
2013-04-02 15:41:54.484667 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 33 0x4732680 pg_stats_ack(2139 pgs tid 12) v1
2013-04-02 15:41:54.484796 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 33 ==== pg_stats_ack(2139 pgs tid 12) v1 ==== 62035+0+0 (162752886 0 0) 0x4732680 con 0x1609e40
2013-04-02 15:41:54.485954 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 34 0x4732840 pg_stats_ack(2139 pgs tid 13) v1
2013-04-02 15:41:54.486291 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 34 ==== pg_stats_ack(2139 pgs tid 13) v1 ==== 62035+0+0 (162752886 0 0) 0x4732840 con 0x1609e40
2013-04-02 15:41:54.487671 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 35 0x4736040 pg_stats_ack(2139 pgs tid 14) v1
2013-04-02 15:41:54.487791 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 35 ==== pg_stats_ack(2139 pgs tid 14) v1 ==== 62035+0+0 (162752886 0 0) 0x4736040 con 0x1609e40
2013-04-02 15:41:54.488818 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 36 0x4b34440 pg_stats_ack(2139 pgs tid 15) v1
2013-04-02 15:41:54.489018 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 36 ==== pg_stats_ack(2139 pgs tid 15) v1 ==== 62035+0+0 (162752886 0 0) 0x4b34440 con 0x1609e40
2013-04-02 15:41:54.490044 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 37 0x164fa80 pg_stats_ack(2139 pgs tid 16) v1
2013-04-02 15:41:54.490173 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 37 ==== pg_stats_ack(2139 pgs tid 16) v1 ==== 62035+0+0 (162752886 0 0) 0x164fa80 con 0x1609e40
2013-04-02 15:41:54.491252 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 38 0x164f700 pg_stats_ack(2139 pgs tid 17) v1
2013-04-02 15:41:54.491376 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 38 ==== pg_stats_ack(2139 pgs tid 17) v1 ==== 62035+0+0 (162752886 0 0) 0x164f700 con 0x1609e40
2013-04-02 15:41:54.492139 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 39 0x4b34d00 pg_stats_ack(1688 pgs tid 18) v1
2013-04-02 15:41:54.492427 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 39 ==== pg_stats_ack(1688 pgs tid 18) v1 ==== 48956+0+0 (1148031672 0 0) 0x4b34d00 con 0x1609e40
2013-04-02 15:41:54.493228 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 40 0x3e63f00 pg_stats_ack(1688 pgs tid 19) v1
2013-04-02 15:41:54.493359 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 40 ==== pg_stats_ack(1688 pgs tid 19) v1 ==== 48956+0+0 (1148031672 0 0) 0x3e63f00 con 0x1609e40
2013-04-02 15:41:54.494104 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 41 0x3e63b80 pg_stats_ack(1688 pgs tid 20) v1
2013-04-02 15:41:54.494228 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 41 ==== pg_stats_ack(1688 pgs tid 20) v1 ==== 48956+0+0 (1148031672 0 0) 0x3e63b80 con 0x1609e40
2013-04-02 15:41:54.494914 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 42 0x3e640c0 pg_stats_ack(1688 pgs tid 21) v1
2013-04-02 15:41:54.494979 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 42 ==== pg_stats_ack(1688 pgs tid 21) v1 ==== 48956+0+0 (1148031672 0 0) 0x3e640c0 con 0x1609e40
2013-04-02 15:41:54.495941 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 43 0x17f5400 pg_stats_ack(1956 pgs tid 22) v1
2013-04-02 15:41:54.496066 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 43 ==== pg_stats_ack(1956 pgs tid 22) v1 ==== 56728+0+0 (217165409 0 0) 0x17f5400 con 0x1609e40
2013-04-02 15:41:54.496825 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 44 0x183fa80 pg_stats_ack(1956 pgs tid 23) v1
2013-04-02 15:41:54.496945 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 44 ==== pg_stats_ack(1956 pgs tid 23) v1 ==== 56728+0+0 (217165409 0 0) 0x183fa80 con 0x1609e40
2013-04-02 15:41:54.497867 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).reader got message 45 0x1839a40 pg_stats_ack(1956 pgs tid 24) v1
2013-04-02 15:41:54.497983 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 45 ==== pg_stats_ack(1956 pgs tid 24) v1 ==== 56728+0+0 (217165409 0 0) 0x1839a40 con 0x1609e40
2013-04-02 15:42:00.522449 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 25 v 7) v1 -- ?+0 0x4031b80 con 0x1609e40
2013-04-02 15:42:00.523046 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 36 0x4031b80pg_stats(108 pgs tid 25 v 7) v1
2013-04-02 15:42:05.525433 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 26 v 7) v1 -- ?+0 0x4031900 con 0x1609e40
2013-04-02 15:42:05.526040 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 38 0x4031900pg_stats(108 pgs tid 26 v 7) v1
2013-04-02 15:42:10.530320 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 27 v 8) v1 -- ?+0 0x4031680 con 0x1609e40
2013-04-02 15:42:10.530987 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 39 0x4031680pg_stats(108 pgs tid 27 v 8) v1
2013-04-02 15:42:15.564684 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 28 v 11) v1 -- ?+0 0x4031400 con 0x1609e40
2013-04-02 15:42:15.565270 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 42 0x4031400pg_stats(108 pgs tid 28 v 11) v1
2013-04-02 15:42:20.568779 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 29 v 13) v1 -- ?+0 0x5861180 con 0x1609e40
2013-04-02 15:42:20.569360 7fffcce2c700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x1748c80 sd=24 :45195 s=2 pgs=1394 cs=1 l=1).writer sending message 45 0x5861180pg_stats(108 pgs tid 29 v 13) v1
2013-04-02 15:42:24.570963 7ffff387a700  1 osd.0 14 mon hasn't acked PGStats in 30.072959 seconds, reconnecting elsewhere
2013-04-02 15:42:33.891060 7fffe485c700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 30 v 14) v1 -- ?+0 0x6794380 con 0x5819e40
2013-04-02 15:42:33.891072 7fffe485c700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 31 v 14) v1 -- ?+0 0x4031680 con 0x5819e40
2013-04-02 15:42:33.891149 7fffe485c700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 32 v 16) v1 -- ?+0 0x6793e80 con 0x5819e40
2013-04-02 15:42:33.891808 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 4 0x6794380pg_stats(108 pgs tid 30 v 14) v1
2013-04-02 15:42:33.892402 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 5 0x4031680pg_stats(108 pgs tid 31 v 14) v1
2013-04-02 15:42:33.893054 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 9 0x6793e80pg_stats(108 pgs tid 32 v 16) v1
2013-04-02 15:42:34.573582 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 33 v 16) v1 -- ?+0 0x6793700 con 0x5819e40
2013-04-02 15:42:34.574136 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 11 0x6793700pg_stats(108 pgs tid 33 v 16) v1
2013-04-02 15:42:39.575223 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 34 v 16) v1 -- ?+0 0x6792d00 con 0x5819e40
2013-04-02 15:42:39.575817 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 12 0x6792d00pg_stats(108 pgs tid 34 v 16) v1
2013-04-02 15:42:44.576975 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 35 v 17) v1 -- ?+0 0x6795f00 con 0x5819e40
2013-04-02 15:42:44.577611 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 14 0x6795f00pg_stats(108 pgs tid 35 v 17) v1
2013-04-02 15:42:48.591071 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).reader got message 5 0x443d080 pg_stats_ack(108 pgs tid 30) v1
2013-04-02 15:42:48.591184 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 5 ==== pg_stats_ack(108 pgs tid 30) v1 ==== 3136+0+0 (3131392639 0 0) 0x443d080 con 0x5819e40
2013-04-02 15:42:49.577888 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 36 v 18) v1 -- ?+0 0x6795c80 con 0x5819e40
2013-04-02 15:42:49.578479 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 15 0x6795c80pg_stats(108 pgs tid 36 v 18) v1
2013-04-02 15:42:50.441073 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).reader got message 6 0x1823480 pg_stats_ack(108 pgs tid 0) v1
2013-04-02 15:42:50.441140 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 6 ==== pg_stats_ack(108 pgs tid 0) v1 ==== 3136+0+0 (3131392639 0 0) 0x1823480 con 0x5819e40
2013-04-02 15:42:52.094048 7fffcd82e700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).reader got message 13 0x6cbec80 pg_stats_ack(108 pgs tid 32) v1
2013-04-02 15:42:52.094159 7fffe485c700  1 -- 172.17.131.32:6800/217031 <== mon.0 172.17.131.31:6789/0 13 ==== pg_stats_ack(108 pgs tid 32) v1 ==== 3136+0+0 (3721100430 0 0) 0x6cbec80 con 0x5819e40
2013-04-02 15:42:54.594067 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 37 v 20) v1 -- ?+0 0x6797580 con 0x5819e40
2013-04-02 15:42:54.594729 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 19 0x6797580pg_stats(108 pgs tid 37 v 20) v1
2013-04-02 15:42:59.658795 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 38 v 20) v1 -- ?+0 0x174a300 con 0x5819e40
2013-04-02 15:42:59.659279 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 20 0x174a300pg_stats(108 pgs tid 38 v 20) v1
2013-04-02 15:43:04.660446 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 39 v 20) v1 -- ?+0 0x6793200 con 0x5819e40
2013-04-02 15:43:04.660952 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 22 0x6793200pg_stats(108 pgs tid 39 v 20) v1
2013-04-02 15:43:09.661467 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 40 v 20) v1 -- ?+0 0x6792a80 con 0x5819e40
2013-04-02 15:43:09.661950 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 23 0x6792a80pg_stats(108 pgs tid 40 v 20) v1
2013-04-02 15:43:14.662762 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 41 v 20) v1 -- ?+0 0x6792300 con 0x5819e40
2013-04-02 15:43:14.663314 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 25 0x6792300pg_stats(108 pgs tid 41 v 20) v1
2013-04-02 15:43:19.664054 7ffff387a700  1 -- 172.17.131.32:6800/217031 --> 172.17.131.31:6789/0 -- pg_stats(108 pgs tid 42 v 20) v1 -- ?+0 0x6791b80 con 0x5819e40
2013-04-02 15:43:19.664776 7fff9bc1f700  2 -- 172.17.131.32:6800/217031 >> 172.17.131.31:6789/0 pipe(0x5862800 sd=27 :47851 s=2 pgs=1425 cs=1 l=1).writer sending message 26 0x6791b80pg_stats(108 pgs tid 42 v 20) v1
2013-04-02 15:43:22.664921 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.570739 seconds, reconnecting elsewhere
2013-04-02 15:43:52.672461 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.007379 seconds, reconnecting elsewhere
2013-04-02 15:44:22.680691 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.007095 seconds, reconnecting elsewhere
2013-04-02 15:44:52.688936 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.007221 seconds, reconnecting elsewhere
2013-04-02 15:45:22.702066 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.012264 seconds, reconnecting elsewhere
2013-04-02 15:45:52.711134 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.007957 seconds, reconnecting elsewhere
2013-04-02 15:46:22.719845 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.007859 seconds, reconnecting elsewhere
2013-04-02 15:46:52.729475 7ffff387a700  1 osd.0 20 mon hasn't acked PGStats in 30.008756 seconds, reconnecting elsewhere

Why would OSD 0 stop trying to send PGStats to the mon?

Maybe the above is all normal behavior, so any thoughts on what I
should be looking for instead are greatly appreciated.

On the bright side, this issue is completely reproducible for me,
and I'll be happy to test anything you think might help sort it out.

-- Jim

