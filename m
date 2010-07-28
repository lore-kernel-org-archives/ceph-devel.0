From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: mds crash on snaptest-2
Date: Wed, 28 Jul 2010 07:03:39 +0200
Message-ID: <4C4FBA2B.9010202@chaschperli.ch>
References: <i21p5k$fma$2@dough.gmane.org>	<AANLkTinxy56sN1K39-1z0AtcYWBI0ndPZQnlZzgaG0xx@mail.gmail.com>	<i2m8g9$53k$2@dough.gmane.org>	<AANLkTimrW=DquX_Pyi8M7wb_GWV1DJr6w28LTOC9RkfD@mail.gmail.com>	<4C4F3876.3030306@chaschperli.ch> <AANLkTinM5e1024M+rg9GBym-MsdQ0qmh++Ywa-pcWOZ-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trillian.muellerit.ch ([83.169.22.129]:59209 "EHLO
	trillian.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab0G1FDs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jul 2010 01:03:48 -0400
In-Reply-To: <AANLkTinM5e1024M+rg9GBym-MsdQ0qmh++Ywa-pcWOZ-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

On 27.07.2010 21:54, Gregory Farnum wrote:
> On Tue, Jul 27, 2010 at 12:50 PM, Thomas Mueller<thomas@chaschperli.ch>  wrote:
>> i'm  always starting just one daemon. my test script sets these vars before
>> calling "vstart.sh":
>>
>> export CEPH_NUM_MON=1
>> export CEPH_NUM_OSD=1
>> export CEPH_NUM_MDS=1
>>
>> last known good rev was  ae82dd5a5c964bb310a5512d10d1e062cbb0c1a5 on July 8
>> - with this rev the test was working fine.
>>
>> i've also tried to compile with "-O0" to run it with gdb (not that i'm a gdb
>> expert..) - but the binaries failed to start (ok back then it was bit late
>> ...)
> Huh. Can you double check that you have the latest code? Specifically,
> it needs to include commit e2b1a4ee119a68b403582ae3bc15b54e9458b9b5.
> I've run your test a number of times under cfuse and haven't gotten
> any single-MDS crashes or hangs with that.
>
> Are you running it under the kclient or cfuse?


today the test passed - thank you!

before i updated for todays testrun - the mentioned ref was the last 
commit in my yesterdays tests:
$ git log -1
commit e2b1a4ee119a68b403582ae3bc15b54e9458b9b5
Author: Greg Farnum <gregf@hq.newdream.net>
Date:   Mon Jul 26 16:43:16 2010 -0700

     mds: Use get_oldest_snap() (not first) in handle_client_lssnap.


i'm running kclient unstable-backport with "merge origin/master" (ref 
0938669c180056f517db836f05697f8a2c41ec61), vanilla kernel 2.6.34.1



- Thomas
