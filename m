From: Gregory Farnum <greg@inktank.com>
Subject: Re: Object Write Latency
Date: Fri, 20 Sep 2013 07:47:58 -0700
Message-ID: <CAPYLRziY9YVXp+zW8dS9+dN-r24AXXG84wx0ZgQFtpX2C1Pnfg@mail.gmail.com>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63642 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab3ITOr7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Sep 2013 10:47:59 -0400
Received: by mail-wi0-f174.google.com with SMTP id hj3so9610873wib.7
        for <ceph-devel@vger.kernel.org>; Fri, 20 Sep 2013 07:47:58 -0700 (PDT)
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Sep 20, 2013 at 5:27 AM, Andreas Joachim Peters
<Andreas.Joachim.Peters@cern.ch> wrote:
> Hi,
>
>
> we made some benchmarks about object read/write latencies on the CERN ceph installation.
>
> The cluster has 44 nodes and ~1k disks, all on 10GE and the pool configuration has 3 copies.
> Client & Server is 0.67.
>
> The latencies we observe (using tiny objects ... 5 bytes) on the idle pool:

Does that mean you have non-idle pools in the same cluster? Unless
you've got physical separation, the fact that the pool is idle doesn't
mean much unless the cluster is as well. (Though if you're getting 60
object writes/hard drive/second I think it probably is idle.)

> write full object(sync) ~65-80ms
> append to object ~60-75ms
> set xattr object ~65-80ms
> lock object ~65-80ms
> stat object ~1ms

Anecdotally those write times look a little high to me, but my
expectations are probably set for 2x and I'm not sure how much
difference that makes (I would expect not much, but maybe there's
something happening I haven't considered).


> We seem to saturate the pools writing ~ 20k objects/s (= internally 60k/s).
>
> Is there an easy explanation for 80 ms (quasi without payload) and a possible tuning to reduce that?
> I measured (append few bytes +fsync) on such a disk around 33ms which explains probably part of the latency.
Ah, and that's also higher than I would normally expect for a disk
access, so that's probably why the above numbers seem a little large.
Separately, what's your journal config? Does each spindle have a
partition? This math all works out to about what I'd expect if so.

> Then I tried with the async API to see if there is a difference in the measurement between wait_for_complete or wait_for_safe ... shouldn't wait_for_complete be much shorter, but I get always comparable results ...

You're presumably on xfs? With non-btrfs FSes, the OSDs have to use
write-ahead journaling so they always commit the op to disk before
applying to the local FS.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
