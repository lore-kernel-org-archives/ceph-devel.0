From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: long object names
Date: Thu, 21 Apr 2011 12:27:01 -0700
Message-ID: <BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
	<20110421185606.GC9431@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56919 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab1DUT1D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 15:27:03 -0400
Received: by fxm17 with SMTP id 17so36118fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2011 12:27:01 -0700 (PDT)
In-Reply-To: <20110421185606.GC9431@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Thu, Apr 21, 2011 at 11:56 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> I also think that Ceph, and especially the RGW bits, needs to be
> written to be fairly robust against DoS attacks. Nasty things happen
> out there, and having somebody able to trigger a "slow mode" on your
> server with fairly cheap operations is bad.

Yeah.

> Here's a concrete proposal: split the filename into subdirs if needed,
> and map the names 1:1, just to avoid the unpredictability of the above
> approach. And to get significantly less code and branching in the fast
> path. That is, I think I'd go for something like (Python written in C
> style to make it more direct to translate):

I like this idea a lot. It does involve extra expense, but only for
long file names. It also avoids object name collisions completely.

One additional idea: can we make the chunking configurable?
If we did a translation like this:
abcdefg -> abc/def/g
123456789 -> 123/456/789

prefix search would become a *lot* more efficient for rgw.
On the other hand, the filesystem layer doesn't care about prefix
search, so it could just configure the chunking to be after 200
characters or something (at which point it's basically a no-op.)

cheers,
Colin
