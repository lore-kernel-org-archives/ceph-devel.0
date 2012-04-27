From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Release/branch naming; input requested
Date: Fri, 27 Apr 2012 09:19:46 -0600
Message-ID: <4F9AB912.904@sandia.gov>
References: <CAORUGqBxO=n_7xkDEFr_gi=y=+7abo0mErYSDOwVTq+zaA_cTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:34232 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760494Ab2D0PUR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Apr 2012 11:20:17 -0400
In-Reply-To: <CAORUGqBxO=n_7xkDEFr_gi=y=+7abo0mErYSDOwVTq+zaA_cTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/26/2012 06:09 PM, Tommi Virtanen wrote:
> Now, here are my actual questions:
>
> 1. What should the "relative" names of the branches be? "stable" vs
> "latest" etc. I especially don't like "integration", but I do see a
> time where it is not ready for "stable" but still needs to branch off
> of "latest".
>
> 2. Do we want to use cutesy codenames? Alphabetical? Based on what theme?
>
> 3. Do we want to use calendar based names? "I'm using Ceph branch
> 2012.04"? (Or spell it 2012-04 to avoid confusing with 0.41 style
> versions?)
>
> 3. What do we do with version numbers? With a 2-3 week iteration,
> we'll end up with something like 0.41.x, 0.56.x for Folsom integration
> (less than a year from now), and 0.57, 0.58 etc for "latest".
>
> 4. What will be worthy of 1.0? Is it when the distributed file system
> is solid? Getting out of 0.x would help with separating the different
> branches based on major numbers, but I fear that window has closed
> already.
>
>
> Your input is welcome.

FWIW, I think the current Linux kernel versioning scheme should be
considered.  In particular I like that for the most part new features
don't get back-ported to stable series kernels; if you want new
features you need to upgrade.

If you haven't seen it, https://lkml.org/lkml/2012/4/11/779
has a good discussion of issues the kernel versioning attempts
to address.

I think names are cute but essentially useless - what I want
from an identification scheme is to tell at a glance that
"a" is likely to be better than "b".  Numeric "a" and "b" where
a > b does that for me; names don't.

Also FWIW, don't get hung up on 1.0.  Instead, borrow again from
kernel experience - what is needed is careful selection of the
versions that get long-term support.

If you haven't seen it, https://lkml.org/lkml/2011/8/15/5
has a good discussion of longterm kernel support.

-- Jim

