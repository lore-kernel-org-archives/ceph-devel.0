From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: CephFS mount delay
Date: Thu, 30 Aug 2012 13:24:14 -0700
Message-ID: <CAPrxi58oZZ25BmcftEz+TgnHy70dPsHhivuFtXd6KkkF7NG8LQ@mail.gmail.com>
References: <CAPrxi5_g2Nfa4AHAUkCx4LRybtDfKqwQuAH7ziVizmgq5oTJwg@mail.gmail.com>
	<alpine.DEB.2.00.1208301233260.8588@cobra.newdream.net>
	<CAPrxi59tZRzv4KG=_U375Vqg7tb5h3nLe6za0L0_B17V5mGw=w@mail.gmail.com>
	<CAPYLRzhh4390wjuZkEuEqs0=3SBX729kEou5NkqmVbBaJWG_rQ@mail.gmail.com>
	<CAPrxi5_G1cQ9XK9dnOP0Sgda_PYNQmj9TyqdO7D+Y7TXoYvuOQ@mail.gmail.com>
	<alpine.DEB.2.00.1208301314370.8588@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48372 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab2H3UYP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 16:24:15 -0400
Received: by iahk25 with SMTP id k25so84847iah.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 13:24:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208301314370.8588@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Here ya go:

https://dl.dropbox.com/u/7899675/client.log
https://dl.dropbox.com/u/7899675/mds.a.log
https://dl.dropbox.com/u/7899675/mds.b.log
https://dl.dropbox.com/u/7899675/mds.c.log

- Noah

On Thu, Aug 30, 2012 at 1:15 PM, Sage Weil <sage@inktank.com> wrote:
> I see that Server::handle_client_session is calling mdlog->flush(), so
> it's a bit odd.  Can you generate a log with 'debug ms = 1' on the client
> (and maybe mds) side?
>
> s
>
> On Thu, 30 Aug 2012, Noah Watkins wrote:
>
>> On Thu, Aug 30, 2012 at 1:06 PM, Gregory Farnum <greg@inktank.com> wrote:
>> > On Thu, Aug 30, 2012 at 12:55 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> >> Using a tick interval of 1 drops the cost down to 3 seconds, but still
>> >> a long time for running many unit tests that use fresh mounts.
>> >
>> > Are you using ceph-fuse or the kernel client? And how many of each daemon type?
>>
>> I'm using the C api, and there are 3 mon, 3 mds, 1 osd.
>>
>> > That said; I'm seeing broadly similar numbers ? with one of each
>> > daemon (but otherwise the vstart defaults) "time sudo ceph-fuse mnt"
>> > reports 3.1 seconds.
>>
>>
