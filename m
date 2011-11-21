From: Mark Kampe <mark.kampe@dreamhost.com>
Subject: The costs of logging and not logging
Date: Mon, 21 Nov 2011 08:29:55 -0800
Message-ID: <4ECA7C83.1090702@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:33639 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab1KUQ3z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Nov 2011 11:29:55 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 227B9C066
	for <ceph-devel@vger.kernel.org>; Mon, 21 Nov 2011 08:38:32 -0800 (PST)
Received: from [192.168.107.232] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 1C3ACC064
	for <ceph-devel@vger.kernel.org>; Mon, 21 Nov 2011 08:38:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The bugs we most dread are situations that only happen rarely,
and are only detected long after the damage has been done.
Given the business we are in, we will face many of them.
We apparently have such bugs open at this very moment.

In most cases, the primary debugging tools one has are
audit and diagnostic logs ... which WE do not have because
they are too expensive (because they are synchronously
written with C++ streams) to leave enabled all the time.

I think it is a mistake to think of audit and diagnostic
logs as a tool to be turned on when we have a problem to
debug.  There should be a basic level of logging that is
always enabled (so we will have data after the first
instance of the bug) ... which can be cranked up from
verbose to bombastic when we find a problem that won't
yield to more moderate interrogation:

  (a) after the problem happens is too late to
      start collecting data.

  (b) these logs are gold mines of information for
      a myriad of purposes we cannot yet even imagine.

This can only be done if the logging mechanism is
sufficiently inexpensive that we are not afraid to
use it:
     low execution artifact from the logging operations
     reansonable memory costs for bufferring
     small enough on disk that we can keep them for months

Not having such a mechanism is (if I correctly
understand) already hurting us for internal debugging,
and will quickly cripple us when we have customer
(i.e. people who cannot diagnose problems for
themselves) problems to debug.

There are many tricks to make logging cheap, and the
sizes acceptable.  There are probably a dozen open-source
implementations that already do what we need, and if they
don't something basic can be built in a two-digit number
of hours.  The real cost is not in the mechanism but in
adapting existing code to use it.  This cost can be
mitigated by making the changes opportunistically ...
one component at a time, as dictated by need/fear.

But we cannot make that change-over until we have a
mechanism.  Because the greatest cost is not the
mechanism, but the change-over, we should give more
than passing thought to what mechanism to choose ...
so that the decision we make remains a good one for
the next few years.

This may be something that we need to do sooner,
rather than later.

regards,
    ---mark---
