From: Ravi Pinjala <pstatic@gmail.com>
Subject: Re: persistent background write activity
Date: Sun, 5 Dec 2010 20:01:03 -0800
Message-ID: <AANLkTikbUCZndDUxB7MnMS143aekcemL7RDSOBwibscS@mail.gmail.com>
References: <AANLkTinWULKcXLmkyqtVc2T38OTh7ZTWOhYa1hfm==By@mail.gmail.com>
	<AANLkTin3eD80Q5=uu3EdgwM=8PQOy3e_jnDWiY1sSmQe@mail.gmail.com>
	<AANLkTinTGVC3+pOFX33JMDp4YcbjAxvgPckKnd4T2+Ng@mail.gmail.com>
	<AANLkTin-suY5HC4HzbkD8fxhPwDOYqKWpJAvRZ5uVbut@mail.gmail.com>
	<AANLkTin-MdrFU7C6SgreEi21Kcj+LZpGhGHp18uo0DXG@mail.gmail.com>
	<AANLkTindP5JYg2ZGm61VkFFUiqUji701XhyaK2VN2dz-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65325 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab0LFEBF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Dec 2010 23:01:05 -0500
Received: by bwz15 with SMTP id 15so10181923bwz.19
        for <ceph-devel@vger.kernel.org>; Sun, 05 Dec 2010 20:01:04 -0800 (PST)
In-Reply-To: <AANLkTindP5JYg2ZGm61VkFFUiqUji701XhyaK2VN2dz-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Greg,

I've tried to isolate the problem, and gotten a log from just writing
to a single file. The MDS was the only thing that produced any
significant logs, even with --debug_{mon,mds,osd} = 20.

http://p-static.net/mds.beta.log

This is from waiting until all other activity on the cluster quiesces
(by watching gkrellm and ceph -w), then adding logging using "ceph mds
injectargs", then creating and deleting a few files (echo "data" >
foo; rm foo - that sort of thing), then disabling logging. gkrellm
reported several bursts of I/O totaling around 1MB (though this is a
complete guess, since gkrellm doesn't count disk bandwidth over time,
only immediate data), which seems high. (Again, this is with no other
activity on the fs at all).

I have another issue, possibly related, with metadata operations being
really laggy. While rsyncing into my cluster, large files saturate the
(gigE) connection, but small files go really slowly (tens of kB/s).
This is consistent with metadata ops having a high overhead.

--Ravi

On Thu, Dec 2, 2010 at 11:29 AM, Gregory Farnum <gregf@hq.newdream.net> wrote:
> Ravi:
> Re-discovered this in my email today, sorry I didn't follow up sooner!
> (Thanksgiving kinda got in the way. ;))
> Are you still observing this behavior, and have you tried it with the
> latest rc branch? If you're still seeing it, we'd appreciate if you
> could turn on logging, zip them up, and post it somewhere for us to
> look at. :)
> Mimicking the debug settings in vstart (with debugging on, it'll have
> stuff like debug mds = 20) should do the trick. :)
> Thanks!
> -Greg
>
> On Sun, Nov 21, 2010 at 2:25 PM, Ravi Pinjala <pstatic@gmail.com> wrote:
>> On Sun, Nov 21, 2010 at 2:11 PM, Gregory Farnum <gregf@hq.newdream.net> wrote:
>>> On Sun, Nov 21, 2010 at 1:44 PM, Ravi Pinjala <pstatic@gmail.com> wrote:
>>>> Ah, that's good to know.
>>>>
>>>> How should I start isolating what's causing it? "ceph -w" doesn't
>>>> indicate that anything's going on, and I'm not sure where to look for
>>>> more detailed information about what ceph's up to.
>>>>
>>>> --Ravi
>>> Well, if you have logging on you can look and see what they're doing
>>> (at a pretty low level). If you don't have it on, you can start it by
>>> using injectargs
>>> (http://ceph.newdream.net/wiki/Monitor_commands#injectargs, you can
>>> actually use it on all the systems even though the describes the mds)
>>> and setting up the appropriate debug options. They're listed here (the
>>> ones preceded by "debug" :) :
>>> http://ceph.newdream.net/wiki/Ceph.conf#options_defined_in_src.2Fconfig.cc
>>>
>>> Looking at the PG map might also show you something, although that'd
>>> probably be captured by changing amounts of data showing up via ceph
>>> -w.
>>>
>>> What version of ceph are you running right now? I think there's some
>>> background scrubbing stuff that got pushed in recently.
>>> -Greg
>>>
>>
>> Running the latest release (0.23), and the client is ubuntu kernel
>> 2.6.35-22. I considered that it might be some kind of background
>> scrubbing, but according to gkrellm it's mostly writes going on, so
>> that didn't really fit.
>>
>
