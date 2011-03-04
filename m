From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: monitor dispatch queue seems backed up?
Date: Fri, 4 Mar 2011 13:45:59 -0700
Message-ID: <1299271559.4750.202.camel@sale659.sandia.gov>
References: <1299258853.4750.191.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103041137050.25280@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:47395 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760155Ab1CDUqI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2011 15:46:08 -0500
In-Reply-To: <Pine.LNX.4.64.1103041137050.25280@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Fri, 2011-03-04 at 12:48 -0700, Sage Weil wrote:
> > Hi,
> > 
> > I'm continuing my testing of the master branch
> > (commit 1ed2d8c587) against 96 osds.
> > 
> > I'm having trouble getting a new filesystem to
> > start up.  FWIW this size filesystem starts up
> > in a minute or two at most under the stable branch.
> 
> The main thing that's changed since then is the default number of PGs has 
> gone up.  Can you try changing the osd_pg_bits to 6 in common/config.cc, 
> rebuild, and re-mkcephfs, and see if that gives you behavior similar to 
> stable?  (mkcephfs isn't currently letting you adjust that yet.)

Sure, I'll give that a try.

> 
> I suspect this is just a problem with the size of the various pg map<>s on 
> the monitor (they're O(log n) for most operations).

I'm also trying to understand why my OSDs each 
need a couple dozen (!!) attempts before they
successfully connect to the monitor.  I'm in
the process of adding some extra diagnostics to
try to understand that.

Here's an OSD trying to connect:

# grep "mon0 172.17.40.34:6789/0" osd.0.log
2011-03-04 13:26:10.305195 7f379ce6f6f0 -- 0.0.0.0:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x2882e00
2011-03-04 13:26:13.305439 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x2882e00
2011-03-04 13:26:16.306263 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0009c0
2011-03-04 13:26:19.306693 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0009c0
2011-03-04 13:26:22.307165 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0009c0
2011-03-04 13:26:25.307613 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0008c0
2011-03-04 13:26:28.308048 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0008c0
2011-03-04 13:26:31.308626 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0008c0
2011-03-04 13:26:34.309116 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0008c0
2011-03-04 13:26:37.309551 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0008c0
2011-03-04 13:26:40.310086 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0018e0
2011-03-04 13:26:43.310503 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c000be0
2011-03-04 13:26:46.311607 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c000be0
2011-03-04 13:26:49.312136 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c001280
2011-03-04 13:26:52.312534 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0008c0
2011-03-04 13:26:55.336440 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0008c0
2011-03-04 13:26:58.336978 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0008c0
2011-03-04 13:27:01.337520 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c000be0
2011-03-04 13:27:04.337945 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c000be0
2011-03-04 13:27:07.338422 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c000be0
2011-03-04 13:27:10.338834 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0015c0
2011-03-04 13:27:13.339393 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0008c0
2011-03-04 13:27:16.339835 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c000be0
2011-03-04 13:27:19.340282 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0013e0
2011-03-04 13:27:22.340709 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0013e0
2011-03-04 13:27:25.341182 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c001990
2011-03-04 13:27:28.341811 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c000be0
2011-03-04 13:27:31.342372 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c000be0
2011-03-04 13:27:34.342988 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c000be0
2011-03-04 13:27:37.343417 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0008c0
2011-03-04 13:27:40.343966 7f3791685940 -- 172.17.40.21:6800/15577 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0x7f378c0008c0
2011-03-04 13:27:42.319377 7f3792e88940 -- 172.17.40.21:6800/15577 <== mon0 172.17.40.34:6789/0 1 ==== auth_reply(proto 1 0 Success) v1 ==== 24+0+0 (2593404908 0 0) 0x28835d0 con 0x7f378c0010e0

And here's the monitor ignoring it:

# grep 172.17.40.21:6800/15577 mon.an14.log | grep "read tag"
2011-03-04 13:26:13.301708 7f139b32f940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=1 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:16.302376 7f139b32f940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=2 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:19.303064 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=3 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:22.303488 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=4 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:25.303905 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=5 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:28.304367 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=6 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:31.304902 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=7 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:34.305400 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=8 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:37.305907 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=9 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:40.306360 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=10 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:43.306810 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=11 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:46.307858 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=12 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:49.308389 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=13 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:52.308881 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=14 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:55.309297 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x2bf1510 sd=10 pgs=15 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:26:58.333247 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x382e3c0 sd=88 pgs=16 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:01.333766 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x382e3c0 sd=88 pgs=17 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:04.334205 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x382e3c0 sd=88 pgs=18 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:07.334666 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x382e300 sd=88 pgs=19 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:10.335170 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x382e300 sd=88 pgs=20 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:13.335651 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x382e300 sd=88 pgs=21 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:16.336085 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x382e300 sd=87 pgs=22 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:19.336573 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x31a5150 sd=87 pgs=23 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:22.336946 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x31a5150 sd=87 pgs=24 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:25.337460 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x31a5150 sd=87 pgs=25 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:28.338088 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x31a5150 sd=86 pgs=26 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:31.338575 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x31a5150 sd=86 pgs=27 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:34.339265 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x7f1397686430 sd=86 pgs=28 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:37.339681 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x7f1397686430 sd=86 pgs=29 cs=1 l=1).reader couldn't read tag, Success
2011-03-04 13:27:40.340234 7f1392ded940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6800/15577 pipe(0x7f1397686430 sd=86 pgs=30 cs=1 l=1).reader couldn't read tag, Success

That doesn't seem right to me, and the 3 second intervals
here seem awfully suspicious, but so far I haven't been
able to catch the socket code in the act of misbehaving.

During this time the monitor is trying to send pg updates, 
but can't because it has no one to talk to - none of the
OSDs has connected.

-- Jim

> 
> Thanks!
> sage
> 
> 


