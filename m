From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 18 Feb 2011 10:04:49 -0700
Message-ID: <1298048689.25491.187.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102172312550.26016@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:49124 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229Ab1BRRFH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 12:05:07 -0500
In-Reply-To: <Pine.LNX.4.64.1102172312550.26016@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Fri, 2011-02-18 at 00:13 -0700, Sage Weil wrote:
> On Thu, 17 Feb 2011, Jim Schutt wrote:
> > Check out the result:
> >
> > osd.68.log:256027:2011-02-17 15:44:50.141378 7fd42ad57940 osd68 5 tick
> > osd.68.log:256028:2011-02-17 15:44:50.141464 7fd42ad57940 osd68 5 tick getting read lock on map_lock
> > osd.68.log:256029:2011-02-17 15:44:50.141472 7fd42ad57940 osd68 5 tick got read lock on map_lock
> > osd.68.log:256031:2011-02-17 15:44:50.141612 7fd42ad57940 osd68 5 tick sending mon report
> > osd.68.log:256032:2011-02-17 15:44:50.141619 7fd42ad57940 osd68 5 tick removing stray pgs
> > osd.68.log:256033:2011-02-17 15:44:50.141626 7fd42ad57940 osd68 5 tick sending log to logclient
> > osd.68.log:256034:2011-02-17 15:44:50.141633 7fd42ad57940 osd68 5 tick arming timer for next tick     <==
> > osd.68.log:256277:2011-02-17 15:45:18.481656 7fd42ad57940 osd68 5 tick checking dispatch queue status <== 28 second gap
> > osd.68.log:256278:2011-02-17 15:45:18.481669 7fd42ad57940 osd68 5 tick done
> > osd.68.log:256279:2011-02-17 15:45:18.481691 7fd42ad57940 osd68 5 tick
> > osd.68.log:256280:2011-02-17 15:45:18.481705 7fd42ad57940 osd68 5 tick getting read lock on map_lock
> > osd.68.log:256281:2011-02-17 15:45:18.481712 7fd42ad57940 osd68 5 tick got read lock on map_lock
> > osd.68.log:256688:2011-02-17 15:45:20.010705 7fd42ad57940 osd68 5 tick sending mon report
> > osd.68.log:256753:2011-02-17 15:45:20.012950 7fd42ad57940 osd68 5 tick removing stray pgs
> > osd.68.log:256754:2011-02-17 15:45:20.012959 7fd42ad57940 osd68 5 tick sending log to logclient
> > osd.68.log:256755:2011-02-17 15:45:20.012965 7fd42ad57940 osd68 5 tick arming timer for next tick
> > osd.68.log:256756:2011-02-17 15:45:20.012976 7fd42ad57940 osd68 5 tick checking dispatch queue status
> > osd.68.log:256757:2011-02-17 15:45:20.012993 7fd42ad57940 osd68 5 tick done
> >
> > Why should it take 28 seconds to add a new timer event?
> 
> Huh.. that is pretty weird.  I see multiple sync in there, too, so it's
> not like something was somehow blocking on a btrfs commit.
> 
> Anybody else have ideas?  :/

So I thought I'd add debug timer = 20 to the [osd] section 
in my config.  Rebuilding my filesystem resulted in this:

importing contents of /tmp/keyring.mds.an15 into /tmp/monkeyring.10158
creating /tmp/keyring.osd.0
cauthtool: ./common/Mutex.h:118: void Mutex::Lock(bool): Assertion `r == 0' failed.
*** Caught signal (Aborted) ***
in thread 7f6e8f29f6f0
 ceph version 0.24.3 (commit:97d65f2cbca2046fa9a014fcdff1628641d43fd8)
 1: (ceph::BackTrace::BackTrace(int)+0x2a) [0x45cd8c]
 2: /usr/bin/cauthtool [0x466a9d]
 3: /lib64/libpthread.so.0 [0x7f6e8ee93b10]
 4: (gsignal()+0x35) [0x7f6e8dcfe265]
 5: (abort()+0x110) [0x7f6e8dcffd10]
 6: (__assert_fail()+0xf6) [0x7f6e8dcf76e6]
 7: (Mutex::Lock(bool)+0x88) [0x45b5e6]
 8: /usr/bin/cauthtool [0x45ba1e]
 9: (operator<<(std::ostream&, _dbeginl_t)+0x11) [0x45c733]
 a: (SafeTimer::shutdown()+0x2a) [0x484d6e]
 b: /usr/bin/cauthtool [0x480a0b]
 c: (FlusherStopper::~FlusherStopper()+0x11) [0x48322d]
 d: /usr/bin/cauthtool [0x480a2e]
 e: (exit()+0xe5) [0x7f6e8dd013a5]
 f: (__libc_start_main()+0xfb) [0x7f6e8dceb99b]
 10: (__gxx_personality_v0()+0x2d1) [0x44ce09]

I guess I'll rebuild it without timer debugging, then
start it with timer debugging, and see what happens.

-- Jim

> 
> sage
> 


