From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Paxos and long-lasting deleted data
Date: Thu, 31 Jan 2013 22:18:22 +0300
Message-ID: <CABYiri-Q=N+N9TQrTkex+WVF0wu94CuXMx_FHXBsEsrjaO1kPQ@mail.gmail.com>
References: <CABYiri8fbbpuhh0RguqdsmYEbEkYz_+PKO4UJqWqKb1TwDcc6A@mail.gmail.com>
 <CAPYLRzjwn4LxnzbX9SBJL7x7AtX6=pmv84HXBGykNGHn7zVLTA@mail.gmail.com>
 <CABYiri82rCvVD79rnhm3mFPoegnF7w4SNyUrFr+axEoty69n1A@mail.gmail.com> <CAPYLRzieYDDOrbpj_Cs0czxA3uFrLez6A5gKdQoMFT2dyA9vqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:58573 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369Ab3AaTSp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 14:18:45 -0500
Received: by mail-oa0-f44.google.com with SMTP id h1so817143oag.3
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 11:18:43 -0800 (PST)
In-Reply-To: <CAPYLRzieYDDOrbpj_Cs0czxA3uFrLez6A5gKdQoMFT2dyA9vqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 31, 2013 at 10:56 PM, Gregory Farnum <greg@inktank.com> wrote:
> On Thu, Jan 31, 2013 at 10:50 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
>> http://xdel.ru/downloads/ceph-log/rados-out.txt.gz
>>
>>
>> On Thu, Jan 31, 2013 at 10:31 PM, Gregory Farnum <greg@inktank.com> wrote:
>>> Can you pastebin the output of "rados -p rbd ls"?
>
>
> Well, that sure is a lot of rbd objects. Looks like a tool mismatch or
> a bug in whatever version you were using. Can you describe how you got
> into this state, what versions of the servers and client tools you
> used, etc?
> -Greg

That`s relatively fresh data moved into bare new cluster after couple
of days of 0.56.1 release, and tool/daemons version kept consistently
the same at any moment. All garbage data belongs to the same pool
prefix(3.) on which I have put a bunch of VM` images lately, cluster
may have been experienced split-brain problem for a short times during
crash-tests with no workload at all and standard crash tests on osd
removal/readdition during moderate workload. Killed osds have been
returned before,at the time and after process of data rearrangement on
``osd down'' timeout. Is it possible to do a little clean somehow
without pool re-creation?
