From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph rbd crashes/stalls while random write 4k blocks
Date: Thu, 24 May 2012 16:09:03 +0200
Message-ID: <4FBE40FF.1040304@profihost.ag>
References: <4FBE167A.9060505@profihost.ag> <CAPUexz8MxynjO9m=TFpAiVtE9OCGWQfL615XU9yYFksHhNKTeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35914 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257Ab2EXOIu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 10:08:50 -0400
In-Reply-To: <CAPUexz8MxynjO9m=TFpAiVtE9OCGWQfL615XU9yYFksHhNKTeA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 24.05.2012 14:12, schrieb Florian Haas:
> Stefan,
> sorry I'm coming a bit late to the various threads you've posted
> recently, but on this particular issue: what kernel are your OSDs
> running on, and do these hung tasks occur if you're using a local
> filesystem other than XFS?

OSDs run 3.0.30 but i tried 3.3.7 too - no difference (regarding XFS
crash and random writes).

Just tried btrfs with 3.4 kernel and the posted patch from yesterday.

But with kernel 3.4 the performance is in general pretty low doesn't
matter if i use xfs or btrfs:

~# rados -p data bench 10 write -t 16
Maintaining 16 concurrent writes of 4194304 bytes for at least 10 seconds.
  sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
    0       0         0         0         0         0         -         0
    1      16        35        19   75.9824        76  0.294869  0.376607
    2      16        51        35   69.9844        64  0.103118  0.345375
    3      16        72        56    74.652        84  0.113909    0.5364
    4      16        88        72   71.9866        64  0.641818  0.786378
    5      16        95        79   63.1887        28  0.131084  0.737699
    6      16       113        97   64.6553        72  0.232688  0.851319
    7      16       129       113   64.5604        64   0.35199  0.822971
    8      16       148       132   65.9888        76   0.09892  0.739852
    9      16       149       133   59.1007         4  0.833541  0.740556
   10      16       157       141   56.3899        32  0.101306  0.715187
   11      16       157       141   51.2634         0         -  0.715187
   12      16       157       141   46.9914         0         -  0.715187
   13      16       157       141   43.3766         0         -  0.715187
   14      16       157       141   40.2782         0         -  0.715187
   15      16       157       141    37.593         0         -  0.715187
   16      16       157       141   35.2434         0         -  0.715187
Total time run:        16.471636
Total writes made:     158
Write size:            4194304
Bandwidth (MB/sec):    38.369

Average Latency:       1.66534
Max latency:           13.554
Min latency:           0.095194

> As of late XFS has occasionally been producing seemingly random kernel
> hangs. Your call trace doesn't have the signature entries from xfssyncd
> that identify a particular problem that I've been struggling with
> lately, but you just might be affected by some other effect of the same
> root issue.
>
> Take a look at these to see if anything looks familiar:
>
> http://oss.sgi.com/bugzilla/show_bug.cgi?id=922
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/979498
> http://oss.sgi.com/archives/xfs/2011-11/msg00400.html

These are solved by using 3.0.20.

Stefan



