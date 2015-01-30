From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] keyvaluestore backend metadata overhead
Date: Fri, 30 Jan 2015 23:52:53 +0800
Message-ID: <CACJqLyZnx28QEDU-Jy3KjzS6sumMG_ivqJQ9Ye_cg++Cj8WWQg@mail.gmail.com>
References: <CAC8iE5iHTEfSQL978paWpu9hSfUbE65OVT_dKi2P=yvWSQ5JhA@mail.gmail.com>
	<alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>
	<CACJqLya-SNwudLTOqu2RPgr3_MZKzFWi9gXYH_xCg1WjxAx59w@mail.gmail.com>
	<CAC8iE5jrYquoQ+n+uwiiZ5uevXfipGsab9a_CgjtZoW9h1L0SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:39368 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbbA3Pwy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 10:52:54 -0500
Received: by mail-wg0-f48.google.com with SMTP id x12so27598230wgg.7
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 07:52:53 -0800 (PST)
In-Reply-To: <CAC8iE5jrYquoQ+n+uwiiZ5uevXfipGsab9a_CgjtZoW9h1L0SQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Pacejo <cpacejo@clearskydata.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jan 30, 2015 at 11:41 PM, Chris Pacejo <cpacejo@clearskydata.com> wrote:
> Hi Haomai,
>
> On Thu, Jan 29, 2015 at 9:46 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> For metadata overhead, we need to resolve it at upper level,
>> keyvaluestore won't add extra metadata in normal io except rarely
>> header save which only update when header changed.
>
> Unfortunately, our write workload is dominated by object creates.
>
>
>> As for active write, why do you think it there only one active write
>> in keyvaluestore threads? I just check runtime perf data again, it
>> looks fine that multi write can do concurrently submit transaction.
>
> We've implemented a MySQL backend for KeyValueDB in the hopes of
> getting better performance than LevelDB (what we're currently seeing
> is on par).  Internally, it uses a LIFO connection pool, from which
> connections are leased for the duration of a transaction commit or
> snapshot walk (to permit concurrent transactions).  Watching the
> connection activity in MySQL using "SHOW PROCESSLIST", during most
> runs, it's clear that, for the duration of the write benchmark, all
> but two of the connections remain idle.  (During cleanup, I do see
> more connections used, and I have on occasion seen more used during
> writes.)  So while it's possible the transactions are being built
> concurrently, they aren't (or are with a very low probability) being
> submitted (via submit_transaction_sync()) concurrently.
>
> (It's entirely possible that a bug in our code, or misdocumented
> behavior in the MySQL client, excludes concurrent threads from using
> open MySQL connections, but I *have* seen concurrent transaction
> commits, only rarely.)
>
> You mention "runtime perf data", is there a simple way to query the
> OSD's idea of how many concurrent transaction submits it is issuing?
> In the meantime I'll instrument our backend to track this value
> itself.
>
> Thanks!

It's really a surprise that you impl a MySQL backend. Could I know the
purpose? Because it may not fit with keyvaluestore I think.

You can simply calculate the sum of submit_transaction_sync consuming
time, it would be the multiple of the op thread number.

-- 
Best Regards,

Wheat
