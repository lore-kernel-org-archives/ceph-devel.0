From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: mds crash on snaptest-2
Date: Tue, 27 Jul 2010 21:50:14 +0200
Message-ID: <4C4F3876.3030306@chaschperli.ch>
References: <i21p5k$fma$2@dough.gmane.org>	<AANLkTinxy56sN1K39-1z0AtcYWBI0ndPZQnlZzgaG0xx@mail.gmail.com>	<i2m8g9$53k$2@dough.gmane.org> <AANLkTimrW=DquX_Pyi8M7wb_GWV1DJr6w28LTOC9RkfD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trillian.muellerit.ch ([83.169.22.129]:35509 "EHLO
	trillian.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab0G0TuX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jul 2010 15:50:23 -0400
In-Reply-To: <AANLkTimrW=DquX_Pyi8M7wb_GWV1DJr6w28LTOC9RkfD@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org


>> the test still fails with ceph.git/unstable from today. now cmds doesn't
>> exit anymore. But after a half an hour the test kills itself because of a
>> timeout (normal running time is about 10 minutes).
>>
>> - Thomas
>>
>> PS: found out that vstart.sh places logs in subdir "out" too. so tell me
>> if you need some of them.
> Yes, I've been working on this for some time now. If you try the test
> on a single MDS it should work fine with the latest git, but there are
> some deeper issues going on with an MDS cluster that we're having a
> hard time isolating in a way that lets us fix it. It appears we might
> need to rework our snapshot inode handling a bit and Sage has asked me
> to move on.
>
> I'd recommend doing your testing on a single MDS (if using vstart:
> CEPH_NUM_MDS=1 ./vstart -- this also works for _OSD and _MON) system
> until we say that we expect the MDS cluster to work under more
> circumstances.

i'm  always starting just one daemon. my test script sets these vars 
before calling "vstart.sh":

export CEPH_NUM_MON=1
export CEPH_NUM_OSD=1
export CEPH_NUM_MDS=1

last known good rev was  ae82dd5a5c964bb310a5512d10d1e062cbb0c1a5 on 
July 8 - with this rev the test was working fine.

i've also tried to compile with "-O0" to run it with gdb (not that i'm a 
gdb expert..) - but the binaries failed to start (ok back then it was 
bit late ...)

- Thomas
