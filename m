From: John Spray <jspray@redhat.com>
Subject: Re: Switching on mds_bal_frag by default
Date: Fri, 5 Aug 2016 15:15:13 +0100
Message-ID: <CALe9h7ffp9NbutrXwCVF1SY5M4hDSn2kdqfquwCPnKoTBkog1A@mail.gmail.com>
References: <CALe9h7fbSiDEf_AYKyOuDDwtDq_4-T1Dq4p0kieyAmZoMyHu8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35695 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759764AbcHEOPf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2016 10:15:35 -0400
Received: by mail-qk0-f177.google.com with SMTP id x185so71177663qkc.2
        for <ceph-devel@vger.kernel.org>; Fri, 05 Aug 2016 07:15:34 -0700 (PDT)
In-Reply-To: <CALe9h7fbSiDEf_AYKyOuDDwtDq_4-T1Dq4p0kieyAmZoMyHu8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Aug 5, 2016 at 11:52 AM, John Spray <jspray@redhat.com> wrote:
> Patrick: can you try enabling fragmentation in the multimds tests so
> that we have an idea if it's going to make them blow up before we
> switch it on in master?
>
> The multimds suites currently don't have the yaml fragments that
> switch it on, and they'll probably be particularly vulnerable to any
> issues it might throw up.
>
> I think we should be switching mds_bal_frag on by default in Kraken,
> it's been enabled in the fs suite for some time (although we're
> currently taking it on faith that it's really being exercised
> http://tracker.ceph.com/issues/16523)

Ah-ha, I've just realised on my wip-smallcache branch that fragmenting
isn't actually happening on our test runs at the moment because of the
allow_dirfrags switch that was added to mdsmap in the run up to jewel.
Fixing!

John
