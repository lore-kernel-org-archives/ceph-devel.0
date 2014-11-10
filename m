From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Pull requests : speed up the reviews
Date: Mon, 10 Nov 2014 13:03:43 -0800
Message-ID: <CAC6JEv_4qRQ++NZU0MsF2bAxZh4LCGxBr_LCkT3aa3+xqqtYFQ@mail.gmail.com>
References: <545E53B5.3070600@dachary.org>
	<CAC6JEv_xbv54VoFfU+6rOKS7ytR7TbzJM3NZSk_sVKjpDEyQFA@mail.gmail.com>
	<alpine.DEB.2.00.1411101116110.24475@cobra.newdream.net>
	<5461171F.8080401@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:60004 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbaKJVDo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Nov 2014 16:03:44 -0500
Received: by mail-ig0-f172.google.com with SMTP id a13so17325117igq.5
        for <ceph-devel@vger.kernel.org>; Mon, 10 Nov 2014 13:03:44 -0800 (PST)
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com. [209.85.213.181])
        by mx.google.com with ESMTPSA id o8sm5283201igh.18.2014.11.10.13.03.43
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Nov 2014 13:03:43 -0800 (PST)
Received: by mail-ig0-f181.google.com with SMTP id l13so10725132iga.8
        for <ceph-devel@vger.kernel.org>; Mon, 10 Nov 2014 13:03:43 -0800 (PST)
In-Reply-To: <5461171F.8080401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 10, 2014 at 11:50 AM, Loic Dachary <loic@dachary.org> wrote=
:
> Hi Greg,
>
>> On Mon, 10 Nov 2014, Gregory Farnum wrote:
>>> I suppose one way of handling this might be to ask everybody to
>>> dedicate a small amount of time to reviews (as you suggest), but to
>>> emphasize PR management as much as doing the actual review.
>>>
>>> 1) If you don't have assigned PRs, look at the unassigned PRs from
>>> oldest to newest, and based on the target area assign it to the per=
son
>>> you think most appropriate.after doing basic due diligence for issu=
es
>>> that you can handle (ie, the feature is something you don't know is
>>> inappropriate; skimming the code doesn't make you cry; etc)
>>>
>>> 2) Manage any reviews assigned to you:
>>>   2a) if you're the wrong target, assign it to somebody more approp=
riate
>>>   2b) If you're the right target but are trying to get somebody els=
e
>>> acquainted with the code base, maybe assign it to them
>>>   2c) assign priorities based on importance and age
>>>
>>> 3) review PRs in appropriate order at the level they deserve, and t=
hen
>>> either merge or assign it back to the author
>
> I'll do as you suggest.
>
>>> In particular, this clearly assigns responsibility for a PR to an
>>> individual. It lets people offload as necessary, and gives feedback=
 to
>>> contributors quickly even if that feedback is just "we appreciate y=
our
>>> submission and it is in somebody's queue". It lets people contribut=
e
>>> to the PR process even if there isn't something they feel qualified=
 to
>>> review directly. And it doesn't emphasize the time spent reviewing =
so
>>> much as the act of moving a PR through the stages of merging. (A
>>> 15-minute timebox might sound great, but trust me we have lots of P=
Rs
>>> that would never make it into the code base if they were done in
>>> 15-minute chunks.)
>
> I see what you mean. However there are few pull requests of that kind=
 in the queue, or am I understimating most of them ?

I don't know; see my comment about ruthlessly pruning things above. ;)
But from my recent queue/things I noticed/things I'm seeing in the
queue now:
1) Lots of MDS changes of substance =E2=80=94 osd epoch barrier handlin=
g, the
inode scrub stuff, locking format changes, quotas
2) The AsyncMessenger, which has merged as an experimental feature but
still not seen formal review
3) copy-on-read rbd changes, rbd bitmaps

(VERY IMPORTANT) Keep in mind that part of the job of reviewing
includes making sure that any suggested changes have been through
adequate testing. For stuff from full-time contributors you work with
daily, that might just be poking them to document it or remembering
that they discussed it in a standup. But with external users it often
means either persuading them to set up teuthology, or developing a
testing script for them =E2=80=94 or if you're lucky, simply pulling th=
eir
branch into the upstream repo and scheduling a suite run. :( We get a
lot of stuff that is trickier than it looks and either hasn't been
tested or has only been tested under working conditions, not failure
conditions; that needs to be covered before merging.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
