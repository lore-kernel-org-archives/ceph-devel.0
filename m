From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: mds crash on snaptest-2
Date: Tue, 27 Jul 2010 11:59:47 -0700
Message-ID: <AANLkTimrW=DquX_Pyi8M7wb_GWV1DJr6w28LTOC9RkfD@mail.gmail.com>
References: <i21p5k$fma$2@dough.gmane.org>
	<AANLkTinxy56sN1K39-1z0AtcYWBI0ndPZQnlZzgaG0xx@mail.gmail.com>
	<i2m8g9$53k$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42546 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab0G0S7s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jul 2010 14:59:48 -0400
Received: by fxm14 with SMTP id 14so847411fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jul 2010 11:59:47 -0700 (PDT)
In-Reply-To: <i2m8g9$53k$2@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Tue, Jul 27, 2010 at 2:22 AM, Thomas Mueller <thomas@chaschperli.ch> wrote:
> Am Mon, 19 Jul 2010 14:16:14 -0700 schrieb Gregory Farnum:
>
>> Can you turn on debugging and verify for me that it's crashing on
>> "assert(p->second.first <= snapid && snapid <= p->first); "
>> CInode::encode_inodestat:1617?
>> I've hit this assert trying to reproduce your issue using cfuse and I
>> think this is it, but I'm hitting some ext3 bugs in my kernel on a
>> fairly regular basis while trying to reproduce, so a fix will need to
>> wait until I've upgraded (tomorrow). :) Thanks!
>> -Greg
>
> hi greg
>
> the test still fails with ceph.git/unstable from today. now cmds doesn't
> exit anymore. But after a half an hour the test kills itself because of a
> timeout (normal running time is about 10 minutes).
>
> - Thomas
>
> PS: found out that vstart.sh places logs in subdir "out" too. so tell me
> if you need some of them.
Yes, I've been working on this for some time now. If you try the test
on a single MDS it should work fine with the latest git, but there are
some deeper issues going on with an MDS cluster that we're having a
hard time isolating in a way that lets us fix it. It appears we might
need to rework our snapshot inode handling a bit and Sage has asked me
to move on.

I'd recommend doing your testing on a single MDS (if using vstart:
CEPH_NUM_MDS=1 ./vstart -- this also works for _OSD and _MON) system
until we say that we expect the MDS cluster to work under more
circumstances.
