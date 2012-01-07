From: Mark Kampe <mark.kampe@dreamhost.com>
Subject: Re: towards a user-mode diagnostic log mechanism
Date: Fri, 06 Jan 2012 17:46:32 -0800
Message-ID: <4F07A3F8.8000407@dreamhost.com>
References: <4EEFF614.8040207@dreamhost.com> <CA+qbEUNvLL0pui+XOr5W2m6dmBCxg8d4ZobrAnXV=wTQ=7YCFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:52323 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759224Ab2AGBqc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2012 20:46:32 -0500
In-Reply-To: <CA+qbEUNvLL0pui+XOr5W2m6dmBCxg8d4ZobrAnXV=wTQ=7YCFw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

On 01/05/12 20:09, Colin McCabe wrote:

> Getting the system time is a surprisingly expensive operation, and
> this poses a problem for logging system designers.  You can use the
> rdtsc CPU instruction, but unfortunately on some architectures CPU
> frequency scaling makes it very inaccurate.  Even when it is accurate,
> it's not synchronized between multiple CPUs.
>
> Another option is to without time for most messages and just have a
> periodic timestamp that gets injected every so often-- perhaps every
> second, for example.

I agree it needs to be cheap ... but my experience with
debugging problems in this sort of system suggests that
we need the finest grained timestamps we can get
(on every single message).

Even though the clocks on different nodes are not that
closely synchronized, computing the relative offsets
from initial transactions isn't hard ... and then it
becomes possible to construct a total ordering of
events with accurate timings.

> Pantheios and log4cpp are two potential candidates.  I don't know that
> much about either, unfortunately.

Good suggestions.  I am also looking at varnish (suggested by Wido
den Hollander) which does logging in a shared memory segment from
which external processes can save it (or not).  What was (for me)
a new idea here is the clean decoupling of in-memory event capture
from on-disk persistence and log rotation.  After I thought about
it for a few minutes, I concluded it had many nice consequences.

> Honestly, I feel like logging is something that you will end up
> customizing pretty extensively to suit the needs of your application.
> But perhaps it's worth checking out what these libraries provide--
> especially in terms of efficiency.

I agree that the data captured is going to be something we hone
based on experience.  I am (for now) most concerned with the
mechanism ... because I don't want to start making big investments
in instrumentation until we have a good mechanism, around which
we can fix the APIs that instrumentation will use.

I'll try to review the suggested candidates and describe the
mechanisms and advantages of each in another two weeks.

Thank you very much for the feedback.
