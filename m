From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Very bad behavior when
Date: Tue, 4 Dec 2012 21:46:11 +0100
Message-ID: <CAF6-1L4rh8Bw9cPGEXY=j8_Wv9-bmjp3uhE8KUR9LBsNYu+P2w@mail.gmail.com>
References: <CAF6-1L5WSukXaDfy64wxUuuHDdhZ3G3AW_=fkjiVLzbm_g-rng@mail.gmail.com>
	<D988AE88A2484A23AA62CF8112AA9B7A@inktank.com>
	<CAF6-1L5WZaqVNpcnuSMQJC0-KMB8xgzJA_O21gG=+EhULFdsQg@mail.gmail.com>
	<CAPYLRzh0Fu5DjjAh1RuYY70iM=pfqekCp9qOoJSRCWgoQ+XnZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65470 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab2LDUqN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 15:46:13 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4417189oag.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Dec 2012 12:46:12 -0800 (PST)
In-Reply-To: <CAPYLRzh0Fu5DjjAh1RuYY70iM=pfqekCp9qOoJSRCWgoQ+XnZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

> Sorry to let this drop for so long, but is this something you've seen
> happen before/again or otherwise reproduced? I'm not entirely sure how
> to best test for it (other than just jerking the time around), and
> while I can come up with scenarios where the OSD leaks memory, I've
> got nothing for how that happens to the monitors. We've also fixed a
> number of leaks recently that could account for part of the problem.

It happenned very reliably at each attempt to restart the OSD and
stopped right when I fixed the clock.
Just take a working cluster, take an osd out, let it rebalance, set
the clock of one of the OSD 50 min too fast, and restart the OSD.

I had it occur twice with the same clock sync problems. (once in a
test cluster with just 2 osd IIRC and once in the prod cluster).

I don't get it anymore because I patched the underlying problem that
was causing the clock to jump forward 50 min.

If you can't reproduce it locally, I can try to reproduce it again on
the test cluster tomorrow.

My best guess was that somehow the messages had a timestamp and it
refused to process message too much in the future and maybe just
queued them while waiting (but 50 min worth of message is a lot of
memory). But that's really a wild guess :p


Cheers,

    Sylvain
