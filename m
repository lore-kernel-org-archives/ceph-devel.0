From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Better anticipation for minor releases
Date: Fri, 2 Feb 2018 07:05:25 -0500
Message-ID: <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
 <4173fd50ca3d6d4e4f691f116b425397@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34804 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeBBMF0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Feb 2018 07:05:26 -0500
Received: by mail-qt0-f171.google.com with SMTP id a27so30587913qtd.1
        for <ceph-devel@vger.kernel.org>; Fri, 02 Feb 2018 04:05:26 -0800 (PST)
In-Reply-To: <4173fd50ca3d6d4e4f691f116b425397@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek <abhishek@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-devel-owner@vger.kernel.org, Nathan Cutler <ncutler@suse.cz>

On Wed, Jan 31, 2018 at 2:25 PM, Abhishek <abhishek@suse.com> wrote:
> On 2018-01-31 18:46, Alfredo Deza wrote:
>>
>> Hi Abhishek,
>>
>> For almost every minor release we have, there is a cloud of
>> uncertainty where nobody really knows when the release will be cut.
>>
>> Most of the time there is an email (or series of emails) that trigger
>> the conversation of "are we now ready to cut a release?", where leads
>> respond what backports are still pending, or if there are test suites
>> that aren't really in the clear.
>>
>> For minor releases a mix of a time-based schedule with a set of each
>> lead's group of passing tests, would be a nice way to predict when we
>> can start having the conversation of cutting a release.
>
>
> Agree, we wanted to introduce a better process for 12.2.3 but this mostly
> took a backseat with vacations and all. Yuri has been kind enough to spend
> time on running the QE suites and we've a lot backports raised from Shinobu
> and the rest of the ceph community which was great. We've mostly had a
> relatively reddish run on QE suites for 12.2.2 and this has relatively
> changed a lot in 12.2.3 with smaller greener runs thanks to Yuri.
>
> For a ~6 week schedule we need to close all the backports in 4 weeks since
> the final qe run takes ~2weeks. Which gives 4 weeks for adding PRs as well
> as going through integration suites etc, we'll have to come up with a soft
> stop in 3 weeks so that we've sufficient time in the 4th week to triage and
> merge the pending queue + any critical PRs we really want in the timeframe.
>
> Quoting Nathan from an earlier email; there are roughly two parts to this
> process: - triaging, backporting and integration testing of PRs
> - Asking leads for approval, release notes, working with QE for the final
> suite approval.
>
> If we approximately stop accepting new PRs at the third week, ask leads at
> beginning of week 4 and go through only critical PRs for week 4; and go to
> QE in week5,6 we might be able to somewhat get to a more scheduled minor
> releases.

This might be a bit hard to deal with, how do you prevent a PR from
getting merged? I've seen several times PRs getting merged at the last
minute,
with little to no testing, and breaking a release :( It hasn't
happened much lately, but I don't know of a way to block all PRs for a
period of time

One way that sounded interesting to me from the Chef Release Team is
that regardless of the state of the branch, they would agree what SHA1
would end up
being the actual release, and then going through the different phases
of QA up until release, when something needed a fix, the pipeline
would start from the beginning.


>
> Brickbats and suggestions ?:)
>>
>> It isn't a one-shot fix, but would certainly improve everyone who
>> wants/needs a new release and can't get any clues as to what that may
>> be.
>>
>> Something like:
>>
>> * Minor releases every 6 weeks
>> * subset of test suites passing from each lead
>>
>> Would be a good way to start. If we can get that initial release path,
>> it would be possible to start thinking about what "gating" really
>> means for our releases (since we don't really have any sort of gating
>> today)
>
>
>
>>
>> What do you think?
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
