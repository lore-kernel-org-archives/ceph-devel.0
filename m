From: Samuel Just <sam.just@inktank.com>
Subject: Re: Hangup during scrubbing - possible solutions
Date: Tue, 27 Nov 2012 17:35:04 -0800
Message-ID: <CA+4uBUYpwJOwcEeKLREVc-GA-uvXKvLqDFKLwqjCyqD=LO5fYQ@mail.gmail.com>
References: <CABYiri-YGDCCzVD2kcJeZQy4ggWBDt0cC8TrHQxTp4tOeabQew@mail.gmail.com>
	<alpine.DEB.2.00.1211221234020.9963@cobra.newdream.net>
	<CABYiri8f3t8ULVWA5SG2tsgO7syaBrR55si2fyKXj8mC--UumQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37235 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189Ab2K1BfF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 20:35:05 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so7553361vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Nov 2012 17:35:04 -0800 (PST)
In-Reply-To: <CABYiri8f3t8ULVWA5SG2tsgO7syaBrR55si2fyKXj8mC--UumQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

If you can reproduce it again, what we really need are the osd logs
from the acting set of a pg stuck in scrub with
debug osd = 20
debug ms = 1
debug filestore = 20.

Thanks,
-Sam

On Sun, Nov 25, 2012 at 2:08 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
> On Fri, Nov 23, 2012 at 12:35 AM, Sage Weil <sage@inktank.com> wrote:
>> On Thu, 22 Nov 2012, Andrey Korolyov wrote:
>>> Hi,
>>>
>>> In the recent versions Ceph introduces some unexpected behavior for
>>> the permanent connections (VM or kernel clients) - after crash
>>> recovery, I/O will hang on the next planned scrub on the following
>>> scenario:
>>>
>>> - launch a bunch of clients doing non-intensive writes,
>>> - lose one or more osd, mark them down, wait for recovery completion,
>>> - do a slow scrub, e.g. scrubbing one osd per 5m, inside bash script,
>>> or wait for ceph to do the same,
>>> - observe a raising number of pgs stuck in the active+clean+scrubbing
>>> state (they took a master role from ones which was on killed osd and
>>> almost surely they are being written in time of crash),
>>> - some time later, clients will hang hardly and ceph log introduce
>>> stuck(old) I/O requests.
>>>
>>> The only one way to return clients back without losing their I/O state
>>> is per-osd restart, which also will help to get rid of
>>> active+clean+scrubbing pgs.
>>>
>>> First of all, I`ll be happy to help to solve this problem by providing
>>> logs.
>>
>> If you can reproduce this behavior with 'debug osd = 20' and 'debug ms =
>> 1' logging on the OSD, that would be wonderful!
>>
>
> I have tested slightly different recovery flow, please see below.
> Since there is no real harm, like frozen I/O, placement groups also
> was stuck forever on the active+clean+scrubbing state, until I
> restarted all osds (end of the log):
>
> http://xdel.ru/downloads/ceph-log/recover-clients-later-than-osd.txt.gz
>
> - start the healthy cluster
> - start persistent clients
> - add an another host with pair of OSDs, let them be in the data placement
> - wait for data to rearrange
> - [22:06 timestamp] mark OSDs out or simply kill them and wait(since I
> have an 1/2 hour delay on readjust in such case, I did ``ceph osd
> out'' manually)
> - watch for data to rearrange again
> - [22:51 timestamp] when it ends, start a manual rescrub, with
> non-zero active+clean+scrubbing-state placement groups at the end of
> process which `ll stay in this state forever until something happens
>
> After that, I can restart osds one per one, if I want to get rid of
> scrubbing states immediately and then do deep-scrub(if I don`t, those
> states will return at next ceph self-scrubbing) or do per-osd
> deep-scrub, if I have a lot of time. The case I have described in the
> previous message took place when I remove osd from data placement
> which existed on the moment when client(s) have started and indeed it
> is more harmful than current one(frozen I/O leads to hanging entire
> guest, for example). Since testing those flow took a lot of time, I`ll
> send logs related to this case tomorrow.
>
>>> Second question is not directly related to this problem, but I
>>> have thought on for a long time - is there a planned features to
>>> control scrub process more precisely, e.g. pg scrub rate or scheduled
>>> scrub, instead of current set of timeouts which of course not very
>>> predictable on when to run?
>>
>> Not yet.  I would be interested in hearing what kind of control/config
>> options/whatever you (and others) would like to see!
>
> Of course it will be awesome to have any determined scheduler or at
> least an option to disable automated scrubbing, since it is not very
> determined in time and deep-scrub eating a lot of I/O if command
> issued against entire OSD. Rate limiting is not in the first place, at
> least it may be recreated in external script, but for those who prefer
> to leave control to Ceph, it may be very useful.
>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
